/**
Lista de exercícios - OUTER JOIN 

Responda as questões:
01 - O que é OUTER JOIN? Quando é necessário? Quais opçõe existem no padrão SQL e no MySQL.
Junções em que é possível gerar resultados de registros sem relacionamento. 
Necessário quando é preciso saber quais registros não tem vínculo. Exemplo: Cliente que nunca comprou algum produto da empresa.
Existem a junção a esquerda (LEFT), a diereita (RIGHT) e a junção completa (FULL). No MySQL não existe a opção do FULL JOIN, porém é possível obter o mesmo resultado utilizando outros recursos.

02 - Quais são as opções em OUTER JOIN? Explique cada uma.
junção a esquerda (LEFT) → traz todos os registros da tabela da esquerda e os que tem relacionamento da tabela da direira.
a diereita (RIGHT) → traz todos os registros da tabela da direira e os que tem relacionamento da tabela da esquerda.
e a junção completa (FULL) → traz todos os registros da tabela da esquerda e da tabela da direira.. 

04 - Qual a sintaxe do OUTER JOIN? Maiúscula ou minúscula faz diferença? Existe algum padrão? Explique.
SELECT [colunas]
FROM tabela1 -- essa é a tabela da esquerda
LEFT JOIN tabela2 ON condição de junção;

SELECT [colunas]
FROM tabela1 -- essa é a tabela da esquerda
RIGHT JOIN tabela2 ON condição de junção;

Maiúscula ou minúscula não faz a diferença, porém, é importante padronizar.

05 - Em OUTER JOIN existe o padrão SQL89 e SQL92? Explique. 
No padrão SQL, há somente uma única forma de realizar o OUTER JOIN, porém, conforme o SGBD, poderá haver outras formas específicas.

06 - Quais são as principais diferenças entre o LEFT e o RIGHT JOIN.
O LEFT JOIN traz todos os registros da tabela da esquerda, mesmo as que não tem relação com a tabela da direira.
Já o RIGHT JOIN traz todos os registros da tabela da direira, mesmo as que não tem relação com a tabela da esquerda.

07 - Utilizando o LEFT JOIN é possível gerar o mesmo resultado com RIGHT JOIN? Justifique.
Sim, basta inverter as tabelas da esquerda para a direita.

08 - De que forma é possível gerar o resultado de FULL JOIN em MySQL?
utilizando a operação de conjunto UNION.
**/


/**
Conforme o estudo de caso, elabore as consultas solicitadas abaixo:
01 - Liste o id e o nome de todos os estados e caso existir, o nome das respectivas cidades.
*/
SELECT 
	estado.id
    ,estado.nome
    ,cidade.nome
FROM estado
LEFT JOIN cidade ON estado.id = cidade.estado_id;
/*
02 - Refaça o comando do exercício anterior, renomeando as colunas.
*/
SELECT 
	estado.id 'id estado'
    ,estado.nome 'nome estado'
    ,cidade.nome 'nome cidade'
FROM estado
LEFT JOIN cidade ON estado.id = cidade.estado_id;

/*
03 - Refaça o exercício anterior atribuindo o nome completo da tabela em todos os atributos.
*/
SELECT 
	estado.id 'id estado'
    ,estado.nome 'nome estado'
    ,cidade.nome 'nome cidade'
FROM estado
LEFT JOIN cidade ON estado.id = cidade.estado_id;

/*
04 - Refaça o exercício anterior definindo o apelido na tabela.
*/
SELECT 
	e.id 'id estado'
    ,e.nome 'nome estado'
    ,c.nome 'nome cidade'
FROM estado e
LEFT JOIN cidade c ON e.id = c.estado_id;

/*
05 - Explique a diferença entre o exercício 03 e 04. Qual é a melhor? Qual devemos estudar?
O uso de apelido reduz a escrita, facilitando a definição da referência da tabela na escrita do comando. 
Sem o apelido, é necessário escrever o nome completo da tabela, o que, conforme o contexto, poderá ajudar na legibilidade do comando.
*/

/*
06 - Liste o nome das cidade e a sigla de todos os estados.Apresente também a sigla dos estados onde não há cidades.
*/
SELECT 
    cidade.nome 
    ,estado.sigla 
FROM cidade
RIGHT JOIN estado ON estado.id = cidade.estado_id;

/*
07 - Liste o nome de todos os fornecedores de BEBEIDA NÃO ALCÓOLICA e caso exista, o registro de todas as compras realizadas com o respectivo fornecedor.
*/
SELECT 
	fornecedor.nome 
    ,compra.*
FROM fornecedor
LEFT JOIN compra ON fornecedor.id = compra.fornecedor_id 
LEFT JOIN icompra ON compra.id = icompra.compra_id 
LEFT JOIN produto ON produto.id = icompra.produto_id 
LEFT JOIN produto_categoria pc ON produto.id = pc.produto_id 
LEFT JOIN categoria ON categoria.id = pc.categoria_id 
WHERE categoria.nome = 'BEBEIDA NÃO ALCÓOLICA';

/*
08 - Escreva o comando que apresente o nome de todos os estados e caso exista, o nome de todos os funcionários que moram no estado.
*/
SELECT estado.nome
FROM estado 
LEFT JOIN cidade ON estado.id = cidade.estado_id 
LEFT JOIN funcionario ON cidade.id = funcionario.cidade_id; 

/*
09 - Escreva o comando que apresente o nome de todos os funcionários e nome dos respectivos estados onde moram. Observação: apresente também o nome dos estados onde não há funcionários morando.
*/
SELECT funcionario.nome, estado.nome
FROM funcionario 
RIGHT JOIN cidade ON cidade.id = funcionario.cidade_id 
RIGHT JOIN estado ON estado.id = cidade.estado_id; 

/*
10 - Explique a diferença entre os 2 exercícios anteriores.
No primeiro, para listar todos os estados, utilizanos o LEFT JOIN, visto que, na cláusula FROM definimos a tabela ESTADO (tabela da esquerda). 
Já no segundo, para listar os funcinários e todos os estados, pelo fato de definirmos a tabela FUNCIONARIO na cláusula FROM, foi necessário utilizar o RIGHT JOIN (a tabela estado estava a direita). 
*/

/*
11 - Liste o id e o nome de todos os clientes da região sudeste que já compraram produtos e as respectivas siglas do estado - apresente também as siglas dos estados que não tenham os clientes relacionados.
*/
SELECT 
	cliente.id
    ,cliente.nome
    ,estado.sigla
FROM cliente
RIGHT JOIN venda ON cliente.id = venda.cliente_id 
RIGHT JOIN cidade ON cidade.id = cliente.cidade_id
RIGHT JOIN estado ON estado.id = cidade.estado_id 
WHERE estado.sigla IN('SP','MG','RJ','ES');

/*
12 - Refaça o exercício anterior utilizando: o LEFT JOIN (se utilizou o RIGHT JOIN) ou o RIGHT JOIN ( se utilizou o LEFT JOIN). 
*/
SELECT 
	cliente.id
    ,cliente.nome
    ,estado.sigla
FROM estado
LEFT JOIN cidade ON estado.id = cidade.estado_id
LEFT JOIN cliente ON cidade.id = cliente.cidade_id
LEFT JOIN venda ON cliente.id = venda.cliente_id 
WHERE estado.sigla IN('SP','MG','RJ','ES');