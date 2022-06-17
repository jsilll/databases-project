DROP TABLE replenishment_event cascade;
DROP TABLE responsible_for cascade;
DROP TABLE retailer cascade;
DROP TABLE planogram cascade;
DROP TABLE shelve cascade;
DROP TABLE installed_at cascade;
DROP TABLE point_of_retail cascade;
DROP TABLE ivm cascade;
DROP TABLE has_category cascade;
DROP TABLE product cascade;
DROP TABLE has_other cascade;
DROP TABLE simple_category cascade;
DROP TABLE super_category cascade;
DROP TABLE category cascade;


----------------------------------------
-- Table Creation
----------------------------------------

-- Named constraints are global to the database.
-- Therefore the following use the following naming rules:
--   1. pk_table for names of primary key constraints
--   2. fk_table_another for names of foreign key constraints

CREATE TABLE category (
    category_name   varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_category PRIMARY KEY (category_name)
);

CREATE TABLE simple_category (
    category_name   varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_simple_category PRIMARY KEY (category_name),
    CONSTRAINT fk_simple_category_name FOREIGN KEY (category_name) REFERENCES category(category_name)
);

CREATE TABLE super_category (
    category_name   varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_super_category PRIMARY KEY (category_name),
    CONSTRAINT fk_super_category_name FOREIGN KEY (category_name) REFERENCES category(category_name)
);

CREATE TABLE has_other (
    super_category  varchar(50) NOT NULL,
    category        varchar(50) NOT NULL UNIQUE,
    CONSTRAINT pk_has_other_category PRIMARY KEY (category),
    CONSTRAINT fk_has_other_super_category FOREIGN KEY (super_category) REFERENCES super_category(category_name),
    CONSTRAINT fk_has_other_category FOREIGN KEY (category) REFERENCES category(category_name)
);

CREATE TABLE product (
    ean     numeric(13, 0)  NOT NULL UNIQUE,
    descr   varchar(100)    NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (ean)
);

CREATE TABLE has_category (
    ean             numeric(13,0)   NOT NULL,
    category_name   varchar(50)     NOT NULL,
    CONSTRAINT pk_has_category PRIMARY KEY (ean, category_name),
    CONSTRAINT  fk_has_category_ean FOREIGN KEY (ean) REFERENCES product(ean),
    CONSTRAINT fk_has_category_cname FOREIGN KEY (category_name) REFERENCES category(category_name)  
);

CREATE TABLE ivm (
    serial_nr   serial  NOT NULL UNIQUE,
    manuf       varchar(50) NOT NULL,
    CONSTRAINT pk_ivm PRIMARY KEY (serial_nr, manuf)
);

CREATE TABLE point_of_retail (
    point_of_retail_name    varchar(100)    NOT NULL UNIQUE,
    district                varchar(50)     NOT NULL,
    county                  varchar(50)     NOT NULL,
    CONSTRAINT pk_point_of_retail PRIMARY KEY (point_of_retail_name)
);

CREATE TABLE installed_at (
    serial_nr   serial          NOT NULL UNIQUE,
    manuf       varchar(50)     NOT NULL,
    place       varchar(100)    NOT NULL,
    CONSTRAINT pk_installed_at  PRIMARY KEY (serial_nr, manuf),
    CONSTRAINT fk_installed_at_ivm FOREIGN KEY (serial_nr, manuf) REFERENCES ivm(serial_nr, manuf),
    CONSTRAINT fk_installed_at_place FOREIGN KEY (place) REFERENCES point_of_retail(point_of_retail_name)
);

CREATE TABLE shelve (
    nr              numeric         NOT NULL CHECK (nr > 0),
    serial_nr       serial          NOT NULL,
    manuf           varchar(50)     NOT NULL,
    category_name   varchar(50)     NOT NULL,
    height          numeric(10,2)   NOT NULL CHECK (height > 0),
    CONSTRAINT pk_shelve PRIMARY KEY (nr, serial_nr, manuf),
    CONSTRAINT fk_shelve_ivm FOREIGN KEY (serial_nr, manuf) REFERENCES ivm(serial_nr, manuf),
    CONSTRAINT fk_shelve_category FOREIGN KEY (category_name) REFERENCES category(category_name)
);

