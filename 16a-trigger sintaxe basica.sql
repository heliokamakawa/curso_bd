/*
OBJETIVO DA AULA 
(1) Entender a diferença entre função, procedure e trigger; 
(2) Aprender os conceitos fundamentais sobre TRIGGER;
(1) Aprender os conceitos fundamentais sobre TRIGGER;

******************** DIFERENÇA ENTRE FUNÇÃO, PROCEDURE E TRIGGER ******************** 
Funções
- Possuem retorno (um único retorno);
- Como há retorno, pode ser utilizado no comando SELECT;  
		Exemplo: SELECT CONCAT("Aula ", "BD", " é", " legal!");
- Não podemos fazer a chamada da função com CALL; 
		Exemplo: call CONCAT("SQL ", "Tutorial ", "is ", "fun!"); -- >>>NÃO FUNCIONA
- Funções não podem mudar o estado do BD (commit/rollback);
- Possuem somente parâmetro de entrada.

Procedures
- Não tem retorno;
- Como não tem retorno, é necessário fazer a chamada pelo 'CALL'; 
		Exemplo:  CALL minha_procedure(); 
- Não podemos chamar no SELECT; Exemplo:  
		SELECT minha_procedure(); -- >>>NÃO FUNCIONA
Pode executar INSERT, UPDATE, DELETE ou SELECT;
Além do parâmetro "tradicional", pode ter “out parameter” (parâmetro de saída);
Podem mudar o estado do BD (commit/rollback);

Trigger
Gerar uma AÇÃO associado a uma operação - Automatizar uma ação (um módulo de bloco de código);


******************** Conceitos fundamentais sobre TRIGGER ******************** 
O que é? 
DA MESMA FORMA QUE FUNÇÃO, é um bloco de programação armazenado no BD para que o código possa ser reutilizado repetidamente;
Podemos definir variáveis, estrutura de decisão e repetição, utilizar o SQL e funções nativas do SGBD que estão acostumados (AVG, MAX, MIN, EXISTS, outros).

Para que serve?
Automatizar uma ação (um módulo de bloco de código);
Gerar uma AÇÃO associado a uma operação

Vantagem
- PROCESSAMENTO LOCAL - velocidade, acesso aos dados locais, "centraliação da ação".
- CENTRALIZAÇÃO DA AÇÃO - pode poupar recursos da máquina cliente e facilitar a manutenção, visto que, 
	o “módulo de código” fica concentrado unicamente no BD, evitando que seja necessário alterar o código fonte nas aplicações.

Como funciona?
Associado a um tempo (antes ou depois) de um evento (insert, update ou delete) de uma tabela;
A trigger é um gatilho que é executado automaticamente - NÃO PODEMOS FAZER UMA CHAMADA EXPLÍCITA PARA EXECUTAR UMA TRIGGER!

Exemplos:
01 -TRIGGER DE RESTRIÇÃO → Impedir REGISTRO na tabela VENDA fora do horário comercial;
02 -TRIGGER DE OPERAÇÕES SEQUENCIAIS → ATUALIZAR estoque de PRODUTO no REGISTRO da VENDA;
03 -VALIDAÇÕES/VERIFICAÇÕES → VERIFICAR se CLIENTE é ativo antes da INSERÇÃO de uma VENDA;
04 - SEGURANÇA → RESTRINGIR acesso de registros de acordo com limites regionais;
05 - ALÉM DISSO → Impor regras de negócio complexas; Implementar estratégias complexas de privilégios de acesso e auditoria; Manter a sincronização de bancos de dados distribuídos; Outros...

Recomendações:
- Embora triggers sejam úteis para personalizar um banco de dados use apenas quando necessário;
	Lembre-se que é um módulo de código que SEMPRE será disparado e executado na operação vinculado;
	Uma SQL pode disparar uma trigger que dispara outras triggers resultando em disparos em cascata produzindo efeitos indesejados;
	Uso excessivo podem afetar: o desempenho; resultar em interdependências complexas; dificuldade de mantenção;

O que pode? 
- Não são permitidos comandos de DDL;
- Não são permitidos comandos de transação (COMMIT, ROLLBACK e SAVEPOINT), mesmo que seja uma procedure executada em um Trigger;
- Não podemos fazer uma consulta (SELECT) na mesma tabela que sofre a ação de um Trigger.
	Pode provocar um erro chamado MUTANT TABLE;
- Especificamente para o MySQL, só existe Trigger em nível de linha (não existe trigger em nível de instrução);

EVITE DEFINIR TRIGGER DESNECESSÁRIOS
- Para restrições de integridade utilize a trigger somente SE NECESSÁRIO!
- Em grande parte é possível definir a integridade pela constraints (NOT NULL, UNIQUE, PK, FK, DELETE CASCADE eDELETE SET NULL).

Links interessantes DOC OFICIAL
Trigger: https://dev.mysql.com/doc/refman/8.0/en/triggers.html
Create Trigger: https://dev.mysql.com/doc/refman/8.0/en/create-trigger.html
Exemplos: https://dev.mysql.com/doc/refman/8.0/en/trigger-syntax.html

******************** SINTAXE BÁSICA TRIGGER ******************** 
Legenda: [] - opcional

DELIMITER //								-- alterando o delimitador padrão de ";" para "//"
CREATE TRIGGER 								-- comando para criar a TRIGGER
[IF NOT EXISTS|IF EXISTS] nome_trigger		-- nome TRIGGER
BEFORE|AFTER  								-- definir em que TEMPO
INSERT|UPDATE|DELTE  						-- defeinir para qual EVENTO  	
ON NOME_TABELA 								-- associar a uma tabela
FOR EACH ROW								-- execuar a trigger para cada linha do EVENTO
[FOLLOWS|PRECEDES nome_outra_trigger] 		-- OPCIONAL - definição da ordem de execução
BEGIN										-- início da trigger
	[DECLARE TIPO_VARIÁVEL nome_variável;]	-- OPCIONAL - declaração de variáveis	
	--COMANDOS (AÇÃO)						
END;										-- fim da trigger
//											-- fim da definição da trigger
DELIMITER ;									-- alterando (retornando) o delimitador de "//" para ";"

*/

