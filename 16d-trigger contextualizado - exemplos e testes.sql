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


-- EXEMPLO TRIGGER 01 - Impedir vendas fora do horário comercial
DELIMITER // 
CREATE TRIGGER venda_horario_comercial 
BEFORE INSERT ON venda FOR EACH ROW
-- FOLLOWS impedir_venda_cliente_inativo
BEGIN 
    IF NOT TIME(current_timestamp) between TIME('08:00:00') and TIME('18:00:00') THEN
		signal sqlstate '45000' set message_text = 'horário não permitido';
	END IF;
END;
//
DELIMITER ;

DELIMITER // 
CREATE TRIGGER impedir_venda_cliente_inativo 
BEFORE INSERT ON venda FOR EACH ROW
-- PRECEDES venda_horario_comercial
BEGIN 
	DECLARE cliente_ativo CHAR(1); 
    SELECT ativo INTO cliente_ativo FROM cliente WHERE id = new.cliente_id;
    IF cliente_ativo <> 'S' THEN
		signal sqlstate '45000' set message_text = 'cliente inativo';
	END IF;
END;
//
DELIMITER ;

-- teste 
INSERT INTO venda (cliente_id) VALUES (4);


-- EXEMPLO TRIGGER 02 - atualização de estoque na inserção
DELIMITER // 
CREATE TRIGGER atualiza_estoque
AFTER INSERT ON item_venda FOR EACH ROW
BEGIN 
	UPDATE produto SET estoque = estoque - new.quantidade WHERE produto.id = new.produto_id;
END;
//
DELIMITER ;

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


