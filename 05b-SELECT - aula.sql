/*
SELECT - Consulta de Dados

**SINTAXE
SELECT * FROM {nome_tabela}; 

→ SELECT – serve para indicar quais colunas da tabela serão apresentadas no resultado 
→ "*" indica que todas as colunas serão apresentadas no resultado 
→ FROM – para indicar de qual tabela será a consulta 

Exemplo: */
	SELECT * FROM estado;  -- mostra TODOS os dados de TODAS as colunas de TODOS os registros de estado 

/*
**SINTAXE de uma consulta especificando colunas: 
SELECT  
 {nome_coluna1} 
 ,{nome_coluna2} 
 ,[... outras colunas] 
FROM  
 {nome_tabela}; 
→ Para especificar colunas no SELECT, separa-se as colunas com “,” (vírgula). 

Exemplo: */
	SELECT 
		nome 
		,sigla 
	FROM estado; -- este comando gera um resultado com os nomes e siglas de TODOS os registros de estado  

/*
**SINTAXE de uma consulta especificando/filtrando registros - WHERE (quais linhas devem ser  apresentadas): 
SELECT  
 {nome_coluna1} 
 ,{nome_coluna2} 
 , [... outras colunas] 
FROM  
 {nome_tabela} 
WHERE  
 coluna {=, <>, >, <, outros} condição 
 AND/OR coluna {=, <>, >, <, outros} condição1 
 AND/OR coluna {=, <>, >, <, outros} condição2 
 AND/OR coluna {=, <>, >, <, outros} condição3; 
 
Exemplo 1: */
	SELECT * 
	FROM estado 
	WHERE id = 1;  -- Este comando gera um resultado com os dados do estado que possui id igual a 1.  

-- Exemplo 2: 
	SELECT nome,sigla 
	FROM estado 
    WHERE nome = 'PARANÁ';  -- Apresenta nome e sigla do estado que possui o nome igual a PARANÁ.
  
/**SINTAXE para indicar qual tabela a coluna pertence (apesar do trabalho extra, é uma boa prática,  visto que, melhora a legibilidade do comando) */
SELECT 
 estado.nome 
 ,estado.sigla 
 ,estado.data_cadastro 
FROM estado 
WHERE estado.id = 1; 
  
/**SINTAXE para definir um apelido (alias) para tabela (muito utilizado em consultas que envolvem muitas  tabelas) */
SELECT 
 e.nome 
 ,e.sigla 
 ,e.data_cadastro 
FROM estado e 
WHERE e.id = 1;

/**SINTAXE para renomear nome de colunas no resultado (muito útil quando a consulta retorna colunas  com nomes iguais ou que possuem nomes que não são compreensíveis). */
SELECT 
 e.nome 'NOME ESTADO' 
 ,e.sigla 'SIGLA ESTADO' 
 ,e.data_cadastro 'DATA DO CADASTRO' 
FROM estado e 
WHERE e.id = 1; 
  
/**SINTAXE para usar funções de biblioteca na cláusula WHERE */
-- consultando estados cadastrados em 2020 
SELECT 
 nome 'NOME ESTADO' 
 ,sigla 'SIGLA ESTADO' 
 ,data_cadastro 'DATA DO CADASTRO' 
FROM  
 estado 
WHERE 
 YEAR(data_cadastro) = 2020; 
  
/**SINTAXE para consultas com o operador relacional “diferente” (!= ou <>) */
-- consultando estados que não foram cadastrados em 2020 
SELECT 
 nome 'NOME ESTADO' 
 ,sigla 'SIGLA ESTADO' 
 ,data_cadastro 'DATA DO CADASTRO' 
FROM  
 estado 
WHERE 
 YEAR(data_cadastro) != 2020; 

/**SINTAXE para consultas com o operador lógico “ou” (OR) */
-- consultando estados que foram cadastrados em 2016 OU 2020 
SELECT 
 nome 'NOME ESTADO' 
 ,sigla 'SIGLA ESTADO' 
 ,data_cadastro 'DATA DO CADASTRO' 
FROM 
 estado 
WHERE 
 YEAR(data_cadastro) = 2016 
 OR YEAR(data_cadastro) = 2020; 
  
/**SINTAXE para consultas com 3 condições na cláusula WHERE */
-- consultando estados que foram cadastrados em 2015, 2017 OU 2020 
SELECT 
 nome 'NOME ESTADO' 
 ,sigla 'SIGLA ESTADO' 
 ,data_cadastro 'DATA DO CADASTRO' 
FROM 
 estado 
WHERE 
 YEAR(data_cadastro) = 2015 
 OR YEAR(data_cadastro) = 2017 
 OR YEAR(data_cadastro) = 2020; 
  
/**SINTAXE para consultas com o uso da função IN na cláusula WHERE */
SELECT 
	nome, sigla, data_cadastro 
FROM 
	estado 
WHERE 
	YEAR(data_cadastro) IN (2015, 2017, 2020); 
  
/**SINTAXE para definir "entre" dois valores com >= e <= */
SELECT 
	nome, sigla, data_cadastro 
FROM estado 
WHERE 
	YEAR(data_cadastro) >= 2015 
	AND YEAR(data_cadastro) <= 2019; 
  
/**SINTAXE para definir "entre" dois valores com o BETWEEN */
SELECT 
	nome, sigla, data_cadastro 
FROM estado 
WHERE 
	YEAR(data_cadastro) BETWEEN 2015 AND 2019; 
  
/**SINTAXE para definir consultas que retornam registros de um determinado período e com outra condição */
-- consultando estados que foram cadastrados de 2015 à 2019 e são ATIVOS 
SELECT 
	nome, sigla, data_cadastro 
FROM estado 
WHERE 
	YEAR(data_cadastro) BETWEEN 2015 AND 2019 
	AND ativo = 'S'; 
  
-- consultando estados que foram cadastrados de 2015 à 2019 e não ATIVOS 
SELECT 
	nome, sigla, data_cadastro 
FROM 
	estado 
WHERE 
	YEAR(data_cadastro) BETWEEN 2015 AND 2019 
	AND ativo = 'N'; 
  
/*
AGORA É A SUA VEZ!!!! Se tiver dificuldades, compareça nos atendimentos! Faça de forma  consciente, sabendo o que é cada coisa que digita. 
1. Escreva o comando que liste os dados de todas as colunas de todos os registros da tabela estado.
2. Refaça o exercício anterior com a diferença de trazer somente os dados das colunas: id, sigla e se o  estado é ativo. 
3. Refaça o exercício nº2 inserindo a tabela na coluna. Na sua opinião o trabalho que dá compensa? Justifique.
4. Refaça o exercício nº2, definindo apelido na tabela e inserindo-a na coluna. O uso de apelido reduz o  trabalho? Na sua opinião, é melhor com ou sem apelido? Justifique. 
5. Liste o nome e a data do cadastro de todos os estados não ativos registrados no ano 2020. 
6. Liste o id e a sigla dos estados ativos com id maior do que 15. 
7. Busque os dados do estado com o id igual a 7. 
8. Liste a sigla dos estados que possuem o nome com a letra inicial “B”. (Faça uma pesquisa para  conseguir fazer este exercício). 
9. Liste o nome de todos os estados da região sul. 
10. Liste o id, nome e sigla dos estados da região sul e norte.
*/