CREATE TABLE planogram (
    ean         numeric(13,0)   NOT NULL,
    nr          numeric         NOT NULL CHECK (nr > 0),
    serial_nr   serial          NOT NULL,
    manuf       varchar(50)     NOT NULL,
    faces       numeric         NOT NULL CHECK (faces > 0),
    nr_units    numeric         NOT NULL CHECK (nr_units > 0),
    loc         varchar(50)     NOT NULL,
    CONSTRAINT pk_planogram PRIMARY KEY (ean, nr, serial_nr, manuf),
    CONSTRAINT fk_planogram_product FOREIGN KEY (ean) REFERENCES product(ean),
    CONSTRAINT fk_planogram_shelve FOREIGN KEY (nr, serial_nr, manuf) REFERENCES shelve(nr, serial_nr, manuf)
);

CREATE TABLE retailer (
    tin             numeric(20,0)   NOT NULL UNIQUE,
    retailer_name   varchar(50)     NOT NULL UNIQUE,
    CONSTRAINT pk_retailer PRIMARY KEY (tin)
);

CREATE TABLE responsible_for (
    category_name   varchar(50)     NOT NULL,
    tin             numeric(20,0)   NOT NULL,
    serial_nr       serial          NOT NULL,
    manuf           varchar(50)     NOT NULL,
    CONSTRAINT pk_responsible_for PRIMARY KEY (category_name, tin, serial_nr, manuf)
);

CREATE TABLE replenishment_event (
    ean         numeric(13,0)   NOT NULL,
    nr          numeric         NOT NULL CHECK (nr > 0),
    serial_nr   serial          NOT NULL,
    manuf       varchar(50)     NOT NULL,
    instant     timestamp(2)    NOT NULL,
    nr_units    numeric         NOT NULL CHECK (nr_units > 0),
    tin         numeric(20,0)   NOT NULL,
    CONSTRAINT pk_replenishment_event PRIMARY KEY (ean, nr, serial_nr, manuf, instant),
    CONSTRAINT fk_replenishment_event_planogram FOREIGN KEY (ean, nr, serial_nr, manuf) REFERENCES planogram(ean, nr, serial_nr, manuf),
    CONSTRAINT fk_replenishment_event_retailer FOREIGN KEY (tin) REFERENCES retailer(tin)
);

----------------------------------------
-- Populate Relations 
----------------------------------------

-------------- Category --------------
INSERT INTO category VALUES ('Sopas'); -- super categoria
INSERT INTO category VALUES ('Sopas Take-Away'); -- subcategoria de sopas / super categoria
INSERT INTO category VALUES ('Sopas de Bebé'); -- subcategoria de sopas / cat simples
INSERT INTO category VALUES ('Sopas Take-Away Frias'); -- subcategoria de sopas take-away / cat simples
INSERT INTO category VALUES ('Sopas Take-Away Quentes'); -- subcategoria de sopas take-away / cat simples

INSERT INTO category VALUES ('Bebidas'); -- super categoria
INSERT INTO category VALUES ('Refrigerantes'); -- subcategoria de bebidas / super categoria
INSERT INTO category VALUES ('Refrigerantes com Gás'); -- subcategoria de refrigerantes / cat simples
INSERT INTO category VALUES ('Refrigerantes sem Gás'); -- subcategoria de refrigerantes / cat simples
INSERT INTO category VALUES ('Cerveja'); -- subcategoria de bebidas / cat simples
INSERT INTO category VALUES ('Sumos'); -- subcategoria de bebidas / super categoria
INSERT INTO category VALUES ('Sumos Naturais'); -- -- subcategoria de sumos / cat simples
INSERT INTO category VALUES ('Sumos com Conservantes'); -- subcategoria de sumos / cat simples
INSERT INTO category VALUES ('Água'); -- subcategoria de bebidas / cat simples

INSERT INTO category VALUES ('Bolachas'); -- super categoria
INSERT INTO category VALUES ('Bolachas de Chocolate'); -- subcategoria de bolachas / cat simples
INSERT INTO category VALUES ('Bolachas de Criança'); -- subcategoria de bolachas / cat simples
INSERT INTO category VALUES ('Bolachas de Água e Sal'); -- subcategoria de bolachas / cat simples

