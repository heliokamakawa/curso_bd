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
03 - Escreva uma procedure que altere o preço de um produto vendido (venda já realizada - necessário verificar a existência da venda). Não permita altearções abusivas - preço de venda abaixo do preço de custo. 
04 - Escreva uma procedure que registre vendas de produtos e já defina o total da venda;
05- Para o controle de salário de funcionários de uma empresa e os respectivos adiantamentos (vales):
 - quais tabelas são necessárias?
06- De acordo com o seu projeto de banco de dados, pense em pelo menos 3 procedures úteis. Discuta com os seus colegas em relação a relevância e implemente-as.
*/
