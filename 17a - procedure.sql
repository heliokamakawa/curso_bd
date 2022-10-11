/*
******************** Procedures ******************** 
- Um bloco de comandos para realizar uma ação;
- Não tem retorno;
- Como ão tem retorno, NÃO podemos chamar no SELECT; Exemplo:  
		SELECT minha_procedure(); -- >>>NÃO FUNCIONA
- Como não tem retorno, é necessário fazer a chamada pelo 'CALL'; 
		Exemplo:  CALL minha_procedure(); 
Pode executar INSERT, UPDATE, DELETE ou SELECT; Podem mudar o estado do BD (commit/rollback); >>>Na função não dá...
Além do parâmetro "tradicional" (IN parameter), pode ter parâmetro de saída (OUT parameter);

******************** SINTAXE BÁSICA TRIGGER ******************** 
Legenda: [] - opcional
DELIMITER //								-- alterando o delimitador padrão de ";" para "//"
CREATE PROCEDURE 							-- comando para criar 
[IF NOT EXISTS|IF EXISTS] nome_procedure	-- nome 
BEGIN										-- início 
	[DECLARE TIPO_VARIÁVEL nome_variável;]	-- OPCIONAL - declaração de variáveis	
	--COMANDOS (AÇÃO)						
END;										-- fim 
//											-- fim da definição 
DELIMITER ;									-- alterando (retornando) o delimitador de "//" para ";"

*/



-- >>>>>>>>>>>>>>>>>>>>>Crie uma procedure que faça a inserção de uma venda. 
-- Caso o cliente não esteja ativo, gerar erro;
DELIMITER //
CREATE PROCEDURE insercao_venda (id_cliente INT)
BEGIN
    DECLARE ativo CHAR; 
    SELECT cliente.ativo INTO ativo FROM cliente WHERE cliente.id = id_cliente;
    IF ativo = 'N' THEN
    BEGIN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'CLIENTE INATIVO';
    END;
    END IF;
    INSERT INTO venda (cliente_id) VALUES (id_cliente);
END;
//
DELIMITER ;


SELECT * FROM venda; -- verificando se há venda...
CALL insercao_venda(1); -- executando procedure

SELECT * FROM venda; -- verificando se deu certo

CALL insercao_venda(4); -- deverá gerar erro


-- >>>>>>>>>>>>>>>>>>>>Crie uma procedure que faça a inserção da venda de um produto e atualize o estoque; 
DELIMITER //
CREATE PROCEDURE insercao_item_venda(id_produto INT, id_venda INT, quantidade INT, preco_unidade DECIMAL(8,2))
BEGIN
    INSERT INTO item_venda (produto_id,venda_id,quantidade,preco_unidade) VALUES 
    (id_produto, id_venda, quantidade, preco_unidade);
    UPDATE produto SET estoque = (estoque - quantidade) WHERE produto.id = id_produto;
END;
//
DELIMITER ;


SELECT produto.nome, produto.estoque FROM produto WHERE produto.id = 1; -- verificado o estoque do produto 1

SET @preco_coca = (SELECT preco_venda FROM produto WHERE id = 1); -- pegando o preço unidade do produto 1

CALL insercao_item_venda(1,1,2,@preco_coca); -- executando a procedure

SELECT produto.nome, produto.estoque FROM produto WHERE produto.id = 1; -- verificado se deu certo!



/*


Link script: https://raw.githubusercontent.com/heliokamakawa/curso_bd/master/00-estudo%20de%20caso%20%20loja%20-script.sql

Exemplos:
01 - Crie uma procedure que faça a inserção de uma venda. Caso o cliente não esteja ativo, gerar erro;
02 - Crie uma procedure que faça a inserção da venda de um produto e atualize o estoque; 

01- Escreva quarto procedures de sintaxe - não precisa ter funcionalidade, basta não dar erro de sintaxe. Use variável global para testar.
- Faça uma declarando variáveis e com select into; 
- Faça a segunda com uma estrutura de decisão; 
- Faça a terceira que gere erro, impedindo a ação;
- Faça a quarta com if e else. 
02 - Escreva uma procedure que registre a baixa de um produto e já atualize devidamente o estoque do produto. Antes das ações, verifique se o produto é ativo.
03 - Escreva uma procedure que altere o preço de um produto vendido (venda já realizada - necessário verificar a existência da venda). Não permita altearções abusivas - preço de venda abaixo do preço de custo. É possível implementar esta funcionalidade sem a procedure? Se sim, indique como, bem como as vantagens e desvantagens.
04 - Escreva uma procedure que registre vendas de produtos e já defina o total da venda. É possível implementar a mesma funcionalidade por meio da trigger? Qual seria a diferença?
05- Para o controle de salário de funcionários de uma empresa e os respectivos adiantamentos (vales):
 - quais tabelas são necessárias?
06- De acordo com o seu projeto de banco de dados, pense em pelo menos 3 procedures úteis. Discuta com os seus colegas em relação a relevância e implemente-as.
07- Explique as diferenças entre trigger, função e procedure. Indique as vantagens e desvantagens em utilizar a procedure.
*/
