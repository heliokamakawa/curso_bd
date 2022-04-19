/**
Lista de exercícios - JOIN 

Responda as questões:
01 - O que é JOIN? Quando é necessário?
R: Recurso utilizado para consultas de mais de uma tabela. Necessário para criar informações onde os dados estão em tabelas distintas.

02 - Qual a sintaxe do JOIN? Maiúscula ou minúscula faz diferença? Existe algum padrão? Explique.
R: 
Em banco de dados não há padrões definidos ou distinção entre letras maiúscula e minúscula. 
Porém, é importante que se adote um padrão.

-- Padrão SQL89
SELECT * ou nome colunas 
FROM nome_tabela1, nome_tabela2 
WHERE coluna_pk = coluna_fk;

-- Padrão SQL92
SELECT * ou nome colunas 
FROM nome_tabela1 
INNER JOIN nome_tabela2 ON coluna_pk = coluna_fk;

04 - O que é primordial para que o resultado tenha sentido em consultas com JOIN? Explique.
A condição de junção, a comparação do identificador de uma tabela e a sua referência na tabela que será juntada.
Sem a condição de junção, todos os registros serão combinados, gerando um resultado com a semântica indesejada.

05 - Existe mais de uma maneira de realizar o JOIN? Quantas? Qual é a mais eficiente? 
Sim, existem duas formas: o padrão SQL89 e o SQL92. Atualmente, não há diferença em funcionamento ou desempenho entre os dois padrões. 

06 - Para realizar o JOIN de 1523 tabelas, quantas comparações de junções são necessárias? Explique.
Serão necessárias 1522 comparações de junções. Para cada duas tabelas é necessário uma comparação de junção.

07 - O que é análise semântica e de sintaxe? Qual a diferença? Para que serve?
A sintaxe se refere à escrita correta de um comando. Conjuntos de palavras permitidas, bem como, a ordem que é definida.
A semântica enfatiza a interpretação de um comando para que se possa projetar o resultado desejado.
Geralmente, os erros de sintaxe são identificados pelo editor de código, enquanto que a sintaxe depende do profissional do BD. 
A semântica errada pode gerar grandes problemas, visto que, são erros não identificáveis pela IDE e assim, pode gerar resultados parcial ou totalmente errados – trazendo possíveis prejuízos à empresa.

08 - Em uma consulta com JOIN, há casos em que seja necessário atribuir o nome da tabela na projeção das colunas? Explique.
Sim, quando se projeta uma coluna no resultado, na qual, o nome é igual em mais que uma tabela envolvida – é necessário para que o BD consiga entender qual coluna será projetada. 
Exemplo: 
ESTADO {ID¬¬PK,NOME,SIGLA}
CIDADE {ID¬¬PK,NOME, ESTADO_ID¬¬FK-estado}

-- este comando gera erro
SELECT nome  → o BD não sabe se queremos o nome de cidade ou estado?
FROM estado, cidade 
WHERE estado.id = cidade.estado_id; 

09 - De acordo com o estudo de caso, cite 4 exemplos em que seja possível utilizar o JOIN e 3 exemplos que não seja possível realizar o JOIN.
Junções possíveis: estado e cidade, cidade e fornecedor, compra e icompra, recebimento e icaixa.
Junções impossíveis: estado e cliente, venda e compra, recebimento e pagamento.
**/

/* Conforme o estudo de caso, elabore as consultas solicitadas abaixo: 
obs: Para cada questão utilize o padrão SQL89 e SQL92 */


/* 01 - Liste o id e o nome de todas as cidades e as respectivas siglas do estado. */
-- SQL89
SELECT cidade.id, cidade.nome, sigla
FROM cidade, estado
WHERE estado.id = estado_id;

-- SQL92
SELECT cidade.id, cidade.nome, sigla
FROM estado
INNER JOIN cidade ON estado.id = estado_id;


/* 02 - Em relação ao resultado do exercício anterior, note que os nomes das colunas não estão claras. Refaça o comando para que torne mais claras. */
-- SQL89
SELECT 
	cidade.id 'código cidade'
	, cidade.nome 'nome cidade'
	, sigla 'sigla estado'
FROM cidade, estado
WHERE estado.id = estado_id;

-- SQL92
SELECT 
	cidade.id 'código cidade'
	, cidade.nome 'nome cidade'
	, sigla 'sigla estado'
FROM estado
INNER JOIN cidade ON estado.id = estado_id;

/* 03 - Refaça o exercício anterior atribuindo o nome completo da tabela em todos os atributos. */
-- SQL89
SELECT 
	cidade.id 'código cidade'
	, cidade.nome 'nome cidade'
	, estado.sigla 'sigla estado'
FROM cidade, estado
WHERE estado.id = cidade.estado_id;

-- SQL92
SELECT 
	cidade.id 'código cidade'
	, cidade.nome 'nome cidade'
	, estado.sigla 'sigla estado'
FROM estado
INNER JOIN cidade ON estado.id = cidade.estado_id;

/* 04 - Refaça o exercício anterior definindo o apelido na tabela. */
-- SQL89
SELECT 
	c.id 'código cidade'
	, c.nome 'nome cidade'
	, e.sigla 'sigla estado'
