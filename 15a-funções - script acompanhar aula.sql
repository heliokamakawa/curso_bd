DROP DATABASE IF EXISTS aula_banco; -- se existir elimine aula_banco
CREATE DATABASE aula_banco; 		-- criar aula_banco
USE aula_banco;						-- selecionar aula_banco

/** criando a tabela pessoa **/
CREATE TABLE cliente(
id INT NOT NULL AUTO_INCREMENT
,nome VARCHAR(100) NOT NULL 
,sobrenome VARCHAR(100) NOT NULL 
,telefone CHAR(15) NOT NULL 
,endereco CHAR(100) NOT NULL
,data_nascimento DATE NOT NULL 
,data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
,ativo CHAR(1) NOT NULL DEFAULT 'S'
,CONSTRAINT pk_cliente PRIMARY KEY (id)
);

CREATE TABLE venda(
id INT NOT NULL AUTO_INCREMENT
,data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
,cliente_id int not null 
,CONSTRAINT pk_venda PRIMARY KEY (id)
,CONSTRAINT fk_venda_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id)
);

CREATE TABLE produto(
id INT NOT NULL AUTO_INCREMENT
,nome varchar(100) not null
,preco decimal(8,2) not null
,CONSTRAINT pk_produto PRIMARY KEY (id)
);

CREATE TABLE item_venda(
venda_id INT NOT NULL
,produto_id INT NOT NULL
,quantidade INT NOT NULL
,preco_unidade INT NOT NULL
,desconto INT DEFAULT 0
,total DECIMAL(8,2) AS (quantidade * preco_unidade - desconto)
,CONSTRAINT pk_item_venda PRIMARY KEY (venda_id,produto_id)
,CONSTRAINT fk_item_venda_venda FOREIGN KEY (venda_id) REFERENCES venda (id)
,CONSTRAINT fk_item_venda_produto_id FOREIGN KEY (produto_id) REFERENCES produto (id)
);

CREATE TABLE conta_receber(
id INT NOT NULL AUTO_INCREMENT
,venda_id INT NOT NULL
,valor_total DECIMAL(8,2) NOT NULL -- total à receber
,valor_pago DECIMAL(8,2) NOT NULL 
,desconto DECIMAL(8,2) NOT NULL 
,juros DECIMAL(8,2) NOT NULL 
,CONSTRAINT pk_conta_receber PRIMARY KEY (id)
,CONSTRAINT fk_pessoa FOREIGN KEY (venda_id) REFERENCES venda (id)
);

/** inserindo pessoas **/
INSERT INTO cliente (nome,sobrenome,telefone,endereco,data_nascimento,data_cadastro,ativo) VALUES ('PAULA','SILVA','(11) 99447-3654','Rua Barbosa, 159','1976-05-06','1999-04-30','S');
INSERT INTO cliente (nome,sobrenome,telefone,endereco,data_nascimento,data_cadastro,ativo) VALUES ('RAUL','PEREIRA','(11) 99123-9852','Rua João Pessoa, 8523','1950-05-06','1980-11-04','S');
INSERT INTO cliente (nome,sobrenome,telefone,endereco,data_nascimento,data_cadastro,ativo) VALUES ('REGIANE','FERNANDES','(11) 99852-9631','Rua Getúlio Vargas, 895','2000-05-06','2019-08-26','S');
INSERT INTO cliente (nome,sobrenome,telefone,endereco,data_nascimento,data_cadastro,ativo) VALUES ('ALDO','SOUZA','(11) 99369-4512','Av. Rio Grande do Norte, 523','1996-11-12','2020-06-14','S');
INSERT INTO cliente (nome,sobrenome,telefone,endereco,data_nascimento,data_cadastro,ativo) VALUES ('PAULA','MATOS','(11) 99258-9512','Av. Pedro Afonso, 58','2001-03-01','2019-08-10','N');
INSERT INTO cliente (nome,sobrenome,telefone,endereco,data_nascimento,data_cadastro,ativo) VALUES ('SILVIA','HIPOLITO','(11) 99456-7412','Rua Miranda, 1598','1996-10-26','2022-09-14','S');

INSERT INTO produto (nome,preco) VALUES ('a',10);
INSERT INTO produto (nome,preco) VALUES ('b',20);
INSERT INTO produto (nome,preco) VALUES ('c',30);
INSERT INTO produto (nome,preco) VALUES ('d',40);
INSERT INTO produto (nome,preco) VALUES ('e',50);