-- Atribuição de variáveis de sistema - EXCELENTE PARA FAZER TESTES E APRENDER A SINTAXE
-- https://dev.mysql.com/doc/refman/8.0/en/set-variable.html
SET @meu_var = 10;
SELECT @meu_var; -- apresenta 10


-- script para aprender a sintaxe de uma trigger
DROP DATABASE IF EXISTS aula;
CREATE DATABASE aula;
USE aula;

CREATE TABLE tabela (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY 
,nome VARCHAR(255) NOT NULL 
,valor DECIMAL(8,2) NOT NULL
);


-- TRIGGER SOMENTE PARA APRENDER A SINTAXE 
DELIMITER // 
CREATE TRIGGER sintaxe_trigger 
AFTER 
INSERT
ON tabela
FOR EACH ROW 
BEGIN
	SET @meu_var = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;

SELECT @meu_var; -- VEJA QUE ANTES DA INSERÇÃO, O VALOR NÃO ALTERA, VISTO QUE, A MUDANÇA ACONTECE PELA AÇÃO DA TRIGGER
INSERT INTO tabela (nome,valor) VALUES ('A',10.0);
SELECT @meu_var; -- APRESENTARÁ A DATA/HORA DA INSERÇÃO

-- TRIGGER SOMENTE PARA APRENDER A SINTAXE - DECLARANDO VARIÁVEIS
DELIMITER // 
CREATE TRIGGER sintaxe_variaveis 
AFTER 
INSERT
ON tabela
FOR EACH ROW 
BEGIN
	DECLARE variavel_um VARCHAR(255);		-- DECLARANDO VARIÁVEL 
    DECLARE variavel_dois INT DEFAULT 90;	-- DECLARANDO VARIÁVEL COM UM VALOR INICIAL
    
    SET variavel_um = 'teste';
	SET @meu_var = CONCAT(variavel_um, variavel_dois, CURRENT_TIMESTAMP);
END;
//
DELIMITER ;

SELECT @meu_var; -- VEJA QUE ANTES DA INSERÇÃO, O VALOR NÃO ALTERA, VISTO QUE, A MUDANÇA ACONTECE PELA AÇÃO DA TRIGGER
INSERT INTO tabela (nome,valor) VALUES ('B',20.0);
SELECT @meu_var; -- APRESENTARÁ a concatenção das variáveis e a DATA/HORA DA INSERÇÃO
INSERT INTO tabela (nome,valor) VALUES ('C',30.0);
SELECT @meu_var; -- APRESENTARÁ a concatenção das variáveis e a DATA/HORA DA INSERÇÃO

