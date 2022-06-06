/*
Lista de exercícios complementar 06 (JOIN, OUTER JOIN, GROUP BY, VIEW, SUBQUERY)
Link DER: https://github.com/heliokamakawa/curso_bd/blob/master/der/servico%20oficina%20mecanica%20-%20DER.png
Link Script: https://github.com/heliokamakawa/curso_bd/blob/master/der/servico%20oficina%20mecanica%20-%20SCRIPT.sql
*/

-- 1) Liste os nomes do clientes da região sul que já realizam algum serviço na empresa envolvendo peças com preço de custo maior que R$ 100,00.
-- padrão SQL89
SELECT cliente.nome
FROM estado, cidade, cliente, ordem_servico, item_ordem_servico, peca, servico_realizado
WHERE estado.id = cidade.estado_id 
   AND cidade.id = cliente.cidade_id 
   AND cliente.id = ordem_servico.cliente_id 
   AND ordem_servico.id = item_ordem_servico.ordem_servico_id 
   AND peca.id = item_ordem_servico.peca_id 
   AND item_ordem_servico.servico_realizado_id = servico_realizado.id 
   AND estado.sigla IN ('PR','SC','RS')
   AND peca.preco_custo > 100;

-- padrão SQL92
SELECT cliente.nome
FROM estado
INNER JOIN cidade ON estado.id = cidade.estado_id
INNER JOIN cliente ON cidade.id = cliente.cidade_id 
INNER JOIN ordem_servico ON cliente.id = ordem_servico.cliente_id 
INNER JOIN item_ordem_servico ON ordem_servico.id = item_ordem_servico.ordem_servico_id 
INNER JOIN peca ON peca.id = item_ordem_servico.peca_id 
INNER JOIN servico_realizado ON item_ordem_servico.servico_realizado_id = servico_realizado.id 
WHERE estado.sigla IN ('PR','SC','RS')
   AND peca.preco_custo > 100;
    
-- 2) Liste o nome de todas as categorias de peças. Em relação a cada categoria de peças, apresente: (i) a quantidade de peças, (ii) a peça mais cara, (iii) a mais barata, e (iv) a média de preços das peças. Observação: considere o preço de custo. 
-- padrão SQL89
SELECT 
    categoria.nome
    , SUM(estoque) 
    , MAX(peca.preco_custo) 
    , MIN(peca.preco_custo) 
    , AVG(peca.preco_custo)
FROM 
    categoria
    , peca_categoria
    , peca
WHERE categoria.id = peca_categoria.categoria_id
   AND peca_categoria.peca_id = peca.id
GROUP BY categoria.id;

-- padrão SQL92
SELECT 
    categoria.nome
    , COUNT(estoque) 
    , MAX(peca.preco_custo) 
    , MIN(peca.preco_custo) 
    , AVG(peca.preco_custo)
FROM categoria
INNER JOIN peca_categoria ON categoria.id = peca_categoria.categoria_id
INNER JOIN peca ON peca_categoria.peca_id = peca.id
GROUP BY categoria.id;

-- 3) Liste a data de cadastro e o total de todas as ordens de serviços e caso exista, os respectivos serviços realizados.
SELECT ordem_servico.data_cadastro, ordem_servico.total, servico.nome
FROM ordem_servico
LEFT JOIN item_ordem_servico ON ordem_servico.id = item_ordem_servico.ordem_servico_id
LEFT JOIN servico_realizado ON servico_realizado.id = item_ordem_servico.servico_realizado_id
LEFT JOIN servico ON servico.id = servico_realizado.servico_id;

-- 4) Crie uma VIEW que apresente todos os clientes ativos do estado “PARANÁ” que já realizam algum orçamento. Em seguida, escreva o comando de consulta desta VIEW que apresente o nome de todos os clientes que fizeram o orçamento acima de R$ 500,00.
-- padrão SQL89
CREATE OR REPLACE VIEW view_cliente_parana AS 
    SELECT cliente.id, cliente.nome, ordem_servico.total
    FROM estado, cidade, cliente, ordem_servico
    WHERE estado.id = cidade.estado_id
    AND cidade.id = cliente.cidade_id 
    AND cliente.id = ordem_servico.cliente_id
    AND estado.nome = 'PARANÁ'
    AND ordem_servico.e_orcamento = 'S'
    AND cliente.ativo = 'S';

-- padrão SQL92    
CREATE OR REPLACE VIEW view_cliente_parana AS 
    SELECT cliente.id, cliente.nome, ordem_servico.total
    FROM estado
    INNER JOIN cidade ON estado.id = cidade.estado_id
    INNER JOIN cliente ON cidade.id = cliente.cidade_id 
    INNER JOIN ordem_servico ON cliente.id = ordem_servico.cliente_id
    WHERE estado.nome = 'PARANÁ'
    AND ordem_servico.e_orcamento = 'S'
    AND cliente.ativo = 'S';

SELECT view_cliente_parana.nome FROM view_cliente_parana WHERE view_cliente_parana.total > 500;
    
-- 5) Liste os nomes de todos os clientes e o respectivo total geral de todas as ordens de serviços realizadas pelo respectivo cliente. Retire os resultados em que a média de total geral de cada cliente seja abaixo de R$ 900,00.
-- padrão SQL89  
SELECT cliente.nome, SUM(ordem_servico.total)
FROM cliente, ordem_servico
WHERE cliente.id = ordem_servico.cliente_id
AND ordem_servico.e_orcamento = 'N'
GROUP BY cliente.id
HAVING AVG(ordem_servico.total) >= 900;

-- padrão SQL92  
SELECT cliente.nome, SUM(ordem_servico.total)
FROM cliente
INNER JOIN ordem_servico ON cliente.id = ordem_servico.cliente_id
WHERE ordem_servico.e_orcamento = 'N'
GROUP BY cliente.id
HAVING AVG(ordem_servico.total) >= 900;

-- 6) Liste o nome e o preço de venda de todas as peças cadastradas que já foram orçadas pelos clientes, porém que ainda não foram vendidas.
SELECT peca.nome, peca.preco_venda
FROM cliente, ordem_servico, item_ordem_servico, peca
WHERE cliente.id = ordem_servico.cliente_id 
AND ordem_servico.id = item_ordem_servico.ordem_servico_id 
AND item_ordem_servico.peca_id = peca.id
AND  ordem_servico.e_orcamento = 'S'
AND peca.id NOT IN(
		SELECT item_ordem_servico.peca_id
		FROM ordem_servico, item_ordem_servico
		AND ordem_servico.id = item_ordem_servico.ordem_servico_id 
		AND ordem_servico.e_orcamento = 'N'
	);
    
SELECT peca.nome, peca.preco_venda
FROM ordem_servico ON cliente.id = ordem_servico.cliente_id 
INNER JOIN item_ordem_servico ON ordem_servico.id = item_ordem_servico.ordem_servico_id
INNER JOIN peca ON item_ordem_servico.peca_id = peca.id
WHERE ordem_servico.e_orcamento = 'S'
AND peca.id NOT IN(
		SELECT peca.id
		FROM ordem_servico ON cliente.id = ordem_servico.cliente_id 
		INNER JOIN item_ordem_servico ON ordem_servico.id = item_ordem_servico.ordem_servico_id
		WHERE ordem_servico.e_orcamento = 'N'
	);
