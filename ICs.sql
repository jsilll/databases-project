-- (RI-1) Uma Categoria não pode estar contida em si própria
DROP TRIGGER check_self_contaned_category_trigger ON has_other IF EXISTS;

-- (RI-4) O número de unidades repostas num Evento de Reposição não pode exceder o número de unidades especificado no Planograma
DROP TRIGGER check_number_of_replenished_units_trigger ON replenishment_event IF EXISTS;

-- (RI-5) Um Produto só pode ser reposto numa Prateleira que apresente (pelo menos) uma das Categorias desse produto
DROP TRIGGER check_product_on_shelve_trigger ON replenishment_event IF EXISTS;

CREATE OR REPLACE FUNCTION check_self_contaned_category_proc()
RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.super_category = NEW.category THEN
        RAISE EXCEPTION 'A category cannot be contained within itself';
    END IF;
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_self_contaned_category_trigger
BEFORE INSERT OR UPDATE ON has_other
FOR EACH ROW EXECUTE PROCEDURE check_self_contaned_category_proc();

CREATE OR REPLACE FUNCTION check_number_of_replenished_units_proc()
RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.nr_units > (
        SELECT nr_units
        FROM planogram P
        WHERE NEW.ean = P.ean AND NEW.nr = P.nr AND NEW.serial_nr = P.serial_nr AND NEW.manuf = P.manuf
    ) THEN
        RAISE EXCEPTION 'Number of replenished units cant exceed those specified in planogram.';
    END IF;
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_number_of_replenished_units_trigger
BEFORE INSERT OR UPDATE ON replenishment_event
FOR EACH ROW EXECUTE PROCEDURE check_number_of_replenished_units_proc();

CREATE OR REPLACE FUNCTION check_product_on_shelve_proc()
RETURNS TRIGGER
AS $$
BEGIN
    DECLARE category varchar(100);

    SELECT category_name INTO category
    FROM shelve S
    WHERE NEW.nr = S.nr AND NEW.serial_nr = S.serial_nr AND NEW.manuf = S.manuf 

    IF category NOT IN (
        SELECT category_name
        FROM has_category H
        WHERE H.ean = NEW.ean;
    ) THEN
        RAISE EXCEPTION 'Product can only be replenished in a shelve that has at least one of the product''s categories.';
    END IF;
    RETURN NEW;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_product_on_shelve_trigger
BEFORE INSERT OR UPDATE ON replenishment_event
FOR EACH ROW EXECUTE PROCEDURE check_product_on_shelve_proc();
