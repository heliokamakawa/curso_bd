USE aula;
-- inserções de venda
INSERT INTO venda (cliente_id,data_venda) VALUES (1,'2022-01-20');
SET @id_venda1 = (SELECT LAST_INSERT_ID());
INSERT INTO venda (cliente_id,data_venda) VALUES (1,'2022-02-22');
SET @id_venda2 = (SELECT LAST_INSERT_ID());
INSERT INTO venda (cliente_id,data_venda) VALUES (2,'2022-04-01');
SET @id_venda3 = (SELECT LAST_INSERT_ID());
INSERT INTO venda (cliente_id,data_venda) VALUES (1,'2022-05-03');
SET @id_venda4 = (SELECT LAST_INSERT_ID());
INSERT INTO venda (cliente_id,data_venda) VALUES (3,'2022-06-14');
SET @id_venda5 = (SELECT LAST_INSERT_ID());

SET @preco_coca = (SELECT preco_venda FROM produto WHERE nome = 'COCA-COLA');
SET @preco_choquito = (SELECT preco_venda FROM produto WHERE nome = 'CHOKITO');
SET @preco_baconzitos = (SELECT preco_venda FROM produto WHERE nome = 'BACONZITOS');

-- ***************EXEMPLO TRIGGER 01 - Impedir vendas fora do horário comercial***************
-- trocar delimitador
-- criar trigger venda_horario_comercial 
-- tempo --evento --tabela --para cada linha
-- início
    -- se não é hora comeracial então 
		-- gerar erro
	-- fim do if
-- fim
-- fim criação trigger
-- voltar delimitador

-- teste 
INSERT INTO venda (cliente_id) VALUES (2);

-- altere a trigger para que funcione

-- ***************EXEMPLO TRIGGER 02 - atualização de estoque na inserção ***************
-- trocar delimitador
-- criar trigger impedir_venda_cliente_inativo 
-- tempo --evento --tabela --para cada linha
-- início 
	-- declarar cliente_ativo CHAR(1); 
    -- consulta para pegar o valor do atributo ativo do cliente 
    -- se cliente_ativo é 'N' então
		-- gerar erro
	-- fim do if
-- fim
-- fim criação trigger
-- voltar delimitador

-- teste 
INSERT INTO venda (cliente_id) VALUES (4); -- deverá gerar erro



-- alterar sequência trigger FOLLOWS
-- alterar sequência trigger PRECEDES


-- ***************EXEMPLO TRIGGER 03 - atualização de estoque na inserção ***************
-- trocar o delimitador
-- criar trigger atualiza_estoque
-- tempo --evento --tabela --para cada linha
-- inicio 
	-- alterar estoque
-- fim
-- fim criação trigger
-- vaoltar o delimitador

-- teste 
INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (2,@id_venda1,3,@preco_choquito);
SELECT estoque FROM produto WHERE id = 2; -- terá que apresentar 57 (era 60 e vendeu 3)
INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (3,@id_venda1,1,@preco_baconzitos);
SELECT estoque FROM produto WHERE id = 3; -- terá que apresentar 79 (era 80 e vendeu 1)
INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (1,@id_venda2,3,@preco_coca);
SELECT estoque FROM produto WHERE id = 1; -- terá que apresentar 27 (era 30 e vendeu 3)

INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (1,@id_venda3,2,@preco_coca);
SELECT estoque FROM produto WHERE id = 1; -- terá que apresentar 25 (era 27 e vendeu 2)
INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (2,@id_venda3,1,@preco_choquito);
SELECT estoque FROM produto WHERE id = 2; -- terá que apresentar 56 (era 57 e vendeu 1)

INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (3,@id_venda3,2,@preco_baconzitos);
SELECT estoque FROM produto WHERE id = 3; -- terá que apresentar 77 (era 79 e vendeu 2)

INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (1,@id_venda4,2,@preco_coca);
SELECT estoque FROM produto WHERE id = 1; -- terá que apresentar 23 (era 25 e vendeu 2)
INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (3,@id_venda4,2,@preco_baconzitos);
SELECT estoque FROM produto WHERE id = 3; -- terá que apresentar 75 (era 77 e vendeu 2)

INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (1,@id_venda5,1,@preco_coca);
SELECT estoque FROM produto WHERE id = 1; -- terá que apresentar 22 (era 23 e vendeu 1)
INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (2,@id_venda5,2,@preco_choquito);
SELECT estoque FROM produto WHERE id = 2; -- terá que apresentar 54 (era 56 e vendeu 2)
INSERT INTO item_venda(produto_id,venda_id,quantidade,preco_unidade)VALUES (3,@id_venda5,1,@preco_baconzitos);
SELECT estoque FROM produto WHERE id = 3; -- terá que apresentar 74 (era 75 e vendeu 1)

-- SELECT * FROM produto;