-------------- Super Category --------------
INSERT INTO super_category VALUES ('Sopas');
INSERT INTO super_category VALUES ('Sopas Take-Away');
INSERT INTO super_category VALUES ('Bebidas');
INSERT INTO super_category VALUES ('Refrigerantes');
INSERT INTO super_category VALUES ('Sumos');
INSERT INTO super_category VALUES ('Bolachas');

-------------- Simple Category --------------
INSERT INTO simple_category VALUES ('Sopas Bebé');
INSERT INTO simple_category VALUES ('Sopas Take-Away Frias');
INSERT INTO simple_category VALUES ('Sopas Take-Away Quentes');
INSERT INTO simple_category VALUES ('Refrigerantes com Gás');
INSERT INTO simple_category VALUES ('Refrigerantes sem Gás');
INSERT INTO simple_category VALUES ('Cerveja');
INSERT INTO simple_category VALUES ('Sumos Naturais');
INSERT INTO simple_category VALUES ('Sumos com Conservantes');
INSERT INTO simple_category VALUES ('Água');
INSERT INTO simple_category VALUES ('Bolachas de Chocolate');
INSERT INTO simple_category VALUES ('Bolachas de Criança');
INSERT INTO simple_category VALUES ('Bolachas de Água e Sal');

-------------- has_other --------------
INSERT INTO has_other VALUES ('Sopas', 'Sopas Take-Away');
INSERT INTO has_other VALUES ('Sopas', 'Sopas Bebé');

INSERT INTO has_other VALUES ('Sopas Take-Away', 'Sopas Take-Away Frias');
INSERT INTO has_other VALUES ('Sopas Take-Away', 'Sopas Take-Away Quentes');

INSERT INTO has_other VALUES ('Bebidas', 'Refrigerantes');
INSERT INTO has_other VALUES ('Bebidas', 'Cerveja');
INSERT INTO has_other VALUES ('Bebidas', 'Sumos');
INSERT INTO has_other VALUES ('Bebidas', 'Água');

INSERT INTO has_other VALUES ('Refrigerantes', 'Refrigerantes com Gás');
INSERT INTO has_other VALUES ('Refrigerantes', 'Refrigerantes sem Gás');

INSERT INTO has_other VALUES ('Sumos', 'Sumos Naturais');
INSERT INTO has_other VALUES ('Sumos', 'Sumos com Conservantes');

INSERT INTO has_other VALUES ('Bolachas', 'Bolachas de Chocolate');
INSERT INTO has_other VALUES ('Bolachas', 'Bolachas de Criança');
INSERT INTO has_other VALUES ('Bolachas', 'Bolachas de Água e Sal');

-------------- Product --------------
INSERT INTO product VALUES (1, 'Sopa de espinafres');
INSERT INTO product VALUES (2, 'Sopa de cenoura passada');
INSERT INTO product VALUES (3, 'Sopa de legumes');
INSERT INTO product VALUES (4, 'Sopa de tomate');
INSERT INTO product VALUES (5, 'Canja');
INSERT INTO product VALUES (6, 'Sopa de agrião');
INSERT INTO product VALUES (7, 'Água natural');
INSERT INTO product VALUES (8, 'Água de morango');
INSERT INTO product VALUES (9, 'Água com gás');
INSERT INTO product VALUES (10, 'Coca-cola');
INSERT INTO product VALUES (11, 'Iced-tea');
INSERT INTO product VALUES (12, 'Fanta');
INSERT INTO product VALUES (13, 'Sumo de laranja');
INSERT INTO product VALUES (14, 'Sumo de maçã');
INSERT INTO product VALUES (15, 'Compal de maçã');
INSERT INTO product VALUES (16, 'Compal de pêra');
INSERT INTO product VALUES (17, 'Sagres');
INSERT INTO product VALUES (18, 'Super-Bock');
INSERT INTO product VALUES (19, 'Oreo');
INSERT INTO product VALUES (10, 'Chips Ahoy');
INSERT INTO product VALUES (21, 'Tuc');
INSERT INTO product VALUES (22, 'Principe');
INSERT INTO product VALUES (23, 'Dino');
INSERT INTO product VALUES (24, 'Gullon Chocolate');



