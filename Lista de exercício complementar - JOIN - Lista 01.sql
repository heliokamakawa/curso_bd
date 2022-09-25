/* 
Link videoaula JOIN → https://www.youtube.com/watch?v=wm3e7rICW2I&list=PLg5-aZqPjMmC69aUbYfCHiXIPbb5MwMmw&index=10
caso queira treinar na prática link script ddl e dml: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso-loja_bebida-script.sql
*** JOIN - LISTA 01 ***

Sintaxe de uma consulta com JOIN:
SELECT 
    {nome_coluna1}
    ,{nome_coluna2}
    , [... outras colunas]
FROM {nome_tabela1}, {nome_tabela2}
WHERE pk = fk;

Sintaxe
1.	Escreva o comando que liste os nomes de todas as cidades e as respectivas siglas do estado.
2.	Escreva o comando que liste os nomes das cidades ativas e as respectivas siglas do estado. 
3.	Escreva o comando que liste os nomes dos cliente e os nomes das respectivas cidades. 
4.	Escreva o comando que liste os nomes dos cliente e os nomes das respectivas cidades. Liste somente os clientes que moram na cidade de Paranavaí.
5.	Escreva o comando que liste os nomes das cidades e as respectivas siglas do estado. Liste somente as cidades ativas.
6.	Escreva o comando que liste os nomes dos funcionários e os nomes das respectivas cidades. 
7.	Escreva o comando que liste os nomes dos funcionários e a sigla do respectivo estado. 
8.	Escreva o comando que liste os nomes dos cliente e os nomes das respectivas cidades. Liste somente os clientes que moram na região sul.
9.	Escreva o comando que liste os nomes dos estados com cadastros ativos que possuem algum cliente cadastrado.
10.	Escreva o comando que liste todas as vendas e o nome do respectivo funcionário que a realizou.
11.	Liste o nome dos produtos, o preço de venda e o nome da unidade de medida.
12.	Liste o nome dos produtos da marca "Coca-cola".
13. DESAFIO!!! Liste os nomes dos clientes do estado de São Paulo que já compraram o produto 'REFRIGERANTE COCA-COLA GARRAFA PET 3 L'.

Semântica
1.	Em que caso devemos utilizar o JOIN? Quais tabelas podem ser utilizando em um comando JOIN?
2.	No caso do JOIN, o que é condição de junção. Qual cuidado devemos ter. 
3.	Em relação a sintaxe, em um JOIN não é necessário utilizarmos condições (WHERE) - o comando irá executar normalmente. Porém, em questão de semântica, a cada junção é necessário ter ao menos 1 condição. Explique.
4.	O que é produto cartesiano? Como funciona? Qual a relação com o JOIN.
5.	Na elaboração de um consulta que envolve 1587 tabelas, serão necessários, quantas condições de junção?

 */