FROM cidade c, estado e
WHERE e.id = c.estado_id;

-- SQL92
SELECT 
	c.id 'código cidade'
	, c.nome 'nome cidade'
	, e.sigla 'sigla estado'
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id;

/* 05 - Explique a diferença entre o exercício 03 e 04. Qual é a melhor? Qual devemos estudar? */
-- R: A definição do apelido nas tabelas (exercício 04) facilita/reduz a escrita. Porém, em muitos casos, o nome completo das tabelas torna o comando mais legível, e assim, consequentemente mais fácil de dar manutenção.

/* 06 - Quantos registros foram gerados no resultado do exercício 02? O comando do exercício anterior pode ser utilizado para descobrir as cidades da região sul? Justifique/explique o que ocorre. */
Foram gerados, 1.000 registros. 
As cidades da região sul constam no resultado. Porém, além da dificuldade na visualização, executar o comando anterior para buscar as cidades da região sul, gera desperdício de processamento e espaço.

/* 07 - Liste o id e o nome de todas as cidades e as respectivas siglas do estado de São Paulo. */
-- SQL89
SELECT 
	c.id 'código cidade'
	, c.nome 'nome cidade'
	, e.sigla 'sigla estado'
FROM cidade c, estado e
WHERE e.id = c.estado_id
	AND e.nome = 'SÃO PAULO';

-- SQL92
SELECT 
	c.id 'código cidade'
	, c.nome 'nome cidade'
	, e.sigla 'sigla estado'
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id
WHERE e.nome = 'SÃO PAULO';


/* 08 - Liste o id e o nome de todas as cidades da região sudeste e as respectivas siglas do estado. */
-- SQL89
SELECT 
	c.id 'código cidade'
	, c.nome 'nome cidade'
	, e.sigla 'sigla estado'
FROM cidade c, estado e
WHERE e.id = c.estado_id
	AND e.nome IN('MINAS GERAIS','ESPÍRITO SANTO','RIO DE JANEIRO','SÃO PAULO');

-- SQL92
SELECT 
	c.id 'código cidade'
	, c.nome 'nome cidade'
	, e.sigla 'sigla estado'
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id
WHERE e.nome IN('MINAS GERAIS','ESPÍRITO SANTO','RIO DE JANEIRO','SÃO PAULO');

/* 09 - Escreva a consulta que liste o nome dos Funcionários do estado Paraná. */
-- SQL89
SELECT 
	f.nome
FROM funcionario f, cidade c, estado e
WHERE e.id = c.estado_id
	AND c.id = f.cidade_id
	AND e.nome = 'PARANÁ';

-- SQL92
SELECT 
	f.nome
FROM estado e
INNER JOIN cidade c ON e.id = c.estado_id 
INNER JOIN funcionario f ON c.id = f.cidade_id
WHERE e.nome = 'PARANÁ';

/* 10 - Escreva a consulta que liste o nome e o telefone dos Fornecedores da cidade de São Paulo. */
-- SQL89
SELECT 
	f.nome, f.fone, f.fone_segundario
FROM fornecedor f, cidade c
WHERE 
	c.id = f.cidade_id
	AND c.nome = 'SÃO PAULO'; //CUIDADO A CIDADE NÃO É ÚNICA

-- SQL92
SELECT 
	f.nome, f.fone, f.fone_segundario 
FROM cidade c 
INNER JOIN fornecedor f ON c.id = f.cidade_id
WHERE c.nome = 'SÃO PAULO';


/* 11 - Liste os produtos da categoria BEBEIDA NÃO ALCÓOLICA e da linha ALIMENTOS E BEBIDAS. */
-- SQL89
SELECT 
	p.nome
FROM 
	produto p
	, produto_categoria pc 
	, categoria c
	, linha_categoria lc 
	, linha l
WHERE 
	p.id = pc.produto_id
	AND pc.categoria_id = c.id
	AND c.id = lc.categoria_id
	AND lc.linha_id = l.id
	AND c.nome = 'BEBEIDA NÃO ALCÓOLICA'
	AND l.nome = 'ALIMENTOS E BEBIDAS'; 

-- SQL92
SELECT 
	p.nome 
FROM produto p 
INNER JOIN produto_categoria pc ON p.id = pc.produto_id 
INNER JOIN categoria c ON c.id = pc.categoria_id
INNER JOIN linha_categoria lc ON c.id = lc.categoria_id 
INNER JOIN linha l ON l.id = lc.linha_id
WHERE 
	c.nome = 'BEBEIDA NÃO ALCÓOLICA'
	AND l.nome = 'ALIMENTOS E BEBIDAS'; 

/* 12 - Liste os produtos que possuem a unidade de medida em QUILOGRAMA. */
-- SQL89
SELECT 
	p.nome
FROM produto p, unidade_medida um
WHERE 
	um.id = p.unidade_medida_id
	AND um.nome = 'QUILOGRAMA';

-- SQL92
SELECT 
	p.nome 
FROM produto p 
INNER JOIN unidade_medida um ON um.id = p.unidade_medida_id
WHERE um.nome = 'QUILOGRAMA';