-------------- has_category --------------
-- TODO se um produto pertence a uma subcategoria, tem de estar relacionado com todas as supercategorias acima?
INSERT INTO has_category VALUES (1, 'Sopas');
INSERT INTO has_category VALUES (1, 'Sopas Take-Away');
INSERT INTO has_category VALUES (1, 'Sopas Take-Away Quentes');
INSERT INTO has_category VALUES (2, 'Sopas');
INSERT INTO has_category VALUES (2, 'Sopas Bebé');
INSERT INTO has_category VALUES (3, 'Sopas');
INSERT INTO has_category VALUES (3, 'Sopas Take-Away');
INSERT INTO has_category VALUES (3, 'Sopas Take-Away Quentes');
INSERT INTO has_category VALUES (4, 'Sopas');
INSERT INTO has_category VALUES (4, 'Sopas Take-Away');
INSERT INTO has_category VALUES (4, 'Sopas Take-Away Frias');
INSERT INTO has_category VALUES (5, 'Sopas');
INSERT INTO has_category VALUES (5, 'Sopas Take-Away');
INSERT INTO has_category VALUES (5, 'Sopas Take-Away Quentes');
INSERT INTO has_category VALUES (6, 'Sopas');
INSERT INTO has_category VALUES (7, 'Bebidas');
INSERT INTO has_category VALUES (7, 'Água');
INSERT INTO has_category VALUES (8, 'Bebidas');
INSERT INTO has_category VALUES (8, 'Água');
INSERT INTO has_category VALUES (9, 'Bebidas');
INSERT INTO has_category VALUES (9, 'Água');
INSERT INTO has_category VALUES (10, 'Bebidas');
INSERT INTO has_category VALUES (10, 'Refrigerantes');
INSERT INTO has_category VALUES (10, 'Refrigerantes com Gás');
INSERT INTO has_category VALUES (11, 'Bebidas');
INSERT INTO has_category VALUES (11, 'Refrigerantes');
INSERT INTO has_category VALUES (11, 'Refrigerantes sem Gás');
INSERT INTO has_category VALUES (12, 'Bebidas');
INSERT INTO has_category VALUES (12, 'Refrigerantes');
INSERT INTO has_category VALUES (12, 'Refrigerantes com Gás');
INSERT INTO has_category VALUES (13, 'Bebidas');
INSERT INTO has_category VALUES (13, 'Sumos');
INSERT INTO has_category VALUES (13, 'Sumos Naturais');
INSERT INTO has_category VALUES (14, 'Bebidas');
INSERT INTO has_category VALUES (14, 'Sumos');
INSERT INTO has_category VALUES (14, 'Sumos Naturais');
INSERT INTO has_category VALUES (15, 'Bebidas');
INSERT INTO has_category VALUES (15, 'Sumos');
INSERT INTO has_category VALUES (15, 'Sumos com Conservantes');
INSERT INTO has_category VALUES (16, 'Bebidas');
INSERT INTO has_category VALUES (16, 'Sumos');
INSERT INTO has_category VALUES (16, 'Sumos com Conservantes');
INSERT INTO has_category VALUES (17, 'Bebidas');
INSERT INTO has_category VALUES (17, 'Cerveja');
INSERT INTO has_category VALUES (18, 'Bebidas');
INSERT INTO has_category VALUES (18, 'Cerveja');
INSERT INTO has_category VALUES (19, 'Bolachas');
INSERT INTO has_category VALUES (19, 'Bolachas de Chocolate');
INSERT INTO has_category VALUES (20, 'Bolachas');
INSERT INTO has_category VALUES (20, 'Bolachas de Chocolate');
INSERT INTO has_category VALUES (21, 'Bolachas');
INSERT INTO has_category VALUES (21, 'Bolachas de Água e Sal');
INSERT INTO has_category VALUES (22, 'Bolachas');
INSERT INTO has_category VALUES (22, 'Bolachas de Criança');
INSERT INTO has_category VALUES (23, 'Bolachas');
INSERT INTO has_category VALUES (23, 'Bolachas de Criança');
INSERT INTO has_category VALUES (24, 'Bolachas');
INSERT INTO has_category VALUES (24, 'Bolachas de Chocolate');


