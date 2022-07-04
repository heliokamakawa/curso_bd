USE aula_banco;
/*
FUNÇÕES COM SELECT INTO
recebe como parâmetro código do cliente
retorna o nome do cliente
*/
-- testando a função
-- como fazer a consulta que traga a data e o código do cliente da venda com id 1?
-- ao invés de trazer o código, vamos trazer o nome do cliente utilizando a nossa função
-- fazendo o mesmo para todos os registros
-- qual consulta que gera o mesmo resultado
-- qual o custo? >>>REPARE QUE ESTA FUNÇÃO PODE GERAR PROBLEMAS DE DESEMPENHO
-- em que caso podemos utilizar? Com qual motivo?


-- **** EXEMPLOS DE FUNÇÕES ****
-- 	EXEMPLO 01 - para evitar desnormalizações → cálculo do total da venda
-- testando somente a função
-- consulta de venda
-- consulta de venda
-- >>CUIDADO - neste caso evita desnomalização, porém pode gerar problemas de desempenho em consulta

-- EXEMPLO 02 - verificações
-- verifica se o desconto do item de venda está no limite 


-- EXEMPLO 03 - FUNÇÕES COM CURSOR
-- verificar o limite de desconto de uma venda
-- https://dev.mysql.com/doc/refman/8.0/en/cursors.html
-- 2 fora do limite
