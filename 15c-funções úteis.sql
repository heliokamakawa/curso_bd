USE aula_banco;						-- selecionar aula_banco

/*
VEJA A SINTAXE DESTA FUNÇÃO
funções com intruções SQL 
SELECT INTO
*/
DELIMITER //
CREATE FUNCTION get_nome_cliente(codigo_cliente INT) 
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE nome_cliente VARCHAR(100);
	SELECT nome INTO nome_cliente FROM cliente WHERE id = codigo_cliente;
    RETURN nome_cliente;
END;
//
DELIMITER ;

SELECT get_nome_cliente(1); -- testando a função

-- como fazer a consulta que traga a data e o código do cliente da venda com id 1?
SELECT 
	venda.data_cadastro
    , venda.cliente_id
FROM venda 
WHERE id = 1;

-- ao invés de trazer o código, vamos trazer o nome do cliente utilizando a nossa função
SELECT 
	venda.data_cadastro
	, get_nome_cliente(venda.cliente_id) 
FROM venda 
WHERE id = 1;

-- fazendo o mesmo para todos os registros
SELECT 
	venda.data_cadastro
    , get_nome_cliente(venda.cliente_id) 
FROM venda;

-- a consulta que gera o mesmo resultado
SELECT 
	venda.data_cadastro
    , get_nome_cliente(venda.cliente_id) 
FROM venda, cliente
WHERE 
	cliente.id = venda.cliente_id;
    
-- qual o custo? >>>REPARE QUE ESTA FUNÇÃO PODE GERAR PROBLEMAS DE DESEMPENHO
-- em que caso podemos utilizar? Com qual motivo?


-- **** EXEMPLOS DE FUNÇÕES ****

-- para evitar desnormalizações → cálculo do total da venda
DELIMITER // 
CREATE FUNCTION calcular_total_venda(codigo_venda INT)
RETURNS DECIMAL(8,2) DETERMINISTIC  
BEGIN 
	DECLARE total_venda DECIMAL(8,2); 
    SELECT SUM(item_venda.total) INTO total_venda 
    FROM item_venda
    WHERE venda_id = codigo_venda;
    RETURN total_venda;
END;
//
DELIMITER ;

SELECT calcular_total_venda(1); -- testando somente a função
SELECT venda.id, venda.data_cadastro FROM venda; -- consulta de venda
SELECT venda.data_cadastro, calcular_total_venda(venda.id) 'Total' FROM venda; -- consulta de venda
-- >>CUIDADO - neste caso evita desnomalização, porém pode gerar problemas de desempenho em consulta

-- validações 
DROP FUNCTION IF EXISTS verificar_desconto_produto;
DELIMITER // 
CREATE FUNCTION verificar_desconto_produto(codigo_venda INT, codigo_produto INT)
RETURNS BOOL DETERMINISTIC 
BEGIN
	DECLARE desconto DECIMAL(8,2); 
    DECLARE quantidade INT; 
    DECLARE preco_produto DECIMAL(8,2);
    DECLARE desconto_unidade DECIMAL(8,2); 
    DECLARE limite_preco DECIMAL(8,2); 
    DECLARE resultado BOOL DEFAULT FALSE; 
    
    SELECT 
		item_venda.desconto 
        ,item_venda.quantidade 
        ,item_venda.preco_unidade INTO desconto, quantidade, preco_produto
	FROM item_venda 
    WHERE venda_id = codigo_venda
    AND produto_id = codigo_produto;
    
    SET desconto_unidade = desconto / quantidade;
    SET limite_preco = preco_produto * 0.5;
    
    IF desconto_unidade < limite_preco THEN 
		BEGIN
			SET resultado = TRUE;
        END;
    END IF;
    return resultado;
END;
//
DELIMITER ;
    
SELECT verificar_desconto_produto(1,1);
SELECT verificar_desconto_produto(2,4);
SELECT verificar_desconto_produto(3,3);


-- validação por venda 
DROP FUNCTION IF EXISTS verificar_desconto_venda;
DELIMITER //
CREATE FUNCTION verificar_desconto_venda(codigo_venda INT)
RETURNS BOOL DETERMINISTIC 
BEGIN
    DECLARE resultado BOOL DEFAULT TRUE; 
    DECLARE codigo_produto INT; 
    DECLARE acabou INT DEFAULT FALSE;
	DECLARE cursor_venda CURSOR FOR 
		SELECT item_venda.produto_id
		FROM item_venda 
        WHERE item_venda.venda_id = codigo_venda;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET acabou = TRUE;
        
	OPEN cursor_venda;
    read_loop : LOOP 
		FETCH cursor_venda INTO codigo_produto;
		SET resultado = verificar_desconto_produto(codigo_venda, codigo_produto);
        IF resultado = FALSE OR acabou THEN 
		BEGIN
			LEAVE read_loop;
		END;
        END IF;
    END LOOP;
    CLOSE cursor_venda;
    RETURN resultado;
END;
//
DELIMITER ;

SELECT verificar_desconto_venda(3);