-------------- IVM --------------
INSERT INTO ivm VALUES (1, 'manuf1');
INSERT INTO ivm VALUES (2, 'manuf1');
INSERT INTO ivm VALUES (3, 'manuf1');
INSERT INTO ivm VALUES (4, 'manuf2');
INSERT INTO ivm VALUES (5, 'manuf2');
INSERT INTO ivm VALUES (6, 'manuf2');
INSERT INTO ivm VALUES (7, 'manuf3');
INSERT INTO ivm VALUES (8, 'manuf3');
INSERT INTO ivm VALUES (9, 'manuf3');
INSERT INTO ivm VALUES (10, 'manuf4');
INSERT INTO ivm VALUES (11, 'manuf4');
INSERT INTO ivm VALUES (12, 'manuf4');

-------------- Point of Retail --------------
INSERT INTO point_of_retail VALUES ('Metro Saldanha', 'Lisboa', 'Lisboa');
INSERT INTO point_of_retail VALUES ('Metro Campo Pequeno', 'Lisboa', 'Lisboa');
INSERT INTO point_of_retail VALUES ('Metro Telheiras', 'Lisboa', 'Lisboa');
INSERT INTO point_of_retail VALUES ('Metro Campo Grande', 'Lisboa', 'Lisboa');
INSERT INTO point_of_retail VALUES ('Metro Entrecampos', 'Lisboa', 'Lisboa');
INSERT INTO point_of_retail VALUES ('Baixa Porto', 'Porto', 'Porto');
INSERT INTO point_of_retail VALUES ('Mercado do Bom Sucesso', 'Porto', 'Matosinhos');
INSERT INTO point_of_retail VALUES ('Praia da Figueira', 'Coimbra', 'Figueira da Foz');
INSERT INTO point_of_retail VALUES ('Centro de Saúde de Beja', 'Beja', 'Castro Verde');
INSERT INTO point_of_retail VALUES ('Centro de Évora', 'Évora', 'Évora');

-------------- installed_at --------------
INSERT INTO installed_at VALUES (1, 'manuf1', 'Metro Saldanha');
INSERT INTO installed_at VALUES (2, 'manuf1', 'Metro Campo Pequeno');
INSERT INTO installed_at VALUES (3, 'manuf1', 'Metro Telheiras');
INSERT INTO installed_at VALUES (4, 'manuf2', 'Metro Campo Grande');
INSERT INTO installed_at VALUES (5, 'manuf2', 'Metro Entrecampos');
INSERT INTO installed_at VALUES (6, 'manuf2', 'Centro de Évora');
INSERT INTO installed_at VALUES (7, 'manuf3', 'Baixa Porto');
INSERT INTO installed_at VALUES (8, 'manuf3', 'Mercado do Bom Sucesso');
INSERT INTO installed_at VALUES (9, 'manuf3', 'Praia da Figueira');
INSERT INTO installed_at VALUES (10, 'manuf4', 'Centro de Saúde de Beja');
INSERT INTO installed_at VALUES (11, 'manuf4', 'Baixa Porto');
INSERT INTO installed_at VALUES (12, 'manuf4', 'centro de Évora');

-------------- Shelve --------------
INSERT INTO shelve VALUES (1, 1, 'manuf1', 10, 'Sopas');
INSERT INTO shelve VALUES (2, 1, 'manuf1', 15, 'Sopas Bebé');
INSERT INTO shelve VALUES (3, 1, 'manuf1', 15, 'Água');
INSERT INTO shelve VALUES (4, 1, 'manuf1', 20, 'Refrigerantes com Gás');
INSERT INTO shelve VALUES (5, 1, 'manuf1', 10, 'Sumos Naturais');
INSERT INTO shelve VALUES (6, 1, 'manuf1', 10, 'Bolachas');

INSERT INTO shelve VALUES (1, 2, 'manuf1', 15, 'Água');
INSERT INTO shelve VALUES (2, 2, 'manuf1', 10, 'Refrigerantes com Gás');
INSERT INTO shelve VALUES (3, 2, 'manuf1', 10, 'Sumos com Conservantes');
INSERT INTO shelve VALUES (4, 2, 'manuf1', 10, 'Cerveja');

