-- 7.1
-- SELECT DISTINCT R.nome
-- FROM retalhista R, responsavel_por P
-- WHERE R.tin = P.tin and P.nome_cat = 'Frutos'

CREATE INDEX name_index ON retailer(retailer_name);

-- 7.2 -
-- SELECT T.nome, count(T.ean)
-- FROM produto P, tem_categoria T
-- WHERE P.cat = T.nome and P.desc like 'A%'
-- GROUP BY T.nome

CREATE INDEX desc_index ON product USING HASH (descr);
