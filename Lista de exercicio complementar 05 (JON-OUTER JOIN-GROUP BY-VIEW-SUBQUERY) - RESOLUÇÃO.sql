/*
LISTA DE EXERCÍCIO COMPLEMENTAR 05 - JON/OUTER JOIN/GROUP BY/VIEW/SUBSELECT
Para a realização desta lista, considere o Diagrama de Entidade e Relacionamento (DER) do link: https://github.com/heliokamakawa/curso_bd/blob/master/00-estudo%20de%20caso%20loja%20-%20DER.png
script do DER: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql
*/ 

-- 1) Liste o nome de todos os estados. Em relação a cada estado, apresente: (i) a quantidade de clientes, (ii) a quantidade de fornecedores, e (iii) a quantidade de funcionários. Apresente somente estados com a quantidade de clientes acima de 5. 
-- SQL89
SELECT 
	estado.nome
    , COUNT(cliente.id) quantidade_cliente
    , COUNT(fornecedor.id) quantidade_fornecedor
    , COUNT(funcionario.id) quantidade_funcionario
FROM 
	estado
    , cidade
    , cliente
    , fornecedor
    , funcionario
WHERE estado.id = cidade.estado_id 
	AND cidade.id = cliente.cidade_id 
    AND cidade.id = fornecedor.cidade_id
    AND cidade.id = funcionario.cidade_id
GROUP BY estado.id 
HAVING COUNT(cliente.id) > 5;

-- SQL92
SELECT 
	estado.nome
    , COUNT(cliente.id) quantidade_cliente
    , COUNT(fornecedor.id) quantidade_fornecedor
    , COUNT(funcionario.id) quantidade_funcionario
FROM estado
INNER JOIN cidade ON estado.id = cidade.estado_id 
INNER JOIN cliente ON cidade.id = cliente.cidade_id 
INNER JOIN fornecedor ON cidade.id = fornecedor.cidade_id
INNER JOIN funcionario ON cidade.id = funcionario.cidade_id
GROUP BY estado.id 
HAVING COUNT(cliente.id) > 5;

-- 2) Liste o nome de todos os produtos fornecidos pelos fornecedores da região sul. Em relação a cada produto, apresente: (i) a quantidade que já foi vendida e (ii) a quantidade que já foi comprada. 
-- SQL89
SELECT 
	produto.nome nome_produto
    ,SUM(ivenda.quantidade) quantidade_vendida
    ,SUM(icompra.quantidade) quantidade_comprada
FROM 
	produto 
    ,ivenda 
    ,icompra 
    ,compra 
    ,fornecedor 
    ,cidade
    ,estado
WHERE produto.id = ivenda.produto_id 
	AND produto.id = icompra.produto_id 
    AND compra.id = icompra.compra_id 
    AND fornecedor.id = compra.fornecedor_id 
    AND cidade.id = fornecedor.cidade_id 
    AND estado.id = cidade.estado_id
    AND estado.sigla IN ('PR','SC','RS')
GROUP BY produto.id;

-- SQL92
SELECT 
	produto.nome nome_produto
    ,SUM(ivenda.quantidade) quantidade_vendida
    ,SUM(icompra.quantidade) quantidade_comprada
FROM produto 
INNER JOIN ivenda ON produto.id = ivenda.produto_id
INNER JOIN icompra ON produto.id = icompra.produto_id 
INNER JOIN compra ON compra.id = icompra.compra_id
INNER JOIN fornecedor ON fornecedor.id = compra.fornecedor_id 
INNER JOIN cidade ON cidade.id = fornecedor.cidade_id 
INNER JOIN estado ON estado.id = cidade.estado_id
WHERE estado.sigla IN ('PR','SC','RS')
GROUP BY produto.id; 


-- caso fosse necessário apresentar todos os produtos
SELECT 
	produto.nome nome_produto
    ,SUM(ivenda.quantidade) quantidade_vendida
    ,SUM(icompra.quantidade) quantidade_comprada
FROM  estado
LEFT JOIN cidade ON estado.id = cidade.estado_id 
LEFT JOIN fornecedor ON cidade.id = fornecedor.cidade_id
LEFT JOIN compra ON fornecedor.id = compra.fornecedor_id
LEFT JOIN icompra ON compra.id = icompra.compra_id 
LEFT JOIN produto ON produto.id = icompra.produto_id
LEFT JOIN ivenda ON produto.id = ivenda.produto_id
WHERE estado.sigla IN ('PR','SC','RS')
GROUP BY produto.id; 