INSERT INTO shelve VALUES (1, 3, 'manuf1', 10, 'Sopas Bebé');
INSERT INTO shelve VALUES (2, 3, 'manuf1', 10, 'Água');
INSERT INTO shelve VALUES (3, 3, 'manuf1', 10, 'Cerveja');
INSERT INTO shelve VALUES (4, 3, 'manuf1', 10, 'Bolachas de Chocolate');
INSERT INTO shelve VALUES (5, 3, 'manuf1', 10, 'Bolachas de Água e Sal');

INSERT INTO shelve VALUES (1, 4, 'manuf2', 15, 'Sopas');
INSERT INTO shelve VALUES (2, 4, 'manuf2', 20, 'Bolachas');
INSERT INTO shelve VALUES (3, 4, 'manuf2', 10, 'Refrigerantes');
INSERT INTO shelve VALUES (4, 4, 'manuf2', 10, 'Sopas Bebé');

INSERT INTO shelve VALUES (1, 5, 'manuf2', 15, 'Água');
INSERT INTO shelve VALUES (2, 5, 'manuf2', 10, 'Refrigerantes com Gás');
INSERT INTO shelve VALUES (3, 5, 'manuf2', 10, 'Sumos com Conservantes');
INSERT INTO shelve VALUES (4, 5, 'manuf2', 10, 'Cerveja');

INSERT INTO shelve VALUES (1, 6, 'manuf2', 10, 'Sopas');
INSERT INTO shelve VALUES (2, 6, 'manuf2', 15, 'Sopas Bebé');
INSERT INTO shelve VALUES (3, 6, 'manuf2', 15, 'Água');
INSERT INTO shelve VALUES (4, 6, 'manuf2', 20, 'Refrigerantes com Gás');
INSERT INTO shelve VALUES (5, 6, 'manuf2', 10, 'Sumos Naturais');
INSERT INTO shelve VALUES (6, 6, 'manuf2', 10, 'Bolachas');

INSERT INTO shelve VALUES (1, 7, 'manuf3', 15, 'Sopas');
INSERT INTO shelve VALUES (2, 7, 'manuf3', 20, 'Bolachas');
INSERT INTO shelve VALUES (3, 7, 'manuf3', 10, 'Refrigerantes sem Gás');
INSERT INTO shelve VALUES (4, 7, 'manuf3', 10, 'Sopas Take-Away');

INSERT INTO shelve VALUES (1, 8, 'manuf3', 10, 'Bolachas de Água e Sal');
INSERT INTO shelve VALUES (2, 8, 'manuf3', 10, 'Bolachas de Chocolate');
INSERT INTO shelve VALUES (3, 8, 'manuf3', 10, 'Bolachas de Criança');
INSERT INTO shelve VALUES (4, 8, 'manuf3', 15, 'Água');

INSERT INTO shelve VALUES (1, 9, 'manuf3', 10, 'Sopas Take-Away Frias');
INSERT INTO shelve VALUES (2, 9, 'manuf3', 10, 'Sopas Take-Away Quentes');
INSERT INTO shelve VALUES (3, 9, 'manuf3', 10, 'Sopas Bebé');
INSERT INTO shelve VALUES (4, 9, 'manuf3', 15, 'Sumo Natural');

INSERT INTO shelve VALUES (1, 10, 'manuf4', 10, 'Bolachas de Criança');
INSERT INTO shelve VALUES (2, 10, 'manuf4', 10, 'Sumos Naturais');
INSERT INTO shelve VALUES (3, 10, 'manuf4', 10, 'Sopas Bebé');
INSERT INTO shelve VALUES (4, 10, 'manuf4', 15, 'Água');

INSERT INTO shelve VALUES (1, 11, 'manuf4', 10, 'Sopas');
INSERT INTO shelve VALUES (2, 11, 'manuf4', 10, 'Sumos Naturais');
INSERT INTO shelve VALUES (3, 11, 'manuf4', 10, 'Sopas Bebé');
INSERT INTO shelve VALUES (4, 11, 'manuf4', 15, 'Água');

