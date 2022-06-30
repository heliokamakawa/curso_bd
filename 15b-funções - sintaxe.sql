-- exemplo função sem parâmetro, sem variáveis, somente para entender a sintaxe 
DELIMITER //
CREATE FUNCTION ola() 
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	RETURN 'Olá Pessoal!';
END;
//
DELIMITER ;

SELECT ola();  -- testando função

/** 
FUNÇÃO DETERMINISTIC - conforme parâmetro, o resultado sempre é o mesmo
Exemplo de funções do MySQL: concat, sum, max, mim, avg
**/
SELECT CONCAT(nome, ' - ', ativo) FROM cliente;

-- exemplo de função não deterministc 
SELECT NOW();

-- eliminando função
DROP FUNCTION IF EXISTS ola;


-- exemplo função sem parâmetro, com variável
DELIMITER //
CREATE FUNCTION ola() 
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE mensagem VARCHAR(100); -- DECLARE → palavra chave para declarar variáveis
    SET mensagem = 'Olá Pessoal!'; -- SET → palavra chave atribuir um valor na variável
	RETURN mensagem;
END;
//
DELIMITER ;

SELECT ola(); -- testando função



DROP FUNCTION IF EXISTS ola; -- eliminando função
DELIMITER //
CREATE FUNCTION ola() 	-- exemplo função sem parâmetro, com variável e atribuição
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE mensagem VARCHAR(100) DEFAULT 'Olá Pessoal!'; -- DEFAULT → palavra chave atribuir um valor na declaração
	RETURN mensagem;
END;
//
DELIMITER ;

SELECT ola(); -- testando função


DROP FUNCTION IF EXISTS OLA; -- eliminando a função 
DELIMITER // 
CREATE FUNCTION ola(nome VARCHAR(10)) -- função com parâmetro
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE frase VARCHAR(50);
	SET frase = CONCAT('Olá ', nome);
	RETURN frase;
END;
//
DELIMITER ;

SELECT ola('José'); -- testando somente a função função (sem tabela)

-- consultando nome do cliente
SELECT cliente.nome 
FROM cliente; 

-- usa da função criada na consulta
SELECT ola(cliente.nome)
FROM cliente;

/*
*** ESTRUTURA DE UM IF ***
IF CONDIÇÃO THEN
	BEGIN
		comando...;
	END;
END IF;

*** ESTRUTURA DE UM IF ELSE ***
IF CONDIÇÃO THEN
	BEGIN
		comando...;
	END;
ELSE
	BEGIN
		comando...;
	END;
END IF;

*** ESTRUTURA DE UM IF E IFELSE ***
IF CONDIÇÃO THEN
	BEGIN
		comando...;
	END;
ELSEIF CONDIÇÃO THEN
	BEGIN
		comando...;
	END;
ELSE
	BEGIN
		comando...;
	END;
END IF;

*** OPERADORES RELACIONAIS ***
=, >, >=, <, <=, <>, !=

*** OPERADORES LÓGICOS ***
AND, &&, NOT, !, OR, ||, XOR
*/

DROP FUNCTION IF EXISTS ola; -- eliminando a função 
DELIMITER // 
CREATE FUNCTION ola(ativo CHAR(1)) -- função com if 
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE frase VARCHAR(150) DEFAULT 'CLIENTE INATIVO';
	IF ativo = 'S' THEN
		BEGIN
			SET frase ='CLIENTE ATIVO';
		END;
	END IF;
	RETURN frase;
END;
//
DELIMITER ;

SELECT ola('A'); -- testando função
SELECT cliente.nome, ola(cliente.ativo) FROM cliente; -- testando a função na consulta

DROP FUNCTION IF EXISTS ola; -- eliminando a função 
DELIMITER // 
CREATE FUNCTION ola(ativo CHAR(1)) -- função com if e else
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE frase VARCHAR(150);
	IF ativo = 'S' THEN
		BEGIN
			SET frase ='CLIENTE ATIVO';
		END;
	ELSE
		BEGIN
			SET frase ='CLIENTE INATIVO';
        END;
	END IF;
	RETURN frase;
END;
//
DELIMITER ;

SELECT ola('A'); -- testando função
SELECT cliente.nome, ola(cliente.ativo) FROM cliente; -- testando a função na consulta

DROP FUNCTION IF EXISTS ola; -- eliminando a função 
DELIMITER //
CREATE FUNCTION ola(nome VARCHAR(100), opcao INT) -- função com ELSEIF
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE frase VARCHAR(150);
    IF opcao = 1 THEN
		BEGIN 
			SET frase = CONCAT('BOM DIA ', nome);
		END;
		ELSEIF opcao = 2 THEN 
			BEGIN 
				SET frase = CONCAT('BOA TARDE ', nome);
			END;
		ELSEIF opcao = 3 THEN 
			BEGIN 
				SET frase = CONCAT('BOA NOITE ', nome);
			END;
		ELSE 
			BEGIN
				SET frase = 'OPÇÃO ERRADO';
			END;
	END IF;
	RETURN frase;
END;
//
DELIMITER ;

SELECT ola('Roberto',1); -- testando função
SELECT ola('Maria',2); -- testando função
SELECT ola(cliente.nome,3) FROM cliente; -- testando a função na consulta
SELECT ola(cliente.nome,1) FROM cliente; -- testando a função na consulta


DROP FUNCTION IF EXISTS ola; -- eliminando a função 
DELIMITER //
CREATE FUNCTION ola(nome VARCHAR(100), ativo CHAR(1), opcao INT) -- função com IF aninhado e ELSEIF
RETURNS VARCHAR(150) DETERMINISTIC
BEGIN
	DECLARE frase VARCHAR(150);
    IF ativo = 'S' THEN 
		BEGIN 
			IF opcao = 1 THEN
				BEGIN 
					SET frase = CONCAT('BOM DIA ', nome);
                END;
			ELSEIF opcao = 2 THEN 
				BEGIN 
					SET frase = CONCAT('BOA TARDE ', nome);
                END;
			ELSEIF opcao = 3 THEN 
				BEGIN 
					SET frase = CONCAT('BOA NOITE ', nome);
                END;
			ELSE 
				BEGIN
					SET frase = 'OPÇÃO ERRADO';
                END;
			END IF;
        END;
	ELSE
		BEGIN 
			SET frase = CONCAT(nome, ' ESTÁ INATIVO(A).');
        END;
    END IF;
	RETURN frase;
END;
//
DELIMITER ;

SELECT ola(cliente.nome, cliente.ativo, 1) FROM cliente; -- testando a função na consulta

/*
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
   



