/*
DELETE e UPDATE - Lista de Exercícios
script: https://github.com/heliokamakawa/curso_bd/blob/master/03a-DELETE%20e%20UPDATE-%20script%20%20e%20aula.sql
*/

-- inserindo estados
INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR');
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP');
INSERT INTO estado (nome,sigla) VALUES ('MATO GROSSO','MT');
INSERT INTO estado (nome,sigla) VALUES ('SANTA CATARINA','SC');
INSERT INTO estado (nome,sigla) VALUES ('RIO GRANDE DO SUL','RS');

-- inserindo cidades
INSERT INTO cidade (nome, estado_id) VALUES ('BAURU',2);
INSERT INTO cidade (nome, estado_id) VALUES ('MARINGÁ',1);
INSERT INTO cidade (nome, estado_id) VALUES ('GUARULHOS',2);
INSERT INTO cidade (nome, estado_id) VALUES ('CAMPINAS',2);
INSERT INTO cidade (nome, estado_id) VALUES ('FLORIANÓPOLIS',4);
INSERT INTO cidade (nome, estado_id) VALUES ('PARANAVAÍ',1);
INSERT INTO cidade (nome, estado_id) VALUES ('CUIABA',3);
INSERT INTO cidade (nome, estado_id) VALUES ('BALNEÁRIO CAMBORIÚ',4);
INSERT INTO cidade (nome, estado_id) VALUES ('LONDRINA',1);
INSERT INTO cidade (nome, estado_id) VALUES ('CASCAVEL',1);
INSERT INTO cidade (nome, estado_id) VALUES ('JOINVILLE',4);
INSERT INTO cidade (nome, estado_id) VALUES ('PORTO ALEGRE',5);
INSERT INTO cidade (nome, estado_id) VALUES ('BLUMENAL',4);
INSERT INTO cidade (nome, estado_id) VALUES ('BARRA DOS GARÇAS',3);
INSERT INTO cidade (nome, estado_id) VALUES ('CHAPECÓ',4);
INSERT INTO cidade (nome, estado_id) VALUES ('ITAJAÍ',4);


-- OBSERVAÇÃO IMPORTANTE: TODO COMANDO UPDATE E DELETE DEVE SER INICIADO COM WHERE PARA EVITAR ESQUECIMENTOS!!!!

-- 1) Na inserção do estado, o usuário cometeu um erro, esquecendo de colocar acento. Neste contexto, escreva o comando para alterar o registro colocando acento. Sabe-se que o “id” do registro é “57”.
-- EXERCÍCIO PARA ALTERAR UMA COLUNA DE UM REGISTRO PELO ID
UPDATE estado SET nome = 'PARANÁ' WHERE id = 57;

-- 2) Faça o mesmo exercício anterior, porém, considerando que você não saiba do “id”.
-- EXERCÍCIO PARA ALTERAR O DADO DE UMA COLUNA DE UM REGISTRO PELO NOME
UPDATE estado SET nome = 'PARANÁ' WHERE estado.nome = 'PARANA';

-- 3) Escreva o comando que torne todos os estados ativos.
-- EXERCÍCIO PARA ALTERAR O DADO DE COLUNA DE TODOS OS REGISTROS – CUIDADO!
UPDATE estado SET ativo = 'S';

-- 4) Devido à falha de funcionamento do teclado, o registro com “id” 97 da tabela “cidade” ficou totalmente errado. Neste contexto, altere o registro com os seguintes dados: cidade → MARINGÁ, estado → PARANÁ, não é ATIVO e foi registrado em 15/11/2020.
-- EXERCÍCIO PARA ALTERAR VÁRIAS COLUNAS DE UM REGISTRO

-- verificando o id do paraná
SELECT id FROM estado WHERE nome = 'PARANÁ'; 

-- comando para alterar
UPDATE cidade SET
nome = 'MARINGÁ'
, estado_id = 15
, ativo = 'N'
, data_cadastro = '2020-11-15'
WHERE id = 97;

SELECT * FROM cidade WHERE id = 97; -- conferindo se deu certo

-- 5) Escreva o comando para excluir o registro do estado com o nome “PARANÁ”. Sabe-se que o “id” do registro é “57”.
-- EXERCÍCIO PARA EXCLUIR UM REGISTRO PELO ID
DELETE FROM estado WHERE id = 57;

-- 6) Faça o mesmo exercício anterior, porém, considerando que você não saiba do “id”.
-- EXERCÍCIO PARA EXCLUIR UM REGISTRO PELO NOME – CUIDADO!
DELETE FROM estado WHERE nome = 'PARANÁ';

-- 7) Elimine todos os registros da tabela cliente.
-- EXERCÍCIO PARA EXCLUIR TODOS IS REGISTROS – CUIDADO!
DELETE FROM cliente;
 
-- 8) Escreva o comando para excluir o registro do estado com o id “23”. Sabe-se que, este estado possui VÁRIAS cidades cadastradas.
-- EXERCÍCIO PARA EXCLUIR UM REGISTRO QUE POSSUI RELACIONAMENTO

DELETE FROM estado WHERE id = 23; -- dá erro porque tem relacionamento
/*
>> Então como proceder?
Para excluir o estado com id 23, primeiro, será necessário excluir todas as cidades cadastradas que possui o relacionamento com este estado.
Então verifique se realmente se é para fazer isto!!! Se sim, segue os comandos...
*/

-- eliminando todas as cidade que possuem a FK/referência do estado com id 23
DELETE FROM cidade WHERE cidade_id = 23;

-- agora sim, eliminando o estado com id 23
DELETE FROM estado WHERE id = 23;

/*
AGORA É A SUA VEZ!!!! Para que você aprenda, é muito importante que não copie e cole, digite os comandos e mentalize o que está fazendo na medida que digita cada comando. Uma dica importante é que você digite primeiro no bloco de notas, com intuito de testar se realmente consegue digitar os comandos sem a ajuda do IDE – depois teste os comandos.
9.	Escreva o comando para alterar o valor de uma coluna de um único registro de uma tabela utilizando como filtro, o Primary Key.
10.	Refaça o exercício anterior alterando os dados de mais que uma coluna de um único registro sem utilizar como filtro a chave primária. A escolha da coluna do filtro é muito importante – TOME CUIDADO.
11.	Alter o valor de uma coluna de todos os registros.
12.	Exclua um único registro de uma tabela sem utilizar como filtro, a chave primária.
13.	Escreva todos os comandos necessários para excluir o cliente com o id “38”.
*/