INSERT INTO shelve VALUES (1, 12, 'manuf4', 10, 'Refrigerantes com Gás');
INSERT INTO shelve VALUES (2, 12, 'manuf4', 10, 'Bolachas');
INSERT INTO shelve VALUES (3, 12, 'manuf4', 10, 'Sumos');
INSERT INTO shelve VALUES (4, 12, 'manuf4', 15, 'Água');

-------------- Planogram --------------
INSERT INTO planogram VALUES (1, 1, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (2, 1, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (3, 1, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (2, 2, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (7, 3, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (8, 3, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (9, 3, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (10, 4, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (12, 4, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (13, 5, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (14, 5, 1, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (19, 6, 1, 'manuf1',, 0, 0, 'loc');
INSERT INTO planogram VALUES (20, 6, 1, 'manuf1',, 0, 0, 'loc');
INSERT INTO planogram VALUES (21, 6, 1, 'manuf1',, 0, 0, 'loc');

INSERT INTO planogram VALUES (7, 1, 2, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (10, 2, 2, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (12, 2, 2, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (15, 3, 2, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (16, 3, 2, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (17, 4, 2, 'manuf1', 0, 0, 'loc');

INSERT INTO planogram VALUES (2, 1, 3, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (8, 2, 3, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (17, 3, 3, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (19, 4, 3, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (20, 4, 3, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (24, 4, 3, 'manuf1', 0, 0, 'loc');
INSERT INTO planogram VALUES (21, 5, 3, 'manuf1', 0, 0, 'loc');

INSERT INTO planogram VALUES (1, 1, 4, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (6, 1, 4, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (23, 2, 4, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (24, 2, 4, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (10, 3, 4, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (12, 3, 4, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (2, 4, 4, 'manuf2', 0, 0, 'loc');

INSERT INTO planogram VALUES (7, 1, 5, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (9, 1, 5, 'manuf2', 0, 0, 'loc');

INSERT INTO planogram VALUES (12, 2, 5, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (15, 3, 5, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (16, 3, 5, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (18, 4, 5, 'manuf2', 0, 0, 'loc');


INSERT INTO planogram VALUES (1, 1, 6, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (3, 1, 6, 'manuf2', 0, 0, 'loc');

INSERT INTO planogram VALUES (0, 2, 6, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (8, 3, 6, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (9, 3, 6, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (10, 4, 6, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (13, 5, 6, 'manuf2', 0, 0, 'loc');
INSERT INTO planogram VALUES (19, 6, 6, 'manuf2', 0, 0, 'loc');

INSERT INTO planogram VALUES (4, 1, 7, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (5, 1, 7, 'manuf3', 0, 0, 'loc');

INSERT INTO planogram VALUES (21, 2, 7, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (22, 2, 7, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (23, 2, 7, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (24, 2, 7, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (11, 3, 7, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (1, 4, 7, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (3, 4, 7, 'manuf3', 0, 0, 'loc');


INSERT INTO planogram VALUES (21, 1, 8, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (19, 2, 8, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (24, 2, 8, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (22, 3, 8, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (9, 4, 8, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (7, 4, 8, 'manuf3', 0, 0, 'loc');


INSERT INTO planogram VALUES (4, 1, 9, 'manuf3', 10, 0, 0, 'loc');
INSERT INTO planogram VALUES (1, 2, 9, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (3, 2, 9, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (2, 3, 9, 'manuf3', 0, 0, 'loc');
INSERT INTO planogram VALUES (13, 4, 9, 'manuf3', 0, 0, 'loc');

INSERT INTO planogram VALUES (23, 1, 10, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (13, 2, 10, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (14, 2, 10, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (2, 3, 10, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (7, 4, 10, 'manuf4', 0, 0, 'loc');

INSERT INTO planogram VALUES (5, 1, 11, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (13, 2, 11, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (14, 2, 11, 'manuf4', 0, 0, 'loc');

INSERT INTO planogram VALUES (2, 3, 11, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (7, 4, 11, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (8, 4, 11, 'manuf4', 0, 0, 'loc');

INSERT INTO planogram VALUES (12, 1, 12, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (19, 2, 12, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (20, 2, 12, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (21, 2, 12, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (13, 3, 12, 'manuf4', 0, 0, 'loc');
INSERT INTO planogram VALUES (7, 4, 12, 'manuf4' 0, 0, 'loc');