-- TRIGGER SOMENTE PARA APRENDER A SINTAXE - ESTRUTURA DE DECISÃO
DELIMITER // 
CREATE TRIGGER sintaxe_if
AFTER 
INSERT
ON tabela
FOR EACH ROW 
BEGIN
	DECLARE hora INT DEFAULT HOUR(CURRENT_TIMESTAMP);
	DECLARE saida VARCHAR(255);
    
    IF MOD(hora,2) = 2 THEN 
		SET saida = 'PAR';
	ELSE 
		SET saida = 'ÍMPAR';
    END IF;
    SET @meu_var = saida;
END;
//
DELIMITER ;

SELECT @meu_var; -- VEJA QUE ANTES DA INSERÇÃO, O VALOR NÃO ALTERA, VISTO QUE, A MUDANÇA ACONTECE PELA AÇÃO DA TRIGGER
INSERT INTO tabela (nome,valor) VALUES ('D',40.0);
SELECT @meu_var; -- APRESENTARÁ a concatenção das variáveis e a DATA/HORA DA INSERÇÃO
INSERT INTO tabela (nome,valor) VALUES ('E',50.0);
SELECT @meu_var; -- APRESENTARÁ a concatenção das variáveis e a DATA/HORA DA INSERÇÃO

-- TRIGGER SOMENTE PARA APRENDER A SINTAXE - VARIÁVEL NEW
-- NEW.nome_coluna - conseguimos pegar o NOVO valor de uma coluna da linha afetada
-- exemplo abaixo: pegando o valor no NOVO id
DELIMITER // 
CREATE TRIGGER sintaxe_trigger_new
AFTER 
INSERT
ON tabela
FOR EACH ROW 
BEGIN
	DECLARE id_gerado INT; 
    SET id_gerado = NEW.id;
    SET @meu_var = id_gerado;
END;
//
DELIMITER ;

SELECT @meu_var; -- VEJA QUE ANTES DA INSERÇÃO, O VALOR NÃO ALTERA, VISTO QUE, A MUDANÇA ACONTECE PELA AÇÃO DA TRIGGER
INSERT INTO tabela (nome,valor) VALUES ('F',60.0);
SELECT @meu_var; -- APRESENTARÁ o ide gerado

-- TRIGGER SOMENTE PARA APRENDER A SINTAXE - VARIÁVEL OLD
-- OLD.nome_coluna - conseguimos pegar o valor ANTIGO de uma coluna da linha afetada
-- exemplo abaixo: pegando o valor "antigo" nome que foi excluído
DELIMITER // 
CREATE TRIGGER sintaxe_trigger_delete 
AFTER 
DELETE
ON tabela
FOR EACH ROW 
BEGIN
    SET @meu_var = OLD.nome;
END;
//
DELIMITER ;

SELECT @meu_var; -- VEJA QUE ANTES DA INSERÇÃO, O VALOR NÃO ALTERA, VISTO QUE, A MUDANÇA ACONTECE PELA AÇÃO DA TRIGGER
INSERT INTO tabela (nome,valor) VALUES ('G',70.0);
SELECT @meu_var; -- >>>NÃO ACONTECE NADA!!! PQ? 
DELETE FROM tabela WHERE id = 1;
SELECT @meu_var; -- apresentará o nome antigo que foi excluído

-- TRIGGER SOMENTE PARA APRENDER A SINTAXE - VARIÁVEL OLD e NEW
DELIMITER // 
CREATE TRIGGER sintaxe_trigger_update 
AFTER 
UPDATE
ON tabela
FOR EACH ROW 
BEGIN
    SET @meu_var1 = OLD.nome;
    SET @meu_var2 = NEW.nome;
END;
//
DELIMITER ;

SELECT @meu_var; -- VEJA QUE ANTES DA INSERÇÃO, O VALOR NÃO ALTERA, VISTO QUE, A MUDANÇA ACONTECE PELA AÇÃO DA TRIGGER
UPDATE tabela SET nome = 'teste' WHERE id = 2;
SELECT @meu_var1, @meu_var2; -- APRESENTARÁ o nome antigo (antes da alteração) e o novo (depois da alteração)

