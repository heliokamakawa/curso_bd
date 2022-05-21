/*
EXERCÍCIOS
01) Listar o nome de cidade e quantos fornecedores tem.
*/
SELECT cidade.nome, COUNT(fornecedor.id) 
FROM cidade, fornecedor 
WHERE cidade.id = fornecedor.cidade_id 
GROUP BY cidade.id;

/*
02) Listar o nome de cidade e quantos clientes tem.
*/
SELECT cidade.nome, COUNT(cliente.id) 
FROM cidade
INNER JOIN cliente ON cidade.id = cliente.cidade_id 
GROUP BY cidade.id;

/*
03) Listar o nome de cidade e quantos funcionários tem.
*/
SELECT cidade.nome, COUNT(funcionario.id) 
FROM cidade
INNER JOIN funcionario ON cidade.id = funcionario.cidade_id 
GROUP BY cidade.id;

SELECT cidade.nome, COUNT(funcionario.id) 
FROM cidade, funcionario 
WHERE cidade.id = funcionario.cidade_id 
GROUP BY cidade.id;
/*
04) Listar o nome de cidade e os nomes dos fornecedores de cada cidade.
*/
SELECT cidade.nome, GROUP_CONCAT(fornecedor.nome) 
FROM cidade, fornecedor 
WHERE cidade.id = fornecedor.cidade_id 
GROUP BY cidade.id;
/*
05) Listar o nome de estado e quantos clientes tem. 
*/
SELECT estado.nome, COUNT(cliente.id) 
FROM estado
INNER JOIN cidade ON estado.id = cidade.estado_id 
INNER JOIN cliente ON cidade.id = cliente.cidade_id 
GROUP BY estado.id;
/*
06) Listar o nome de cidade e os nomes dos funcionários de cada cidade 
*/
SELECT cidade.nome, GROUP_CONCAT(funcionario.nome) 
FROM cidade, funcionario 
WHERE cidade.id = funcionario.cidade_id 
GROUP BY cidade.id;
/*
07) Listar o nome de estado e quantos funcionários tem em cada estado. Mostre somente os estados que apresentam mais que 3 funcionários.
*/
SELECT estado.nome, COUNT(funcionario.id) 
FROM estado
INNER JOIN cidade ON estado.id = cidade.estado_id 
INNER JOIN funcionario ON cidade.id = funcionario.cidade_id 
GROUP BY estado.id
HAVING COUNT(funcionario.id) > 3;
/*
08) Listar o nome de estado e quantos clientes tem em cada estado. Mostre somente os estados da região sul e que apresentam mais que 5 clientes em cada estado.
*/
SELECT estado.nome, COUNT(cliente.id) 
FROM estado
INNER JOIN cidade ON estado.id = cidade.estado_id 
INNER JOIN cliente ON cidade.id = cliente.cidade_id 
WHERE estado.sigla IN ('PR','SC','RS')
GROUP BY estado.id
HAVING COUNT(cliente.id) > 5;
/*
09) Listar o nome das categorias dos produtos que nunca foram vendidos.
*/
SELECT categoria.nome
FROM categoria 
LEFT JOIN produto_categoria ON categoria.id = produto_categoria.categoria_id 
LEFT JOIN produto ON produto_categoria.produto_id = produto.id 
LEFT JOIN icompra  ON produto.id = icompra.produto_id
GROUP BY categoria.id
HAVING  COUNT(produto.id) = 0;

/*
10) Listar o nome das categorias dos produtos e quantos produtos tem em cada categoria. Apresente somente as categorias que tem a quantidade de prodtuos maior que a média da categoria.
*/
SELECT categoria.nome 
FROM categoria, produto_categoria, produto 
WHERE categoria.id = produto_categoria.categoria_id 
AND produto_categoria.produto_id = produto.id 
GROUP BY categoria.id 
HAVING COUNT(produto.id) > AVG(produto.id);
/*
11) De acordo com o script executado, elabore 5 consultas utilizando GROUP BY que podem ajudar a empresa. Exeplique.
12) De acordo com o seu estudo de caso, elabore 5 consultas utilizando GROUP BY que podem ajudar a empresa. Exeplique.
13) De acordo com o seu estudo de caso, faça pelo menos 3 exemplos de consultas utilizando GROUP BY e LEFT/RIGHT JOIN que podem ajudar a empresa. Exeplique.
*/


