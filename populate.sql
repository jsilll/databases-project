----------------------------------------
-- Populate Relations 
----------------------------------------

-------------- Category --------------
INSERT INTO category VALUES ('Sopas'); -- super categoria
INSERT INTO category VALUES ('Sopas Take-Away'); -- subcategoria de sopas / super categoria
INSERT INTO category VALUES ('Sopas Bebé'); -- subcategoria de sopas / cat simples
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
INSERT INTO product VALUES (20, 'Chips Ahoy');
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
INSERT INTO installed_at VALUES (12, 'manuf4', 'Centro de Évora');

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
INSERT INTO shelve VALUES (4, 9, 'manuf3', 15, 'Sumos Naturais');

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
INSERT INTO planogram VALUES (1, 1, 1, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (4, 1, 1, 'manuf1', 3, 15, 'loc');
INSERT INTO planogram VALUES (3, 1, 1, 'manuf1', 1, 5, 'loc');
INSERT INTO planogram VALUES (2, 2, 1, 'manuf1', 6, 30, 'loc');
INSERT INTO planogram VALUES (7, 3, 1, 'manuf1', 3, 25, 'loc');
INSERT INTO planogram VALUES (8, 3, 1, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (9, 3, 1, 'manuf1', 1, 5, 'loc');
INSERT INTO planogram VALUES (10, 4, 1, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (12, 4, 1, 'manuf1', 4, 20, 'loc');
INSERT INTO planogram VALUES (13, 5, 1, 'manuf1', 1, 5, 'loc');
INSERT INTO planogram VALUES (14, 5, 1, 'manuf1', 5, 25, 'loc');
INSERT INTO planogram VALUES (19, 6, 1, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (20, 6, 1, 'manuf1', 3, 15, 'loc');
INSERT INTO planogram VALUES (21, 6, 1, 'manuf1', 1, 5, 'loc');

INSERT INTO planogram VALUES (7, 1, 2, 'manuf1', 6, 30, 'loc');
INSERT INTO planogram VALUES (10, 2, 2, 'manuf1', 3, 15, 'loc');
INSERT INTO planogram VALUES (12, 2, 2, 'manuf1', 3, 15, 'loc');
INSERT INTO planogram VALUES (15, 3, 2, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (16, 3, 2, 'manuf1', 4, 20, 'loc');
INSERT INTO planogram VALUES (17, 4, 2, 'manuf1', 6, 30, 'loc');

INSERT INTO planogram VALUES (2, 1, 3, 'manuf1', 6, 30, 'loc');
INSERT INTO planogram VALUES (8, 2, 3, 'manuf1', 6, 30, 'loc');
INSERT INTO planogram VALUES (17, 3, 3, 'manuf1', 6, 30, 'loc');
INSERT INTO planogram VALUES (19, 4, 3, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (20, 4, 3, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (24, 4, 3, 'manuf1', 2, 10, 'loc');
INSERT INTO planogram VALUES (21, 5, 3, 'manuf1', 6, 30, 'loc');

INSERT INTO planogram VALUES (1, 1, 4, 'manuf2', 2, 10, 'loc');
INSERT INTO planogram VALUES (6, 1, 4, 'manuf2', 4, 20, 'loc');
INSERT INTO planogram VALUES (23, 2, 4, 'manuf2', 1, 5, 'loc');
INSERT INTO planogram VALUES (24, 2, 4, 'manuf2', 5, 25, 'loc');
INSERT INTO planogram VALUES (10, 3, 4, 'manuf2', 3, 15, 'loc');
INSERT INTO planogram VALUES (12, 3, 4, 'manuf2', 3, 15, 'loc');
INSERT INTO planogram VALUES (2, 4, 4, 'manuf2', 6, 30, 'loc');

INSERT INTO planogram VALUES (7, 1, 5, 'manuf2', 4, 20, 'loc');
INSERT INTO planogram VALUES (9, 1, 5, 'manuf2', 2, 10, 'loc');
INSERT INTO planogram VALUES (12, 2, 5, 'manuf2', 6, 30, 'loc');
INSERT INTO planogram VALUES (15, 3, 5, 'manuf2', 1, 5, 'loc');
INSERT INTO planogram VALUES (16, 3, 5, 'manuf2', 5, 25, 'loc');
INSERT INTO planogram VALUES (18, 4, 5, 'manuf2', 6, 30, 'loc');

INSERT INTO planogram VALUES (1, 1, 6, 'manuf2', 2, 10, 'loc');
INSERT INTO planogram VALUES (3, 1, 6, 'manuf2', 4, 20, 'loc');
INSERT INTO planogram VALUES (2, 2, 6, 'manuf2', 6, 30, 'loc');
INSERT INTO planogram VALUES (8, 3, 6, 'manuf2', 1, 5, 'loc');
INSERT INTO planogram VALUES (9, 3, 6, 'manuf2', 5, 25, 'loc');
INSERT INTO planogram VALUES (10, 4, 6, 'manuf2', 6, 30, 'loc');
INSERT INTO planogram VALUES (13, 5, 6, 'manuf2', 6, 30, 'loc');
INSERT INTO planogram VALUES (19, 6, 6, 'manuf2', 6, 30, 'loc');

INSERT INTO planogram VALUES (4, 1, 7, 'manuf3', 2, 10, 'loc');
INSERT INTO planogram VALUES (5, 1, 7, 'manuf3', 4, 20, 'loc');
INSERT INTO planogram VALUES (21, 2, 7, 'manuf3', 1, 5, 'loc');
INSERT INTO planogram VALUES (22, 2, 7, 'manuf3', 1, 5, 'loc');
INSERT INTO planogram VALUES (23, 2, 7, 'manuf3', 1, 5, 'loc');
INSERT INTO planogram VALUES (24, 2, 7, 'manuf3', 3, 15, 'loc');
INSERT INTO planogram VALUES (11, 3, 7, 'manuf3', 6, 30, 'loc');
INSERT INTO planogram VALUES (1, 4, 7, 'manuf3', 3, 15, 'loc');
INSERT INTO planogram VALUES (3, 4, 7, 'manuf3', 3, 15, 'loc');


INSERT INTO planogram VALUES (21, 1, 8, 'manuf3', 6, 30, 'loc');
INSERT INTO planogram VALUES (19, 2, 8, 'manuf3', 3, 15, 'loc');
INSERT INTO planogram VALUES (24, 2, 8, 'manuf3', 3, 15, 'loc');
INSERT INTO planogram VALUES (22, 3, 8, 'manuf3', 6, 30, 'loc');
INSERT INTO planogram VALUES (9, 4, 8, 'manuf3', 3, 15, 'loc');
INSERT INTO planogram VALUES (7, 4, 8, 'manuf3', 3, 15, 'loc');


INSERT INTO planogram VALUES (4, 1, 9, 'manuf3', 6, 30, 'loc');
INSERT INTO planogram VALUES (1, 2, 9, 'manuf3', 2, 10, 'loc');
INSERT INTO planogram VALUES (3, 2, 9, 'manuf3', 4, 20, 'loc');
INSERT INTO planogram VALUES (2, 3, 9, 'manuf3', 6, 30, 'loc');
INSERT INTO planogram VALUES (13, 4, 9, 'manuf3', 6, 30, 'loc');

INSERT INTO planogram VALUES (23, 1, 10, 'manuf4', 6, 30, 'loc');
INSERT INTO planogram VALUES (13, 2, 10, 'manuf4', 1, 5, 'loc');
INSERT INTO planogram VALUES (14, 2, 10, 'manuf4', 5, 25, 'loc');
INSERT INTO planogram VALUES (2, 3, 10, 'manuf4', 6, 30, 'loc');
INSERT INTO planogram VALUES (7, 4, 10, 'manuf4', 6, 30, 'loc');

INSERT INTO planogram VALUES (5, 1, 11, 'manuf4', 6, 30, 'loc');
INSERT INTO planogram VALUES (13, 2, 11, 'manuf4', 2, 10, 'loc');
INSERT INTO planogram VALUES (14, 2, 11, 'manuf4', 4, 20, 'loc');
INSERT INTO planogram VALUES (2, 3, 11, 'manuf4', 6, 30, 'loc');
INSERT INTO planogram VALUES (7, 4, 11, 'manuf4', 3, 15, 'loc');
INSERT INTO planogram VALUES (8, 4, 11, 'manuf4', 3, 15, 'loc');

INSERT INTO planogram VALUES (12, 1, 12, 'manuf4', 6, 30, 'loc');
INSERT INTO planogram VALUES (19, 2, 12, 'manuf4', 3, 15, 'loc');
INSERT INTO planogram VALUES (20, 2, 12, 'manuf4', 1, 5, 'loc');
INSERT INTO planogram VALUES (21, 2, 12, 'manuf4', 2, 10, 'loc');
INSERT INTO planogram VALUES (13, 3, 12, 'manuf4', 6, 30, 'loc');
INSERT INTO planogram VALUES (7, 4, 12, 'manuf4', 6, 30, 'loc');

-------------- Retailer --------------
INSERT INTO retailer VALUES (1, 'João');
INSERT INTO retailer VALUES (2, 'Manuel');
INSERT INTO retailer VALUES (3, 'Francisco');
INSERT INTO retailer VALUES (4, 'Inês');
INSERT INTO retailer VALUES (5, 'Hugo');
INSERT INTO retailer VALUES (6, 'Luís');
INSERT INTO retailer VALUES (7, 'José');
INSERT INTO retailer VALUES (8, 'Rita');
INSERT INTO retailer VALUES (9, 'Maria');
INSERT INTO retailer VALUES (10, 'Diogo');
INSERT INTO retailer VALUES (11, 'Joana');
INSERT INTO retailer VALUES (12, 'Carolina');

-------------- responsible_for --------------
INSERT INTO responsible_for VALUES ('Sopas', 1, 1, 'manuf1');
INSERT INTO responsible_for VALUES ('Sopas Bebé', 1, 1, 'manuf1');
INSERT INTO responsible_for VALUES ('Água', 2, 1, 'manuf1');
INSERT INTO responsible_for VALUES ('Refrigerantes com Gás', 2, 1, 'manuf1');
INSERT INTO responsible_for VALUES ('Sumos Naturais', 2, 1, 'manuf1');
INSERT INTO responsible_for VALUES ('Bolachas', 3, 1, 'manuf1');

INSERT INTO responsible_for VALUES ('Água', 2, 2, 'manuf1');
INSERT INTO responsible_for VALUES ('Refrigerantes com Gás', 2, 2, 'manuf1');
INSERT INTO responsible_for VALUES ('Sumos com Conservantes', 3, 2, 'manuf1');
INSERT INTO responsible_for VALUES ('Cerveja', 4, 2, 'manuf1');

INSERT INTO responsible_for VALUES ('Sopas Bebé', 1, 3, 'manuf1');
INSERT INTO responsible_for VALUES ('Água', 2, 3, 'manuf1');
INSERT INTO responsible_for VALUES ('Cerveja', 4, 3, 'manuf1');
INSERT INTO responsible_for VALUES ('Bolachas de Chocolate', 3, 3, 'manuf1');
INSERT INTO responsible_for VALUES ('Bolachas de Água e Sal', 1, 3, 'manuf1');

INSERT INTO responsible_for VALUES ('Sopas', 1, 4, 'manuf2');
INSERT INTO responsible_for VALUES ('Bolachas', 3, 4, 'manuf2');
INSERT INTO responsible_for VALUES ('Refrigerantes', 2, 4, 'manuf2');
INSERT INTO responsible_for VALUES ('Sopas Bebé', 1, 4, 'manuf2');

INSERT INTO responsible_for VALUES ('Água', 2, 5, 'manuf2');
INSERT INTO responsible_for VALUES ('Refrigerantes com Gás', 2, 5, 'manuf2');
INSERT INTO responsible_for VALUES ('Sumos com Conservantes', 3, 5, 'manuf2');
INSERT INTO responsible_for VALUES ('Cerveja', 4, 5, 'manuf2');

INSERT INTO responsible_for VALUES ('Sopas', 5, 6, 'manuf2');
INSERT INTO responsible_for VALUES ('Sopas Bebé', 5, 6, 'manuf2');
INSERT INTO responsible_for VALUES ('Água', 6, 6, 'manuf2');
INSERT INTO responsible_for VALUES ('Refrigerantes com Gás', 6, 6, 'manuf2');
INSERT INTO responsible_for VALUES ('Sumos Naturais', 6, 6, 'manuf2');
INSERT INTO responsible_for VALUES ('Bolachas', 5, 6, 'manuf2');

INSERT INTO responsible_for VALUES ('Sopas', 7, 7, 'manuf3');
INSERT INTO responsible_for VALUES ('Bolachas', 8, 7, 'manuf3');
INSERT INTO responsible_for VALUES ('Refrigerantes sem Gás', 9, 7, 'manuf3');
INSERT INTO responsible_for VALUES ('Sopas Take-Away', 7, 7, 'manuf3');

INSERT INTO responsible_for VALUES ('Bolachas de Água e Sal', 8, 8, 'manuf3');
INSERT INTO responsible_for VALUES ('Bolachas de Chocolate', 8, 8, 'manuf3');
INSERT INTO responsible_for VALUES ('Bolachas de Criança', 8, 8, 'manuf3');
INSERT INTO responsible_for VALUES ('Água', 9, 8, 'manuf3');

INSERT INTO responsible_for VALUES ('Sopas Take-Away Frias', 7, 9, 'manuf3');
INSERT INTO responsible_for VALUES ('Sopas Take-Away Quentes', 7, 9, 'manuf3');
INSERT INTO responsible_for VALUES ('Sopas Bebé', 7, 9, 'manuf3');
INSERT INTO responsible_for VALUES ('Sumos Naturais', 9, 9, 'manuf3');

INSERT INTO responsible_for VALUES ('Bolachas de Criança', 10, 10, 'manuf4');
INSERT INTO responsible_for VALUES ('Sumos Naturais', 10, 10, 'manuf4');
INSERT INTO responsible_for VALUES ('Sopas Bebé', 10, 10, 'manuf4');
INSERT INTO responsible_for VALUES ('Água', 10, 10, 'manuf4');

INSERT INTO responsible_for VALUES ('Sopas', 7, 11, 'manuf4');
INSERT INTO responsible_for VALUES ('Sumos Naturais', 9, 11, 'manuf4');
INSERT INTO responsible_for VALUES ('Sopas Bebé', 7, 11, 'manuf4');
INSERT INTO responsible_for VALUES ('Água', 9, 11, 'manuf4');

INSERT INTO responsible_for VALUES ('Refrigerantes com Gás', 11, 12, 'manuf4');
INSERT INTO responsible_for VALUES ('Bolachas', 12, 12, 'manuf4');
INSERT INTO responsible_for VALUES ('Sumos', 11, 12, 'manuf4');
INSERT INTO responsible_for VALUES ('Água', 12, 12, 'manuf4');

-------------- Replenishment Event --------------
INSERT INTO replenishment_event VALUES (1, 1, 1, 'manuf1', '2021-10-21 14:02', 10, 1);
INSERT INTO replenishment_event VALUES (1, 1, 1, 'manuf1', '2021-10-30 13:47', 7, 1);
INSERT INTO replenishment_event VALUES (1, 1, 1, 'manuf1', '2021-11-03 11:24', 2, 1);

INSERT INTO replenishment_event VALUES (4, 1, 1, 'manuf1', '2021-09-08 09:02', 15, 1);
INSERT INTO replenishment_event VALUES (4, 1, 1, 'manuf1', '2021-10-23 12:04', 15, 1);

INSERT INTO replenishment_event VALUES (3, 1, 1, 'manuf1', '2021-10-21 14:02', 2, 1);

INSERT INTO replenishment_event VALUES (2, 2, 1, 'manuf1', '2021-09-27 17:25', 27, 1);
INSERT INTO replenishment_event VALUES (2, 2, 1, 'manuf1', '2021-10-15 11:37', 26, 1);

INSERT INTO replenishment_event VALUES (7, 3, 1, 'manuf1', '2021-10-21 19:25', 22, 2);
INSERT INTO replenishment_event VALUES (8, 3, 1, 'manuf1', '2021-10-21 15:43', 7, 2);
INSERT INTO replenishment_event VALUES (9, 3, 1, 'manuf1', '2021-10-21 09:55', 5, 2);
INSERT INTO replenishment_event VALUES (9, 3, 1, 'manuf1', '2021-10-21 08:12', 4, 2);

INSERT INTO replenishment_event VALUES (10, 4, 1, 'manuf1', '2021-10-22 17:02', 10, 2);
INSERT INTO replenishment_event VALUES (12, 4, 1, 'manuf1', '2021-10-22 17:10', 20, 2);

INSERT INTO replenishment_event VALUES (13, 5, 1, 'manuf1', '2021-10-15 09:47', 4, 2);
INSERT INTO replenishment_event VALUES (14, 5, 1, 'manuf1', '2021-10-15 10:02', 21, 2);

INSERT INTO replenishment_event VALUES (19, 6, 1, 'manuf1', '2021-10-05 14:16', 9, 3);
INSERT INTO replenishment_event VALUES (20, 6, 1, 'manuf1', '2021-10-03 15:30', 12, 3);
INSERT INTO replenishment_event VALUES (21, 6, 1, 'manuf1', '2021-09-27 16:45', 5, 3);

INSERT INTO replenishment_event VALUES (7, 1, 2, 'manuf1', '2021-10-07 14:16', 27, 2);

INSERT INTO replenishment_event VALUES (10, 2, 2, 'manuf1', '2021-10-22 14:16', 12, 2);
INSERT INTO replenishment_event VALUES (10, 2, 2, 'manuf1', '2021-11-05 17:22', 10, 2);
INSERT INTO replenishment_event VALUES (12, 2, 2, 'manuf1', '2021-10-26 19:34', 15, 2);

INSERT INTO replenishment_event VALUES (15, 3, 2, 'manuf1', '2021-09-27 19:16', 9, 3);
INSERT INTO replenishment_event VALUES (15, 3, 2, 'manuf1', '2021-09-16 15:16', 10, 3);
INSERT INTO replenishment_event VALUES (15, 3, 2, 'manuf1', '2021-09-22 13:16', 10, 3);
INSERT INTO replenishment_event VALUES (16, 3, 2, 'manuf1', '2021-11-12 10:42', 20, 3);
INSERT INTO replenishment_event VALUES (16, 3, 2, 'manuf1', '2021-10-10 12:23', 18, 3);
INSERT INTO replenishment_event VALUES (16, 3, 2, 'manuf1', '2021-09-22 20:16', 16, 3);

INSERT INTO replenishment_event VALUES (17, 4, 2, 'manuf1', '2021-10-05 15:12', 16, 4);
INSERT INTO replenishment_event VALUES (17, 4, 2, 'manuf1', '2021-10-14 10:20', 27, 4);
INSERT INTO replenishment_event VALUES (17, 4, 2, 'manuf1', '2021-11-02 09:24', 22, 4);

INSERT INTO replenishment_event VALUES (2, 1, 3, 'manuf1', '2021-11-06 18:16', 30, 1);

INSERT INTO replenishment_event VALUES (8, 2, 3, 'manuf1', '2021-10-05 14:24', 30, 2);
INSERT INTO replenishment_event VALUES (8, 2, 3, 'manuf1', '2021-10-17 16:54', 27, 2);

INSERT INTO replenishment_event VALUES (17, 3, 3, 'manuf1', '2021-09-24 15:16', 30, 4);

INSERT INTO replenishment_event VALUES (19, 4, 3, 'manuf1', '2021-10-17 19:31', 8, 3);
INSERT INTO replenishment_event VALUES (19, 4, 3, 'manuf1', '2021-10-26 16:24', 9, 3);
INSERT INTO replenishment_event VALUES (20, 4, 3, 'manuf1', '2021-10-20 08:46', 10, 3);
INSERT INTO replenishment_event VALUES (20, 4, 3, 'manuf1', '2021-11-02 17:27', 10, 3);
INSERT INTO replenishment_event VALUES (24, 4, 3, 'manuf1', '2021-09-18 20:36', 7, 3);

INSERT INTO replenishment_event VALUES (21, 5, 3, 'manuf1', '2021-11-03 12:01', 27, 1);
INSERT INTO replenishment_event VALUES (21, 5, 3, 'manuf1', '2021-10-30 13:34', 19, 1);
INSERT INTO replenishment_event VALUES (21, 5, 3, 'manuf1', '2021-10-10 17:24', 24, 1);

INSERT INTO replenishment_event VALUES (1, 1, 4, 'manuf2', '2021-10-21 14:02', 9, 1);
INSERT INTO replenishment_event VALUES (6, 1, 4, 'manuf2', '2021-11-07 17:21', 20, 1);
INSERT INTO replenishment_event VALUES (23, 2, 4, 'manuf2', '2021-11-03 16:34', 4, 3);
INSERT INTO replenishment_event VALUES (24, 2, 4, 'manuf2', '2021-11-03 18:22', 22, 3);
INSERT INTO replenishment_event VALUES (10, 3, 4, 'manuf2', '2021-10-22 19:28', 12, 2);
INSERT INTO replenishment_event VALUES (12, 3, 4, 'manuf2', '2021-10-22 20:01', 15, 2);
INSERT INTO replenishment_event VALUES (2, 4, 4, 'manuf2', '2021-09-24 09:53', 28, 1);

INSERT INTO replenishment_event VALUES (7, 1, 5, 'manuf2', '2021-09-29 12:12', 20, 2);
INSERT INTO replenishment_event VALUES (7, 1, 5, 'manuf2', '2021-10-23 18:05', 18, 2);
INSERT INTO replenishment_event VALUES (7, 1, 5, 'manuf2', '2021-11-04 13:54', 20, 2);
INSERT INTO replenishment_event VALUES (9, 1, 5, 'manuf2', '2021-09-29 12:04', 6, 2);
INSERT INTO replenishment_event VALUES (9, 1, 5, 'manuf2', '2021-10-23 18:05', 7, 2);
INSERT INTO replenishment_event VALUES (9, 1, 5, 'manuf2', '2021-11-04 13:54', 9, 2);

INSERT INTO replenishment_event VALUES (12, 2, 5, 'manuf2', '2021-11-07 12:04', 30, 2);

INSERT INTO replenishment_event VALUES (15, 3, 5, 'manuf2', '2021-11-04 15:09', 5, 3);
INSERT INTO replenishment_event VALUES (15, 3, 5, 'manuf2', '2021-10-23 19:04', 5, 3);

INSERT INTO replenishment_event VALUES (16, 3, 5, 'manuf2', '2021-11-01 12:04', 25, 3);

INSERT INTO replenishment_event VALUES (18, 4, 5, 'manuf2', '2021-10-14 12:04', 30, 4);
INSERT INTO replenishment_event VALUES (18, 4, 5, 'manuf2', '2021-11-06 18:16', 27, 4);

INSERT INTO replenishment_event VALUES (1, 1, 6, 'manuf2', '2021-11-04 17:09', 9, 5);
INSERT INTO replenishment_event VALUES (3, 1, 6, 'manuf2', '2021-11-04 15:17', 17, 5);
INSERT INTO replenishment_event VALUES (2, 2, 6, 'manuf2', '2021-11-07 19:17', 25, 5);
INSERT INTO replenishment_event VALUES (8, 3, 6, 'manuf2', '2021-10-23 15:42', 4, 6);
INSERT INTO replenishment_event VALUES (9, 3, 6, 'manuf2', '2021-10-23 15:51', 25, 6);
INSERT INTO replenishment_event VALUES (10, 4, 6, 'manuf2', '2021-09-22 19:47', 29, 6);
INSERT INTO replenishment_event VALUES (13, 5, 6, 'manuf2', '2021-09-22 19:42', 30, 6);
INSERT INTO replenishment_event VALUES (19, 6, 6, 'manuf2', '2021-10-17 15:24', 27, 5);

INSERT INTO replenishment_event VALUES (4, 1, 7, 'manuf3', '2021-10-22 17:24', 9, 7);
INSERT INTO replenishment_event VALUES (4, 1, 7, 'manuf3', '2021-11-05 18:46', 7, 7);
INSERT INTO replenishment_event VALUES (5, 1, 7, 'manuf3', '2021-10-22 17:46', 18, 7);
INSERT INTO replenishment_event VALUES (5, 1, 7, 'manuf3', '2021-11-05 18:54', 17, 7);
INSERT INTO replenishment_event VALUES (21, 2, 7, 'manuf3', '2021-10-30 09:04', 5, 8);
INSERT INTO replenishment_event VALUES (21, 2, 7, 'manuf3', '2021-11-02 12:10', 3, 8);
INSERT INTO replenishment_event VALUES (22, 2, 7, 'manuf3', '2021-10-30 09:16', 4, 8);
INSERT INTO replenishment_event VALUES (22, 2, 7, 'manuf3', '2021-11-02 12:16', 5, 8);
INSERT INTO replenishment_event VALUES (23, 2, 7, 'manuf3', '2021-10-30 09:22', 5, 8);
INSERT INTO replenishment_event VALUES (24, 2, 7, 'manuf3', '2021-10-30 09:01', 12, 8);
INSERT INTO replenishment_event VALUES (1, 4, 7, 'manuf3', '2021-11-02 15:24', 14, 7);
INSERT INTO replenishment_event VALUES (3, 4, 7, 'manuf3', '2021-11-02 15:28', 15, 7);
INSERT INTO replenishment_event VALUES (3, 4, 7, 'manuf3', '2021-11-07 09:10', 12, 7);


INSERT INTO replenishment_event VALUES (21, 1, 8, 'manuf3', '2021-10-24 08:47', 25, 8);
INSERT INTO replenishment_event VALUES (19, 2, 8, 'manuf3', '2021-10-24 11:10', 14, 8);
INSERT INTO replenishment_event VALUES (24, 2, 8, 'manuf3', '2021-10-24 11:15', 15, 8);
INSERT INTO replenishment_event VALUES (22, 3, 8, 'manuf3', '2021-10-15 14:36', 29, 8);
INSERT INTO replenishment_event VALUES (9, 4, 8, 'manuf3', '2021-10-18 10:17', 12, 9);
INSERT INTO replenishment_event VALUES (7, 4, 8, 'manuf3', '2021-10-18 11:24', 7, 9);

INSERT INTO replenishment_event VALUES (4, 1, 9, 'manuf3', '2021-10-22 10:44', 30, 7);
INSERT INTO replenishment_event VALUES (1, 2, 9, 'manuf3', '2021-10-22 11:34', 10, 7);
INSERT INTO replenishment_event VALUES (3, 2, 9, 'manuf3', '2021-10-22 11:42', 20, 7);
INSERT INTO replenishment_event VALUES (2, 3, 9, 'manuf3', '2021-10-22 14:23', 30, 7);
INSERT INTO replenishment_event VALUES (13, 4, 9, 'manuf3', '2021-10-22 17:34', 30, 9);

INSERT INTO replenishment_event VALUES (23, 1, 10, 'manuf4', '2021-10-14 09:42', 30, 10);
INSERT INTO replenishment_event VALUES (13, 2, 10, 'manuf4', '2021-10-14 09:49', 5, 10);
INSERT INTO replenishment_event VALUES (14, 2, 10, 'manuf4', '2021-10-14 10:02', 25, 10);
INSERT INTO replenishment_event VALUES (2, 3, 10, 'manuf4', '2021-10-14 12:45', 30, 10);
INSERT INTO replenishment_event VALUES (7, 4, 10, 'manuf4', '2021-10-14 19:32', 30, 10);

INSERT INTO replenishment_event VALUES (5, 1, 11, 'manuf4', '2021-10-17 09:42', 30, 7);
INSERT INTO replenishment_event VALUES (5, 1, 11, 'manuf4', '2021-10-24 10:35', 27, 7);
INSERT INTO replenishment_event VALUES (13, 2, 11, 'manuf4', '2021-10-14 09:42', 10, 9);
INSERT INTO replenishment_event VALUES (13, 2, 11, 'manuf4', '2021-11-02 17:23', 10, 9);
INSERT INTO replenishment_event VALUES (14, 2, 11, 'manuf4', '2021-10-14 13:30', 20, 9);
INSERT INTO replenishment_event VALUES (2, 3, 11, 'manuf4', '2021-10-17 09:24', 30, 7);
INSERT INTO replenishment_event VALUES (7, 4, 11, 'manuf4', '2021-10-17 12:52', 15, 9);
INSERT INTO replenishment_event VALUES (8, 4, 11, 'manuf4', '2021-10-14 08:24', 15, 9);

INSERT INTO replenishment_event VALUES (12, 1, 12, 'manuf4', '2021-11-02 17:24', 30, 11);
INSERT INTO replenishment_event VALUES (19, 2, 12, 'manuf4', '2021-11-03 08:24', 15, 12);
INSERT INTO replenishment_event VALUES (20, 2, 12, 'manuf4', '2021-11-03 08:35', 5, 12);
INSERT INTO replenishment_event VALUES (21, 2, 12, 'manuf4', '2021-11-03 08:42', 10, 12);
INSERT INTO replenishment_event VALUES (13, 3, 12, 'manuf4', '2021-11-02 10:37', 30, 11);
INSERT INTO replenishment_event VALUES (7, 4, 12, 'manuf4', '2021-11-03 08:53', 30, 12);