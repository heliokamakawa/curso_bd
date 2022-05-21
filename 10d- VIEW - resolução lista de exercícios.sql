
/*
01)Crie uma VIEW que apresente o nome de todos os produtos e seus respectivos nomes de categoria, marca, tipo e linha. 
*/
CREATE VIEW view_produto AS
	SELECT	
		p.nome produto_nome
        , c.nome categoria_nome
        , m.nome marca_nome
        , t.nome tipo_nome
        , l.nome linha_nome
	FROM produto p, produto_categoria pc, categoria c, marca m, produto_tipo pt, tipo t, linha_categoria lc, linha l
	WHERE p.id = pc.produto_id 
		  AND pc.categoria_id = c.id
		AND p.marca_id = m.id 
		AND p.id = pt.produto_id
		AND pt.tipo_id = t.id
		AND c.id = lc.categoria_id
		AND lc.linha_id = l.id;
        
SELECT produto_nome, categoria_nome, marca_nome, tipo_nome, linha_nome FROM view_produto;

/*
02)Crie uma VIEW que liste a data e o valor de todas as parcelas a pagar e caso exista, o sua respectiva data de pagamento.
*/
CREATE VIEW view_parcelas AS
	SELECT 
		pp.valor valor_parcela
        , p.data_pagamento data_pagamento
	FROM parcela_pagar pp
	LEFT JOIN pagamento p ON pp.id = p.parcela_pagar_id;

SELECT valor_parcela, data_pagamento FROM view_parcelas;

/*
03)Crie uma VIEW que apresente o nome de todos os fornecedores e a (1) média e o (2) total geral de todas as compras realizadas com o respectivo fornecedor. 
*/
CREATE VIEW view_fornecedor AS
	SELECT 
		f.nome nome_fornecedor
        , AVG(c.total) media_total_compra
        , SUM(c.total) soma_total_compra
	FROM fornecedor f
	LEFT JOIN compra c ON f.id = c.fornecedor_id
	GROUP BY f.id;
    
SELECT nome_fornecedor, media_total_compra, soma_total_compra FROM view_fornecedor;

/*
04)Crie uma VIEW que possua o nome de todos os produtos fornecidos pelos fornecedores do estado do “PARANÁ” da linha “NATURAL” com o preço de custo acima de R$ 100,00.
*/
CREATE VIEW view_produto_fornecido AS
	SELECT p.nome nome_produto
	FROM estado e, cidade c, fornecedor f, compra com, item_compra ic, produto p, produto_categoria pc, categoria cat, linha_categoria lc, linha l
	WHERE e.id = c.estado_id
	AND c.id = f.cidade_id
	AND f.id = com.fornecedor_id
	AND com.id = ic.compra_id
	AND p.id = ic.produto_id
	AND p.id = pc.produto_id
	AND cat.id = pc.categoria_id 
	AND cat.id = lc.categoria_id 
	AND l.id = lc.linha_id
	AND e.nome = "PARANÁ" 
	AND l.nome = "NATURAL"
	AND p.preco_custo > 100.00;
    
SELECT nome_produto 
FROM view_produto_fornecido;

/*
05)Crie uma VIEW que tenha os nomes de todas as linhas de produtos fornecidos pelos fornecedores da região sul. Apresente o menor, o maior e a média do preço de custo dos produtos para cada linha. Retire do resultado, as linhas de produtos que possuem o preço de custo médio de cada linha menor do que R$ 100,00.
*/
CREATE VIEW view_linha AS
	SELECT 
		l.nome linha_nome
        , MIN(p.preco_custo) menor_preco
        , MAX(p.preco_custo) maior_preco
        , AVG(p.preco_custo) media_preco
	FROM estado e, cidade c, fornecedor f, compra com, item_compra ic, produto p, produto_categoria pc, categoria cat, linha_categoria lc, linha l
	WHERE e.id = c.estado_id
	AND c.id = f.cidade_id
	AND f.id = com.fornecedor_id
	AND com.id = ic.compra_id
	AND p.id = ic.produto_id
	AND p.id = pc.produto_id
	AND cat.id = pc.categoria_id 
	AND cat.id = lc.categoria_id 
	AND l.id = lc.linha_id
	AND e.nome  IN ("PARANÁ", "SANTA CATARINA", "RIO GRANDE DO SUL")
	GROUP BY l.id
	HAVING AVG(p.preco_custo) < 100.00;
    
SELECT 
	linha_nome
    , menor_preco
	, maior_preco
	, media_preco
FROM view_linha;

/*
06)Crie uma VIEW que liste o id e o nome de todos os fornecedores da região sudeste que ainda não forneceram produtos para a empresa.
*/
CREATE VIEW view_fornecedor_sudeste AS
	SELECT f.nome nome_fornecedor
	FROM estado e 
	LEFT JOIN cidade c ON c.estado_id = e.id
	LEFT JOIN fornecedor f ON f.cidade_id = c.id 
	LEFT JOIN compra com ON com.fornecedor_id = f.id
	AND e.nome  IN ("MINAS GERAIS", "SÃO PAULO", "ESPÍRITO SANTO", "RIO DE JANEIRO")
	GROUP BY f.id
	HAVING COUNT(f.id) = 0;

SELECT nome_fornecedor FROM view_fornecedor_sudeste;
    
    
 
