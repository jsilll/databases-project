-- Qual o nome do retalhista (ou retalhistas) responsáveis pela reposição do maior número de categorias?
SELECT retailer_name
FROM retailer NATURAL JOIN responsible_for
GROUP BY tin
HAVING COUNT(*) >= ALL(
  SELECT COUNT(*)
  FROM responsible_for
  GROUP BY tin
);

-- Qual o nome do ou dos retalhistas que são responsáveis por todas as categorias simples? TODO
SELECT DISTINCT retailer_name
FROM retailer
NATURAL JOIN responsible_for
NATURAL JOIN simple_category;

-- Quais os produtos (ean) que nunca foram repostos?
SELECT ean
FROM product
WHERE ean NOT IN (
  SELECT ean
  FROM replenishment_event
);

-- Quais os produtos (ean) que foram repostos sempre pelo mesmo retalhista?
SELECT ean, COUNT(DISTINCT(tin))
FROM replenishment_event
GROUP BY ean
HAVING COUNT(DISTINCT(tin)) = 1;