INSERT INTO venda (cliente_id, data_cadastro) VALUES (1,'1999-06-02');
INSERT INTO venda (cliente_id, data_cadastro) VALUES (2,'1980-12-15');
INSERT INTO venda (cliente_id, data_cadastro) VALUES (1,'2010-05-30');
INSERT INTO venda (cliente_id, data_cadastro) VALUES (3,'2019-08-30');
INSERT INTO venda (cliente_id, data_cadastro) VALUES (4,'2022-05-30');
INSERT INTO venda (cliente_id, data_cadastro) VALUES (3,'2022-05-30');
INSERT INTO venda (cliente_id, data_cadastro) VALUES (1,'2022-05-30');

INSERT INTO item_venda (venda_id, produto_id,quantidade,desconto, preco_unidade) VALUES (1,1,5,2,10);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (1,3,2,30);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (1,5,1,50);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (2,2,2,20);
INSERT INTO item_venda (venda_id, produto_id,quantidade,desconto,preco_unidade) VALUES (2,4,2,60,40); -- ACIMA DO DESCONTO
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (3,1,5,9.5);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (3,3,5,30);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (3,2,5,20);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (3,4,5,40);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (4,1,3,25);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (5,3,3,29);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (5,5,3,50);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (6,5,10,42);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (7,1,1,10);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (7,2,1,20);
INSERT INTO item_venda (venda_id, produto_id,quantidade,preco_unidade) VALUES (7,3,1,30);

INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (1,100,70,0,0);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (2,200,180,20,0);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (2,30,33,0,3);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (2,150,0,0,0);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (1,250,50,0,3);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (2,120,108,12,0);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (1,10,10,0,0);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (1,30,70,0,0);
INSERT INTO conta_receber (venda_id,valor_total,valor_pago,desconto,juros) VALUES (1,20,70,0,0);


/**
***** sintaxe de uma função MySQL  ****
DELIMITER //                            → troca do símbolo do delimitador que por padrão é ; - para diferenciar com o final do comando
CREATE FUNCTION nome( [parâmetros] )    → cria função, os parâmetros são opcionais
RETURNS {TIPO DE DADO}                  → definir o tipo de dados que a função irá retornar
[NOT] DETERMINISTC                      → se a função será ou não DETERMINISTC
BEGIN                                   → início do bloco de comando
   DECLARE [variáveis];                 → declaração da variável
   código...                            → nossa programação
   RETURN ....;                         → o retorno do resultado
END;                                    → fim do bloco de comando
//                                      → fim da função                          
DELIMITER ;                             → retornando o símbolo padrão do delimitador
**/

-- exemplo função sem parâmetro, sem variáveis, somente para entender a sintaxe 

-- testando função

/** 
FUNÇÃO DETERMINISTIC - conforme parâmetro, o resultado sempre é o mesmo
Exemplo de funções do MySQL: concat, sum, max, mim, avg
**/
SELECT CONCAT(nome, ' - ', ativo) FROM cliente;

-- exemplo de função não deterministc 
SELECT NOW();

-- eliminando função


-- exemplo função sem parâmetro, com variável - declarand variável de retorno
-- testando função


-- eliminando função
-- exemplo função sem parâmetro, com variável e atribuição
-- DEFAULT → palavra chave atribuir um valor na declaração
-- testando função


-- eliminando a função 
-- função com parâmetro - definido o parâmetro nome
-- testando somente a função função (sem tabela)
-- consultando nome do cliente
-- usa da função criada na consulta

/*
PRÁTICA 
→ Escreva uma função que receba como parâmetro o nome/sobrenome e retorne o nome completo.
	teste somente a função (sem tabelas);
	teste a função inserida em uma consulta; 
	eliminte a função.
*/

/*
*** ESTRUTURA DE DECISÃO ***
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

-- eliminando a função 
-- função com if → se parâmetro é 'S' retornar CLIENTE ATIVO.
-- testando somente a função (sem tabela)
-- testando a função na consulta


-- eliminando a função 
-- função com if e else → se parâmetro é 'S' retornar CLIENTE ATIVO senão CLIENTE INATIVO.
-- testando somente a função (sem tabela)
-- testando a função na consulta


-- eliminando a função 
-- função com ELSEIF → Função com parâmetros nome e opção - Bom dia, boa tarde, boa noite e opção errado...
-- testando função
-- testando função
-- testando a função na consulta
-- testando a função na consulta


-- eliminando a função 
-- função com IF aninhado SE ATIVO ENTÃO ELSEIF para opções
-- testando a função na consulta

/*
funções com intruções SQL → parâmetrdo do código do cliente e retorna o nome do cliente
SELECT INTO → atribuição do retorno para variável
*/
-- testando a função
-- como fazer a consulta que traga a data e o código do cliente da venda com id 1?
-- ao invés de trazer o código, vamos trazer o nome do cliente utilizando a nossa função
-- fazendo o mesmo para todos os registros
-- a consulta que gera o mesmo resultado




