DROP DATABASE IF EXISTS AULA_BANCO;
CREATE DATABASE AULA_BANCO;
USE AULA_BANCO;

CREATE TABLE ESTADO(
	ID INT NOT NULL AUTO_INCREMENT
    ,NOME VARCHAR(100) NOT NULL UNIQUE
    ,SIGLA CHAR(2) NOT NULL UNIQUE
    ,STATUS CHAR(1) NOT NULL DEFAULT 'A'
    ,DATA_CADASTRO DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
    ,CONSTRAINT PK_ESTADO PRIMARY KEY (ID)
);
CREATE TABLE CIDADE(
	ID INT NOT NULL AUTO_INCREMENT
    ,NOME VARCHAR(100) NOT NULL 
    ,ESTADO_ID INT NOT NULL
    ,STATUS CHAR(1) NOT NULL DEFAULT 'A' 
    ,DATA_CADASTRO DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP 
    ,CONSTRAINT PK_CIDADE PRIMARY KEY (ID) 
    ,CONSTRAINT FK_CIDADE_ESTADO FOREIGN KEY (ESTADO_ID) REFERENCES ESTADO (ID)
    ,CONSTRAINT UNIQUE_CIDADE UNIQUE (NOME,ESTADO_ID)
);

INSERT INTO ESTADO (NOME,SIGLA) VALUES ('PARANÁ','PR');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('SÃO PAULO','SP');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('MATO GROSSO','MT');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('SANTA CATARINA','SC');
INSERT INTO ESTADO (NOME,SIGLA) VALUES ('RIO GRANDE DO SUL','RS');

INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BAURU',2);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('MARINGÁ',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('GUARULHOS',2);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CAMPINAS',2);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('FLORIANÓPOLIS',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('PARANAVAÍ',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CUIABA',3);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BALNEÁRIO CAMBORIÚ',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('LONDRINA',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CASCAVEL',1);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('JOINVILLE',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('PORTO ALEGRE',5);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BLUMENAL',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('BARRA DOS GARÇAS',3);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('CHAPECÓ',4);
INSERT INTO CIDADE (NOME, ESTADO_ID) VALUES ('ITAJAÍ',4);

SELECT E.NOME, GROUP_CONCAT(C.NOME), COUNT(C.ID) 
FROM ESTADO E
INNER JOIN CIDADE C ON E.ID = C.ESTADO_ID  
WHERE E.NOME IN ('PARANÁ','SANTA CATARINA', 'RIO GRANDE DO SUL')
GROUP BY E.ID
HAVING COUNT(C.ID) > 2;

/**
>>>SINTAXE DE UMA VIEW
CREATE VIEW nome_view AS select_statement;

A views pode utilizada para:
- Isolamento;
- Segurança;
- Reduzir a complexidade;
- Facilitar o acesso.
**/
DESCRIBE ESTADO;

-- criando uma VIEW
CREATE OR REPLACE VIEW VIEW_ESTADO AS SELECT * FROM ESTADO;

-- alterando uma VIEW
ALTER TABLE ESTADO ADD COLUMN TESTE VARCHAR(10) NULL;

SELECT * FROM ESTADO;
SELECT * FROM VIEW_ESTADO;

-- inseriindo dados por meio de uma VIEW
INSERT INTO VIEW_ESTADO (NOME,SIGLA) VALUES ('PERNAMBUCO','EE');

-- alterando dados por meio de uma VIEW
UPDATE VIEW_ESTADO SET SIGLA='PE' WHERE NOME = 'PERNAMBUCO';

-- excluíndo dados por meio de uma VIEW
DELETE FROM VIEW_ESTADO WHERE NOME = 'PERNAMBUCO';

-- comando para ver a estrutura de uma VIEW
DESCRIBE VIEW_ESTADO;
DESCRIBE ESTADO;

-- fazendo uma consulta de dados de uma VIEW
SELECT ID,NOME,DATA_CADASTRO FROM VIEW_ESTADO;

SELECT * FROM CIDADE;

CREATE VIEW VIEW_CIDADES_PARANA AS SELECT * FROM CIDADE WHERE ESTADO_ID = 1;

SELECT * FROM VIEW_CIDADES_PARANA WHERE ID >6;

SELECT VCP.NOME 'NOME CIDADE', VE.SIGLA 'SIGLA ESTADO'
FROM VIEW_ESTADO VE, VIEW_CIDADES_PARANA VCP
WHERE VE.ID = VCP.ESTADO_ID;

SELECT C.NOME 'NOME CIDADE', VE.SIGLA 'SIGLA ESTADO'
FROM VIEW_ESTADO VE, CIDADE C
WHERE VE.ID = C.ESTADO_ID;


/** - Simplificar o acesso  
CIDADES AGRUPADOS PELO ESTADO, 
NOMES DAS CIDADES POR ESTADO,
QUANTIDADE DE CIDADES POR ESTADO,
QUE SEJAM DA REGIÃO SUL, 
MAS SOMENTE DOS ESTADOS QUE POSSUEM MAIS DE 2 CIDADES CADASTRADAS
**/

CREATE OR REPLACE VIEW VIEW_GROUP_ESTADO AS 
SELECT E.NOME 'ESTADO', GROUP_CONCAT(C.NOME) 'CIDADES', COUNT(C.ID) 'QUANTIDADE CIDADES'
FROM ESTADO E 
INNER JOIN CIDADE C ON E.ID = C.ESTADO_ID 
WHERE  E.NOME IN ('PARANÁ', 'SANTA CATARINA', 'RIO GRANDE DO SUL')
GROUP BY E.ID;

SELECT * FROM VIEW_GROUP_ESTADO;

DROP VIEW VIEW_GROUP_ESTADO;





/** - para o Desempenho **/