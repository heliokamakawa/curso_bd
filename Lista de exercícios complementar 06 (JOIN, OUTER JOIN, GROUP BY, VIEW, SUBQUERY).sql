/*
Lista de exercícios complementar 06 (JOIN, OUTER JOIN, GROUP BY, VIEW, SUBQUERY)
Link DER: https://github.com/heliokamakawa/curso_bd/blob/master/der/servico%20oficina%20mecanica%20-%20DER.png
Link Script: https://github.com/heliokamakawa/curso_bd/blob/master/der/servico%20oficina%20mecanica%20-%20SCRIPT.sql
*/

-- 1) Liste os nomes do clientes da região sul que já realizam algum serviço na empresa envolvendo peças com preço de custo maior que R$ 100,00.
-- 2) Liste o nome de todas as categorias de peças. Em relação a cada categoria de peças, apresente: (i) a quantidade de peças, (ii) a peça mais cara, (iii) a mais barata, e (iv) a média de preços das peças. Observação: considere o preço de custo. 
-- 3) Liste a data de cadastro e o total de todas as ordens de serviços e caso exista, os respectivos serviços realizados.
-- 4) Crie uma VIEW que apresente todos os clientes ativos do estado “PARANÁ” que já realizam algum orçamento. Em seguida, escreva o comando de consulta desta VIEW que apresente o nome de todos os clientes que fizeram o orçamento acima de R$ 500,00.
-- 5) Liste os nomes de todos os clientes e o respectivo total geral de todas as ordens de serviços realizadas pelo respectivo cliente. Retire os resultados em que a média de total geral de cada cliente seja abaixo de R$ 900,00.
-- 6) Liste o nome e o preço >>de venda<< de todas as peças cadastradas que já foram orçadas pelos clientes, porém que ainda não foram vendidas.

