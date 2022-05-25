/*
LISTA DE EXERCÍCIO COMPLEMENTAR 05 - JON/OUTER JOIN/GROUP BY/VIEW/SUBSELECT
Para a realização desta lista, considere o Diagrama de Entidade e Relacionamento (DER) do link: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20loja%20-%20DER.png
script do DER: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql
 
1.	Liste o nome de todos os estados. Em relação a cada estado, apresente: (i) a quantidade de clientes, (ii) a quantidade de fornecedores, e (iii) a quantidade de funcionários. Apresente somente estados com a quantidade de clientes acima de 5. 
2.	Liste o nome de todos os produtos fornecidos pelos fornecedores da região sul. Em relação a cada produto, apresente: (i) a quantidade que já foi vendida e (ii) a quantidade que já foi comprada. 
3.	Refaça o primeiro exercício, porém, apresentando todos os estados (mesmo aqueles que não tenha clientes, fornecedores e funcionários.
4.	Liste o nome de todos os produtos e caso exista, a quantidade e data da baixa do respectivo produto.
5.	Crie uma VIEW que apresente todos os clientes ativos do estado “PARANÁ” que já realizam algum pedido. Em seguida, escreva o comando de consulta desta VIEW que apresente o nome de todos os clientes que fizeram o orçamento acima de R$ 500,00.
6.	Crie uma VIEW que apresente todos os estados, e a quantidade de fornecedores que possuem algum valor a receber da empresa. Caso o estado não tenha registros nestas condições apresente 0. Em seguida, escreva o comando de consulta desta VIEW.
7.	Liste o nome e o preço de todos os produtos cadastrados que já foram pedidos por um cliente, porém que ainda não foram vendidas.
8.	Liste o nome de todos os estados cujo não há clientes cadastrados.
*/