/* 13 - Em qual categoria e linha pertence o produto REFRIGERANTE COCA-COLA GARRAFA PET 2 L?*/
-- SQL89
SELECT 
	c.nome
FROM categoria c, produto_categoria pc, produto p
WHERE 
	c.id = pc.categoria_id
	AND pc.produto_id = p.id
	AND p.nome = 'REFRIGERANTE COCA-COLA GARRAFA PET 2 L';

-- SQL92
SELECT 
	p.nome 
FROM categoria c 
INNER JOIN produto_categoria pc ON c.id = pc.categoria_id
INNER JOIN produto p ON pc.produto_id = p.id
WHERE p.nome = 'REFRIGERANTE COCA-COLA GARRAFA PET 2 L';


/*14 - Qual o nome da linha onde estão todos os refrigentes? */
-- SQL89
SELECT 
	DISTINCT c.nome
FROM categoria c, produto_categoria pc, produto p
WHERE 
	c.id = pc.categoria_id
	AND pc.produto_id = p.id
	AND p.nome LIKE '%REFRIGERANTE%';

-- SQL92
SELECT 
	DISTINCT c.nome
FROM categoria c 
INNER JOIN produto_categoria pc ON c.id = pc.categoria_id
INNER JOIN produto p ON pc.produto_id = p.id
WHERE  p.nome LIKE '%REFRIGERANTE%';

/* 15 - Qual o produto (preço de venda) mais caro da categoria BEBEIDA NÃO ALCÓOLICA? */
-- SQL89
SELECT 
	MAX(p.preco_venda)
FROM categoria c, produto_categoria pc, produto p
WHERE 
	c.id = pc.categoria_id
	AND pc.produto_id = p.id
	AND c.nome = 'BEBIDA NÃO ALCÓOLICA';

-- SQL92
SELECT 
	MAX(p.preco_venda)
FROM categoria c 
INNER JOIN produto_categoria pc ON c.id = pc.categoria_id
INNER JOIN produto p ON pc.produto_id = p.id
WHERE c.nome = 'BEBIDA NÃO ALCÓOLICA';

SELECT 
	p.nome
FROM produto p
WHERE p.preco_venda = ??? → COLOCA O PREÇO QUE ENCONTROU

-- Observação: há outras formas melhores. Ainda vamos estudar.


/* 16 - Escreva o comando que apresente a quantidade de produtos líquidos? */

-- SQL89
SELECT 
	COUNT(p.id)
FROM 
	produto p
	, unidade_medida um
WHERE 
	um.id = p.unidade_medida_id
	AND um.nome IN ('LITRO','MILILITRO');

-- SQL92
SELECT 
	COUNT(p.id)
FROM 
	produto p
INNER JOIN unidade_medida um ON um.id = p.unidade_medida_id
WHERE um.nome IN ('LITRO','MILILITRO');

/* 17 - Escreva o comando que apresente a quantidade de BEBIDA ALCÓOLICA que estão cadastrados em produtos? */
-- SQL89
SELECT COUNT(p.id)
FROM 
	produto p
	, produto_categoria pc
	, categoria c
WHERE 
	p.id = pc.produto_id
	AND c.id = pc.categoria_id
	AND c.nome = 'BEBIDA ALCÓOLICA';

-- SQL92
SELECT 
	COUNT(p.id)
FROM 
	produto p
INNER JOIN produto_categoria pc ON p.id = pc.produto_id
INNER JOIN categoria c ON c.id = pc.categoria_id
WHERE c.nome = 'BEBIDA ALCÓOLICA';

/* 18 - Escreva o comando que liste o nome dos Refrigerantes de 2 L? */
-- SQL89
SELECT p.nome
FROM 
	produto p
	, produto_tipo pt
	, tipo t
WHERE 
	p.id = pt.produto_id
	AND t.id = pt.tipo_id
	AND c.descricao = ' REFRIGERANTE GARRAFA PET 2 L';

-- SQL92
SELECT p.nome
FROM 
	produto p
INNER JOIN produto_tipo pt ON t.id = pt.tipo_id
INNER JOIN tipo t ON t.id = pt.tipo_id
WHERE c.descricao = ' REFRIGERANTE GARRAFA PET 2 L';

/* 19 - Escreva o comando que apresente o preço médio dos Refrigentes de 2 L? */
-- SQL89
SELECT AVG(p.preco_venda)
FROM 
	produto p
	, produto_tipo pt
	, tipo t
WHERE 
	p.id = pt.produto_id
	AND t.id = pt.tipo_id
	AND c.descricao = ' REFRIGERANTE GARRAFA PET 2 L';

-- SQL92
SELECT AVG(p.preco_venda)
FROM 
	produto p
INNER JOIN produto_tipo pt ON t.id = pt.tipo_id
INNER JOIN tipo t ON t.id = pt.tipo_id
WHERE c.descricao = ' REFRIGERANTE GARRAFA PET 2 L';

/* 20 - Com base do estudo de caso, elabore um exercício de sua autoria que envolva pelo menos 3 tabelas, no qual, o resultado possa ajudar o usuário. Em seguida resolva o exercício elaborado.*/