-- 3) Refaça o primeiro exercício, porém, apresentando todos os estados (mesmo aqueles que não tenha clientes, fornecedores e funcionários).
SELECT 
	estado.nome
    , COUNT(cliente.id) quantidade_cliente
    , COUNT(fornecedor.id) quantidade_fornecedor
    , COUNT(funcionario.id) quantidade_funcionario
FROM estado
LEFT JOIN cidade ON estado.id = cidade.estado_id 
LEFT JOIN cliente ON cidade.id = cliente.cidade_id 
LEFT JOIN fornecedor ON cidade.id = fornecedor.cidade_id
LEFT JOIN funcionario ON cidade.id = funcionario.cidade_id
GROUP BY estado.id 
HAVING COUNT(cliente.id) > 5;

-- 4) Liste o nome de todos os produtos e caso exista, a quantidade e data da baixa do respectivo produto.
SELECT 
	produto.nome
    ,SUM(baixa_produto.quantidade) 
    ,GROUP_CONCAT(baixa_produto.data_cadastro)
FROM produto 
LEFT JOIN baixa_produto ON produto.id = baixa_produto.produto_id;

-- 5) Crie uma VIEW que apresente todos os clientes ativos do estado “PARANÁ” que já realizam algum pedido. Em seguida, escreva o comando de consulta desta VIEW que apresente o nome de todos os clientes que fizeram o orçamento acima de R$ 500,00.
-- SQL89
CREATE OR REPLACE VIEW view_clientes_parana AS
	SELECT cliente.*, venda.total
    FROM estado
		,cidade
        ,cliente 
        ,venda
	WHERE estado.id = cidade.estado_id 
		AND cidade.id = cliente.cidade_id 
        AND cliente.id = venda.cliente_id
        AND cliente.status = 'A' 
        AND estado.nome = 'PARANÁ'
        AND venda.tipo = 'PEDIDO';

-- SQL92
CREATE OR REPLACE VIEW view_clientes_parana AS
	SELECT cliente.*, venda.total
    FROM estado
	INNER JOIN cidade ON estado.id = cidade.estado_id
    INNER JOIN cliente ON cidade.id = cliente.cidade_id
    INNER JOIN venda ON cliente.id = venda.cliente_id
	WHERE cliente.status = 'A' 
        AND estado.nome = 'PARANÁ'
        AND venda.tipo = 'PEDIDO';


SELECT nome 
FROM view_clientes_parana
WHERE total > 500;
        
-- 6) Crie uma VIEW que apresente todos os estados, e a quantidade de fornecedores que possuem algum valor a receber da empresa. Caso o estado não tenha registros nestas condições apresente 0. Em seguida, escreva o comando de consulta desta VIEW.
CREATE OR REPLACE VIEW view_qtde_fornecedores_a_pagar AS 
	SELECT 
		estado.nome 
        ,COUNT(fornecedor.id) 
	FROM estado
    LEFT JOIN cidade ON estado.id = cidade.estado_id 
    LEFT JOIN fornecedor ON cidade.id = fornecedor.cidade_id 
    LEFT JOIN compra ON fornecedor.id = compra.fornecedor_id 
    LEFT JOIN cpagar ON compra.id = cpagar.compra_id 
    WHERE cpagar.qtde_parc_pendente > 0;

SELECT * FROM view_qtde_fornecedores_a_pagar;
    
-- 7) Liste o nome e o preço de todos os produtos cadastrados que já foram pedidos por um cliente, porém que ainda não foram vendidas.
SELECT 
	produto.nome
    ,produto.preco_venda
FROM produto
	,ivenda
    ,venda
WHERE produto.id = ivenda.produto_id 
	AND venda.id = ivenda.venda_id 
    AND venda.tipo = 'PEDIDO' 
    AND produto.id NOT IN (
			SELECT produto.id 
            FROM produto
				,ivenda 
			WHERE produto.id = ivenda.produto_id
		);

-- 8) Liste o nome de todos os estados cujo não há clientes cadastrados.
SELECT 
	estado.nome 
FROM estado 
WHERE estado.id NOT IN (
		SELECT estado.id 
        FROM estado
			,cidade
            ,cliente
		WHERE estado.id = cidade.estado_id 
        AND cidade.id = cliente.cidade_id
	);