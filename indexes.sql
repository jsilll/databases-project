-- Este ficheiro não vai estar presente na entrega final --

-- Meramente ilustrativo para mostrar a criação dos índices e apresentar
-- a justificação para os mesmos (facilita a escrita do relatório)

-- 7.1
-- SELECT DISTINCT R.nome
-- FROM retalhista R, responsavel_por P
-- WHERE R.tin = P.tin and P.nome_cat = 'Frutos'

CREATE INDEX retailer_name_index ON retailer(retailer_name)
-- R.tin é uma chave primária, e P.tin e P.nome_cat são chaves estrangeiras, pelo que não
-- há necessidade de de criar indices sobre estes atributos, no entanto, o
-- SELECT DISTINCT remove duplicados, ou seja, há um sorting, pelo que deve haver
-- um índice em R.nome


-- 7.2 -
-- SELECT T.nome, count(T.ean)
-- FROM produto P, tem_categoria T
-- WHERE P.cat = T.nome and P.desc like 'A%'
-- GROUP BY T.nome

CREATE INDEX descr_index ON product(descr)
-- P.cat e T.nome são chaves estrangeiras, e como tal não precisam que se crie índices
-- porque já são criados por defeito. Mas é benéfico criar um índice em P.desc para ajudar 
-- na clausula WHERE P.desc like 'A%'.
