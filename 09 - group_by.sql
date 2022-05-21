  
DROP DATABASE IF EXISTS banco; 
CREATE DATABASE banco;
USE banco;

CREATE TABLE ESTADO (
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,SIGLA CHAR(2) NOT NULL 
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
,CONSTRAINT ESTADO_PK PRIMARY KEY (ID)
,CONSTRAINT ESTADO_NOME_U UNIQUE(NOME) 
,CONSTRAINT ESTADO_SIGLA_U UNIQUE(SIGLA)
,CONSTRAINT ESTADO_STAUTS_AI CHECK (STATUS IN('A','I'))
);

CREATE TABLE CIDADE(
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,ESTADO_ID INT NOT NULL 
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,CONSTRAINT CIDADE_PK PRIMARY KEY (ID) 
,CONSTRAINT CIDADE_EST_FK FOREIGN KEY (ESTADO_ID) REFERENCES ESTADO (ID)
,CONSTRAINT CIDADE_STATUS_AI CHECK (STATUS IN ('A','I'))
,CONSTRAINT CIDADE_UNIQUE UNIQUE(NOME,ESTADO_ID)
);

CREATE TABLE FORNECEDOR (
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,APELIDO VARCHAR(100) 
,CPF_CNPJ VARCHAR(18) NOT NULL 
,ENDERECO VARCHAR(100) NOT NULL 
,ENDERECO_NUMERO VARCHAR(20) NOT NULL 
,ENDERECO_COMPLEMENTO VARCHAR(100)  
,ENDERECO_BAIRRO VARCHAR(100) NOT NULL 
,CEP VARCHAR(10) NOT NULL 
,FONE VARCHAR(15) 
,FONE_D VARCHAR(15)
,CONTATO VARCHAR(100)
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,DATA_NASCIMENTO DATE 
,EMAIL VARCHAR(100) 
,CIDADE_ID INT NOT NULL 
,CONSTRAINT FORNECEDOR_PK PRIMARY KEY (ID)
,CONSTRAINT FORNECEDOR_CID_FK FOREIGN KEY (CIDADE_ID) REFERENCES CIDADE (ID)
,CONSTRAINT FORNECEDOR_CPFCNPJ_U UNIQUE (CPF_CNPJ)
,CONSTRAINT FORNECEDOR_STATUS CHECK(STATUS IN('A','I'))
);

CREATE TABLE CLIENTE (
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,APELIDO VARCHAR(100) 
,CPF_CNPJ VARCHAR(18) NOT NULL 
,ENDERECO VARCHAR(100) NOT NULL 
,ENDERECO_NUMERO VARCHAR(20) NOT NULL 
,ENDERECO_COMPLEMENTO VARCHAR(100)  
,ENDERECO_BAIRRO VARCHAR(100) NOT NULL 
,CEP VARCHAR(10) NOT NULL 
,FONE VARCHAR(15) 
,FONE_D VARCHAR(15)
,CONTATO VARCHAR(100)
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,DATA_NASCIMENTO DATE 
,EMAIL VARCHAR(100) 
,CIDADE_ID INT NOT NULL 
,CONSTRAINT CLIENTE_PK PRIMARY KEY (ID)
,CONSTRAINT CLIENTE_CID_FK FOREIGN KEY (CIDADE_ID) REFERENCES CIDADE (ID)
,CONSTRAINT CLIENTE_CPFCNPJ_U UNIQUE (CPF_CNPJ)
,OCUPACAO VARCHAR(100)
,CONSTRAINT CLIENTE_STATUS CHECK(STATUS IN('A','I'))
);

CREATE TABLE FUNCIONARIO (
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,APELIDO VARCHAR(100) 
,CPF CHAR(14) NOT NULL 
,ENDERECO VARCHAR(100) NOT NULL 
,ENDERECO_NUMERO VARCHAR(20) NOT NULL 
,ENDERECO_COMPLEMENTO VARCHAR(100)  
,ENDERECO_BAIRRO VARCHAR(100) NOT NULL 
,CEP VARCHAR(10) NOT NULL 
,FONE VARCHAR(15) 
,FONE_D VARCHAR(15)
,CONTATO VARCHAR(100)
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,DATA_NASCIMENTO DATE 
,EMAIL VARCHAR(100) 
,CIDADE_ID INT NOT NULL 
,CONSTRAINT FUNCIONARIO_PK PRIMARY KEY (ID)
,CONSTRAINT FUNCIONARIO_CID_FK FOREIGN KEY (CIDADE_ID) REFERENCES CIDADE (ID)
,CONSTRAINT FUNCIONARIO_CPF CHECK (LENGTH(CPF) = 14)
,CONSTRAINT FUNCIONARIO_CPF_U UNIQUE (CPF)
,CONSTRAINT FUNCIONARIO_STATUS CHECK(STATUS IN('A','I'))
);

CREATE TABLE CATEGORIA (
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,DESCRICAO VARCHAR(2000) 
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,CONSTRAINT CATEGORIA_ID PRIMARY KEY (ID) 
,CONSTRAINT CATEGORIA_STATUS_AI CHECK(STATUS IN('A','I'))
);

CREATE TABLE TIPO (
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,DESCRICAO VARCHAR(2000) NOT NULL 
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,CONSTRAINT TIPO_ID PRIMARY KEY (ID) 
,CONSTRAINT TIPO_STATUS_AI CHECK(STATUS IN('A','I'))
);

CREATE TABLE LINHA (
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,DESCRICAO VARCHAR(2000) 
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,CONSTRAINT LINHA_ID PRIMARY KEY (ID) 
,CONSTRAINT LINHA_STATUS_AI CHECK(STATUS IN('A','I'))
);

CREATE TABLE MARCA(
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,DESCRICAO VARCHAR(100)
,STATUS CHAR DEFAULT 'A' NOT NULL
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
,CONSTRAINT MAR_PK PRIMARY KEY (ID)
,CONSTRAINT MAR_STATUS CHECK(STATUS IN('A','I'))
);

CREATE TABLE UMEDIDA(
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,SIGLA VARCHAR(10) NOT NULL UNIQUE
,STATUS CHAR DEFAULT 'A' NOT NULL
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
,CONSTRAINT UMEDIDA_PK PRIMARY KEY (ID)
,CONSTRAINT UMEDIDA_STATUS CHECK(STATUS IN('A','I')) 
);

CREATE TABLE PRODUTO( 
ID INT NOT NULL auto_increment
,NOME VARCHAR(100) NOT NULL 
,DESCRICAO VARCHAR(2000) 
,CONTEUDO DECIMAL(15,2)
,UNIDADE INT
,PRECO_CUSTO DECIMAL(12,2) NOT NULL 
,PRECO_VENDA DECIMAL(12,2) NOT NULL 
,STATUS CHAR DEFAULT 'A' NOT NULL
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,ESTOQUE INT DEFAULT 0 NOT NULL 
,CONTROLA_LOTE CHAR NOT NULL
,UMEDIDA_ID INT NOT NULL
,MARCA_ID INT NOT NULL
,CONSTRAINT PRODUTO_ID PRIMARY KEY (ID)
,CONSTRAINT PROD_FK_UMEDIDA FOREIGN KEY (UMEDIDA_ID) REFERENCES UMEDIDA (ID)
,CONSTRAINT PROD_FK_MARCA FOREIGN KEY (MARCA_ID) REFERENCES MARCA (ID)
,CONSTRAINT PRODUTO_STATUS_AI CHECK(STATUS IN('A','I'))
,CONSTRAINT PRODUTO_CONTLOT CHECK(CONTROLA_LOTE IN('S','N'))
);

CREATE TABLE LOTE(
ID INT NOT NULL auto_increment
,ESTOQUE INT
,DATA_VENCIMENTO DATETIME NOT NULL 
,PRODUTO_ID INT NOT NULL
,CONSTRAINT LOTE_PK PRIMARY KEY (ID) 
,CONSTRAINT LOTE_PROD_FK FOREIGN KEY (PRODUTO_ID) REFERENCES PRODUTO (ID)
,CONSTRAINT LOTE_UNICO UNIQUE(PRODUTO_ID,DATA_VENCIMENTO)
);

CREATE TABLE PRODUTO_CATEGORIA (
PRODUTO_ID INT NOT NULL
,CATEGORIA_ID INT NOT NULL 
,CONSTRAINT PRODCAT_PK PRIMARY KEY (PRODUTO_ID,CATEGORIA_ID) 
,CONSTRAINT PRODCAT_PRODUTO_FK FOREIGN KEY(PRODUTO_ID) REFERENCES PRODUTO (ID)
,CONSTRAINT PRODCAT_CATEGORIA_FK FOREIGN KEY (CATEGORIA_ID) REFERENCES CATEGORIA (ID)
);

CREATE TABLE LINHA_CATEGORIA(
LINHA_ID INT NOT NULL
,CATEGORIA_ID INT NOT NULL
,CONSTRAINT LINCAT_PK PRIMARY KEY (LINHA_ID, CATEGORIA_ID)
,CONSTRAINT LINCAT_FK_LINHA FOREIGN KEY (LINHA_ID) REFERENCES LINHA (ID)
,CONSTRAINT LINCAT_FK_CATEGORIA FOREIGN KEY (CATEGORIA_ID) REFERENCES CATEGORIA (ID)
);

CREATE TABLE PRODUTO_TIPO (
PRODUTO_ID INT NOT NULL
,TIPO_ID INT NOT NULL 
,CONSTRAINT PRODTIP_PK PRIMARY KEY (PRODUTO_ID,TIPO_ID) 
,CONSTRAINT PRODTIP_PRODUTO_FK FOREIGN KEY(PRODUTO_ID) REFERENCES PRODUTO (ID)
,CONSTRAINT PRODTIP_TIPO_FK FOREIGN KEY (TIPO_ID) REFERENCES TIPO (ID)
);

CREATE TABLE BAIXA_PRODUTO (
ID INT NOT NULL auto_increment
,DESCRICAO VARCHAR(100) NOT NULL 
,QUANTIDADE INT NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,FUNCIONARIO_ID INT NOT NULL 
,PRODUTO_ID INT NOT NULL 
,DATA_VENCIMENTO DATETIME NOT NULL
,CONSTRAINT BAIXAPROD_ID PRIMARY KEY (ID) 
,CONSTRAINT BAIXAPROD_FUN_FK FOREIGN KEY (FUNCIONARIO_ID) REFERENCES FUNCIONARIO (ID)
,CONSTRAINT BAIXAPROD_PROD_FK FOREIGN KEY (PRODUTO_ID) REFERENCES PRODUTO (ID)
);

CREATE TABLE  FPAGAMENTO (
ID INT NOT NULL auto_increment
,DESCRICAO VARCHAR(100) NOT NULL 
,QTDE_PARCELAS INT NOT NULL 
,ENTRADA CHAR NOT NULL 
,STATUS CHAR DEFAULT 'A' NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,CONSTRAINT FPAGAMENTO_PK PRIMARY KEY (ID)
,CONSTRAINT FPAGAMENTO_STATUS CHECK(STATUS IN('A','I'))
);

CREATE TABLE VENDA (
ID INT NOT NULL auto_increment
,TIPO CHAR(2) NOT NULL
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,CLIENTE_ID INT NOT NULL 
,FUNCIONARIO_ID INT NOT NULL 
,FPAGAMENTO_ID INT NOT NULL 
,TOTAL DECIMAL(12,2) 
,CONSTRAINT VENDA_PK PRIMARY KEY (ID) 
,CONSTRAINT VENDA_CLIENTE_FK FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTE (ID)
,CONSTRAINT VENDA_FUNCIONARIO_FK FOREIGN KEY (FUNCIONARIO_ID) REFERENCES FUNCIONARIO (ID)
,CONSTRAINT VENDA_TIPO CHECK(TIPO IN('PA','PF','VA','VF'))
);

CREATE TABLE IVENDA (
VENDA_ID INT NOT NULL 
,PRODUTO_ID INT NOT NULL 
,QUANTIDADE INT NOT NULL 
,PRECO_UNIDADE DECIMAL(12,2) NOT NULL 
,DESCONTO DECIMAL(12,2) 
,CONSTRAINT IVENDA_PK PRIMARY KEY (VENDA_ID,PRODUTO_ID)
,CONSTRAINT IVENDA_PROD_FK FOREIGN KEY (PRODUTO_ID) REFERENCES PRODUTO (ID)
,CONSTRAINT IVENDA_VEN_FK FOREIGN KEY (VENDA_ID) REFERENCES VENDA (ID)
);

CREATE TABLE COMPRA (
ID INT NOT NULL auto_increment
,TIPO CHAR(2) NOT NULL 
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,FORNECEDOR_ID INT NOT NULL 
,FUNCIONARIO_ID INT NOT NULL 
,FPAGAMENTO_ID INT NOT NULL 
,DESCONTO DECIMAL(12,2)  
,ACRESCIMO DECIMAL(12,2)  
,TOTAL DECIMAL(12,2) 
,CONSTRAINT COMPRA_PK PRIMARY KEY (ID) 
,CONSTRAINT COMPRA_FORNECEDOR_FK FOREIGN KEY (FORNECEDOR_ID) REFERENCES FORNECEDOR (ID)
,CONSTRAINT COMPRA_FUNCIONARIO_FK FOREIGN KEY  (FUNCIONARIO_ID) REFERENCES FUNCIONARIO (ID)
,CONSTRAINT COMPRA_TIPO CHECK(TIPO IN('PA','PF','CA','CF'))
);

CREATE TABLE ICOMPRA (
COMPRA_ID INT NOT NULL 
,PRODUTO_ID INT NOT NULL 
,QUANTIDADE INT NOT NULL 
,DESCONTO DECIMAL(12,2) 
,CONSTRAINT ICOMPRA_PK PRIMARY KEY (COMPRA_ID,PRODUTO_ID)
,CONSTRAINT ICOMPRA_PROD_FK FOREIGN KEY (PRODUTO_ID) REFERENCES PRODUTO (ID)
,CONSTRAINT ICOMPRA_COM_FK FOREIGN KEY (COMPRA_ID) REFERENCES COMPRA (ID)
);

CREATE TABLE CRECEBER (
ID INT NOT NULL auto_increment
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,VENDA_ID INT 
,FPAGAMENTO_ID INT NOT NULL 
,QTDE_PARC_PENDENTE INT
,CONSTRAINT CRECEBER_PK PRIMARY KEY (ID) 
,CONSTRAINT CREC_VEN_FK FOREIGN KEY (VENDA_ID) REFERENCES VENDA (ID)
,CONSTRAINT CREC_FPAG_FK FOREIGN KEY (FPAGAMENTO_ID) REFERENCES FPAGAMENTO (ID)
);

CREATE TABLE PARCELA_RECEBER(
ID INT NOT NULL auto_increment
,VALOR DECIMAL(12,2) NOT NULL 
,QUITADO DECIMAL(12,2) DEFAULT 0
,JUROS DECIMAL(12,2) DEFAULT 0
,DESCONTO DECIMAL(12,2) DEFAULT 0
,VENCIMENTO DATETIME
,CRECEBER_ID INT NOT NULL
,CONSTRAINT PARCELA_RECEBER_PK PRIMARY KEY (ID)
,CONSTRAINT PARREC_CREC_FK FOREIGN KEY (CRECEBER_ID) REFERENCES CRECEBER (ID)
);

CREATE TABLE RECEBIMENTO (
ID INT NOT NULL auto_increment
,DESCRICAO VARCHAR(200)
,VALOR DECIMAL(12,2)  
,DATA_RECEBIMENTO DATETIME DEFAULT CURRENT_TIMESTAMP
,PARCELA_RECEBER_ID INT 
,CONSTRAINT RECEBIMENTO_PK PRIMARY KEY (ID) 
,CONSTRAINT REC_PARREC_FK FOREIGN KEY (PARCELA_RECEBER_ID) REFERENCES PARCELA_RECEBER (ID)
);

CREATE TABLE CPAGAR (
ID INT NOT NULL auto_increment
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL 
,COMPRA_ID INT 
,FPAGAMENTO_ID INT NOT NULL 
,QTDE_PARC_PENDENTE INT
,CONSTRAINT CPAGAR_PK PRIMARY KEY (ID) 
,CONSTRAINT CPAG_COM_FK FOREIGN KEY (COMPRA_ID) REFERENCES COMPRA (ID)
,CONSTRAINT CPAG_FPAG_FK FOREIGN KEY (FPAGAMENTO_ID) REFERENCES FPAGAMENTO (ID)
);

CREATE TABLE PARCELA_PAGAR(
ID INT NOT NULL auto_increment
,VALOR DECIMAL(12,2) NOT NULL 
,QUITADO DECIMAL(12,2) DEFAULT 0
,JUROS DECIMAL(12,2) DEFAULT 0
,DESCONTO DECIMAL(12,2) DEFAULT 0
,VENCIMENTO DATETIME
,CPAGAR_ID INT 
,CONSTRAINT PARCELA_PAGAR_PK PRIMARY KEY (ID)
,CONSTRAINT PARPAGAR_CPAG_FK FOREIGN KEY (CPAGAR_ID) REFERENCES CPAGAR (ID)
);

CREATE TABLE PAGAMENTO (
ID INT NOT NULL auto_increment
,DESCRICAO VARCHAR(200)
,VALOR DECIMAL(12,2)  
,DATA_PAGAMENTO DATETIME DEFAULT CURRENT_TIMESTAMP
,PARCELA_PAGAR_ID INT 
,FORNECEDOR_ID INT  
,CONSTRAINT PAGAMENTO_PK PRIMARY KEY (ID) 
,CONSTRAINT PAG_PARPAG_FK FOREIGN KEY (PARCELA_PAGAR_ID) REFERENCES PARCELA_PAGAR (ID)
,CONSTRAINT PAG_FORN_FK FOREIGN KEY (FORNECEDOR_ID) REFERENCES FORNECEDOR (ID)
);

CREATE TABLE CAIXA (
ID INT NOT NULL auto_increment
,DATA_CADASTRO DATETIME DEFAULT CURRENT_TIMESTAMP 
,SALDO INT 
,STATUS CHAR NOT NULL 
,CONSTRAINT CAIXA_PK PRIMARY KEY (ID) 
,CONSTRAINT CAIXA_STATUS CHECK(STATUS IN('A','F'))
);

CREATE TABLE ICAIXA(
ID INT NOT NULL auto_increment
,DESCRICAO VARCHAR(100)
,NATUREZA CHAR NOT NULL 
,VALOR INT NOT NULL 
,HORA TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
,CAIXA_ID INT NOT NULL 
,RECEBIMENTO_ID INT 
,PAGAMENTO_ID INT 
,CONSTRAINT ICAIXA_PK PRIMARY KEY (ID) 
,CONSTRAINT ICX_CX_FK FOREIGN KEY (CAIXA_ID) REFERENCES CAIXA (ID)
,CONSTRAINT ICX_REC_FK FOREIGN KEY (RECEBIMENTO_ID) REFERENCES RECEBIMENTO (ID)
,CONSTRAINT ICX_PAG_FK FOREIGN KEY (PAGAMENTO_ID) REFERENCES PAGAMENTO (ID)
,CONSTRAINT ICX_NATUREZA CHECK (NATUREZA IN ('C','D'))
);


-- insert 

INSERT INTO estado (nome,sigla) VALUES ('ACRE','AC'); 
INSERT INTO estado (nome,sigla) VALUES ('ALAGOAS','AL'); 
INSERT INTO estado (nome,sigla) VALUES ('AMAPÁ','AP');
INSERT INTO estado (nome,sigla) VALUES ('AMAZONAS','AM');
INSERT INTO estado (nome,sigla) VALUES ('BAHIA','BA');
INSERT INTO estado (nome,sigla) VALUES ('CEARÁ','CE');
INSERT INTO estado (nome,sigla) VALUES ('DISTRITO FEDERAL','DF');
INSERT INTO estado (nome,sigla) VALUES ('ESPÍRITO SANTO','ES');
INSERT INTO estado (nome,sigla) VALUES ('GOIÁS','GO'); 
INSERT INTO estado (nome,sigla) VALUES ('MARANHÃO','MA');
INSERT INTO estado (nome,sigla) VALUES ('MATO GROSSO','MT'); 
INSERT INTO estado (nome,sigla) VALUES ('MATO GROSSO DO SUL','MS'); 
INSERT INTO estado (nome,sigla) VALUES ('MINAS GERAIS','MG'); 
INSERT INTO estado (nome,sigla) VALUES ('PARÁ','PA'); 
INSERT INTO estado (nome,sigla) VALUES ('PARAÍBA','PB');
INSERT INTO estado (nome,sigla) VALUES ('PARANÁ','PR'); 
INSERT INTO estado (nome,sigla) VALUES ('PERNAMBUCO','PE'); 
INSERT INTO estado (nome,sigla) VALUES ('PIAUÍ','PI'); 
INSERT INTO estado (nome,sigla) VALUES ('RORAIMA','RR'); 
INSERT INTO estado (nome,sigla) VALUES ('RONDÔNIA','RO'); 
INSERT INTO estado (nome,sigla) VALUES ('RIO DE JANEIRO','RJ'); 
INSERT INTO estado (nome,sigla) VALUES ('RIO GRANDE DO NORTE','RN'); 
INSERT INTO estado (nome,sigla) VALUES ('RIO GRANDE DO SUL','RS'); 
INSERT INTO estado (nome,sigla) VALUES ('SANTA CATARINA','SC'); 
INSERT INTO estado (nome,sigla) VALUES ('SÃO PAULO','SP'); 
INSERT INTO estado (nome,sigla) VALUES ('SERGIPE','SE'); 
INSERT INTO estado (nome,sigla) VALUES ('TOCANTINS','TO');


INSERT INTO cidade (nome,estado_id) VALUES ('PARANAVAÍ',(SELECT id FROM estado WHERE nome = 'PARANÁ'));
INSERT INTO cidade (nome,estado_id) VALUES ('BLUMENAU',(SELECT id FROM estado WHERE nome = 'SANTA CATARINA'));
INSERT INTO cidade (nome,estado_id) VALUES ('MARINGÁ',(SELECT id FROM estado WHERE nome = 'PARANÁ'));
INSERT INTO cidade (nome,estado_id) VALUES ('SOCORRO',(SELECT id FROM estado WHERE nome = 'SÃO PAULO'));
INSERT INTO cidade (nome,estado_id) VALUES ('CURITIBA',(SELECT id FROM estado WHERE nome = 'PARANÁ'));
INSERT INTO cidade (nome,estado_id) VALUES ('FLORIANÓPOLIS',(SELECT id FROM estado WHERE nome = 'SANTA CATARINA'));
INSERT INTO cidade (nome,estado_id) VALUES ('VERA CRUZ',(SELECT id FROM estado WHERE nome = 'RIO GRANDE DO SUL'));
INSERT INTO cidade (nome,estado_id) VALUES ('ITAJAÍ',(SELECT id FROM estado WHERE nome = 'SANTA CATARINA'));
INSERT INTO cidade (nome,estado_id) VALUES ('SÃO PAULO',(SELECT id FROM estado WHERE nome = 'SÃO PAULO'));
INSERT INTO cidade (nome,estado_id) VALUES ('VERA CRUZ',(SELECT id FROM estado WHERE nome = 'SÃO PAULO'));
INSERT INTO cidade (nome,estado_id) VALUES ('CUIABÁ',(SELECT id FROM estado WHERE nome = 'MATO GROSSO'));
INSERT INTO cidade (nome,estado_id) VALUES ('CAMPINAS',(SELECT id FROM estado WHERE nome = 'SÃO PAULO'));
INSERT INTO cidade (nome,estado_id) VALUES ('SÃO JOSÉ DOS CAMPOS',(SELECT id FROM estado WHERE nome = 'SÃO PAULO'));
INSERT INTO cidade (nome,estado_id) VALUES ('JUNDIAÍ',(SELECT id FROM estado WHERE nome = 'SÃO PAULO'));
INSERT INTO cidade (nome,estado_id) VALUES ('SOROCABA',(SELECT id FROM estado WHERE nome = 'SÃO PAULO'));

INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Davi Rodrigues'	,'151.338.392-27'	,'Rua Vereador Duque Estrada '	,1564	,'Alvorada'	,'24240-211'	,'(21) 4421-7219'	,'Leonardo'	,'A'	,'1959-5-2'	,'DaviSantosRodrigues@superrito.com'	,1);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Júlia Alves'	,'515.364.390-53'	,'Rua Raimunda Nobre Pontes '	,37	,'Monte Rei'	,'69044-300'	,'(92) 7092-7747'	,'Samuel'	,'A'	,'1994-2-15'	,'JuliaGomesAlves@rhyta.com'	,2);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('André Cunha'	,'120.240.316-68'	,'Praça Caciporé '	,1223	,'Vila Esperança'	,'03617-160'	,'(11) 2318-8092'	,'Vitor'	,'A'	,'1952-4-9'	,'AndreRochaCunha@gustr.com'	,2);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Maria Martins'	,'585.601.519-31'	,'Rua Eneida de Morais '	,1550	,'Jardim Atami'	,'68628-588'	,'(91) 7273-8366'	,'Alex'	,'A'	,'1985-8-10'	,'MariaAraujoMartins@fleckens.hu'	,1);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Luis Pereira'	,'890.762.982-03'	,'Av. Paraná '	,1672	,'Laranjeiras'	,'13503-510'	,'(19) 5052-2660'	,'Thiago'	,'A'	,'1966-9-22'	,'LuisFernandesPereira@superrito.com'	,1);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Luís Almeida'	,'738.533.650-78'	,'Rua Morretes '	,1167	,'Liberdade'	,'44036-080'	,'(75) 7453-5733'	,'Kauã'	,'A'	,'1974-2-15'	,'LuisRochaAlmeida@jourrapide.com'	,5);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Julieta Pinto'	,'969.843.151-90'	,'Rua José Gomes Hespanha '	,1787	,'Tarumã'	,'15802-295'	,'(17) 8358-9690'	,'Eduardo'	,'A'	,'1983-8-1'	,'JulietaAraujoPinto@dayrep.com'	,7);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Victor Oliveira'	,'300.744.467-54'	,'Rua Icarai '	,1792	,'Parque Avenida'	,'26387-020'	,'(21) 8232-6163'	,'Rafaela'	,'A'	,'1967-10-4'	,'VictorCostaOliveira@cuvox.de'	,8);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Danilo Silva'	,'667.406.258-83'	,'Rua Monsenhor Soares '	,1581	,'Jardim Industrial'	,'18200-009'	,'(15) 7103-9941'	,'Emilly'	,'A'	,'1959-1-22'	,'DaniloDiasSilva@superrito.com'	,11);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Letícia Pinto'	,'382.647.349-36'	,'Rua Jacob Sens '	,1839	,'São Domingos'	,'88113-285'	,'(48) 4999-3657'	,'Murilo'	,'A'	,'1973-8-9'	,'LeticiaPereiraPinto@superrito.com'	,11);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Diego Fernandes'	,'533.660.064-47'	,'Av. Paraná '	,663	,'Jardim América'	,'72215-219'	,'(61) 3284-4137'	,'Martim'	,'I'	,'1972-5-23'	,'DiegoCardosoFernandes@dayrep.com'	,11);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Fábio Lima'	,'325.206.896-68'	,'Rua Ibertioga '	,364	,'Indaiá'	,'31130-790'	,'(31) 7111-6617'	,'Paulo'	,'A'	,'1973-3-22'	,'FabioSousaLima@rhyta.com'	,11);
INSERT INTO fornecedor (nome, cpf_cnpj, endereco, endereco_numero, endereco_bairro, CEP, fone, contato, status, data_nascimento, email, cidade_id) VALUES ('Carlos Araujo'	,'408.142.811-50'	,'Praça Brandura '	,1850	,'Ouro Cola'	,'03650-050'	,'(11) 9037-5504'	,'Eduardo'	,'A'	,'1957-7-22'	,'CarlosCarvalhoAraujo@rhyta.com'	,11);

INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Davi Rodrigues'	,'151.338.392-27'	,'Rua Vereador Duque Estrada '	,1564	,'Alvorada'	,'24240-211'	,'(21) 4421-7219'	,'A'	,'1959-5-2'	,'DaviSantosRodrigues@superrito.com'	,2	);
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Júlia Alves'	,'515.364.390-53'	,'Rua Raimunda Nobre Pontes '	,37	,'Monte Rei'	,'69044-300'	,'(92) 7092-7747'	,'A'	,'1994-2-15'	,'JuliaGomesAlves@rhyta.com'	,11);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('André Cunha'	,'120.240.316-68'	,'Praça Caciporé '	,1223	,'Vila Esperança'	,'03617-160'	,'(11) 2318-8092'	,'A'	,'1952-4-9'	,'AndreRochaCunha@gustr.com'	,8);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Larissa Azevedo'	,'696.166.620-58'	,'Rua Carlos Ribeiro '	,597	,'São Clemente'	,'28013-023'	,'(22) 2202-8112'	,'A'	,'1980-5-5'	,'LarissaRodriguesAzevedo@teleworm.us'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Gabrielle Azevedo'	,'766.688.211-46'	,'Rua Capitão Luiz Dorneles '	,1907	,'Jardim América'	,'51290-240'	,'(81) 7295-5332'	,'A'	,'1975-6-20'	,'GabrielleSilvaAzevedo@dayrep.com'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Antônio Gomes'	,'551.067.304-49'	,'Rua Dez '	,1971	,'Jardim Atami'	,'92030-410'	,'(51) 3058-2450'	,'I'	,'1976-8-20'	,'AntonioAlmeidaGomes@armyspy.com'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Ryan Gomes'	,'159.148.559-26'	,'Rua Osmar Miranda '	,899	,'São Clemente'	,'13171-823'	,'(19) 7014-3132'	,'A'	,'1975-7-17'	,'RyanAlvesGomes@einrot.com'	,6);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Clara Azevedo'	,'831.225.623-75'	,'Rua Domingos dos Santos '	,561	,'Itaipu'	,'21550-580'	,'(21) 7756-6724'	,'A'	,'1953-11-22'	,'ClaraMartinsAzevedo@gustr.com'	,5);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Diego Rodrigues'	,'824.450.808-60'	,'Rua Ministro Oliveira Salazar '	,289	,'Aclimação'	,'13308-252'	,'(11) 4369-5235'	,'I'	,'1961-11-19'	,'DiegoPintoRodrigues@rhyta.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Mariana Alves'	,'470.755.667-17'	,'Condomínio Sobradinho Novo Etapa II '	,1659	,'Santa Felicidade'	,'73070-051'	,'(61) 8426-8863'	,'A'	,'1953-7-15'	,'MarianaCastroAlves@superrito.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Ágatha Ferreira'	,'556.688.641-89'	,'Praça Elba '	,257	,'Ouro Cola'	,'31620-160'	,'(31) 9977-3012'	,'A'	,'1967-11-23'	,'AgathaCunhaFerreira@cuvox.de'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Luís Castro'	,'749.134.060-19'	,'Rua Investigador Apolônio Crispim '	,1443	,'Parque Bandeirantes'	,'58079-103'	,'(83) 2270-2251'	,'A'	,'1954-9-26'	,'LuisMartinsCastro@dayrep.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Danilo Oliveira'	,'138.536.850-05'	,'Rua Doutor Amadeu Sacchi '	,1596	,'Oásis'	,'13214-280'	,'(11) 8304-5082'	,'A'	,'1975-12-9'	,'DaniloCorreiaOliveira@rhyta.com'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Brenda Rodrigues'	,'437.536.752-02'	,'Rua Timor '	,1426	,'Zona 03 - Vila Operária'	,'27281-270'	,'(24) 9254-4136'	,'A'	,'1970-12-2'	,'BrendaAlmeidaRodrigues@jourrapide.com'	,8);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Lara Barbosa'	,'411.750.728-18'	,'Rua Fotometria '	,1733	,'Miosótis'	,'53411-240'	,'(81) 4355-6634'	,'A'	,'1972-10-18'	,'LaraLimaBarbosa@rhyta.com'	,9);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Aline Goncalves'	,'294.569.932-05'	,'Avenida Futura Perimetral Expressa '	,930	,'São Domingos'	,'13203-540'	,'(11) 2763-5805'	,'A'	,'1992-3-14'	,'AlineMartinsGoncalves@teleworm.us'	,9);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vinícius Rocha'	,'469.371.385-63'	,'Rua Laranjeiras '	,799	,'Recanto dos Magnatas'	,'33902-090'	,'(31) 9518-6614'	,'A'	,'1953-11-13'	,'ViniciusAraujoRocha@cuvox.de'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('João Castro'	,'778.557.993-89'	,'Rua das Macaúbas '	,1777	,'Zona 07'	,'38703-698'	,'(34) 8934-7609'	,'A'	,'1978-2-12'	,'JoaoRodriguesCastro@teleworm.us'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Otávio Correia'	,'226.872.688-60'	,'Praça Francisco Urbano '	,834	,'Alamar'	,'08740-020'	,'(11) 4090-6365'	,'A'	,'1965-7-12'	,'OtavioCardosoCorreia@fleckens.hu'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Felipe Dias'	,'901.054.699-39'	,'Rua Afonso Ribeiro '	,440	,'Grevíleas'	,'26030-770'	,'(21) 3385-6149'	,'I'	,'1965-8-1'	,'FelipeAzevedoDias@armyspy.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Igor Cavalcanti'	,'480.630.415-85'	,'Rua Macieira '	,709	,'Laranjeiras'	,'52291-022'	,'(81) 6501-8279'	,'A'	,'1966-5-1'	,'IgorRochaCavalcanti@jourrapide.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Paulo Castro'	,'982.524.371-68'	,'Rua Padre Petrus Joannes Dingenouts '	,1739	,'Vila Bosque'	,'13087-781'	,'(19) 4896-4911'	,'A'	,'1969-3-22'	,'PauloCunhaCastro@armyspy.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Melissa Oliveira'	,'668.128.328-47'	,'Rua Quinze '	,1964	,'Cidade Alta'	,'78913-355'	,'(69) 6462-5997'	,'I'	,'1993-6-6'	,'MelissaCardosoOliveira@teleworm.us'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Felipe Fernandes'	,'945.041.085-26'	,'Travessa Três de Janeiro '	,1851	,'Parque do Horto'	,'65060-740'	,'(98) 6817-9872'	,'A'	,'1971-12-11'	,'FelipeCardosoFernandes@fleckens.hu'	,5);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Julian Alves'	,'323.005.175-07'	,'Rua Lenita Monteiro Cruz '	,1677	,'Olímpico'	,'29057-100'	,'(27) 8461-9997'	,'A'	,'1974-8-12'	,'JulianMeloAlves@teleworm.us'	,8);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Marcos Goncalves'	,'863.127.041-57'	,'Rua Ministro Oliveira Salazar '	,1711	,'Moradias Atenas'	,'61905-470'	,'(85) 7275-6794'	,'A'	,'1985-11-13'	,'MarcosCarvalhoGoncalves@fleckens.hu'	,9);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Davi Goncalves'	,'735.476.047-10'	,'Rua Particular '	,762	,'Zona 06'	,'12941-202'	,'(11) 5531-8593'	,'A'	,'1965-4-27'	,'DaviRodriguesGoncalves@dayrep.com'	,10);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Diego Azevedo'	,'422.647.581-04'	,'Avenida Visconde de Caravelas '	,714	,'Olímpico'	,'12228-050'	,'(12) 8603-4994'	,'A'	,'1989-1-25'	,'DiegoMeloAzevedo@superrito.com'	,10);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Sarah Gomes'	,'687.812.716-54'	,'Rua Lauro Teixeira Osório '	,1568	,'Liberdade'	,'86810-030'	,'(43) 2655-5387'	,'A'	,'1993-1-3'	,'SarahCavalcantiGomes@einrot.com'	,11);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Otávio Rocha'	,'374.442.183-07'	,'Rua Giorgio Morandi '	,1262	,'Portal das Torres'	,'05891-260'	,'(11) 7320-4328'	,'A'	,'1964-3-25'	,'OtavioCardosoRocha@superrito.com'	,11);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vitór Barros'	,'691.157.117-06'	,'Rua Contenda '	,1891	,'Alvorada'	,'81910-100'	,'(41) 4110-6077'	,'A'	,'1997-4-1'	,'VitorCastroBarros@superrito.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vitor Costa'	,'440.767.697-32'	,'Alameda Cezane '	,1715	,'Oásis'	,'74575-080'	,'(62) 9399-5808'	,'A'	,'1999-6-17'	,'VitorFernandesCosta@jourrapide.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Thiago Goncalves'	,'755.645.830-00'	,'Rua Gabriel Elias '	,1294	,'Santa Felicidade'	,'74595-288'	,'(62) 9884-7340'	,'A'	,'1981-12-10'	,'ThiagoLimaGoncalves@superrito.com'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Leonor Cunha'	,'712.441.938-79'	,'Rua Dona Achilina Fachini '	,385	,'Guaporé'	,'13607-010'	,'(19) 8294-6939'	,'I'	,'1988-3-13'	,'LeonorRochaCunha@rhyta.com'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Júlio Alves'	,'863.479.805-41'	,'Rua José Custódio de Oliveira '	,1540	,'São Clemente'	,'36204-174'	,'(32) 2957-3664'	,'A'	,'1988-7-25'	,'JulioSantosAlves@rhyta.com'	,5);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Camila Ferreira'	,'102.957.867-28'	,'Rua José Pinto Lima '	,1501	,'Tuiuti'	,'02839-170'	,'(11) 3618-8078'	,'A'	,'1957-12-8'	,'CamilaSantosFerreira@gustr.com'	,6);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Sarah Rocha'	,'912.415.575-60'	,'Rua Emílio Ghiberti '	,144	,'Olímpico'	,'04165-120'	,'(11) 5153-8132'	,'I'	,'1974-6-24'	,'SarahPintoRocha@rhyta.com'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Clara Ribeiro'	,'662.270.446-52'	,'Rua Maceio '	,491	,'Recanto dos Magnatas'	,'72660-375'	,'(61) 7829-9971'	,'A'	,'1967-5-8'	,'ClaraCardosoRibeiro@armyspy.com'	,8);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Arthur Azevedo'	,'240.837.682-31'	,'Rua Araçá '	,1574	,'Alvorada'	,'94040-370'	,'(51) 6118-9175'	,'A'	,'1960-5-22'	,'ArthurBarbosaAzevedo@einrot.com'	,9);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Isabella Barbosa'	,'126.382.016-69'	,'Rua Bahia '	,290	,'Tuiuti'	,'77403-220'	,'(63) 6080-2559'	,'A'	,'1998-10-23'	,'IsabellaAraujoBarbosa@teleworm.us'	,10);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Lucas Ribeiro'	,'162.073.899-64'	,'Travessa Oropo '	,1578	,'Tarumã'	,'08737-180'	,'(11) 3777-9274'	,'A'	,'1996-6-17'	,'LucasCavalcantiRibeiro@jourrapide.com'	,11);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Igor Dias'	,'211.496.719-04'	,'Rua Urbano de Moura '	,1767	,'Iguaçu'	,'72851-020'	,'(61) 3036-7329'	,'A'	,'1959-8-5'	,'IgorCastroDias@teleworm.us'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Larissa Silva'	,'525.159.958-70'	,'Beco da Lagoa '	,1395	,'Parque do Horto'	,'25560-700'	,'(21) 7266-7264'	,'A'	,'1993-7-27'	,'LarissaBarbosaSilva@fleckens.hu'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Camila Ferreira'	,'555.938.793-20'	,'Travessa Esmeralda '	,804	,'Aclimação'	,'21721-550'	,'(21) 2155-8401'	,'A'	,'1951-2-4'	,'CamilaPintoFerreira@armyspy.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Luís Pinto'	,'205.417.847-06'	,'Rua Eduardo de Oliveira '	,60	,'Hortênsia'	,'09608-010'	,'(11) 3642-2696'	,'A'	,'1966-4-15'	,'LuisCorreiaPinto@superrito.com'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Evelyn Cavalcanti'	,'267.910.352-18'	,'Rua Dois A '	,772	,'Cidade Nova'	,'04966-155'	,'(11) 8475-5136'	,'A'	,'1966-5-18'	,'EvelynFerreiraCavalcanti@dayrep.com'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vitória Souza'	,'939.668.239-00'	,'Rua Nuno Campos '	,151	,'Zona 01 - Centro'	,'17514-850'	,'(14) 5963-2819'	,'A'	,'1958-4-25'	,'VitoriaCunhaSouza@superrito.com'	,5);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Kai Carvalho'	,'614.086.709-68'	,'Rua dos Sabiás '	,727	,'Zona 08 - Bairro Aeroporto'	,'59625-370'	,'(84) 5416-4509'	,'I'	,'1979-10-24'	,'KaiCunhaCarvalho@jourrapide.com'	,6);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Giovanna Fernandes'	,'643.297.656-16'	,'Passagem Europa '	,1016	,'Ney Braga'	,'66645-135'	,'(91) 4878-5945'	,'A'	,'1987-7-10'	,'GiovannaMeloFernandes@teleworm.us'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('José Barbosa'	,'222.226.904-04'	,'Praça João Machado Barcelos '	,660	,'Hortênsia'	,'26545-173'	,'(21) 5817-3637'	,'A'	,'1964-5-27'	,'JoseCorreiaBarbosa@dayrep.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Julieta Azevedo'	,'967.927.388-16'	,'Rua Antílope '	,1990	,'Indaiá'	,'79040-230'	,'(67) 6877-5803'	,'I'	,'1982-9-12'	,'JulietaLimaAzevedo@dayrep.com'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Leila Barbosa'	,'706.987.732-33'	,'Rua Bahia '	,1878	,'Cidade Monções'	,'72755-001'	,'(61) 9140-7787'	,'A'	,'1962-2-1'	,'LeilaRochaBarbosa@einrot.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Luis Almeida'	,'429.540.639-20'	,'Rua da Revlução dos Malês '	,255	,'Hortênsia'	,'40327-395'	,'(71) 6757-5758'	,'A'	,'1955-7-3'	,'LuisFerreiraAlmeida@einrot.com'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vinicius Barros'	,'191.039.044-58'	,'Rua Maestro Vicente d''Alo '	,1476	,'Miosótis'	,'81480-255'	,'(41) 3607-3218'	,'A'	,'1986-9-26'	,'ViniciusOliveiraBarros@rhyta.com'	,5);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vitória Correia'	,'398.802.249-73'	,'Rua Particular '	,1385	,'Ouro Cola'	,'05176-010'	,'(11) 7775-3804'	,'A'	,'1972-6-14'	,'VitoriaCarvalhoCorreia@cuvox.de'	,6);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Julian Martins'	,'989.179.749-02'	,'Rua N '	,451	,'Moradias Atenas'	,'11724-210'	,'(13) 8581-6341'	,'A'	,'1962-4-23'	,'JulianPintoMartins@dayrep.com'	,6);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Luiz Rodrigues'	,'889.161.812-83'	,'Rua da Praia de Francelos '	,1089	,'Andrade'	,'02976-150'	,'(11) 2205-3861'	,'A'	,'1998-9-5'	,'LuizOliveiraRodrigues@gustr.com'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Rafaela Cardoso'	,'411.829.854-67'	,'Avenida Prefeito Paulo Novaes '	,510	,'Pinheiros'	,'18705-000'	,'(14) 5940-6782'	,'A'	,'1952-2-23'	,'RafaelaSantosCardoso@cuvox.de'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Júlio Souza'	,'246.387.612-32'	,'Rua Quarenta e Três '	,1217	,'Zona 04'	,'13061-338'	,'(19) 3979-3639'	,'A'	,'1965-7-17'	,'JulioCardosoSouza@fleckens.hu'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Fernanda Oliveira'	,'732.272.966-83'	,'Travessa Dois Irmãos '	,26	,'Colina Verde'	,'55026-511'	,'(81) 4498-8494'	,'A'	,'1955-6-8'	,'FernandaBarrosOliveira@jourrapide.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Luiz Barbosa'	,'695.503.995-40'	,'Rua André Ritucci '	,440	,'Cidade Monções'	,'09770-240'	,'(11) 2567-9097'	,'A'	,'1997-5-2'	,'LuizCostaBarbosa@rhyta.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Julian Rocha'	,'837.730.864-90'	,'Rua Oliveira '	,863	,'Zona 03 - Vila Operária'	,'20725-040'	,'(21) 6944-3410'	,'I'	,'1950-5-24'	,'JulianGoncalvesRocha@fleckens.hu'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Marisa Souza'	,'357.512.891-02'	,'Rua Lauro Monteiro '	,1546	,'Paris'	,'53090-660'	,'(81) 8911-8863'	,'A'	,'1997-2-15'	,'MarisaGomesSouza@cuvox.de'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Nicole Cardoso'	,'824.883.031-43'	,'Rua Pedro Artigiani '	,746	,'Zona 02'	,'13976-124'	,'(19) 8635-2255'	,'A'	,'1976-4-20'	,'NicoleMartinsCardoso@einrot.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Júlia Cardoso'	,'743.103.775-99'	,'Rua Bahia '	,1249	,'São Domingos'	,'77023-488'	,'(63) 6717-8943'	,'I'	,'1962-4-8'	,'JuliaLimaCardoso@gustr.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Matilde Cunha'	,'563.060.003-64'	,'Rua Bahia '	,808	,'Ney Braga'	,'71510-225'	,'(61) 8753-8364'	,'A'	,'1994-1-3'	,'MatildeCardosoCunha@gustr.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Paulo Alves'	,'107.185.253-10'	,'Rua Dimas da Silva Rocha '	,1468	,'Três Lagoas'	,'08717-610'	,'(11) 5618-8574'	,'A'	,'1979-2-17'	,'PauloFernandesAlves@einrot.com'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Larissa Correia'	,'128.528.945-56'	,'Rua Beatriz Siqueira '	,1288	,'Cidade Nova'	,'60455-200'	,'(85) 6371-6864'	,'A'	,'1966-9-19'	,'LarissaCunhaCorreia@armyspy.com'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Samuel Oliveira'	,'315.708.739-84'	,'Rua Maracaju '	,1729	,'São Clemente'	,'59124-470'	,'(84) 2040-6147'	,'A'	,'1998-11-21'	,'SamuelFerreiraOliveira@teleworm.us'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Kai Martins'	,'852.089.961-70'	,'Rua Ricardo Apra '	,1122	,'Jardim América'	,'18086-380'	,'(15) 8106-4564'	,'A'	,'1996-2-18'	,'KaiAlvesMartins@superrito.com'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vitór Almeida'	,'620.336.406-12'	,'Rua Penha '	,1776	,'Liberdade'	,'09846-270'	,'(11) 3404-4250'	,'A'	,'1983-5-26'	,'VitorSouzaAlmeida@teleworm.us'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Matheus Araujo'	,'325.887.131-06'	,'Rua Antônio Raposo Tavares '	,1332	,'Borba Gato'	,'13230-360'	,'(11) 4481-6706'	,'A'	,'1979-2-24'	,'MatheusCavalcantiAraujo@cuvox.de'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Aline Silva'	,'997.453.070-92'	,'Rua Doutor Alceu da Silva Oliveira '	,1880	,'Vila Bosque'	,'83701-820'	,'(41) 5489-3779'	,'A'	,'1963-2-20'	,'AlineRodriguesSilva@armyspy.com'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Eduardo Pereira'	,'471.561.698-07'	,'Travessa Abul '	,160	,'Ouro Cola'	,'02210-190'	,'(11) 6900-5387'	,'A'	,'1964-9-17'	,'EduardoSousaPereira@gustr.com'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Enzo Costa'	,'868.478.976-86'	,'Rua Toffoli Culau '	,429	,'Parque Industrial'	,'97090-670'	,'(55) 2492-7754'	,'A'	,'1954-11-3'	,'EnzoAlvesCosta@fleckens.hu'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Giovanna Castro'	,'228.493.618-01'	,'Rua Projetada São Francisco '	,63	,'Ouro Cola'	,'56906-480'	,'(87) 8292-9859'	,'I'	,'1999-10-21'	,'GiovannaGomesCastro@dayrep.com'	,4);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Isabella Ribeiro'	,'332.127.597-04'	,'Rua Tomé Mendes '	,29	,'Três Lagoas'	,'99010-360'	,'(54) 7929-9462'	,'A'	,'1978-12-19'	,'IsabellaGoncalvesRibeiro@fleckens.hu'	,6);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vitór Costa'	,'602.955.508-13'	,'Rua Luanda '	,360	,'Jardim Atami'	,'06716-659'	,'(11) 8908-8273'	,'A'	,'1951-2-9'	,'VitorCunhaCosta@gustr.com'	,6);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Marcos Goncalves'	,'329.438.749-06'	,'Rua General Hipólito '	,1280	,'Cidade Alta'	,'97510-230'	,'(55) 5901-6469'	,'I'	,'1986-3-4'	,'MarcosCavalcantiGoncalves@fleckens.hu'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Arthur Rodrigues'	,'898.249.818-45'	,'Rua José da Silva Vizela '	,790	,'Colina Verde'	,'28051-330'	,'(22) 3224-6712'	,'A'	,'1959-7-4'	,'ArthurSilvaRodrigues@dayrep.com'	,7);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Otávio Martins'	,'860.598.434-17'	,'Rua Felipe Camarão '	,1986	,'Indaiá'	,'86026-650'	,'(43) 5690-2002'	,'A'	,'1978-3-19'	,'OtavioDiasMartins@jourrapide.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Carla Alves'	,'335.895.861-25'	,'Rua Tipe '	,1722	,'Rebouças'	,'29112-065'	,'(27) 6344-8514'	,'A'	,'1980-1-7'	,'CarlaPereiraAlves@fleckens.hu'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Tomás Oliveira'	,'205.397.108-81'	,'Rua Engenheiro César '	,993	,'Três Lagoas'	,'02018-070'	,'(11) 2181-8709'	,'A'	,'1961-7-8'	,'TomasBarrosOliveira@teleworm.us'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Letícia Cunha'	,'682.770.023-27'	,'Av. Maringá '	,1603	,'Rebouças'	,'71571-408'	,'(61) 9340-4232'	,'A'	,'1981-8-12'	,'LeticiaRodriguesCunha@jourrapide.com'	,1);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Pedro Silva'	,'152.886.689-49'	,'Rua Fernão Albernaz '	,1031	,'Recanto dos Magnatas'	,'03532-000'	,'(11) 6370-9333'	,'A'	,'1979-3-18'	,'PedroFernandesSilva@jourrapide.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Guilherme Ferreira'	,'962.680.044-50'	,'Rua Cosmópolis '	,1335	,'Indaiá'	,'13177-281'	,'(19) 9480-7209'	,'A'	,'1998-5-22'	,'GuilhermeGomesFerreira@dayrep.com'	,2);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Rodrigo Azevedo'	,'816.268.466-26'	,'Rua São Cristóvão '	,422	,'Novo Horizonte'	,'07223-100'	,'(11) 2803-7183'	,'A'	,'1979-10-25'	,'RodrigoCavalcantiAzevedo@teleworm.us'	,3);	
INSERT INTO funcionario (nome	,cpf	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,status	,data_nascimento	,email	,cidade_id) VALUES ('Vitór Dias'	,'114.357.630-68'	,'Avenida Lúcio Meira '	,449	,'Santa Felicidade'	,'25953-003'	,'(21) 6469-4585'	,'A'	,'1970-11-13'	,'VitorSousaDias@einrot.com'	,3);


INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Murilo Castro'	,'272.550.997-18'	,'Rua Elson Nunes de Souza '	,1921	,'Parque Avenida'	,'30840-530'	,'(31) 7285-9550'	,'Breno'	,'A'	,'1979-5-23'	,'MuriloBarbosaCastro@armyspy.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bianca Fernandes'	,'388.876.106-90'	,'Rua Pierre Marques Barbosa '	,84	,'Três Lagoas'	,'57045-835'	,'(82) 4211-6283'	,'Ágatha'	,'I'	,'1968-9-11'	,'BiancaBarbosaFernandes@fleckens.hu'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabrielle Oliveira'	,'241.358.623-73'	,'Rua Vinte '	,41	,'Parque Avenida'	,'12721-310'	,'(12) 6039-9684'	,'Estevan'	,'A'	,'1980-5-14'	,'GabrielleCorreiaOliveira@rhyta.com'	,'Professor'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luiz Santos'	,'407.612.199-60'	,'Rua Bonfinópolis de Minas '	,1956	,'Zona 06'	,'04939-230'	,'(11) 5471-8449'	,'Tiago'	,'A'	,'1962-3-16'	,'LuizPereiraSantos@armyspy.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bianca Rodrigues'	,'909.638.158-06'	,'Trecho Anel Rodoviário '	,883	,'Vila Bosque'	,'79037-000'	,'(67) 4367-2974'	,'Rodrigo'	,'A'	,'1966-8-22'	,'BiancaRochaRodrigues@jourrapide.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Martim Silva'	,'578.884.539-45'	,'Rua João Alberto Carvalho '	,274	,'Paris'	,'21520-420'	,'(21) 2110-8463'	,'Paulo'	,'A'	,'2000-6-20'	,'MartimSantosSilva@dayrep.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Tomás Rodrigues'	,'779.986.153-38'	,'Praça Landulfo Mendes de Souza '	,1404	,'Zona 09'	,'86060-185'	,'(43) 3104-8925'	,'Paulo'	,'A'	,'1959-11-14'	,'TomasCunhaRodrigues@fleckens.hu'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julieta Pereira'	,'615.538.036-80'	,'Rua Dois '	,851	,'Zona 04'	,'67105-002'	,'(91) 7332-2034'	,'Julian'	,'A'	,'1972-10-16'	,'JulietaSousaPereira@einrot.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julian Correia'	,'849.946.806-39'	,'Rua Vista Central do Abrigo '	,113	,'Campos Elíseos'	,'54260-590'	,'(81) 5833-8145'	,'Beatriz'	,'A'	,'1969-3-9'	,'JulianCarvalhoCorreia@dayrep.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Enzo Barros'	,'456.045.970-31'	,'Rua Colibrí '	,772	,'Guaporé'	,'11676-160'	,'(12) 4789-8466'	,'Martim'	,'A'	,'1983-6-24'	,'EnzoPereiraBarros@cuvox.de'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vinícius Costa'	,'345.241.417-58'	,'Rua Elessário João Pedro Nolasco '	,1131	,'Hortênsia'	,'89051-350'	,'(47) 7865-8983'	,'Anna'	,'A'	,'1961-3-7'	,'ViniciusPereiraCosta@dayrep.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Guilherme Santos'	,'649.067.317-75'	,'Rua Chopin '	,239	,'Itália'	,'09960-620'	,'(11) 7059-7270'	,'Vitór'	,'A'	,'1991-9-17'	,'GuilhermeSilvaSantos@dayrep.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luiz Azevedo'	,'224.951.165-90'	,'Rua Marechal Castelo Branco '	,1210	,'Jardim Oriental'	,'65047-740'	,'(98) 3617-4758'	,'Amanda'	,'I'	,'1998-2-26'	,'LuizCavalcantiAzevedo@einrot.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vinicius Castro'	,'110.654.173-14'	,'Rua Catita '	,1045	,'Tarumã'	,'02280-230'	,'(11) 9684-2605'	,'Raissa'	,'A'	,'1999-11-17'	,'ViniciusAzevedoCastro@cuvox.de'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marcos Almeida'	,'105.145.636-30'	,'Rua Jaguari '	,288	,'Paris'	,'96820-300'	,'(51) 3729-5307'	,'Kai'	,'A'	,'1986-1-8'	,'MarcosGoncalvesAlmeida@rhyta.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leonor Correia'	,'419.845.486-89'	,'Rua Guarepe '	,1249	,'São Domingos'	,'08451-130'	,'(11) 9331-7267'	,'Maria'	,'I'	,'1970-3-17'	,'LeonorLimaCorreia@dayrep.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Júlio Santos'	,'341.207.310-57'	,'Rua Vera Cruz '	,890	,'Grevíleas'	,'59129-300'	,'(84) 2259-8349'	,'Aline'	,'A'	,'1978-5-24'	,'JulioFernandesSantos@cuvox.de'	,'Professor'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lavinia Correia'	,'835.945.918-59'	,'Avenida Alex Abrahão '	,638	,'Grevíleas'	,'38412-622'	,'(34) 8319-9649'	,'Clara'	,'A'	,'1985-9-13'	,'LaviniaAraujoCorreia@teleworm.us'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lara Fernandes'	,'679.699.392-60'	,'Rua Bulgária '	,751	,'Itaipu'	,'13905-112'	,'(19) 5585-4140'	,'Samuel'	,'A'	,'1968-12-3'	,'LaraRodriguesFernandes@fleckens.hu'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kai Barros'	,'478.671.434-83'	,'Rua Presidente Washington Luiz '	,1151	,'Jardim Atami'	,'33035-310'	,'(31) 4632-9510'	,'Bruna'	,'A'	,'1985-5-6'	,'KaiLimaBarros@fleckens.hu'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabrielle Azevedo'	,'625.290.622-00'	,'Av. Paraná '	,568	,'Tuiuti'	,'74440-570'	,'(62) 5058-9486'	,'Estevan'	,'A'	,'1976-12-24'	,'GabrielleRodriguesAzevedo@armyspy.com'	,'Professor'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lavinia Melo'	,'607.781.657-44'	,'Rua Perminio Schimidt '	,1888	,'Universo'	,'25635-370'	,'(24) 2543-3559'	,'Marcos'	,'A'	,'1969-8-20'	,'LaviniaSantosMelo@jourrapide.com'	,'Professor'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Anna Sousa'	,'874.670.682-80'	,'Praça das Mansões '	,249	,'Zona 07'	,'74455-350'	,'(62) 4783-6485'	,'Gabriela'	,'A'	,'1967-11-14'	,'AnnaAzevedoSousa@teleworm.us'	,'Professor'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kai Silva'	,'537.149.135-05'	,'Travessa Bernardo Lorenziti '	,118	,'Indaiá'	,'04918-000'	,'(11) 9521-2850'	,'Antônio'	,'A'	,'1958-5-17'	,'KaiCorreiaSilva@jourrapide.com'	,'Professor'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bianca Santos'	,'519.522.657-11'	,'Rua Júlio Borges '	,1901	,'Imperial'	,'21050-500'	,'(21) 9926-7009'	,'João'	,'A'	,'1962-7-12'	,'BiancaAzevedoSantos@teleworm.us'	,'Professor'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Danilo Oliveira'	,'487.348.629-78'	,'Rua Mirangaba '	,432	,'Borba Gato'	,'06853-350'	,'(11) 6610-9450'	,'Gabrielly'	,'A'	,'1966-12-20'	,'DaniloDiasOliveira@armyspy.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitoria Barros'	,'196.599.794-52'	,'Rua João Camilo de Camargo '	,778	,'Liberdade'	,'13184-290'	,'(19) 3463-5059'	,'Diogo'	,'I'	,'1951-5-6'	,'VitoriaBarbosaBarros@dayrep.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Diogo Ribeiro'	,'593.099.581-89'	,'Rua Desembargador Eduardo de Oliveira Cruz '	,1356	,'Sumaré'	,'06702-160'	,'(11) 5126-9732'	,'Júlio'	,'A'	,'1961-2-8'	,'DiogoAlmeidaRibeiro@fleckens.hu'	,'Professor'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leila Castro'	,'532.548.847-36'	,'Viela Sete '	,453	,'Zona 08 - Bairro Aeroporto'	,'07804-050'	,'(11) 5406-8432'	,'Amanda'	,'A'	,'1967-6-9'	,'LeilaCunhaCastro@rhyta.com'	,'Professor'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gustavo Souza'	,'864.983.461-24'	,'Rua Afonso Cucolo '	,140	,'Zona 06'	,'16401-383'	,'(19) 4150-9289'	,'Maria'	,'I'	,'1972-6-1'	,'GustavoGoncalvesSouza@rhyta.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Otávio Souza'	,'896.448.767-25'	,'Travessa Carvalho Leomil '	,765	,'Oásis'	,'24120-400'	,'(21) 6501-8619'	,'Raissa'	,'A'	,'1987-1-6'	,'OtavioDiasSouza@armyspy.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Samuel Ribeiro'	,'201.181.518-51'	,'Rua Ângelo Herculano Teixeira da Silva '	,797	,'Duzentão'	,'05852-420'	,'(11) 3473-5822'	,'Eduardo'	,'A'	,'1995-12-24'	,'SamuelAzevedoRibeiro@dayrep.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bruna Azevedo'	,'903.089.822-40'	,'Praça Doutor José Inácio da Silva '	,1688	,'Vila Bosque'	,'48903-430'	,'(74) 9992-4531'	,'Manuela'	,'A'	,'1988-9-9'	,'BrunaBarrosAzevedo@cuvox.de'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Evelyn Pinto'	,'873.560.335-69'	,'Av. Paraná '	,199	,'Requião'	,'74810-260'	,'(62) 9965-4424'	,'Otávio'	,'A'	,'1969-11-21'	,'EvelynCavalcantiPinto@teleworm.us'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Fábio Fernandes'	,'567.085.154-40'	,'Rua Jovita Ana de Jesus '	,816	,'Itália'	,'07154-100'	,'(11) 4445-6177'	,'Luis'	,'A'	,'1987-9-23'	,'FabioLimaFernandes@fleckens.hu'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Diogo Alves'	,'533.785.039-39'	,'Rua São Salvador '	,282	,'Parque do Horto'	,'87701-260'	,'(44) 5378-8672'	,'Isabela'	,'A'	,'1972-8-11'	,'DiogoAzevedoAlves@jourrapide.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leonardo Santos'	,'100.933.582-02'	,'Rua João Branco '	,1441	,'Jardim Industrial'	,'60415-020'	,'(85) 8050-2209'	,'Gustavo'	,'A'	,'1987-2-18'	,'LeonardoSouzaSantos@fleckens.hu'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Samuel Martins'	,'173.189.093-12'	,'Estrada da Lagoa '	,182	,'Iguaçu'	,'06673-700'	,'(11) 5158-7952'	,'Vitoria'	,'A'	,'1954-7-23'	,'SamuelCorreiaMartins@einrot.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Ferreira'	,'966.758.436-48'	,'Rua Duque de Caxias '	,1582	,'Vila Esperança'	,'74685-710'	,'(62) 6568-8467'	,'Gabriel'	,'A'	,'1989-12-8'	,'LucasFernandesFerreira@fleckens.hu'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Melo'	,'334.263.339-53'	,'Rua Doze '	,1382	,'São Clemente'	,'65061-620'	,'(98) 7555-9714'	,'Luana'	,'A'	,'1985-10-20'	,'LucasLimaMelo@jourrapide.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Enzo Araujo'	,'668.550.038-77'	,'Rua João Camilo de Oliveira Torres '	,1511	,'Alamar'	,'35900-271'	,'(31) 5968-4211'	,'Evelyn'	,'I'	,'1967-2-1'	,'EnzoOliveiraAraujo@teleworm.us'	,'Professor'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Clara Alves'	,'614.950.069-13'	,'Praça Vinte e Dois de Novembro '	,658	,'Tarumã'	,'09310-100'	,'(11) 4067-8283'	,'Marcos'	,'A'	,'1973-4-7'	,'ClaraRibeiroAlves@einrot.com'	,'Professor'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Nicolash Santos'	,'231.259.705-55'	,'Av. Paraná '	,1806	,'Ipanema'	,'74921-340'	,'(62) 7674-8345'	,'Júlio'	,'A'	,'1997-1-21'	,'NicolashMartinsSantos@einrot.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauê Carvalho'	,'475.681.900-13'	,'Beco Quatro '	,681	,'Rebouças'	,'90830-750'	,'(51) 6318-8116'	,'João'	,'I'	,'1977-1-25'	,'KaueAlmeidaCarvalho@cuvox.de'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Fábio Gomes'	,'604.351.647-08'	,'Vila Santa Terezinha '	,1907	,'Jardim Oriental'	,'60340-100'	,'(85) 5036-6915'	,'Kauã'	,'A'	,'1993-12-13'	,'FabioRodriguesGomes@jourrapide.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Arthur Santos'	,'896.240.465-65'	,'Rua Georgia '	,1851	,'Iguaçu'	,'13455-538'	,'(19) 5799-9264'	,'Kauê'	,'A'	,'1997-7-10'	,'ArthurAraujoSantos@gustr.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Paulo Ribeiro'	,'804.936.443-77'	,'Rua Carapajo '	,1173	,'Novo Horizonte'	,'23068-090'	,'(21) 3495-6857'	,'Luis'	,'A'	,'1996-6-4'	,'PauloBarrosRibeiro@cuvox.de'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alice Cavalcanti'	,'911.337.545-89'	,'Rua Esmeralda '	,547	,'Zona 02'	,'29706-402'	,'(27) 6965-6270'	,'Joao'	,'A'	,'1996-10-8'	,'AliceMeloCavalcanti@einrot.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ágatha Azevedo'	,'506.800.178-36'	,'Rua Sebastião Annunciatto '	,611	,'Zona 05'	,'05527-040'	,'(11) 7908-2168'	,'Gustavo'	,'A'	,'1956-5-4'	,'AgathaFerreiraAzevedo@cuvox.de'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luiza Costa'	,'228.507.086-15'	,'Rua Newton de Castro '	,944	,'Itaipu'	,'13872-026'	,'(19) 3168-6339'	,'Gabrielle'	,'A'	,'1953-10-22'	,'LuizaAzevedoCosta@rhyta.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Clara Melo'	,'240.672.450-68'	,'Rua Trinta e Seis '	,1591	,'Guaporé'	,'78149-096'	,'(65) 2077-8067'	,'João'	,'A'	,'1995-4-18'	,'ClaraAlmeidaMelo@dayrep.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Melissa Melo'	,'665.925.473-08'	,'Rua Eduardo Tuldra '	,1870	,'Duzentão'	,'05143-220'	,'(11) 9158-8177'	,'Marisa'	,'A'	,'1988-8-7'	,'MelissaBarbosaMelo@jourrapide.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabrielle Cavalcanti'	,'611.425.083-40'	,'Vila Base '	,1262	,'Novo Horizonte'	,'66060-360'	,'(91) 9642-5076'	,'Leila'	,'A'	,'1953-4-1'	,'GabrielleCorreiaCavalcanti@jourrapide.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Thaís Barbosa'	,'511.230.044-20'	,'Rua Doutor Souza Silveira '	,1398	,'Zona 01 - Centro'	,'21511-120'	,'(21) 3905-9975'	,'Antônio'	,'A'	,'1995-6-13'	,'ThaisDiasBarbosa@jourrapide.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Carlos Dias'	,'361.579.180-04'	,'Rua Presidente Vargas '	,447	,'Universo'	,'13847-004'	,'(16) 8141-4918'	,'Marcos'	,'I'	,'1964-12-26'	,'CarlosFerreiraDias@rhyta.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Felipe Santos'	,'748.005.723-71'	,'Rua José Bertolli '	,377	,'Monte Rei'	,'18072-320'	,'(15) 4212-3051'	,'Alex'	,'A'	,'1992-3-6'	,'FelipeFerreiraSantos@gustr.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Antônio Carvalho'	,'458.307.562-69'	,'Rua João Francisco da Silva '	,1749	,'Portal das Torres'	,'38703-606'	,'(34) 7146-6726'	,'Enzo'	,'A'	,'1965-3-5'	,'AntonioCavalcantiCarvalho@fleckens.hu'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Isabelle Cardoso'	,'914.602.385-24'	,'Rua Expedicionário Silvestre Skodowski '	,810	,'Zona 01 - Centro'	,'83085-360'	,'(41) 4826-9685'	,'Enzo'	,'I'	,'1989-8-1'	,'IsabelleMeloCardoso@gustr.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Murilo Pereira'	,'605.817.349-39'	,'Rua Antônio Soares de Oliveira '	,11	,'São Silvestre'	,'24734-220'	,'(21) 6736-3244'	,'Danilo'	,'A'	,'1979-3-25'	,'MuriloBarbosaPereira@superrito.com'	,'Professor'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Antônio Ribeiro'	,'277.545.422-42'	,'Rua Marechal Hermes da Fonseca '	,700	,'São Clemente'	,'12285-040'	,'(12) 9783-4479'	,'Ryan'	,'A'	,'1995-10-23'	,'AntonioMartinsRibeiro@teleworm.us'	,'Professor'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luan Barbosa'	,'999.774.274-53'	,'Rua Juscelino Kubitschek '	,941	,'Zona 04'	,'47802-170'	,'(77) 5182-9911'	,'Diogo'	,'A'	,'1970-3-26'	,'LuanSousaBarbosa@fleckens.hu'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Cauã Cardoso'	,'197.607.205-07'	,'Rua Agenor Martins de Carvalho '	,1601	,'Imperial'	,'78909-300'	,'(69) 5092-9842'	,'Vitor'	,'A'	,'1988-1-6'	,'CauaGoncalvesCardoso@rhyta.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('João Araujo'	,'419.051.303-25'	,'Av. Paraná '	,565	,'Ipanema'	,'13572-274'	,'(16) 3116-6275'	,'Nicole'	,'A'	,'1964-10-11'	,'JoaoSantosAraujo@gustr.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Thiago Silva'	,'660.216.702-21'	,'Rua Dois '	,1358	,'Vila Bosque'	,'13053-652'	,'(19) 5396-5304'	,'Fernanda'	,'A'	,'1957-11-17'	,'ThiagoMartinsSilva@cuvox.de'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitór Rodrigues'	,'115.849.645-10'	,'Rua José Simões '	,509	,'Vila Esperança'	,'22743-560'	,'(21) 4469-4290'	,'Eduardo'	,'A'	,'1975-6-8'	,'VitorCorreiaRodrigues@superrito.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vinícius Souza'	,'377.867.891-46'	,'Rua Cinco '	,1094	,'Paris'	,'96214-250'	,'(53) 2382-3770'	,'Evelyn'	,'A'	,'1995-2-9'	,'ViniciusFerreiraSouza@teleworm.us'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luiz Rocha'	,'572.858.005-03'	,'Rua Campina das Missões '	,776	,'Liberdade'	,'07232-021'	,'(11) 9118-4581'	,'Ana'	,'A'	,'1977-2-21'	,'LuizGomesRocha@gustr.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Almeida'	,'363.750.964-48'	,'Estrada Abílio Bastos '	,1741	,'Pinheiros'	,'23097-000'	,'(21) 2779-3437'	,'Danilo'	,'A'	,'1983-11-1'	,'LucasCavalcantiAlmeida@superrito.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Enzo Cavalcanti'	,'530.533.106-43'	,'Rua Nova Petrópolis '	,726	,'São Domingos'	,'54490-212'	,'(81) 9293-7168'	,'Anna'	,'I'	,'1957-12-20'	,'EnzoAraujoCavalcanti@einrot.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Diogo Ferreira'	,'940.240.183-02'	,'Rua do Açafrão '	,956	,'Cidade Nova'	,'21870-330'	,'(21) 6286-9591'	,'Gustavo'	,'A'	,'1959-12-5'	,'DiogoFernandesFerreira@teleworm.us'	,'Professor'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Samuel Carvalho'	,'100.970.825-20'	,'Rua Valdomiro dos Santos Pereira '	,665	,'Zona 08 - Bairro Aeroporto'	,'05821-160'	,'(11) 3564-7677'	,'Erick'	,'A'	,'1993-3-2'	,'SamuelGoncalvesCarvalho@dayrep.com'	,'Professor'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Thiago Azevedo'	,'179.053.402-01'	,'Av. Paraná '	,2105	,'Borba Gato'	,'70361-761'	,'(61) 9946-4450'	,'Kai'	,'I'	,'1975-6-18'	,'ThiagoRodriguesAzevedo@armyspy.com'	,'Professor'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Maria Barros'	,'698.752.176-03'	,'Rua Professor Alcoforado de Pereira '	,1629	,'Parque do Horto'	,'57081-700'	,'(82) 6568-5128'	,'Emilly'	,'A'	,'1967-7-5'	,'MariaBarbosaBarros@superrito.com'	,'Professor'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Yasmin Souza'	,'523.496.830-87'	,'Rua João Melanski Filho '	,16	,'Aclimação'	,'83085-160'	,'(41) 7010-7165'	,'Gabriel'	,'A'	,'1995-8-22'	,'YasminAzevedoSouza@gustr.com'	,'Professor'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Tânia Dias'	,'960.742.566-91'	,'Rua José Salmen '	,865	,'Jardim Oriental'	,'78705-060'	,'(66) 8271-4909'	,'Kaua'	,'A'	,'1980-5-18'	,'TaniaFernandesDias@jourrapide.com'	,'Professor'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Eduardo Costa'	,'457.118.393-30'	,'Rua Urandi Santos Figueiredo '	,420	,'Grevíleas'	,'49070-500'	,'(79) 5389-3400'	,'Gustavo'	,'A'	,'1961-10-27'	,'EduardoPereiraCosta@armyspy.com'	,'Professor'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kaua Dias'	,'485.949.338-94'	,'Av. Paraná '	,1390	,'Hortênsia'	,'31780-185'	,'(31) 8300-8199'	,'Joao'	,'A'	,'1958-2-21'	,'KauaFernandesDias@jourrapide.com'	,'Professor'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alice Silva'	,'586.144.038-79'	,'Rua Antônio Sarkis '	,1196	,'Itália'	,'05038-200'	,'(11) 5576-7774'	,'Julian'	,'A'	,'1950-11-21'	,'AliceLimaSilva@cuvox.de'	,'Cortador'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Clara Barbosa'	,'997.024.799-91'	,'Rua Roberto Moreira da Silva '	,1156	,'Tuiuti'	,'08795-040'	,'(11) 5160-2816'	,'Igor'	,'A'	,'1971-9-25'	,'ClaraAlvesBarbosa@armyspy.com'	,'Psiquiatra'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ana Azevedo'	,'727.727.164-57'	,'Avenida Alfredo Ávila '	,874	,'Guaporé'	,'02279-110'	,'(11) 5005-4138'	,'Kauê'	,'A'	,'1961-5-15'	,'AnaSilvaAzevedo@fleckens.hu'	,'Psiquiatra'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('José Souza'	,'316.746.154-34'	,'Travessa Cruz dos Milagres '	,505	,'Ipanema'	,'53010-260'	,'(81) 4307-7348'	,'Camila'	,'A'	,'1976-1-3'	,'JoseRochaSouza@gustr.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Maria Oliveira'	,'747.315.451-61'	,'Rua Salgado Filho '	,1528	,'Duzentão'	,'69314-420'	,'(95) 8881-5570'	,'Gabrielly'	,'A'	,'1968-9-27'	,'MariaRochaOliveira@cuvox.de'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Caio Barros'	,'385.844.880-06'	,'Rua Monsenhor Magaldi '	,1346	,'Recanto dos Magnatas'	,'18043-030'	,'(15) 8523-4050'	,'Gustavo'	,'I'	,'1982-10-8'	,'CaioMeloBarros@superrito.com'	,'Psiquiatra'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Mateus Cardoso'	,'237.055.797-46'	,'Rua C '	,958	,'Zona 08 - Bairro Aeroporto'	,'40731-480'	,'(71) 9981-7654'	,'Julia'	,'A'	,'1997-12-4'	,'MateusGomesCardoso@fleckens.hu'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabriel Fernandes'	,'511.421.489-63'	,'Rua Columbia '	,1180	,'Jardim Diamante'	,'09241-000'	,'(11) 2223-6462'	,'Felipe'	,'A'	,'1987-1-24'	,'GabrielCardosoFernandes@dayrep.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luis Costa'	,'681.350.488-66'	,'Rua Sessenta e Quatro '	,698	,'Indaiá'	,'18306-490'	,'(15) 8328-6368'	,'Renan'	,'I'	,'1950-4-26'	,'LuisPereiraCosta@jourrapide.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafael Oliveira'	,'769.217.970-07'	,'Rua Cardoso Palhano '	,226	,'São Domingos'	,'58103-215'	,'(83) 7330-5061'	,'Tânia'	,'A'	,'1965-8-26'	,'RafaelRibeiroOliveira@dayrep.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitor Melo'	,'649.287.073-54'	,'Rua Pedro Seita Hirata '	,1222	,'Hermann Moraes de Barros'	,'17527-576'	,'(14) 6154-3480'	,'André'	,'A'	,'1958-8-5'	,'VitorRibeiroMelo@fleckens.hu'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Letícia Lima'	,'678.994.683-70'	,'Rua Lagoa Verde '	,126	,'São Clemente'	,'86192-680'	,'(43) 2452-9851'	,'Camila'	,'A'	,'1970-3-27'	,'LeticiaSantosLima@cuvox.de'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Giovanna Cardoso'	,'346.174.624-06'	,'Vila Santo Antônio '	,938	,'Zona 01 - Centro'	,'59030-357'	,'(84) 3607-2944'	,'André'	,'A'	,'1990-5-22'	,'GiovannaSousaCardoso@teleworm.us'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafael Sousa'	,'516.871.428-58'	,'Rua Stélio Machado Loureiro '	,534	,'Itaipu'	,'14810-071'	,'(16) 5417-5698'	,'Ágatha'	,'A'	,'1995-2-7'	,'RafaelCardosoSousa@superrito.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauê Castro'	,'221.856.218-90'	,'Rua Noé Gonçalves de Souza '	,1008	,'Monte Rei'	,'15046-320'	,'(17) 7651-2547'	,'Guilherme'	,'A'	,'1970-12-25'	,'KaueAlmeidaCastro@superrito.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Emily Almeida'	,'920.415.509-45'	,'Rua da Padroeira '	,758	,'Itaipu'	,'13060-487'	,'(19) 2761-7828'	,'Ryan'	,'A'	,'1957-11-21'	,'EmilyAraujoAlmeida@fleckens.hu'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Evelyn Barros'	,'959.498.832-09'	,'Rua Valparaiso '	,430	,'Recanto dos Magnatas'	,'25976-077'	,'(21) 5454-4324'	,'Clara'	,'A'	,'1980-6-13'	,'EvelynBarbosaBarros@einrot.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leila Barros'	,'474.471.155-33'	,'Rua Calixto Mezetti '	,1305	,'Duzentão'	,'19030-310'	,'(18) 7490-4812'	,'Arthur'	,'A'	,'1953-12-19'	,'LeilaFerreiraBarros@jourrapide.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Aline Silva'	,'152.091.696-50'	,'Avenida Gradin '	,870	,'Colina Verde'	,'40375-490'	,'(71) 4623-4098'	,'Sarah'	,'A'	,'1978-1-4'	,'AlineAlmeidaSilva@rhyta.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Davi Costa'	,'605.484.303-65'	,'Rua Pedro Benitez '	,1131	,'Jardim Diamante'	,'85862-490'	,'(45) 5623-2175'	,'Júlio'	,'I'	,'1974-10-7'	,'DaviCardosoCosta@dayrep.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('João Martins'	,'857.412.818-00'	,'Av. Paraná '	,1250	,'Laranjeiras'	,'71882-058'	,'(61) 5414-9609'	,'Gustavo'	,'A'	,'1989-2-26'	,'JoaoAlvesMartins@rhyta.com'	,'Psiquiatra'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matheus Cavalcanti'	,'491.431.415-01'	,'Rua Walter Moretto '	,697	,'Indaiá'	,'18681-870'	,'(14) 9801-8829'	,'Samuel'	,'A'	,'1976-10-8'	,'MatheusSilvaCavalcanti@armyspy.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Antônio Fernandes'	,'261.092.855-60'	,'Rua Antônia Barbosa Schallmair '	,1728	,'Cidade Alta'	,'17024-844'	,'(14) 9329-4782'	,'Giovana'	,'I'	,'1952-8-10'	,'AntonioRibeiroFernandes@rhyta.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauã Silva'	,'915.759.895-90'	,'Rua Maria Todesco '	,1155	,'Laranjeiras'	,'82210-080'	,'(41) 9533-7827'	,'Kauan'	,'A'	,'1987-4-20'	,'KauaAzevedoSilva@gustr.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauê Oliveira'	,'535.604.599-90'	,'Rua Sol Nascente '	,1832	,'Zona 09'	,'79080-290'	,'(67) 4981-4519'	,'Nicolash'	,'A'	,'1985-9-3'	,'KaueMartinsOliveira@fleckens.hu'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauê Ferreira'	,'677.361.202-00'	,'Rua Estado do Piauí '	,156	,'Itália'	,'03936-040'	,'(11) 3796-2802'	,'Luiz'	,'A'	,'1984-11-1'	,'KaueSilvaFerreira@einrot.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauã Carvalho'	,'412.511.444-70'	,'Rua das Rosedas '	,1184	,'Zona 01 - Centro'	,'11712-660'	,'(13) 3950-3437'	,'Kaua'	,'A'	,'1996-3-5'	,'KauaFerreiraCarvalho@cuvox.de'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julian Oliveira'	,'111.517.069-49'	,'Rua Amália Ferreira Moura '	,1871	,'Sumaré'	,'57081-245'	,'(82) 8380-9193'	,'Isabelle'	,'A'	,'1979-5-11'	,'JulianSousaOliveira@gustr.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ágatha Cardoso'	,'160.834.423-11'	,'Rua Professor Leopoldo Amaral '	,924	,'Vila Bosque'	,'41810-415'	,'(71) 2553-3646'	,'Carlos'	,'A'	,'1968-8-26'	,'AgathaPintoCardoso@cuvox.de'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Caio Martins'	,'377.138.663-29'	,'Rua Alexandre Correia da Silva '	,1304	,'Vila Bosque'	,'04766-100'	,'(11) 9111-7971'	,'Laura'	,'A'	,'1997-10-12'	,'CaioFerreiraMartins@rhyta.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Emily Pinto'	,'918.139.325-30'	,'Campo São Cristóvão '	,1367	,'Vila Bosque'	,'20921-440'	,'(21) 4156-4318'	,'Ryan'	,'A'	,'1950-2-19'	,'EmilyRodriguesPinto@teleworm.us'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leonor Cunha'	,'647.437.651-10'	,'Travessa Bolívar Reis '	,1457	,'Ney Braga'	,'45208-160'	,'(73) 9769-2730'	,'Vinicius'	,'A'	,'1990-10-14'	,'LeonorDiasCunha@rhyta.com'	,'Psiquiatra'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matheus Cardoso'	,'949.076.452-36'	,'Rua Jorge Daniel Cordeiro '	,43	,'Campos Elíseos'	,'81810-090'	,'(41) 2576-5458'	,'Kai'	,'A'	,'1971-5-26'	,'MatheusPintoCardoso@cuvox.de'	,'Psiquiatra'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Martim Cavalcanti'	,'538.752.950-56'	,'Avenida Professor Dorival de Oliveira '	,807	,'Zona 01 - Centro'	,'14802-378'	,'(16) 2220-5016'	,'Caio'	,'I'	,'1953-8-15'	,'MartimCastroCavalcanti@dayrep.com'	,'Psiquiatra'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Felipe Oliveira'	,'730.574.999-02'	,'Travessa Fonte de Amor '	,618	,'Zona 01 - Centro'	,'04407-120'	,'(11) 4519-6260'	,'Marisa'	,'A'	,'1966-12-23'	,'FelipeBarrosOliveira@armyspy.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Breno Barbosa'	,'272.862.387-28'	,'Rua Juaie '	,395	,'São Silvestre'	,'23017-180'	,'(21) 5683-5956'	,'Davi'	,'A'	,'1993-9-27'	,'BrenoAzevedoBarbosa@superrito.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitor Pereira'	,'990.239.706-91'	,'Rua Orleans '	,667	,'Alamar'	,'26020-230'	,'(21) 5378-5203'	,'Fernanda'	,'I'	,'1954-1-5'	,'VitorSantosPereira@einrot.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Emilly Alves'	,'151.391.332-88'	,'Rua Quarenta e Três '	,1938	,'Borba Gato'	,'53520-660'	,'(81) 9644-6676'	,'Luiz'	,'A'	,'1983-7-10'	,'EmillySouzaAlves@armyspy.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Arthur Costa'	,'950.572.891-36'	,'Rua Dezessete '	,1581	,'Pinheiros'	,'54535-180'	,'(81) 3723-5372'	,'Pedro'	,'A'	,'1996-10-13'	,'ArthurSouzaCosta@fleckens.hu'	,'Psiquiatra'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alex Almeida'	,'508.558.251-97'	,'Rua Siderópolis '	,755	,'Mandacaru'	,'88505-325'	,'(49) 9143-5405'	,'Larissa'	,'A'	,'1951-7-9'	,'AlexGomesAlmeida@superrito.com'	,'Psiquiatra'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julian Castro'	,'909.467.631-19'	,'Praça Alexandre Botinelli '	,1079	,'Parque Avenida'	,'07802-210'	,'(11) 8365-4722'	,'Rodrigo'	,'A'	,'1964-9-4'	,'JulianFernandesCastro@teleworm.us'	,'Psiquiatra'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marina Costa'	,'602.895.160-99'	,'Rua Euriclides Formiga '	,1278	,'Monte Rei'	,'06714-300'	,'(11) 4778-3168'	,'Matheus'	,'A'	,'1990-3-5'	,'MarinaRibeiroCosta@jourrapide.com'	,'Psiquiatra'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Caio Martins'	,'589.298.076-66'	,'Rua Manoel Roriz '	,952	,'Zona 01 - Centro'	,'72801-710'	,'(61) 2253-5676'	,'Mateus'	,'A'	,'1982-7-23'	,'CaioSouzaMartins@cuvox.de'	,'Psiquiatra'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Emilly Souza'	,'477.131.296-69'	,'Rua Dezessete '	,1062	,'Cidade Alta'	,'13067-110'	,'(19) 5426-3418'	,'Luis'	,'A'	,'1965-1-6'	,'EmillyMartinsSouza@cuvox.de'	,'Psiquiatra'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ryan Ferreira'	,'882.639.077-05'	,'Rua Tambuatá '	,1212	,'Paris'	,'54230-160'	,'(81) 7445-2889'	,'Carla'	,'A'	,'1970-4-21'	,'RyanFernandesFerreira@jourrapide.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Camila Barros'	,'881.465.957-58'	,'Alameda Irã '	,106	,'Recanto dos Magnatas'	,'69037-082'	,'(92) 7847-7482'	,'Lucas'	,'A'	,'1992-9-20'	,'CamilaGoncalvesBarros@jourrapide.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bruna Pereira'	,'281.557.657-09'	,'Rua Tabuleiro '	,117	,'Oásis'	,'57084-540'	,'(82) 8632-6798'	,'Nicolash'	,'A'	,'1992-10-16'	,'BrunaRodriguesPereira@rhyta.com'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Anna Pinto'	,'548.839.069-30'	,'Rua Flor-de-lis '	,446	,'Aclimação'	,'86188-410'	,'(43) 8007-3811'	,'Kauã'	,'I'	,'1970-5-3'	,'AnnaSilvaPinto@teleworm.us'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marcos Martins'	,'117.949.182-30'	,'Avenida João de Castro Sussuarana '	,356	,'Tuiuti'	,'68902-270'	,'(96) 9408-7887'	,'Vitór'	,'A'	,'1991-11-14'	,'MarcosSousaMartins@cuvox.de'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julian Dias'	,'763.340.817-05'	,'Rua Lins '	,89	,'São Clemente'	,'12233-650'	,'(12) 9242-8579'	,'Nicole'	,'A'	,'1968-11-25'	,'JulianAraujoDias@teleworm.us'	,'Psiquiatra'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Murilo Gomes'	,'293.813.944-66'	,'Rua Íris Hass '	,299	,'Duzentão'	,'89020-380'	,'(47) 9124-4502'	,'Matheus'	,'I'	,'1950-12-26'	,'MuriloCorreiaGomes@gustr.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Murilo Sousa'	,'347.461.684-66'	,'Travessa Tabelião Hidelbrando Martins da Costa '	,1632	,'Indaiá'	,'35900-767'	,'(31) 8128-8215'	,'Sophia'	,'A'	,'1994-2-26'	,'MuriloRibeiroSousa@teleworm.us'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('João Sousa'	,'303.858.334-07'	,'Rua Pérola '	,797	,'Aclimação'	,'18301-238'	,'(15) 9388-7009'	,'Felipe'	,'A'	,'1967-2-19'	,'JoaoAlvesSousa@cuvox.de'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Raissa Barbosa'	,'126.748.302-47'	,'Rua Assad Abu-Jamra '	,958	,'Ney Braga'	,'86047-650'	,'(43) 4954-2635'	,'Julian'	,'A'	,'1956-7-25'	,'RaissaGomesBarbosa@gustr.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sofia Costa'	,'731.365.234-82'	,'Rua Bettino Borgo '	,755	,'Cidade Monções'	,'17020-280'	,'(14) 4997-9602'	,'Giovana'	,'A'	,'1953-12-14'	,'SofiaFernandesCosta@teleworm.us'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitória Castro'	,'430.353.293-20'	,'Rua Nogueira dos Santos '	,409	,'Dias'	,'27347-530'	,'(24) 2696-8495'	,'Erick'	,'A'	,'1956-7-9'	,'VitoriaCorreiaCastro@superrito.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('André Oliveira'	,'182.358.595-72'	,'Rua Frutuosa Silveira '	,431	,'Zona 04'	,'97573-260'	,'(55) 8017-4565'	,'Brenda'	,'A'	,'1986-7-11'	,'AndreSousaOliveira@jourrapide.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sofia Souza'	,'350.687.881-63'	,'Rua Taubaté '	,216	,'São Clemente'	,'13035-740'	,'(19) 2538-9300'	,'Evelyn'	,'A'	,'1952-7-27'	,'SofiaCorreiaSouza@armyspy.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Tiago Costa'	,'239.471.213-93'	,'Rua Barueri '	,1316	,'Borba Gato'	,'13090-500'	,'(19) 4256-4023'	,'Gabriela'	,'A'	,'1985-2-9'	,'TiagoDiasCosta@rhyta.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sophia Gomes'	,'276.998.732-11'	,'Rua Todos os Santos '	,949	,'Universo'	,'06360-130'	,'(11) 4387-5607'	,'Murilo'	,'A'	,'1958-7-6'	,'SophiaSantosGomes@jourrapide.com'	,'Psiquiatra'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Pedro Castro'	,'655.914.921-85'	,'Rua das Tilias '	,667	,'Zona 08 - Bairro Aeroporto'	,'59067-690'	,'(84) 7749-5643'	,'Isabela'	,'I'	,'1998-4-5'	,'PedroAzevedoCastro@einrot.com'	,'Psiquiatra'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alice Ribeiro'	,'713.095.803-08'	,'Avenida Jabota '	,321	,'Jardim Industrial'	,'12949-391'	,'(11) 2600-7639'	,'Arthur'	,'A'	,'1965-7-17'	,'AliceAzevedoRibeiro@gustr.com'	,'Psiquiatra'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rodrigo Melo'	,'690.055.626-41'	,'Rua Terceiro-Sargento Noraldino Rosa dos Santos '	,758	,'Grevíleas'	,'02147-020'	,'(11) 6632-2721'	,'Otávio'	,'A'	,'1973-2-12'	,'RodrigoFernandesMelo@fleckens.hu'	,'Psiquiatra'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luan Almeida'	,'117.763.472-42'	,'Rua Hibisco '	,682	,'Iguaçu'	,'03583-180'	,'(11) 8199-7525'	,'Marisa'	,'I'	,'1993-6-10'	,'LuanAzevedoAlmeida@cuvox.de'	,'Médico'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Davi Costa'	,'590.029.987-24'	,'Travessa Martins '	,1918	,'Jardim América'	,'28025-355'	,'(22) 3898-5199'	,'Estevan'	,'A'	,'1974-3-23'	,'DaviCarvalhoCosta@gustr.com'	,'Médico'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kaua Sousa'	,'903.587.576-14'	,'Rua Juscelino Kubitschek '	,1834	,'Bertioga'	,'09896-370'	,'(11) 3437-2519'	,'Luiz'	,'A'	,'1998-9-25'	,'KauaAlmeidaSousa@rhyta.com'	,'Médico'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ana Alves'	,'693.089.906-23'	,'Rua Pinheiro Machado '	,1893	,'Ouro Cola'	,'14085-650'	,'(16) 7034-5877'	,'Thiago'	,'A'	,'1979-8-26'	,'AnaCardosoAlves@gustr.com'	,'Médico'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Erick Rodrigues'	,'219.423.226-58'	,'Rua Trinta e Cinco '	,1934	,'Parque Avenida'	,'38082-095'	,'(34) 5825-6750'	,'Anna'	,'A'	,'1981-8-8'	,'ErickBarbosaRodrigues@gustr.com'	,'Médico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lara Almeida'	,'179.569.300-22'	,'Rua Otávio Sigefredo Roriz '	,702	,'Liberdade'	,'79603-080'	,'(67) 9334-4035'	,'Arthur'	,'A'	,'1991-10-16'	,'LaraPintoAlmeida@rhyta.com'	,'Médico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julian Cardoso'	,'410.585.122-50'	,'Viela Santa Cruz '	,473	,'Ouro Cola'	,'18015-370'	,'(15) 6701-3460'	,'Tomás'	,'A'	,'1998-6-13'	,'JulianCostaCardoso@jourrapide.com'	,'Médico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Maria Barbosa'	,'437.763.026-15'	,'Rua Daniel Luiz '	,1393	,'Grevíleas'	,'94060-050'	,'(51) 8535-7022'	,'Caio'	,'A'	,'1978-10-3'	,'MariaMartinsBarbosa@einrot.com'	,'Médico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Livia Azevedo'	,'109.066.029-47'	,'Av. Paraná '	,161	,'Portal das Torres'	,'72504-508'	,'(61) 3508-4145'	,'Murilo'	,'A'	,'1950-11-8'	,'LiviaRodriguesAzevedo@superrito.com'	,'Médico'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Carlos Souza'	,'774.559.618-12'	,'Travessa Antônio Salgado '	,556	,'Itaipu'	,'15030-525'	,'(17) 9675-3731'	,'Kai'	,'A'	,'1987-8-24'	,'CarlosFerreiraSouza@dayrep.com'	,'Médico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Evelyn Pereira'	,'895.063.158-09'	,'Rua Santa Marta '	,1637	,'Jardim Atami'	,'59065-560'	,'(84) 4761-3673'	,'Carlos'	,'A'	,'1977-9-1'	,'EvelynSilvaPereira@armyspy.com'	,'Médico'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rodrigo Costa'	,'924.619.613-95'	,'Rua Dois '	,733	,'Zona 04'	,'27273-370'	,'(24) 6158-7623'	,'Luís'	,'I'	,'1950-6-17'	,'RodrigoFerreiraCosta@fleckens.hu'	,'Médico'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Paulo Araujo'	,'916.904.147-40'	,'Rua Maria Soares Leitão '	,598	,'Jardim Diamante'	,'18047-690'	,'(15) 3998-6580'	,'Igor'	,'A'	,'1954-2-26'	,'PauloOliveiraAraujo@fleckens.hu'	,'Médico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sophia Barbosa'	,'963.588.581-49'	,'Praça Tenente-Coronel Fábio Solano Pereira '	,1529	,'Olímpico'	,'05547-125'	,'(11) 2269-6418'	,'Douglas'	,'A'	,'1981-8-15'	,'SophiaMeloBarbosa@cuvox.de'	,'Médico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabriel Azevedo'	,'472.599.092-26'	,'Rua José Magalhães '	,826	,'Guaporé'	,'69301-360'	,'(95) 7437-5279'	,'Felipe'	,'I'	,'1984-8-14'	,'GabrielCorreiaAzevedo@fleckens.hu'	,'Médico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Pedro Pinto'	,'463.636.180-61'	,'Rua Canal '	,99	,'Borba Gato'	,'55608-590'	,'(81) 3214-9166'	,'Victor'	,'A'	,'1997-7-23'	,'PedroSilvaPinto@rhyta.com'	,'Arqueólogo'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matheus Cunha'	,'809.340.901-73'	,'Rua Marcos Arlindo Trombetta '	,116	,'Sumaré'	,'89815-620'	,'(49) 3096-5322'	,'Emilly'	,'A'	,'1951-3-3'	,'MatheusPintoCunha@armyspy.com'	,'Arqueólogo'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Danilo Cunha'	,'515.053.998-82'	,'Rua Mário de Lima Hornes '	,784	,'Recanto dos Magnatas'	,'91450-090'	,'(51) 7921-3307'	,'Marisa'	,'A'	,'1982-1-25'	,'DaniloRibeiroCunha@einrot.com'	,'Arqueólogo'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Cavalcanti'	,'974.776.190-41'	,'Avenida Luiz Pereira dos Santos '	,281	,'Vila Esperança'	,'13214-821'	,'(11) 7561-5040'	,'Vitór'	,'A'	,'1968-4-18'	,'LucasOliveiraCavalcanti@teleworm.us'	,'Blogger'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matheus Goncalves'	,'814.142.853-53'	,'Avenida Zildo de Sousa Resende '	,1769	,'Bertioga'	,'13051-401'	,'(19) 3191-4622'	,'Vitor'	,'A'	,'1981-3-7'	,'MatheusCavalcantiGoncalves@cuvox.de'	,'Blogger'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Tânia Pinto'	,'121.174.840-50'	,'Rua Carlos Mantovani '	,1420	,'Laranjeiras'	,'95042-630'	,'(54) 9474-9753'	,'André'	,'A'	,'1994-3-12'	,'TaniaFerreiraPinto@fleckens.hu'	,'Blogger'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('José Carvalho'	,'777.891.623-14'	,'Rua Treze '	,621	,'Pinheiros'	,'69313-260'	,'(95) 5962-6671'	,'Bruna'	,'A'	,'1997-9-3'	,'JosePereiraCarvalho@cuvox.de'	,'Blogger'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luana Sousa'	,'172.106.285-84'	,'Av. Paraná '	,1831	,'Imperial'	,'55030-153'	,'(81) 8290-6072'	,'Bruno'	,'A'	,'1952-2-19'	,'LuanaCunhaSousa@einrot.com'	,'Blogger'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafaela Santos'	,'357.662.348-56'	,'Rua Espanha '	,512	,'Zona 02'	,'15084-080'	,'(17) 8569-7548'	,'Kaua'	,'A'	,'1978-8-1'	,'RafaelaRibeiroSantos@armyspy.com'	,'Blogger'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Cunha'	,'510.989.496-50'	,'Beco Serafim '	,199	,'Cidade Alta'	,'94955-500'	,'(51) 4767-4072'	,'João'	,'A'	,'1974-9-4'	,'LucasRochaCunha@teleworm.us'	,'Blogger'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leonardo Rocha'	,'683.791.629-78'	,'Rua Baianópolis '	,1127	,'Monte Rei'	,'53425-480'	,'(81) 7570-7821'	,'Eduardo'	,'I'	,'1974-3-13'	,'LeonardoDiasRocha@armyspy.com'	,'Blogger'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Beatriz Almeida'	,'466.257.745-45'	,'Rua Benedito de Abreu '	,1548	,'Ouro Cola'	,'17065-230'	,'(14) 4639-7827'	,'Erick'	,'A'	,'1988-12-13'	,'BeatrizFerreiraAlmeida@teleworm.us'	,'Blogger'	,7);				

INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Anna Goncalves'	,'897.893.562-18'	,'Rua Vinte e Dois '	,975	,'Monte Rei'	,'29105-420'	,'(27) 4250-4026'	,'Luan'	,'A'	,'1996-11-16'	,'AnnaSantosGoncalves@einrot.com'	,'Blogger'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Arthur Sousa'	,'579.321.338-40'	,'Rua Estônia '	,996	,'Zona 07'	,'18707-400'	,'(14) 2386-3121'	,'Renan'	,'I'	,'1978-5-4'	,'ArthurSouzaSousa@rhyta.com'	,'Blogger'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitoria Pinto'	,'599.388.695-13'	,'Rua A '	,505	,'Itália'	,'91040-650'	,'(51) 6960-4644'	,'José'	,'A'	,'1982-7-2'	,'VitoriaLimaPinto@cuvox.de'	,'Blogger'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Carlos Martins'	,'712.521.248-48'	,'Rua Bento de Barros '	,355	,'Sumaré'	,'14810-083'	,'(16) 7021-2966'	,'Julian'	,'A'	,'1978-5-12'	,'CarlosOliveiraMartins@fleckens.hu'	,'Blogger'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Aline Ribeiro'	,'965.497.380-40'	,'Praça Leônidas Silva '	,1225	,'Zona 08 - Bairro Aeroporto'	,'82960-220'	,'(41) 8775-4068'	,'Bianca'	,'A'	,'1978-3-10'	,'AlineSantosRibeiro@teleworm.us'	,'Blogger'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ágatha Gomes'	,'838.676.842-86'	,'Avenida Campos Novos '	,326	,'Ney Braga'	,'88309-650'	,'(47) 5423-7867'	,'Victor'	,'A'	,'1979-12-11'	,'AgathaCavalcantiGomes@rhyta.com'	,'Blogger'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Estevan Alves'	,'927.270.674-29'	,'Rua Goianira '	,1861	,'Hortênsia'	,'08285-240'	,'(11) 9849-7240'	,'Marcos'	,'A'	,'1951-10-23'	,'EstevanAzevedoAlves@teleworm.us'	,'Blogger'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitória Ribeiro'	,'289.797.769-85'	,'Rua Rei Cristo '	,1770	,'Parque Bandeirantes'	,'29177-110'	,'(27) 9130-3500'	,'Murilo'	,'A'	,'1958-4-23'	,'VitoriaCostaRibeiro@dayrep.com'	,'Blogger'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vinícius Oliveira'	,'697.958.568-12'	,'Rua Emílio Blum '	,1054	,'Imperial'	,'88521-100'	,'(49) 6570-2241'	,'Anna'	,'A'	,'1962-3-7'	,'ViniciusCardosoOliveira@superrito.com'	,'Auxiliar de escritório'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafael Fernandes'	,'423.869.134-22'	,'Travessa Joana '	,1486	,'Duzentão'	,'23510-483'	,'(21) 7274-2125'	,'Raissa'	,'A'	,'1966-11-11'	,'RafaelSousaFernandes@fleckens.hu'	,'Auxiliar de escritório'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leila Oliveira'	,'543.165.430-67'	,'Rua Campos Sales '	,599	,'Zona 08 - Bairro Aeroporto'	,'80030-230'	,'(41) 6574-7062'	,'Alice'	,'A'	,'1976-11-2'	,'LeilaLimaOliveira@cuvox.de'	,'Auxiliar de escritório'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ryan Cardoso'	,'304.675.607-06'	,'Av. Paraná '	,2200	,'Indaiá'	,'75063-260'	,'(62) 5048-2055'	,'Paulo'	,'A'	,'1952-9-27'	,'RyanMartinsCardoso@gustr.com'	,'Auxiliar de escritório'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bruno Cardoso'	,'608.977.003-50'	,'Rua Renato Cincurá '	,1952	,'Liberdade'	,'41110-010'	,'(71) 3917-2051'	,'Sarah'	,'I'	,'1979-9-1'	,'BrunoAlmeidaCardoso@fleckens.hu'	,'Auxiliar de escritório'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Danilo Pinto'	,'868.762.828-56'	,'Av. Paraná '	,2094	,'Olímpico'	,'54315-302'	,'(81) 4010-6886'	,'Alice'	,'A'	,'1999-11-27'	,'DaniloRochaPinto@teleworm.us'	,'Auxiliar de escritório'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matheus Gomes'	,'707.791.505-03'	,'Rua Doutor Francisco Portela '	,1372	,'Borba Gato'	,'27910-200'	,'(22) 2246-3124'	,'Fernanda'	,'A'	,'1983-10-3'	,'MatheusAraujoGomes@cuvox.de'	,'Auxiliar de escritório'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauê Castro'	,'995.811.147-00'	,'Avenida do Catarinense '	,181	,'Três Lagoas'	,'23097-115'	,'(21) 6686-3857'	,'Vitór'	,'I'	,'1992-4-12'	,'KaueBarrosCastro@dayrep.com'	,'Auxiliar de escritório'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Diogo Ribeiro'	,'336.572.278-57'	,'Rua Rio da Prata '	,1779	,'Alvorada'	,'21820-092'	,'(21) 3003-9839'	,'Isabelle'	,'A'	,'1968-5-21'	,'DiogoBarrosRibeiro@cuvox.de'	,'Auxiliar de escritório'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Douglas Azevedo'	,'961.708.138-57'	,'Rua Coelho '	,663	,'Zona 02'	,'30440-210'	,'(31) 2809-4305'	,'Guilherme'	,'A'	,'1962-5-27'	,'DouglasSilvaAzevedo@armyspy.com'	,'Auxiliar de escritório'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabriel Santos'	,'489.538.727-58'	,'Rua Guanhães '	,1815	,'Grevíleas'	,'35931-099'	,'(31) 9404-2955'	,'Kauã'	,'A'	,'1977-1-6'	,'GabrielRodriguesSantos@jourrapide.com'	,'Auxiliar de escritório'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lara Melo'	,'587.701.820-51'	,'Rua Doutor Miguel Vieira Ferreira '	,1121	,'Borba Gato'	,'07095-070'	,'(11) 3518-6622'	,'Gabrielly'	,'A'	,'1960-3-13'	,'LaraSantosMelo@einrot.com'	,'Auxiliar de escritório'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ágatha Alves'	,'789.707.274-69'	,'Av. Paraná '	,2471	,'São Clemente'	,'71655-220'	,'(61) 2224-4088'	,'Anna'	,'A'	,'1980-12-19'	,'AgathaBarbosaAlves@dayrep.com'	,'Auxiliar de escritório'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Raissa Azevedo'	,'735.114.560-10'	,'Rua do Cristo '	,159	,'Zona 03 - Vila Operária'	,'06753-130'	,'(11) 5997-6669'	,'Paulo'	,'A'	,'1975-8-4'	,'RaissaPereiraAzevedo@armyspy.com'	,'Auxiliar de escritório'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luís Silva'	,'919.346.058-91'	,'Rua Alfredo Gioielli '	,1447	,'Borba Gato'	,'05634-070'	,'(11) 9280-9311'	,'Pedro'	,'A'	,'1962-1-5'	,'LuisSantosSilva@teleworm.us'	,'Auxiliar de escritório'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Estevan Barbosa'	,'379.162.701-53'	,'Rua João Zanetti '	,238	,'Jardim América'	,'22621-030'	,'(21) 8207-8781'	,'Gabrielly'	,'A'	,'1960-10-20'	,'EstevanRibeiroBarbosa@dayrep.com'	,'Auxiliar de escritório'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Douglas Cavalcanti'	,'251.209.176-74'	,'Rua Paulo de Frontim '	,1399	,'Hortênsia'	,'26015-020'	,'(21) 5844-9672'	,'Igor'	,'A'	,'1996-9-10'	,'DouglasPintoCavalcanti@armyspy.com'	,'Auxiliar de escritório'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Joao Sousa'	,'877.468.015-36'	,'Rua Miguel '	,1141	,'Duzentão'	,'33141-255'	,'(31) 7142-3760'	,'Giovana'	,'A'	,'1997-11-8'	,'JoaoBarbosaSousa@jourrapide.com'	,'Auxiliar de escritório'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitória Goncalves'	,'578.661.523-57'	,'Av. Paraná '	,117	,'Zona 05'	,'74303-070'	,'(62) 5499-5310'	,'Emily'	,'I'	,'1996-8-5'	,'VitoriaDiasGoncalves@rhyta.com'	,'Auxiliar de escritório'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Cauã Carvalho'	,'825.303.573-07'	,'Rua Dona Vicentina '	,1855	,'Tarumã'	,'12226-844'	,'(12) 3412-9333'	,'Pedro'	,'A'	,'1987-6-18'	,'CauaAzevedoCarvalho@einrot.com'	,'Auxiliar de escritório'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luiza Santos'	,'105.717.762-80'	,'Rua Coronel Paulo Antônio Lisboa '	,937	,'Vila Esperança'	,'74967-710'	,'(62) 4552-2352'	,'Gabriel'	,'A'	,'1951-11-6'	,'LuizaAlvesSantos@cuvox.de'	,'Pedreiro'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafael Oliveira'	,'235.304.413-17'	,'Rua Alberto Erthal '	,1765	,'Grevíleas'	,'82210-200'	,'(41) 6639-9447'	,'Nicolash'	,'I'	,'1990-2-16'	,'RafaelSouzaOliveira@teleworm.us'	,'Pedreiro'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Erick Castro'	,'198.679.471-77'	,'Rua Francisco da Lira '	,1282	,'Zona 04'	,'02346-010'	,'(11) 5751-5650'	,'Otávio'	,'A'	,'1998-11-18'	,'ErickSousaCastro@armyspy.com'	,'Pedreiro'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marcos Barbosa'	,'353.265.375-32'	,'Rua Porfírio de Campos Pedroso '	,1103	,'Liberdade'	,'18274-198'	,'(15) 5551-8949'	,'Kauê'	,'A'	,'1984-7-13'	,'MarcosRodriguesBarbosa@rhyta.com'	,'Pedreiro'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Nicolash Gomes'	,'919.601.620-55'	,'Av. Paraná '	,786	,'Ney Braga'	,'72856-684'	,'(61) 7212-2348'	,'Luís'	,'A'	,'1984-5-14'	,'NicolashFerreiraGomes@jourrapide.com'	,'Policial'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Livia Costa'	,'476.991.131-95'	,'Rua Santa Ana '	,740	,'São Domingos'	,'85602-800'	,'(46) 9310-4816'	,'Bianca'	,'A'	,'1989-9-2'	,'LiviaCardosoCosta@teleworm.us'	,'Policial'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitor Castro'	,'902.739.659-05'	,'Rua Sete '	,600	,'Parque Bandeirantes'	,'18087-307'	,'(15) 5682-5414'	,'Evelyn'	,'A'	,'1993-7-25'	,'VitorBarbosaCastro@cuvox.de'	,'Policial'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Arthur Cavalcanti'	,'357.022.271-31'	,'Av. Paraná '	,184	,'Vila Esperança'	,'71010-095'	,'(61) 8839-6261'	,'Antônio'	,'A'	,'1950-5-23'	,'ArthurBarbosaCavalcanti@rhyta.com'	,'Zelador'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafaela Santos'	,'581.348.884-70'	,'Rua Forte dos Dragoes '	,1762	,'Liberdade'	,'04865-050'	,'(11) 2412-4083'	,'Vitor'	,'A'	,'1996-3-5'	,'RafaelaRibeiroSantos@jourrapide.com'	,'Zelador'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Nicolash Araujo'	,'918.787.026-61'	,'Rua Pitininga '	,891	,'Vila Esperança'	,'54080-100'	,'(81) 2250-4234'	,'Nicolash'	,'A'	,'1973-4-21'	,'NicolashGomesAraujo@dayrep.com'	,'Zelador'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Joao Dias'	,'330.882.300-42'	,'Rua Angico '	,728	,'Parque Bandeirantes'	,'94955-040'	,'(51) 3756-8095'	,'Marina'	,'A'	,'1997-1-20'	,'JoaoAlmeidaDias@einrot.com'	,'Zelador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marisa Martins'	,'896.712.053-21'	,'Av. Paraná '	,2980	,'Ney Braga'	,'78735-741'	,'(66) 9225-6286'	,'Emily'	,'A'	,'1986-5-12'	,'MarisaRibeiroMartins@dayrep.com'	,'Zelador'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Giovanna Santos'	,'199.863.927-48'	,'Rua Tamoio '	,1195	,'Alamar'	,'09430-130'	,'(16) 7992-3920'	,'André'	,'I'	,'1987-3-18'	,'GiovannaPereiraSantos@teleworm.us'	,'Zelador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafael Martins'	,'352.771.468-57'	,'Rua Um '	,1698	,'Hortênsia'	,'37704-312'	,'(35) 8128-5834'	,'Evelyn'	,'A'	,'1989-4-7'	,'RafaelRibeiroMartins@armyspy.com'	,'Zelador'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Thiago Cunha'	,'747.047.740-31'	,'Rua Hilário Gouveia '	,1458	,'Iguaçu'	,'04384-010'	,'(11) 9214-6030'	,'Julia'	,'A'	,'1952-10-7'	,'ThiagoPereiraCunha@gustr.com'	,'Zelador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitór Gomes'	,'424.736.148-14'	,'Av. Paraná '	,607	,'Dias'	,'72815-190'	,'(61) 7426-2189'	,'Kaua'	,'I'	,'1963-11-14'	,'VitorMeloGomes@einrot.com'	,'Zelador'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bruno Carvalho'	,'538.387.238-80'	,'Rua João Castelhanos '	,1388	,'Itália'	,'02407-030'	,'(11) 4769-7461'	,'Beatrice'	,'A'	,'2000-7-14'	,'BrunoPintoCarvalho@jourrapide.com'	,'Zelador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Júlio Alves'	,'227.780.504-18'	,'Avenida Noroeste '	,1319	,'Bertioga'	,'79005-570'	,'(67) 8183-2995'	,'Rodrigo'	,'A'	,'1965-2-2'	,'JulioCavalcantiAlves@jourrapide.com'	,'Zelador'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Júlio Goncalves'	,'361.336.905-26'	,'Rua C '	,121	,'Parque Bandeirantes'	,'39402-396'	,'(38) 3844-9623'	,'Lavinia'	,'A'	,'1958-5-16'	,'JulioGomesGoncalves@cuvox.de'	,'Zelador'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rodrigo Sousa'	,'424.353.135-86'	,'Rua Coronel França Leite '	,860	,'Zona 05'	,'26515-020'	,'(21) 8774-2950'	,'Kai'	,'A'	,'1992-1-25'	,'RodrigoAzevedoSousa@gustr.com'	,'Diretor de Treinamento'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Melissa Castro'	,'188.137.949-32'	,'Rua Emília Martins Rulo '	,1143	,'Grevíleas'	,'06773-300'	,'(11) 4238-9812'	,'Estevan'	,'A'	,'1958-8-26'	,'MelissaRibeiroCastro@dayrep.com'	,'Diretor de Treinamento'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vinícius Cardoso'	,'272.616.065-45'	,'Rua São Gonçalo '	,1263	,'Guaporé'	,'78903-845'	,'(69) 8039-8237'	,'Gabriela'	,'A'	,'1977-4-6'	,'ViniciusBarbosaCardoso@rhyta.com'	,'Diretor de Treinamento'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marcos Sousa'	,'424.693.681-20'	,'Rua Belo Horizonte '	,1784	,'Jardim Industrial'	,'11665-335'	,'(12) 2741-8849'	,'Tânia'	,'A'	,'1951-7-10'	,'MarcosCavalcantiSousa@teleworm.us'	,'Diretor de Treinamento'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('José Cardoso'	,'496.606.460-03'	,'Avenida Paraná '	,1239	,'Mandacaru'	,'18105-001'	,'(15) 5313-8338'	,'Felipe'	,'A'	,'1995-12-12'	,'JoseLimaCardoso@fleckens.hu'	,'Diretor de Treinamento'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alex Sousa'	,'168.925.299-50'	,'Estrada União Indústria '	,560	,'Hermann Moraes de Barros'	,'25805-335'	,'(24) 5107-7730'	,'Matheus'	,'A'	,'1975-3-24'	,'AlexFerreiraSousa@cuvox.de'	,'Diretor de Treinamento'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Enzo Araujo'	,'892.779.920-85'	,'Travessa Argila '	,1774	,'Pinheiros'	,'60542-290'	,'(85) 5600-7486'	,'Nicolash'	,'A'	,'1955-4-7'	,'EnzoGomesAraujo@dayrep.com'	,'Diretor de Treinamento'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rebeca Pereira'	,'715.698.329-60'	,'Rua Itacoatiara '	,435	,'Oásis'	,'52280-120'	,'(81) 6017-7743'	,'Letícia'	,'I'	,'1963-2-26'	,'RebecaCorreiaPereira@gustr.com'	,'Diretor de Treinamento'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Giovana Rocha'	,'532.431.943-00'	,'Rua Ricarte Leite Alvim '	,1839	,'Tuiuti'	,'08460-030'	,'(11) 3702-8151'	,'Bruno'	,'A'	,'1981-3-24'	,'GiovanaAlvesRocha@einrot.com'	,'Diretor de Treinamento'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matilde Dias'	,'199.586.593-10'	,'Rua Ibirama '	,572	,'Pinheiros'	,'89810-140'	,'(49) 4442-4718'	,'Sofia'	,'A'	,'1972-10-13'	,'MatildePereiraDias@rhyta.com'	,'Diretor de Treinamento'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Samuel Lima'	,'565.081.727-86'	,'Av. Paraná '	,2777	,'Jardim Atami'	,'54250-210'	,'(81) 2425-3569'	,'Carolina'	,'I'	,'1992-1-6'	,'SamuelCardosoLima@teleworm.us'	,'Diretor de Treinamento'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vinícius Ferreira'	,'691.249.770-55'	,'Rua José Alves da Silva '	,787	,'Zona 04'	,'15047-134'	,'(17) 8665-2068'	,'Matheus'	,'A'	,'1987-11-16'	,'ViniciusDiasFerreira@dayrep.com'	,'Diretor de Treinamento'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Antônio Dias'	,'342.035.678-15'	,'Av. Paraná '	,293	,'Iguaçu'	,'72821-120'	,'(61) 8528-2247'	,'Sofia'	,'A'	,'1950-11-27'	,'AntonioRodriguesDias@jourrapide.com'	,'Diretor de Treinamento'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matheus Alves'	,'752.100.465-59'	,'Rua Dallas '	,337	,'Alvorada'	,'79017-166'	,'(67) 3061-3298'	,'Rafael'	,'A'	,'1986-5-6'	,'MatheusCunhaAlves@gustr.com'	,'Superintendente'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marisa Pereira'	,'108.706.218-74'	,'Rua Francisco Aro '	,683	,'Oásis'	,'08683-170'	,'(11) 7095-5727'	,'Sophia'	,'A'	,'1951-12-26'	,'MarisaFernandesPereira@jourrapide.com'	,'Superintendente'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Aline Barbosa'	,'517.919.876-30'	,'Rua Ângelo Ricardo Zanotto '	,1735	,'Recanto dos Magnatas'	,'18609-170'	,'(14) 8471-3853'	,'Estevan'	,'A'	,'1970-7-18'	,'AlineCardosoBarbosa@gustr.com'	,'Superintendente'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gustavo Araujo'	,'716.938.185-07'	,'Rua Correia de Araújo '	,690	,'Jardim América'	,'65035-100'	,'(98) 6629-3011'	,'Douglas'	,'A'	,'1960-5-1'	,'GustavoAzevedoAraujo@fleckens.hu'	,'Superintendente'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Cavalcanti'	,'469.562.964-03'	,'Rua Dois Riachos '	,1262	,'Borba Gato'	,'59115-340'	,'(84) 8489-2115'	,'Tiago'	,'A'	,'1954-6-13'	,'LucasRodriguesCavalcanti@rhyta.com'	,'Superintendente'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Amanda Cunha'	,'749.245.713-85'	,'Rua Jacques Le Mercier '	,1660	,'Cidade Alta'	,'05866-050'	,'(11) 2080-5457'	,'Nicole'	,'A'	,'1962-11-27'	,'AmandaCardosoCunha@superrito.com'	,'Superintendente'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vinícius Ferreira'	,'463.885.692-69'	,'Rua Frederico Rudolpho Germano Dumke '	,1788	,'Alamar'	,'89231-546'	,'(47) 6321-6811'	,'Renan'	,'A'	,'1966-4-14'	,'ViniciusSousaFerreira@einrot.com'	,'Superintendente'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Maria Ribeiro'	,'244.350.166-30'	,'Rua Piratini '	,1078	,'Iguaçu'	,'93540-010'	,'(51) 5110-8628'	,'Mateus'	,'A'	,'1970-3-25'	,'MariaCunhaRibeiro@cuvox.de'	,'Superintendente'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Giovanna Santos'	,'732.632.178-79'	,'Rua Piratininga '	,244	,'Parque Industrial'	,'29101-220'	,'(27) 8681-2346'	,'Tomás'	,'I'	,'1996-2-20'	,'GiovannaCastroSantos@dayrep.com'	,'Superintendente'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Davi Sousa'	,'316.270.686-60'	,'Av. Paraná '	,1638	,'São Domingos'	,'72237-200'	,'(61) 4017-7659'	,'Miguel'	,'A'	,'1973-11-4'	,'DaviCardosoSousa@teleworm.us'	,'Superintendente'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rebeca Cardoso'	,'650.592.222-92'	,'Praça das Estrêlas '	,482	,'Hermann Moraes de Barros'	,'09606-130'	,'(11) 8689-6463'	,'Antônio'	,'A'	,'1992-8-25'	,'RebecaSilvaCardoso@armyspy.com'	,'Superintendente'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kaua Costa'	,'229.868.590-89'	,'Av. Paraná '	,2172	,'Tuiuti'	,'74950-100'	,'(62) 3158-9719'	,'Maria'	,'I'	,'1995-7-8'	,'KauaCardosoCosta@superrito.com'	,'Superintendente'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sarah Araujo'	,'433.560.657-50'	,'Travessa Sandra '	,220	,'Campos Elíseos'	,'40350-130'	,'(71) 3510-5928'	,'Nicole'	,'A'	,'1965-5-21'	,'SarahDiasAraujo@jourrapide.com'	,'Superintendente'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Emilly Castro'	,'128.498.307-20'	,'Rua José Dalcy do Amaral '	,1559	,'Guaporé'	,'88504-125'	,'(49) 7337-5703'	,'Davi'	,'A'	,'1961-8-15'	,'EmillyMeloCastro@gustr.com'	,'Superintendente'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Nicolas Souza'	,'116.951.094-90'	,'Rua Ametista '	,1861	,'Itaipu'	,'50910-530'	,'(81) 9335-6861'	,'Vitória'	,'A'	,'1996-10-25'	,'NicolasRochaSouza@fleckens.hu'	,'Superintendente'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ryan Souza'	,'652.210.032-01'	,'Travessa Caipós '	,317	,'Zona 05'	,'68701-390'	,'(91) 9538-4738'	,'Eduardo'	,'A'	,'1976-1-20'	,'RyanSousaSouza@teleworm.us'	,'Superintendente'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Nicole Rodrigues'	,'597.603.244-31'	,'Rua Luiz Batista Bertaco '	,975	,'Jardim Atami'	,'91770-500'	,'(51) 3561-9908'	,'Leonardo'	,'A'	,'1955-3-14'	,'NicoleFernandesRodrigues@rhyta.com'	,'Superintendente'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Pedro Rocha'	,'917.165.057-12'	,'Rua Major Armando de Souza Melo '	,889	,'Dias'	,'51030-180'	,'(81) 7970-7294'	,'Vitória'	,'A'	,'1994-7-25'	,'PedroAzevedoRocha@fleckens.hu'	,'Superintendente'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Daniel Rodrigues'	,'655.772.551-39'	,'Vila Mires '	,937	,'Mandacaru'	,'60110-240'	,'(85) 6460-5015'	,'Alex'	,'A'	,'1954-8-24'	,'DanielRochaRodrigues@rhyta.com'	,'Superintendente'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabrielly Cavalcanti'	,'858.282.683-41'	,'Rua da Luz '	,1143	,'Zona 10'	,'27150-580'	,'(24) 7780-2044'	,'Kauã'	,'A'	,'1991-7-21'	,'GabriellyAlmeidaCavalcanti@jourrapide.com'	,'Superintendente'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('José Almeida'	,'773.207.429-77'	,'Rua Delegado Francisco Alves de Araújo '	,258	,'Zona 05'	,'64038-280'	,'(86) 7990-9125'	,'Anna'	,'A'	,'1981-12-11'	,'JoseCastroAlmeida@superrito.com'	,'Superintendente'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Aline Costa'	,'822.689.902-81'	,'Rua Alfredo de Oliveira '	,68	,'Indaiá'	,'89207-015'	,'(47) 4790-4979'	,'André'	,'A'	,'1979-1-11'	,'AlineGomesCosta@armyspy.com'	,'Superintendente'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Anna Ferreira'	,'169.945.423-00'	,'Rua Rubi '	,358	,'Recanto dos Magnatas'	,'38035-200'	,'(34) 3580-2847'	,'Vitór'	,'I'	,'1984-4-18'	,'AnnaOliveiraFerreira@cuvox.de'	,'Auditor interno'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gustavo Pinto'	,'616.930.209-71'	,'Rua Urano '	,1369	,'Miosótis'	,'68903-480'	,'(96) 8109-8002'	,'Marina'	,'A'	,'1990-6-11'	,'GustavoFernandesPinto@gustr.com'	,'Auditor interno'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Victor Silva'	,'721.852.586-56'	,'Beco Santo Agostinho '	,1605	,'Liberdade'	,'30440-280'	,'(31) 5312-7806'	,'Daniel'	,'A'	,'1950-8-17'	,'VictorPintoSilva@rhyta.com'	,'Auditor interno'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Pinto'	,'955.645.195-15'	,'Rua Ziembinsky '	,1749	,'Tuiuti'	,'06719-427'	,'(11) 8466-3396'	,'Bruno'	,'I'	,'1990-6-6'	,'LucasCardosoPinto@dayrep.com'	,'Auditor interno'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafael Cardoso'	,'499.859.094-45'	,'Travessa Maria da Penha Tavares '	,1168	,'Parque Avenida'	,'28080-785'	,'(22) 9766-5079'	,'Júlio'	,'A'	,'1982-9-23'	,'RafaelSousaCardoso@superrito.com'	,'Árbitro'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leonor Martins'	,'956.033.261-90'	,'Avenida José Glicério de Mello '	,1125	,'Miosótis'	,'08715-530'	,'(11) 5067-9368'	,'André'	,'A'	,'1953-4-5'	,'LeonorOliveiraMartins@rhyta.com'	,'Engenheiro'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bruno Rocha'	,'481.692.695-04'	,'Rua Andarilho '	,1400	,'Novo Horizonte'	,'86706-630'	,'(43) 5468-8878'	,'Victor'	,'A'	,'1998-5-20'	,'BrunoBarrosRocha@fleckens.hu'	,'Engenheiro'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Diogo Martins'	,'221.978.238-76'	,'Rua Professor Américo Braga '	,1804	,'Requião'	,'24130-230'	,'(21) 4395-6982'	,'Vitória'	,'A'	,'1977-6-12'	,'DiogoCunhaMartins@gustr.com'	,'Engenheiro'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Erick Castro'	,'988.504.662-34'	,'Rua Horácio Fidani '	,725	,'Zona 02'	,'03929-020'	,'(11) 6770-6941'	,'Diogo'	,'A'	,'1993-8-17'	,'ErickSouzaCastro@gustr.com'	,'Engenheiro'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luan Correia'	,'432.745.551-26'	,'Rua Mário Mendes '	,1512	,'Jardim Diamante'	,'83414-370'	,'(41) 2971-4747'	,'Tomás'	,'A'	,'1984-3-12'	,'LuanSouzaCorreia@armyspy.com'	,'Seguro investigador'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Maria Oliveira'	,'756.334.603-16'	,'Avenida Resende '	,1399	,'Três Lagoas'	,'74455-515'	,'(62) 3292-5787'	,'Fernanda'	,'A'	,'1993-11-11'	,'MariaCostaOliveira@armyspy.com'	,'Árbitro'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alex Pinto'	,'814.601.981-15'	,'Rua Carajás '	,1529	,'Dias'	,'06719-535'	,'(11) 6822-7232'	,'Luiz'	,'A'	,'1950-8-18'	,'AlexAzevedoPinto@superrito.com'	,'Árbitro'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lara Cardoso'	,'773.389.959-15'	,'Rua América Central '	,1468	,'São Domingos'	,'09351-190'	,'(11) 3312-5644'	,'Kauan'	,'A'	,'1965-9-10'	,'LaraSouzaCardoso@cuvox.de'	,'Árbitro'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Mariana Dias'	,'134.464.283-72'	,'Travessa Doutor Geraldo Melo dos Santos '	,784	,'Hortênsia'	,'57025-665'	,'(82) 7567-2092'	,'Rafaela'	,'A'	,'1996-1-27'	,'MarianaLimaDias@jourrapide.com'	,'Contador'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Nicole Araujo'	,'462.994.528-89'	,'Rua Doutor Arthur de Souza Costa '	,734	,'Olímpico'	,'83206-210'	,'(41) 6853-7860'	,'Vinicius'	,'I'	,'1962-3-10'	,'NicoleRibeiroAraujo@jourrapide.com'	,'Contador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Rafael Carvalho'	,'318.035.969-29'	,'Rua Nazareth '	,1265	,'Tuiuti'	,'74675-610'	,'(62) 4382-4410'	,'Luis'	,'A'	,'1971-8-2'	,'RafaelSantosCarvalho@gustr.com'	,'Contador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marina Alves'	,'380.759.868-57'	,'Quadra Setenta e Dois '	,1237	,'São Clemente'	,'66110-178'	,'(91) 5335-4797'	,'Manuela'	,'A'	,'1961-9-27'	,'MarinaMeloAlves@superrito.com'	,'Contador'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Igor Ribeiro'	,'548.670.710-05'	,'Rua Constantino de Moura Batista '	,1861	,'Liberdade'	,'09580-570'	,'(11) 6410-4822'	,'Felipe'	,'I'	,'1952-7-17'	,'IgorCorreiaRibeiro@teleworm.us'	,'Contador'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Thiago Cunha'	,'234.560.906-09'	,'Rua Santo Antônio do Sudoeste '	,1393	,'Iguaçu'	,'81310-090'	,'(41) 8615-7002'	,'Gabrielle'	,'A'	,'1977-10-12'	,'ThiagoAlvesCunha@fleckens.hu'	,'Contador'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lara Melo'	,'948.513.014-72'	,'Praça Tiradentes '	,1857	,'Jardim América'	,'43805-220'	,'(71) 2147-3369'	,'Anna'	,'A'	,'1982-9-11'	,'LaraDiasMelo@einrot.com'	,'Contador'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Beatrice Almeida'	,'924.547.061-05'	,'Rua Rolf F. Penski '	,66	,'Três Lagoas'	,'89237-813'	,'(47) 8215-7149'	,'Gabriela'	,'A'	,'1969-8-19'	,'BeatriceFernandesAlmeida@armyspy.com'	,'Contador'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Danilo Melo'	,'107.529.101-16'	,'Avenida Tales Neto '	,1481	,'Ney Braga'	,'65057-470'	,'(98) 5555-4566'	,'Isabella'	,'A'	,'1973-10-13'	,'DaniloPintoMelo@cuvox.de'	,'Contador'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luana Dias'	,'420.714.093-02'	,'Av. Paraná '	,1228	,'Itaipu'	,'72542-221'	,'(61) 5153-9985'	,'Luiz'	,'A'	,'1957-8-1'	,'LuanaSantosDias@jourrapide.com'	,'Contador'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Douglas Carvalho'	,'703.419.103-41'	,'Rua Cinquenta e Quatro '	,425	,'São Domingos'	,'54520-010'	,'(81) 5841-2738'	,'Antônio'	,'A'	,'1989-9-19'	,'DouglasMartinsCarvalho@dayrep.com'	,'Contador'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitór Gomes'	,'244.152.475-55'	,'Vila Galdino Ribeiro '	,17	,'Oásis'	,'60420-610'	,'(85) 3570-8805'	,'Kauê'	,'A'	,'2000-4-3'	,'VitorRibeiroGomes@rhyta.com'	,'Contador'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Pedro Sousa'	,'457.756.839-00'	,'Rua São Luís '	,1939	,'São Silvestre'	,'40730-160'	,'(71) 4694-8050'	,'Enzo'	,'A'	,'1985-11-7'	,'PedroCavalcantiSousa@einrot.com'	,'Contador'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitor Silva'	,'677.735.176-06'	,'Rua Josefina Fernandes Pereira '	,322	,'Ipanema'	,'18611-100'	,'(14) 2357-5835'	,'Leonardo'	,'A'	,'1981-3-6'	,'VitorCorreiaSilva@teleworm.us'	,'Contador'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Caio Cardoso'	,'577.954.123-00'	,'Rua Tibúrcia Monteiro Queiroz '	,1535	,'São Domingos'	,'79630-212'	,'(67) 6164-9310'	,'Pedro'	,'A'	,'1974-3-15'	,'CaioBarbosaCardoso@einrot.com'	,'Aviador'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauan Santos'	,'133.659.293-12'	,'Avenida Adolpho Bloch '	,477	,'Oásis'	,'13058-120'	,'(19) 9917-3389'	,'Lara'	,'I'	,'1953-6-19'	,'KauanLimaSantos@rhyta.com'	,'Técnico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabriela Sousa'	,'954.759.746-91'	,'Rua Correia Vasques '	,246	,'Jardim Diamante'	,'20211-140'	,'(21) 6267-6138'	,'Leonor'	,'A'	,'1961-8-4'	,'GabrielaCorreiaSousa@armyspy.com'	,'Técnico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kaua Araujo'	,'635.015.053-88'	,'Rua Vereador Orestes Pagliosa '	,60	,'Ipanema'	,'85506-525'	,'(46) 6601-7657'	,'Matheus'	,'A'	,'1963-3-12'	,'KauaFerreiraAraujo@cuvox.de'	,'Técnico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Eduarda Fernandes'	,'158.667.582-61'	,'Rua Campos Salles '	,387	,'Três Lagoas'	,'13418-310'	,'(19) 4615-4716'	,'Miguel'	,'I'	,'1998-3-19'	,'EduardaRodriguesFernandes@cuvox.de'	,'Técnico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Paulo Castro'	,'849.733.911-82'	,'Av. Paraná '	,164	,'Requião'	,'72270-411'	,'(61) 9243-2405'	,'Thaís'	,'A'	,'1994-2-14'	,'PauloFernandesCastro@gustr.com'	,'Técnico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gustavo Araujo'	,'860.710.865-40'	,'Rua Sete '	,1788	,'Indaiá'	,'78932-493'	,'(69) 3211-4968'	,'Bruna'	,'A'	,'1986-5-27'	,'GustavoRochaAraujo@gustr.com'	,'Técnico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Murilo Santos'	,'899.202.850-48'	,'Rua Sacramento '	,1100	,'Colina Verde'	,'37903-210'	,'(35) 8267-3802'	,'Yasmin'	,'A'	,'2000-9-19'	,'MuriloPintoSantos@cuvox.de'	,'Técnico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Nicolash Costa'	,'677.248.523-83'	,'Rua João da Silva L Sobrinho '	,309	,'Zona 02'	,'23855-380'	,'(21) 6024-4327'	,'Diogo'	,'A'	,'2000-9-14'	,'NicolashSouzaCosta@fleckens.hu'	,'Técnico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitor Pereira'	,'313.175.258-09'	,'Rua Três '	,677	,'Grevíleas'	,'30882-400'	,'(31) 7806-5518'	,'Arthur'	,'A'	,'1972-10-3'	,'VitorCavalcantiPereira@rhyta.com'	,'Técnico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lavinia Almeida'	,'798.837.050-26'	,'Rua Lee Fergusson '	,1916	,'Cidade Alta'	,'13450-257'	,'(19) 2356-7395'	,'Vitoria'	,'A'	,'1959-8-19'	,'LaviniaSouzaAlmeida@rhyta.com'	,'Técnico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sarah Ferreira'	,'883.259.902-36'	,'Vila Socorro de Farias '	,918	,'Jardim Atami'	,'60341-370'	,'(85) 7959-7750'	,'Danilo'	,'A'	,'1981-7-3'	,'SarahCunhaFerreira@superrito.com'	,'Técnico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Guilherme Carvalho'	,'286.568.500-40'	,'Rua Vinte e Dois '	,1459	,'São Silvestre'	,'54240-220'	,'(81) 6282-6475'	,'Enzo'	,'A'	,'1952-1-27'	,'GuilhermeDiasCarvalho@superrito.com'	,'Técnico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Enzo Pinto'	,'948.098.895-05'	,'Rua Perseus '	,1693	,'Alvorada'	,'89226-566'	,'(47) 2027-2587'	,'Eduardo'	,'A'	,'1996-9-9'	,'EnzoOliveiraPinto@fleckens.hu'	,'Técnico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julian Oliveira'	,'838.559.722-06'	,'Av. Paraná '	,2921	,'Tarumã'	,'72220-401'	,'(61) 8539-9330'	,'Diogo'	,'A'	,'1989-10-6'	,'JulianCostaOliveira@teleworm.us'	,'Contador'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kai Fernandes'	,'585.558.554-97'	,'Rua Desembargador Pedro Silva '	,1759	,'Parque Avenida'	,'89012-150'	,'(47) 3540-5135'	,'Danilo'	,'I'	,'1986-6-13'	,'KaiPintoFernandes@fleckens.hu'	,'Contador'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Davi Pinto'	,'959.514.727-33'	,'Praça Ricardo Janzon Nogueira '	,259	,'Novo Horizonte'	,'17021-123'	,'(14) 9741-4900'	,'Caio'	,'A'	,'1986-3-12'	,'DaviSousaPinto@einrot.com'	,'Contador'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Guilherme Alves'	,'554.034.366-26'	,'Rua Alemanha '	,991	,'Zona 05'	,'18685-710'	,'(14) 5195-5496'	,'Bruna'	,'A'	,'1965-1-23'	,'GuilhermeRochaAlves@fleckens.hu'	,'Contador'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Eduarda Sousa'	,'148.232.957-30'	,'Rua Benedito Walter dos Santos '	,27	,'Parque Avenida'	,'13098-413'	,'(19) 3538-3501'	,'Emily'	,'I'	,'1967-4-27'	,'EduardaSantosSousa@armyspy.com'	,'Contador'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitór Rodrigues'	,'201.881.386-25'	,'Rua Antenor Nogueira '	,70	,'Bertioga'	,'64002-650'	,'(86) 5110-8818'	,'Melissa'	,'A'	,'1974-5-13'	,'VitorCarvalhoRodrigues@cuvox.de'	,'Contador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Douglas Martins'	,'901.025.513-16'	,'Rua Havaí '	,357	,'Ouro Cola'	,'75533-220'	,'(64) 2932-8223'	,'Gustavo'	,'A'	,'1974-1-25'	,'DouglasCorreiaMartins@superrito.com'	,'Contador'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lavinia Ferreira'	,'648.308.614-87'	,'Rua Pedro Gomes da Silveira '	,954	,'Santa Felicidade'	,'55020-140'	,'(81) 3733-7051'	,'Gabriela'	,'A'	,'1962-10-3'	,'LaviniaRodriguesFerreira@cuvox.de'	,'Contador'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitor Rocha'	,'207.330.556-30'	,'Rua Um '	,336	,'São Clemente'	,'55614-340'	,'(81) 5194-7590'	,'Julieta'	,'A'	,'1968-4-10'	,'VitorSantosRocha@gustr.com'	,'Contador'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Anna Lima'	,'496.105.035-00'	,'Travessa Domingos Requião '	,148	,'Parque Industrial'	,'40327-620'	,'(71) 9923-4079'	,'Bruno'	,'A'	,'1958-8-4'	,'AnnaAraujoLima@fleckens.hu'	,'Contador'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Cauã Pinto'	,'688.153.900-22'	,'Rua Primavera '	,1085	,'Aclimação'	,'77824-775'	,'(63) 4990-3582'	,'Carlos'	,'A'	,'1992-10-1'	,'CauaDiasPinto@rhyta.com'	,'Contador'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alice Pinto'	,'390.362.334-29'	,'Alameda Belchior de Araújo '	,620	,'Zona 10'	,'66093-610'	,'(91) 2613-5392'	,'Lucas'	,'A'	,'1966-2-20'	,'AliceAlvesPinto@teleworm.us'	,'Contador'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Miguel Carvalho'	,'397.527.932-07'	,'Rua Engenheiro Alberto Scharlet '	,1811	,'Jardim Atami'	,'30380-370'	,'(31) 2806-4664'	,'Leonor'	,'A'	,'1997-3-13'	,'MiguelRochaCarvalho@einrot.com'	,'Contador'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Antônio Dias'	,'478.678.034-08'	,'Avenida Tibiriçá '	,564	,'Duzentão'	,'09111-090'	,'(11) 2833-7417'	,'Erick'	,'A'	,'1978-4-10'	,'AntonioCorreiaDias@jourrapide.com'	,'Contador'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauã Rocha'	,'622.219.572-53'	,'Avenida Mandaqui '	,988	,'São Domingos'	,'02550-000'	,'(11) 4318-9113'	,'Rodrigo'	,'A'	,'2000-5-24'	,'KauaRibeiroRocha@cuvox.de'	,'Contador'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sarah Cardoso'	,'318.376.230-74'	,'Rua Deputado Acácio Figueiredo '	,353	,'Tuiuti'	,'58031-145'	,'(83) 7447-6809'	,'Bianca'	,'I'	,'1968-11-24'	,'SarahAraujoCardoso@einrot.com'	,'Contador'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Paulo Pereira'	,'485.396.722-27'	,'Rua Jerônimo Batista Davi '	,1090	,'Universo'	,'59625-085'	,'(84) 6225-3864'	,'Victor'	,'A'	,'1988-1-25'	,'PauloCastroPereira@fleckens.hu'	,'Farmacêutico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Thiago Pinto'	,'961.347.147-20'	,'Rua Valter Galvão '	,1580	,'São Domingos'	,'14409-588'	,'(16) 3178-4547'	,'Leonor'	,'A'	,'2000-10-13'	,'ThiagoMeloPinto@einrot.com'	,'Farmacêutico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marisa Costa'	,'765.739.091-35'	,'Rua Agrônomo Tenisson Freire '	,793	,'Hortênsia'	,'49030-030'	,'(79) 3294-2419'	,'Murilo'	,'I'	,'1969-8-21'	,'MarisaFernandesCosta@teleworm.us'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kai Cardoso'	,'999.969.614-78'	,'Rua Sergipe '	,685	,'Três Lagoas'	,'74974-400'	,'(62) 6971-9112'	,'Kaua'	,'A'	,'1964-5-26'	,'KaiCavalcantiCardoso@teleworm.us'	,'Farmacêutico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Davi Ribeiro'	,'109.461.379-78'	,'Rua Ernesto Barros '	,19	,'Aclimação'	,'96506-310'	,'(51) 7071-9510'	,'Diego'	,'A'	,'1992-9-8'	,'DaviFerreiraRibeiro@einrot.com'	,'Farmacêutico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Júlio Almeida'	,'562.117.203-51'	,'Rua Francisco Simas '	,1412	,'Jardim Atami'	,'89056-109'	,'(47) 4340-9871'	,'Antônio'	,'A'	,'1959-11-21'	,'JulioCorreiaAlmeida@teleworm.us'	,'Farmacêutico'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luis Goncalves'	,'730.602.064-14'	,'Rua Benedito Máximo Araújo '	,1914	,'Duzentão'	,'14810-522'	,'(16) 5540-8508'	,'Marina'	,'A'	,'1989-5-18'	,'LuisDiasGoncalves@armyspy.com'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Eduardo Ferreira'	,'730.329.555-05'	,'Av. Paraná '	,1682	,'Liberdade'	,'75096-450'	,'(62) 4144-4126'	,'Marisa'	,'A'	,'1970-6-1'	,'EduardoBarrosFerreira@dayrep.com'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Tomás Cardoso'	,'747.984.476-09'	,'Servidão Ernani Souza '	,759	,'Mandacaru'	,'88058-007'	,'(48) 5888-2490'	,'Emily'	,'A'	,'1954-1-16'	,'TomasMartinsCardoso@cuvox.de'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Sarah Correia'	,'770.574.428-74'	,'Avenida Piracicaba '	,1017	,'Tuiuti'	,'18131-230'	,'(11) 3667-3439'	,'Gabrielle'	,'A'	,'1954-12-19'	,'SarahRodriguesCorreia@einrot.com'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Erick Souza'	,'875.374.369-59'	,'Servidão Alexandre Souza '	,1529	,'Zona 03 - Vila Operária'	,'88050-020'	,'(48) 4064-8365'	,'Evelyn'	,'A'	,'1992-11-9'	,'ErickSilvaSouza@einrot.com'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Samuel Castro'	,'131.306.226-08'	,'Rua Antônio Wosniak '	,1560	,'Campos Elíseos'	,'81250-670'	,'(41) 9556-8652'	,'Davi'	,'A'	,'1980-3-20'	,'SamuelRochaCastro@dayrep.com'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Renan Barros'	,'344.571.644-70'	,'Travessa Canuto '	,1265	,'Alamar'	,'41225-290'	,'(71) 9434-9606'	,'Sophia'	,'A'	,'1967-10-26'	,'RenanAlvesBarros@teleworm.us'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Guilherme Rocha'	,'567.516.524-02'	,'Viela Ado '	,1800	,'Colina Verde'	,'07143-120'	,'(11) 3854-2086'	,'Danilo'	,'I'	,'1954-7-5'	,'GuilhermePereiraRocha@cuvox.de'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Gabriel Azevedo'	,'699.896.450-19'	,'Rua Afogados da Ingazeira '	,982	,'Aclimação'	,'53610-200'	,'(81) 6531-6933'	,'Vinicius'	,'A'	,'1952-2-13'	,'GabrielSousaAzevedo@rhyta.com'	,'Farmacêutico'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kaua Ribeiro'	,'748.958.425-68'	,'Via de Pedestre Saxônia '	,448	,'Parque Industrial'	,'02273-065'	,'(11) 4194-2319'	,'Kauan'	,'A'	,'1952-8-16'	,'KauaFernandesRibeiro@gustr.com'	,'Farmacêutico'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luan Rodrigues'	,'646.850.579-88'	,'Rua Planalto '	,191	,'Paris'	,'02328-160'	,'(11) 4338-2697'	,'Mateus'	,'I'	,'1993-3-14'	,'LuanSilvaRodrigues@cuvox.de'	,'Farmacêutico'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Alex Oliveira'	,'385.931.587-06'	,'Rua Yolanda Arduini Balcano '	,1331	,'Oásis'	,'38038-106'	,'(34) 9633-5044'	,'Tânia'	,'A'	,'1970-4-12'	,'AlexMartinsOliveira@einrot.com'	,'Farmacêutico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Victor Sousa'	,'939.571.973-76'	,'Av. Paraná '	,676	,'Moradias Atenas'	,'66623-271'	,'(91) 8551-8514'	,'Thiago'	,'A'	,'1981-12-14'	,'VictorCarvalhoSousa@gustr.com'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Júlio Costa'	,'117.658.897-40'	,'Rua Celeste '	,628	,'Campos Elíseos'	,'03174-060'	,'(11) 8983-4606'	,'Douglas'	,'A'	,'1971-5-8'	,'JulioRodriguesCosta@superrito.com'	,'Farmacêutico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitoria Dias'	,'227.048.028-74'	,'Rua Luiz Alberto Menegaz '	,248	,'Universo'	,'95059-330'	,'(54) 8172-8696'	,'Estevan'	,'A'	,'1996-5-24'	,'VitoriaFernandesDias@einrot.com'	,'Farmacêutico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitor Ribeiro'	,'630.403.881-00'	,'Av. Paraná '	,514	,'Liberdade'	,'61919-300'	,'(85) 2437-4381'	,'Vinícius'	,'A'	,'1987-10-2'	,'VitorLimaRibeiro@jourrapide.com'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Leonor Martins'	,'277.735.144-96'	,'Avenida Sete de Setembro '	,1548	,'Dias'	,'57601-140'	,'(82) 7044-8033'	,'Erick'	,'A'	,'1959-6-23'	,'LeonorAlvesMartins@cuvox.de'	,'Farmacêutico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Guilherme Goncalves'	,'119.694.383-47'	,'Rua Estrela do Norte '	,923	,'Jardim Oriental'	,'21720-220'	,'(21) 5506-3341'	,'Guilherme'	,'A'	,'1971-9-10'	,'GuilhermeCastroGoncalves@armyspy.com'	,'Farmacêutico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Eduarda Almeida'	,'513.085.377-60'	,'Av. Paraná '	,773	,'Cidade Monções'	,'75515-240'	,'(64) 6223-9899'	,'Rodrigo'	,'A'	,'1990-6-23'	,'EduardaDiasAlmeida@teleworm.us'	,'Farmacêutico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Giovana Dias'	,'517.112.303-91'	,'Rua Projetada A '	,851	,'Parque do Horto'	,'68744-435'	,'(91) 9664-6805'	,'Sophia'	,'A'	,'1951-4-24'	,'GiovanaMartinsDias@teleworm.us'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Igor Martins'	,'248.181.609-97'	,'Rua Salvador Xavier Neto '	,1391	,'Borba Gato'	,'13843-273'	,'(16) 3260-4972'	,'Julieta'	,'A'	,'1986-5-26'	,'IgorRibeiroMartins@cuvox.de'	,'Farmacêutico'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Caio Cardoso'	,'466.144.113-30'	,'Rua Professor Adalberto Nicolli '	,1724	,'Hortênsia'	,'24445-640'	,'(21) 3680-8666'	,'Lavinia'	,'I'	,'1961-3-11'	,'CaioFerreiraCardoso@dayrep.com'	,'Farmacêutico'	,7);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marisa Pinto'	,'168.158.112-47'	,'Rua Paratinga '	,903	,'Hermann Moraes de Barros'	,'06711-350'	,'(11) 8408-6203'	,'Fábio'	,'A'	,'1976-11-9'	,'MarisaBarbosaPinto@teleworm.us'	,'Farmacêutico'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Daniel Pinto'	,'388.092.538-09'	,'Rua Diadema '	,1468	,'Borba Gato'	,'13214-192'	,'(11) 9440-3353'	,'Mateus'	,'A'	,'1998-4-14'	,'DanielMartinsPinto@dayrep.com'	,'Farmacêutico'	,9);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luis Dias'	,'355.991.967-39'	,'Rua Angelina '	,1825	,'Itaipu'	,'06780-040'	,'(11) 7284-4043'	,'Sarah'	,'I'	,'1976-1-14'	,'LuisRochaDias@teleworm.us'	,'Farmacêutico'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Martins'	,'818.810.863-48'	,'Rua Rui Barbosa - D '	,1077	,'Paris'	,'89801-042'	,'(49) 8602-3562'	,'Letícia'	,'A'	,'1985-4-16'	,'LucasLimaMartins@gustr.com'	,'Farmacêutico'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Douglas Dias'	,'272.505.890-24'	,'Rua Manoel Cordeiro Galvão '	,1444	,'Zona 02'	,'55018-350'	,'(81) 6448-4681'	,'Luana'	,'A'	,'1970-3-26'	,'DouglasCorreiaDias@jourrapide.com'	,'Farmacêutico'	,10);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Yasmin Castro'	,'146.236.701-12'	,'Rua Lopes da Costa '	,1644	,'Tarumã'	,'30881-390'	,'(31) 7439-6312'	,'Luís'	,'A'	,'1966-7-23'	,'YasminSouzaCastro@superrito.com'	,'Farmacêutico'	,11);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Enzo Melo'	,'572.853.092-30'	,'Rua Roque Gonzales '	,1198	,'Sumaré'	,'93290-000'	,'(51) 5475-7497'	,'Aline'	,'A'	,'1972-4-17'	,'EnzoSantosMelo@einrot.com'	,'Farmacêutico'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Marisa Ferreira'	,'838.756.620-91'	,'Rua Tutóia '	,1913	,'Paris'	,'64079-355'	,'(86) 7875-6834'	,'Douglas'	,'A'	,'1973-1-3'	,'MarisaRodriguesFerreira@fleckens.hu'	,'Farmacêutico'	,8);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lara Azevedo'	,'771.015.757-22'	,'Rua Martim Francisco '	,777	,'Andrade'	,'14050-260'	,'(16) 2299-7878'	,'Luana'	,'A'	,'1989-12-10'	,'LaraCorreiaAzevedo@fleckens.hu'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauê Barbosa'	,'508.860.589-70'	,'Rua Pedro Narcísio Castanheira '	,1891	,'Olímpico'	,'58046-320'	,'(83) 8908-8938'	,'Lucas'	,'A'	,'1964-8-21'	,'KauePereiraBarbosa@armyspy.com'	,'Farmacêutico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Pedro Rodrigues'	,'948.464.235-73'	,'Rua Pardal '	,1972	,'Parque Industrial'	,'04895-370'	,'(11) 9788-6222'	,'Maria'	,'A'	,'1962-1-3'	,'PedroFernandesRodrigues@cuvox.de'	,'Farmacêutico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Davi Souza'	,'888.569.408-09'	,'Av. Paraná '	,1694	,'Tarumã'	,'71805-814'	,'(61) 2845-6078'	,'Vitor'	,'A'	,'1959-11-12'	,'DaviCardosoSouza@jourrapide.com'	,'Farmacêutico'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Murilo Sousa'	,'990.446.540-12'	,'Av. Paraná '	,376	,'Parque Avenida'	,'72311-204'	,'(61) 5831-8788'	,'Ana'	,'A'	,'1962-8-12'	,'MuriloSilvaSousa@dayrep.com'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ágatha Ribeiro'	,'843.000.018-63'	,'Rua Felipe D'' Oliveira '	,855	,'Zona 06'	,'04340-080'	,'(11) 3882-9204'	,'Julieta'	,'I'	,'1990-3-26'	,'AgathaCorreiaRibeiro@dayrep.com'	,'Farmacêutico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Barros'	,'248.548.816-90'	,'Rua Arroio do Tigre '	,1024	,'Zona 01 - Centro'	,'94465-040'	,'(51) 9005-4891'	,'Luan'	,'A'	,'1950-3-4'	,'LucasCostaBarros@gustr.com'	,'Farmacêutico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitór Goncalves'	,'267.873.193-63'	,'Rua Tarira '	,453	,'Zona 08 - Bairro Aeroporto'	,'21371-540'	,'(21) 6007-8671'	,'Luis'	,'A'	,'1990-6-7'	,'VitorRochaGoncalves@rhyta.com'	,'Farmacêutico'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Isabella Oliveira'	,'698.664.906-10'	,'Rua Domingos Januário Balsamo '	,1619	,'Parque do Horto'	,'18051-070'	,'(15) 3965-8300'	,'Livia'	,'I'	,'1978-2-27'	,'IsabellaRochaOliveira@einrot.com'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Felipe Pinto'	,'431.003.823-90'	,'Rua Anselmo Pieri '	,923	,'Alvorada'	,'13803-802'	,'(16) 3548-8325'	,'Marina'	,'A'	,'1986-7-26'	,'FelipeSouzaPinto@teleworm.us'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Cauã Carvalho'	,'374.336.509-03'	,'Rua Coronel Antônio Fernandes Pacilha '	,586	,'Zona 02'	,'93120-640'	,'(51) 2760-4387'	,'Rafaela'	,'A'	,'1987-6-12'	,'CauaCardosoCarvalho@fleckens.hu'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ana Araujo'	,'665.005.859-92'	,'Rua Oito '	,1683	,'Alvorada'	,'54505-140'	,'(81) 7736-4412'	,'Julieta'	,'A'	,'1996-6-19'	,'AnaCavalcantiAraujo@jourrapide.com'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Matilde Lima'	,'168.582.937-60'	,'Travessa Palmeira '	,1265	,'Paris'	,'93295-760'	,'(51) 6552-8468'	,'Antônio'	,'A'	,'1996-6-18'	,'MatildePintoLima@jourrapide.com'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitoria Melo'	,'264.575.121-00'	,'Vila Porto '	,662	,'Hermann Moraes de Barros'	,'60510-041'	,'(85) 7415-6876'	,'Julian'	,'A'	,'1993-12-25'	,'VitoriaFerreiraMelo@teleworm.us'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Vitór Martins'	,'783.616.184-65'	,'Travessa Um '	,1836	,'Universo'	,'78055-778'	,'(65) 2717-8271'	,'Renan'	,'A'	,'1997-6-2'	,'VitorFerreiraMartins@jourrapide.com'	,'Farmacêutico'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Felipe Azevedo'	,'428.619.886-30'	,'Rua Olímpia Lemes da Silva '	,653	,'Zona 02'	,'05541-040'	,'(11) 8063-8186'	,'Antônio'	,'A'	,'1955-2-1'	,'FelipeRodriguesAzevedo@superrito.com'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Ana Costa'	,'209.776.752-46'	,'Travessa Regente Feijó '	,1359	,'Parque Bandeirantes'	,'62030-090'	,'(88) 5962-4212'	,'Pedro'	,'A'	,'1981-12-13'	,'AnaSouzaCosta@jourrapide.com'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Estevan Correia'	,'185.168.844-73'	,'Av. Paraná '	,1656	,'Andrade'	,'61635-150'	,'(85) 9922-7072'	,'Felipe'	,'A'	,'1993-5-4'	,'EstevanRodriguesCorreia@einrot.com'	,'Farmacêutico'	,6);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lucas Melo'	,'711.396.431-18'	,'Rua Serra Bonita '	,298	,'Zona 10'	,'25015-685'	,'(21) 2953-6521'	,'Anna'	,'A'	,'1969-10-11'	,'LucasRodriguesMelo@rhyta.com'	,'Farmacêutico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Lavinia Araujo'	,'650.238.987-25'	,'Rua Ítalo Balbo '	,610	,'Iguaçu'	,'02550-070'	,'(11) 2565-3327'	,'Estevan'	,'I'	,'1986-7-6'	,'LaviniaRochaAraujo@cuvox.de'	,'Farmacêutico'	,5);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Livia Pinto'	,'968.818.155-22'	,'Rua Joaquim Ribeiro '	,410	,'Zona 01 - Centro'	,'54771-325'	,'(81) 4820-6146'	,'Ryan'	,'A'	,'1989-10-17'	,'LiviaMartinsPinto@einrot.com'	,'Farmacêutico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Renan Costa'	,'102.972.756-23'	,'Rua Itacolomi '	,1823	,'Portal das Torres'	,'85501-240'	,'(46) 6605-9152'	,'Enzo'	,'A'	,'1951-6-5'	,'RenanPintoCosta@armyspy.com'	,'Farmacêutico'	,4);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Bruna Cavalcanti'	,'712.133.030-01'	,'Praça Doutor Willian Salomão '	,900	,'Mandacaru'	,'13343-649'	,'(19) 2043-8045'	,'Luiza'	,'I'	,'1992-7-22'	,'BrunaDiasCavalcanti@cuvox.de'	,'Farmacêutico'	,3);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Júlia Correia'	,'234.505.696-78'	,'Rua Treze '	,1827	,'Zona 02'	,'08584-280'	,'(11) 9057-4348'	,'Lucas'	,'A'	,'1981-5-4'	,'JuliaAlvesCorreia@rhyta.com'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Kauê Correia'	,'331.013.957-39'	,'Avenida Henrique Mansano '	,120	,'Ney Braga'	,'86079-450'	,'(43) 3148-6562'	,'Aline'	,'A'	,'1987-12-7'	,'KaueCavalcantiCorreia@rhyta.com'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Júlio Almeida'	,'650.296.302-10'	,'Rua Tacaimbó '	,1601	,'Parque Avenida'	,'54777-320'	,'(81) 8762-7227'	,'Leila'	,'A'	,'1989-7-27'	,'JulioPintoAlmeida@cuvox.de'	,'Farmacêutico'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Maria Martins'	,'585.601.519-31'	,'Rua Eneida de Morais '	,1550	,'Jardim Atami'	,'68628-588'	,'(91) 7273-8366'	,'Alex'	,'A'	,'1985-8-10'	,'MariaAraujoMartins@fleckens.hu'	,'Fotógrafo'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luis Pereira'	,'890.762.982-03'	,'Av. Paraná '	,1672	,'Laranjeiras'	,'13503-510'	,'(19) 5052-2660'	,'Thiago'	,'A'	,'1966-9-22'	,'LuisFernandesPereira@superrito.com'	,'Fotógrafo'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Luís Almeida'	,'738.533.650-78'	,'Rua Morretes '	,1167	,'Liberdade'	,'44036-080'	,'(75) 7453-5733'	,'Kauã'	,'A'	,'1974-2-15'	,'LuisRochaAlmeida@jourrapide.com'	,'Fotógrafo'	,2);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Julieta Pinto'	,'969.843.151-90'	,'Rua José Gomes Hespanha '	,1787	,'Tarumã'	,'15802-295'	,'(17) 8358-9690'	,'Eduardo'	,'A'	,'1983-8-1'	,'JulietaAraujoPinto@dayrep.com'	,'Fotógrafo'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Victor Oliveira'	,'300.744.467-54'	,'Rua Icarai '	,1792	,'Parque Avenida'	,'26387-020'	,'(21) 8232-6163'	,'Rafaela'	,'A'	,'1967-10-4'	,'VictorCostaOliveira@cuvox.de'	,'Fotógrafo'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Danilo Silva'	,'667.406.258-83'	,'Rua Monsenhor Soares '	,1581	,'Jardim Industrial'	,'18200-009'	,'(15) 7103-9941'	,'Emilly'	,'A'	,'1959-1-22'	,'DaniloDiasSilva@superrito.com'	,'Fotógrafo'	,1);				
INSERT INTO cliente (nome	,cpf_cnpj	,endereco	,endereco_numero	,endereco_bairro	,cep	,fone	,contato	,status	,data_nascimento	,email	,ocupacao	,cidade_id) VALUES ('Letícia Pinto'	,'382.647.349-36'	,'Rua Jacob Sens '	,1839	,'São Domingos'	,'88113-285'	,'(48) 4999-3657'	,'Murilo'	,'A'	,'1973-8-9'	,'LeticiaPereiraPinto@superrito.com'	,'Fotógrafo'	,1);			


INSERT INTO LINHA (NOME) VALUES ('ALIMENTOS E BEBIDAS');
INSERT INTO LINHA (NOME) VALUES ('ARTE E ANTIGUIDADE');
INSERT INTO LINHA (NOME) VALUES ('ARTIGOS RELIGIOSOS');
INSERT INTO LINHA (NOME) VALUES ('ASSINATURAS E REVISTAS');
INSERT INTO LINHA (NOME) VALUES ('AUTOMÓVEIS E VEÍCULOS');
INSERT INTO LINHA (NOME) VALUES ('BEBÊS E CIA');
INSERT INTO LINHA (NOME) VALUES ('BRINQUEDOS');
INSERT INTO LINHA (NOME) VALUES ('CASA E DECORAÇÃO');
INSERT INTO LINHA (NOME) VALUES ('CONSTRUÇÃO E FERRAMENTAS');
INSERT INTO LINHA (NOME) VALUES ('ELETRODOMÉSTICOS');
INSERT INTO LINHA (NOME) VALUES ('ELETRÔNICOS');
INSERT INTO LINHA (NOME) VALUES ('ESPORTE E LAZER');

INSERT INTO CATEGORIA (NOME) VALUES ('BEBIDA ALCOÓLICA');
INSERT INTO CATEGORIA (NOME) VALUES ('BEBIDA NÃO ALCOÓLICA');
INSERT INTO CATEGORIA (NOME) VALUES ('BOMBONIERE');
INSERT INTO CATEGORIA (NOME) VALUES ('CARNES');
INSERT INTO CATEGORIA (NOME) VALUES ('CESTA BÁSICA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHOCOTONE');
INSERT INTO CATEGORIA (NOME) VALUES ('CONGELADOS');
INSERT INTO CATEGORIA (NOME) VALUES ('FRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('HORTIFRUTIGRANJEIROS');
INSERT INTO CATEGORIA (NOME) VALUES ('LATICÍNIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MATINAIS');
INSERT INTO CATEGORIA (NOME) VALUES ('MERCEARIA');
INSERT INTO CATEGORIA (NOME) VALUES ('PADARIA / CONFEITARIA');
INSERT INTO CATEGORIA (NOME) VALUES ('PANETONE');
INSERT INTO CATEGORIA (NOME) VALUES ('PAPINHA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('SOBREMESAS / CONFEITARIA');
INSERT INTO CATEGORIA (NOME) VALUES ('CRISTAL / PORCELANA / VIDRO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESCULTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('FOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('GRAVURA');
INSERT INTO CATEGORIA (NOME) VALUES ('OBJETOS DE DECORAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ARTIGOS DE ARTE / ANTIGUIDADES');
INSERT INTO CATEGORIA (NOME) VALUES ('PAPEL');
INSERT INTO CATEGORIA (NOME) VALUES ('PEÇAS EM ARTESANATO');
INSERT INTO CATEGORIA (NOME) VALUES ('PEDRA');
INSERT INTO CATEGORIA (NOME) VALUES ('PEDRAS PRECIOSAS');
INSERT INTO CATEGORIA (NOME) VALUES ('PINTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('POSTER');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS BUDISTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS CATÓLICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS DE CANDOMBLÉ');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS DE UMBANDA');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS ESPÍRITAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS EVANGÉLICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS ISLÂMICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS JUDAICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('JOIAS RELIGIOSAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MÓVEIS PARA IGREJA');
INSERT INTO CATEGORIA (NOME) VALUES ('ÁLBUM DE FIGURINHAS');
INSERT INTO CATEGORIA (NOME) VALUES ('APOSTILA PARA CONCURSOS / CURSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSINATURAS DE JORNAIS');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSINATURAS DE REVISTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSINATURAS DE WEBSITES');
INSERT INTO CATEGORIA (NOME) VALUES ('REVISTAS AVULSAS');
INSERT INTO CATEGORIA (NOME) VALUES ('REVISTAS EM QUADRINHOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA AVIÕES');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA CAMINHÕES');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA CARRO');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA MOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA TRATORES');
INSERT INTO CATEGORIA (NOME) VALUES ('AUTOMÓVEL NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('AUTOMÓVEL USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('AVIÃO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMINHÃO NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMINHÃO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('CARRETA NOVA');
INSERT INTO CATEGORIA (NOME) VALUES ('CARRETA USADA');
INSERT INTO CATEGORIA (NOME) VALUES ('CARROS');
INSERT INTO CATEGORIA (NOME) VALUES ('CONSÓRCIO DE AUTOMÓVEIS');
INSERT INTO CATEGORIA (NOME) VALUES ('CONSÓRCIO DE MOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('HELICÓPTERO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('JET SKI');
INSERT INTO CATEGORIA (NOME) VALUES ('KART USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('MOTO NOVA');
INSERT INTO CATEGORIA (NOME) VALUES ('MOTO USADA');
INSERT INTO CATEGORIA (NOME) VALUES ('ÔNIBUS USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('QUADRICICLO NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('QUADRICICLO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS EM VEÍCULOS');
INSERT INTO CATEGORIA (NOME) VALUES ('SOM AUTOMOTIVO E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('TRATOR NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('TRATOR USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('TRICICLO NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('TRICICLO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('ÁLBUM DE FOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ANDADOR PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS DE SEGURANÇA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BABÁ ELETRÔNICA');
INSERT INTO CATEGORIA (NOME) VALUES ('BANHEIRA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BASE DE CADEIRA PARA AUTO');
INSERT INTO CATEGORIA (NOME) VALUES ('BERÇO');
INSERT INTO CATEGORIA (NOME) VALUES ('BOLSA / MALA / TROCADOR PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CADEIRA DE DESCANSO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CADEIRA PARA AUTO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMA / MESA / BANHO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CARRINHO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CERCADO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CHUPETA E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ENFEITE / DECORAÇÃO PARA QUARTO DO BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('FRALDA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('HIGIENE / SAÚDE PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('MAMADEIRA E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MODA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ARTIGOS PARA PRAIA E PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS CALÇADOS INFANTIS');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE COLOCAÇÃO DE REDE DE PROTEÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE DECORAÇÃO PARA QUARTO DO BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('TAPETES DE ATIVIDADES');
INSERT INTO CATEGORIA (NOME) VALUES ('TERMÔMETRO');
INSERT INTO CATEGORIA (NOME) VALUES ('UTENSÍLIOS DIVERSOS PARA A MAMÃE');
INSERT INTO CATEGORIA (NOME) VALUES ('UTENSÍLIOS PARA ALIMENTAÇÃO DO BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BICICLETA');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS EDUCATIVOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS ELETRÔNICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA MENINAS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA MENINOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA MENINOS / MENINAS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA PRAIA E PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('FANTASIAS / MÁSCARAS E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('GAMES');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGO DE CARIMBOS');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGO DE DOMINÓ');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DE CARTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DE RPG');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DIVERSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('KIT DE MÁGICAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MINIATURAS COLECIONÁVEIS');
INSERT INTO CATEGORIA (NOME) VALUES ('MODELISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('PELÚCIAS');
INSERT INTO CATEGORIA (NOME) VALUES ('PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('PLAYGROUND');
INSERT INTO CATEGORIA (NOME) VALUES ('TAPETES DE ATIVIDADES');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMA / MESA / BANHO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMA / MESA / BANHO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('ESOTÉRICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ILUMINAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('JARDINAGEM');
INSERT INTO CATEGORIA (NOME) VALUES ('MATERIAIS PARA LIMPEZA');
INSERT INTO CATEGORIA (NOME) VALUES ('MÓVEIS PARA CASA');
INSERT INTO CATEGORIA (NOME) VALUES ('MÓVEIS PARA ESCRITÓRIO');
INSERT INTO CATEGORIA (NOME) VALUES ('OBJETOS DE DECORAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('PRODUTOS PARA SEGURANÇA E VIGILÂNCIA');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE DECORAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('UTENSÍLIOS PARA BANHEIRO');
INSERT INTO CATEGORIA (NOME) VALUES ('UTILIDADES DOMÉSTICAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACABAMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('AGROBUSINESS');
INSERT INTO CATEGORIA (NOME) VALUES ('AQUECEDOR SOLAR');
INSERT INTO CATEGORIA (NOME) VALUES ('ARRANJOS / COROAS FÚNEBRES');
INSERT INTO CATEGORIA (NOME) VALUES ('BANHEIROS / COZINHAS');
INSERT INTO CATEGORIA (NOME) VALUES ('BETONEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('BOMBA DE VÁCUO');
INSERT INTO CATEGORIA (NOME) VALUES ('COMPONENTES ELETRÔNICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('FECHADURA');
INSERT INTO CATEGORIA (NOME) VALUES ('FERRAGENS');
INSERT INTO CATEGORIA (NOME) VALUES ('FERRAMENTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('HIDRÁULICA');
INSERT INTO CATEGORIA (NOME) VALUES ('INSTRUMENTOS DE MEDIÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('JARDINAGEM');
INSERT INTO CATEGORIA (NOME) VALUES ('MARCENARIA / HOBBY');
INSERT INTO CATEGORIA (NOME) VALUES ('MATERIAIS ELÉTRICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MATERIAL DE CONSTRUÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('PISOS / REVESTIMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('PORTAS / JANELAS');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS EM CONSTRUÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('TINTAS / ACESSÓRIOS PARA PINTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA ELETRODOMÉSTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ADEGA CLIMATIZADA');
INSERT INTO CATEGORIA (NOME) VALUES ('AQUECEDOR DE ÁGUA');
INSERT INTO CATEGORIA (NOME) VALUES ('AQUECEDOR DE AMBIENTE');
INSERT INTO CATEGORIA (NOME) VALUES ('AR CONDICIONADO');
INSERT INTO CATEGORIA (NOME) VALUES ('ASPIRADOR DE PÓ / ÁGUA');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSISTÊNCIA TÉCNICA PARA ELETRODOMÉSTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BATEDEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('BEBEDOURO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAFETEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHALEIRA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHOCOLATEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHUVEIRO / DUCHA');
INSERT INTO CATEGORIA (NOME) VALUES ('CLIMATIZADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('COIFA / EXAUSTOR');
INSERT INTO CATEGORIA (NOME) VALUES ('COOLER PARA BEBIDAS');
INSERT INTO CATEGORIA (NOME) VALUES ('CORTINA DE AR');
INSERT INTO CATEGORIA (NOME) VALUES ('DESUMIDIFICADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('ENCERADEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUIPAMENTOS PARA INDÚSTRIA ALIMENTÍCIA');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUIPAMENTOS PARA SUPERMERCADO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESPREMEDOR DE FRUTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ESTERILIZADOR / PURIFICADOR DE AR');
INSERT INTO CATEGORIA (NOME) VALUES ('EXPOSITOR REFRIGERADO');
INSERT INTO CATEGORIA (NOME) VALUES ('EXTRATOR DE SUCO');
INSERT INTO CATEGORIA (NOME) VALUES ('FÁBRICA DE MASSA');
INSERT INTO CATEGORIA (NOME) VALUES ('FACA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('FERRO DE PASSAR ROUPAS');
INSERT INTO CATEGORIA (NOME) VALUES ('FOGÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('FONTE / CASCATA DE CHOCOLATE');
INSERT INTO CATEGORIA (NOME) VALUES ('FORNO A GÁS');
INSERT INTO CATEGORIA (NOME) VALUES ('FORNO ELÉTRICO');
INSERT INTO CATEGORIA (NOME) VALUES ('FREEZER');
INSERT INTO CATEGORIA (NOME) VALUES ('FRIGOBAR');
INSERT INTO CATEGORIA (NOME) VALUES ('FRITADEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('GELADEIRA / REFRIGERADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('GRILL ELÉTRICO / SANDUICHEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('HIGIENIZADOR A VAPOR');
INSERT INTO CATEGORIA (NOME) VALUES ('IOGURTEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('LAVA LOUÇAS');
INSERT INTO CATEGORIA (NOME) VALUES ('LAVADORA DE ALTA PRESSÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('LAVADORA DE ROUPAS INDUSTRIAL');
INSERT INTO CATEGORIA (NOME) VALUES ('LIQUIDIFICADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE COSTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE CREPE');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE CUPCAKE');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE GÁS PARA BEBIDAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE GELO');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE LAVAR ROUPAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE SORVETE');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE WAFFLE');
INSERT INTO CATEGORIA (NOME) VALUES ('MICROONDAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MOEDOR DE CAFÉ');
INSERT INTO CATEGORIA (NOME) VALUES ('MOEDOR DE CARNE');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ELETRODOMÉSTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('PANELA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('PANIFICADORA DOMÉSTICA');
INSERT INTO CATEGORIA (NOME) VALUES ('PASSADEIRA A VAPOR');
INSERT INTO CATEGORIA (NOME) VALUES ('PIPOQUEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('PROCESSADORES DE ALIMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('PURIFICADOR DE ÁGUA');
INSERT INTO CATEGORIA (NOME) VALUES ('RALADOR ELÉTRICO');
INSERT INTO CATEGORIA (NOME) VALUES ('SECADORA DE ROUPAS');
INSERT INTO CATEGORIA (NOME) VALUES ('SECADORA DE ROUPAS INDUSTRIAL');
INSERT INTO CATEGORIA (NOME) VALUES ('TORRADEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('TRITURADOR DE ALIMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('UTILIDADES DOMÉSTICAS');
INSERT INTO CATEGORIA (NOME) VALUES ('VASSOURA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('VENTILADOR / CIRCULADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS PARA ÁUDIO / VÍDEO');
INSERT INTO CATEGORIA (NOME) VALUES ('AGENDA ELETRÔNICA');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSISTÊNCIA TÉCNICA PARA ELETRO-ELETRÔNICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BLU-RAY PLAYER / HD-DVD PLAYER');
INSERT INTO CATEGORIA (NOME) VALUES ('CALCULADORA');
INSERT INTO CATEGORIA (NOME) VALUES ('CÂMERA DIGITAL');
INSERT INTO CATEGORIA (NOME) VALUES ('CARTÃO DE MEMÓRIA');
INSERT INTO CATEGORIA (NOME) VALUES ('DVD PLAYER');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUIPAMENTOS DE SOM');
INSERT INTO CATEGORIA (NOME) VALUES ('FAX');
INSERT INTO CATEGORIA (NOME) VALUES ('FILMADORA');
INSERT INTO CATEGORIA (NOME) VALUES ('GAMES');
INSERT INTO CATEGORIA (NOME) VALUES ('GPS / ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('HOME THEATER / ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('LEITOR DE E-BOOK');
INSERT INTO CATEGORIA (NOME) VALUES ('MEDIA SERVER');
INSERT INTO CATEGORIA (NOME) VALUES ('MONITOR');
INSERT INTO CATEGORIA (NOME) VALUES ('NOTEBOOK');
INSERT INTO CATEGORIA (NOME) VALUES ('PRODUTOS PARA SEGURANÇA E VIGILÂNCIA');
INSERT INTO CATEGORIA (NOME) VALUES ('TABLET');
INSERT INTO CATEGORIA (NOME) VALUES ('TELEFONIA');
INSERT INTO CATEGORIA (NOME) VALUES ('TV');
INSERT INTO CATEGORIA (NOME) VALUES ('VÍDEO CASSETE');
INSERT INTO CATEGORIA (NOME) VALUES ('VIDEOKÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('WEBCAM');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS NÁUTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS PARA FLIPERAMA');
INSERT INTO CATEGORIA (NOME) VALUES ('AIR HOCKEY');
INSERT INTO CATEGORIA (NOME) VALUES ('APITO');
INSERT INTO CATEGORIA (NOME) VALUES ('ARCO E FLECHA');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTES MARCIAIS / LUTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ATLETISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('AUTÓDROMO / KARTÓDROMO');
INSERT INTO CATEGORIA (NOME) VALUES ('BADMINTON');
INSERT INTO CATEGORIA (NOME) VALUES ('BANDEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('BARCO');
INSERT INTO CATEGORIA (NOME) VALUES ('BASQUETE');
INSERT INTO CATEGORIA (NOME) VALUES ('BEISEBOL');
INSERT INTO CATEGORIA (NOME) VALUES ('BILHAR / SINUCA');
INSERT INTO CATEGORIA (NOME) VALUES ('BODYBOARD');
INSERT INTO CATEGORIA (NOME) VALUES ('BOLA DE HANDEBOL');
INSERT INTO CATEGORIA (NOME) VALUES ('BOMBA DE AR');
INSERT INTO CATEGORIA (NOME) VALUES ('BOTE INFLÁVEL');
INSERT INTO CATEGORIA (NOME) VALUES ('BUMERANGUE');
INSERT INTO CATEGORIA (NOME) VALUES ('CAÇA SUBMARINA');
INSERT INTO CATEGORIA (NOME) VALUES ('CAIAQUE');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMPING');
INSERT INTO CATEGORIA (NOME) VALUES ('CANIVETE');
INSERT INTO CATEGORIA (NOME) VALUES ('CANOA');
INSERT INTO CATEGORIA (NOME) VALUES ('CICLISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('DANÇA');
INSERT INTO CATEGORIA (NOME) VALUES ('ELETRÔNICOS PARA ESPORTE / LAZER');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUITAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESCALADA / MONTANHISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESPORTE - CURSOS / CLUBES / ESCOLAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ESQUI');
INSERT INTO CATEGORIA (NOME) VALUES ('ESQUI AQUÁTICO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESTÁDIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('FLIPERAMA');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEBOL');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEBOL AMERICANO');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEBOL DE BOTÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEVOLEI');
INSERT INTO CATEGORIA (NOME) VALUES ('GOLFE');
INSERT INTO CATEGORIA (NOME) VALUES ('HIDROGINÁSTICA');
INSERT INTO CATEGORIA (NOME) VALUES ('INGRESSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('INSTRUMENTOS ÓTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('JARDINAGEM');
INSERT INTO CATEGORIA (NOME) VALUES ('JET SKI');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGO DE PÔQUER');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DIVERSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('KART');
INSERT INTO CATEGORIA (NOME) VALUES ('MALABARES');
INSERT INTO CATEGORIA (NOME) VALUES ('MEDALHA');
INSERT INTO CATEGORIA (NOME) VALUES ('MERGULHO');
INSERT INTO CATEGORIA (NOME) VALUES ('MESA PARA JOGOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MINIATURAS COLECIONÁVEIS');
INSERT INTO CATEGORIA (NOME) VALUES ('MOCHILA');
INSERT INTO CATEGORIA (NOME) VALUES ('MODELISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('MOTOCROSS');
INSERT INTO CATEGORIA (NOME) VALUES ('MUSCULAÇÃO / GINÁSTICA');
INSERT INTO CATEGORIA (NOME) VALUES ('NATAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ARTIGOS DE ESPORTE / LAZER');
INSERT INTO CATEGORIA (NOME) VALUES ('PAINTBALL');
INSERT INTO CATEGORIA (NOME) VALUES ('PATINS');
INSERT INTO CATEGORIA (NOME) VALUES ('PEBOLIM');
INSERT INTO CATEGORIA (NOME) VALUES ('PESCA');
INSERT INTO CATEGORIA (NOME) VALUES ('PORTA-CHUTEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('PRAIA E PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('RODEIO');
INSERT INTO CATEGORIA (NOME) VALUES ('RUGBY');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE COLOCAÇÃO DE REDE DE PROTEÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('SKATE / ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('SNOWBOARD');
INSERT INTO CATEGORIA (NOME) VALUES ('SQUASH');
INSERT INTO CATEGORIA (NOME) VALUES ('SUPLEMENTO');
INSERT INTO CATEGORIA (NOME) VALUES ('SURF');
INSERT INTO CATEGORIA (NOME) VALUES ('TÊNIS DE CAMPO');
INSERT INTO CATEGORIA (NOME) VALUES ('TÊNIS DE MESA');
INSERT INTO CATEGORIA (NOME) VALUES ('TROFÉU');
INSERT INTO CATEGORIA (NOME) VALUES ('VESTUÁRIO ESPORTIVO');
INSERT INTO CATEGORIA (NOME) VALUES ('VÔLEI');
INSERT INTO CATEGORIA (NOME) VALUES ('WAKEBOARD');
INSERT INTO CATEGORIA (NOME) VALUES ('YOGA');

INSERT INTO CATEGORIA (NOME) VALUES ('BEBIDA ALCOÓLICA');
INSERT INTO CATEGORIA (NOME) VALUES ('BEBIDA NÃO ALCOÓLICA');
INSERT INTO CATEGORIA (NOME) VALUES ('BOMBONIERE');
INSERT INTO CATEGORIA (NOME) VALUES ('CARNES');
INSERT INTO CATEGORIA (NOME) VALUES ('CESTA BÁSICA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHOCOTONE');
INSERT INTO CATEGORIA (NOME) VALUES ('CONGELADOS');
INSERT INTO CATEGORIA (NOME) VALUES ('FRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('HORTIFRUTIGRANJEIROS');
INSERT INTO CATEGORIA (NOME) VALUES ('LATICÍNIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MATINAIS');
INSERT INTO CATEGORIA (NOME) VALUES ('MERCEARIA');
INSERT INTO CATEGORIA (NOME) VALUES ('PADARIA / CONFEITARIA');
INSERT INTO CATEGORIA (NOME) VALUES ('PANETONE');
INSERT INTO CATEGORIA (NOME) VALUES ('PAPINHA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('SOBREMESAS / CONFEITARIA');
INSERT INTO CATEGORIA (NOME) VALUES ('CRISTAL / PORCELANA / VIDRO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESCULTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('FOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('GRAVURA');
INSERT INTO CATEGORIA (NOME) VALUES ('OBJETOS DE DECORAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ARTIGOS DE ARTE / ANTIGUIDADES');
INSERT INTO CATEGORIA (NOME) VALUES ('PAPEL');
INSERT INTO CATEGORIA (NOME) VALUES ('PEÇAS EM ARTESANATO');
INSERT INTO CATEGORIA (NOME) VALUES ('PEDRA');
INSERT INTO CATEGORIA (NOME) VALUES ('PEDRAS PRECIOSAS');
INSERT INTO CATEGORIA (NOME) VALUES ('PINTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('POSTER');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS BUDISTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS CATÓLICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS DE CANDOMBLÉ');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS DE UMBANDA');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS ESPÍRITAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS EVANGÉLICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS ISLÂMICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS JUDAICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('JOIAS RELIGIOSAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MÓVEIS PARA IGREJA');
INSERT INTO CATEGORIA (NOME) VALUES ('ÁLBUM DE FIGURINHAS');
INSERT INTO CATEGORIA (NOME) VALUES ('APOSTILA PARA CONCURSOS / CURSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSINATURAS DE JORNAIS');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSINATURAS DE REVISTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSINATURAS DE WEBSITES');
INSERT INTO CATEGORIA (NOME) VALUES ('REVISTAS AVULSAS');
INSERT INTO CATEGORIA (NOME) VALUES ('REVISTAS EM QUADRINHOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA AVIÕES');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA CAMINHÕES');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA CARRO');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA MOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA TRATORES');
INSERT INTO CATEGORIA (NOME) VALUES ('AUTOMÓVEL NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('AUTOMÓVEL USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('AVIÃO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMINHÃO NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMINHÃO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('CARRETA NOVA');
INSERT INTO CATEGORIA (NOME) VALUES ('CARRETA USADA');
INSERT INTO CATEGORIA (NOME) VALUES ('CARROS');
INSERT INTO CATEGORIA (NOME) VALUES ('CONSÓRCIO DE AUTOMÓVEIS');
INSERT INTO CATEGORIA (NOME) VALUES ('CONSÓRCIO DE MOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('HELICÓPTERO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('JET SKI');
INSERT INTO CATEGORIA (NOME) VALUES ('KART USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('MOTO NOVA');
INSERT INTO CATEGORIA (NOME) VALUES ('MOTO USADA');
INSERT INTO CATEGORIA (NOME) VALUES ('ÔNIBUS USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('QUADRICICLO NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('QUADRICICLO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS EM VEÍCULOS');
INSERT INTO CATEGORIA (NOME) VALUES ('SOM AUTOMOTIVO E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('TRATOR NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('TRATOR USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('TRICICLO NOVO');
INSERT INTO CATEGORIA (NOME) VALUES ('TRICICLO USADO');
INSERT INTO CATEGORIA (NOME) VALUES ('ÁLBUM DE FOTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ANDADOR PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTIGOS DE SEGURANÇA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BABÁ ELETRÔNICA');
INSERT INTO CATEGORIA (NOME) VALUES ('BANHEIRA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BASE DE CADEIRA PARA AUTO');
INSERT INTO CATEGORIA (NOME) VALUES ('BERÇO');
INSERT INTO CATEGORIA (NOME) VALUES ('BOLSA / MALA / TROCADOR PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CADEIRA DE DESCANSO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CADEIRA PARA AUTO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMA / MESA / BANHO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CARRINHO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CERCADO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('CHUPETA E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ENFEITE / DECORAÇÃO PARA QUARTO DO BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('FRALDA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('HIGIENE / SAÚDE PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('MAMADEIRA E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MODA PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ARTIGOS PARA PRAIA E PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS CALÇADOS INFANTIS');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE COLOCAÇÃO DE REDE DE PROTEÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE DECORAÇÃO PARA QUARTO DO BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('TAPETES DE ATIVIDADES');
INSERT INTO CATEGORIA (NOME) VALUES ('TERMÔMETRO');
INSERT INTO CATEGORIA (NOME) VALUES ('UTENSÍLIOS DIVERSOS PARA A MAMÃE');
INSERT INTO CATEGORIA (NOME) VALUES ('UTENSÍLIOS PARA ALIMENTAÇÃO DO BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BICICLETA');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS EDUCATIVOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS ELETRÔNICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA MENINAS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA MENINOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA MENINOS / MENINAS');
INSERT INTO CATEGORIA (NOME) VALUES ('BRINQUEDOS PARA PRAIA E PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('FANTASIAS / MÁSCARAS E ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('GAMES');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGO DE CARIMBOS');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGO DE DOMINÓ');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DE CARTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DE RPG');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DIVERSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('KIT DE MÁGICAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MINIATURAS COLECIONÁVEIS');
INSERT INTO CATEGORIA (NOME) VALUES ('MODELISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('PELÚCIAS');
INSERT INTO CATEGORIA (NOME) VALUES ('PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('PLAYGROUND');
INSERT INTO CATEGORIA (NOME) VALUES ('TAPETES DE ATIVIDADES');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMA / MESA / BANHO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMA / MESA / BANHO PARA BEBÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('ESOTÉRICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ILUMINAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('JARDINAGEM');
INSERT INTO CATEGORIA (NOME) VALUES ('MATERIAIS PARA LIMPEZA');
INSERT INTO CATEGORIA (NOME) VALUES ('MÓVEIS PARA CASA');
INSERT INTO CATEGORIA (NOME) VALUES ('MÓVEIS PARA ESCRITÓRIO');
INSERT INTO CATEGORIA (NOME) VALUES ('OBJETOS DE DECORAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('PRODUTOS PARA SEGURANÇA E VIGILÂNCIA');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE DECORAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('UTENSÍLIOS PARA BANHEIRO');
INSERT INTO CATEGORIA (NOME) VALUES ('UTILIDADES DOMÉSTICAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACABAMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('AGROBUSINESS');
INSERT INTO CATEGORIA (NOME) VALUES ('AQUECEDOR SOLAR');
INSERT INTO CATEGORIA (NOME) VALUES ('ARRANJOS / COROAS FÚNEBRES');
INSERT INTO CATEGORIA (NOME) VALUES ('BANHEIROS / COZINHAS');
INSERT INTO CATEGORIA (NOME) VALUES ('BETONEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('BOMBA DE VÁCUO');
INSERT INTO CATEGORIA (NOME) VALUES ('COMPONENTES ELETRÔNICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('FECHADURA');
INSERT INTO CATEGORIA (NOME) VALUES ('FERRAGENS');
INSERT INTO CATEGORIA (NOME) VALUES ('FERRAMENTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('HIDRÁULICA');
INSERT INTO CATEGORIA (NOME) VALUES ('INSTRUMENTOS DE MEDIÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('JARDINAGEM');
INSERT INTO CATEGORIA (NOME) VALUES ('MARCENARIA / HOBBY');
INSERT INTO CATEGORIA (NOME) VALUES ('MATERIAIS ELÉTRICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MATERIAL DE CONSTRUÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('PISOS / REVESTIMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('PORTAS / JANELAS');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS EM CONSTRUÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('TINTAS / ACESSÓRIOS PARA PINTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS / PEÇAS PARA ELETRODOMÉSTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ADEGA CLIMATIZADA');
INSERT INTO CATEGORIA (NOME) VALUES ('AQUECEDOR DE ÁGUA');
INSERT INTO CATEGORIA (NOME) VALUES ('AQUECEDOR DE AMBIENTE');
INSERT INTO CATEGORIA (NOME) VALUES ('AR CONDICIONADO');
INSERT INTO CATEGORIA (NOME) VALUES ('ASPIRADOR DE PÓ / ÁGUA');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSISTÊNCIA TÉCNICA PARA ELETRODOMÉSTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BATEDEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('BEBEDOURO');
INSERT INTO CATEGORIA (NOME) VALUES ('CAFETEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHALEIRA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHOCOLATEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('CHUVEIRO / DUCHA');
INSERT INTO CATEGORIA (NOME) VALUES ('CLIMATIZADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('COIFA / EXAUSTOR');
INSERT INTO CATEGORIA (NOME) VALUES ('COOLER PARA BEBIDAS');
INSERT INTO CATEGORIA (NOME) VALUES ('CORTINA DE AR');
INSERT INTO CATEGORIA (NOME) VALUES ('DESUMIDIFICADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('ENCERADEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUIPAMENTOS PARA INDÚSTRIA ALIMENTÍCIA');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUIPAMENTOS PARA SUPERMERCADO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESPREMEDOR DE FRUTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ESTERILIZADOR / PURIFICADOR DE AR');
INSERT INTO CATEGORIA (NOME) VALUES ('EXPOSITOR REFRIGERADO');
INSERT INTO CATEGORIA (NOME) VALUES ('EXTRATOR DE SUCO');
INSERT INTO CATEGORIA (NOME) VALUES ('FÁBRICA DE MASSA');
INSERT INTO CATEGORIA (NOME) VALUES ('FACA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('FERRO DE PASSAR ROUPAS');
INSERT INTO CATEGORIA (NOME) VALUES ('FOGÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('FONTE / CASCATA DE CHOCOLATE');
INSERT INTO CATEGORIA (NOME) VALUES ('FORNO A GÁS');
INSERT INTO CATEGORIA (NOME) VALUES ('FORNO ELÉTRICO');
INSERT INTO CATEGORIA (NOME) VALUES ('FREEZER');
INSERT INTO CATEGORIA (NOME) VALUES ('FRIGOBAR');
INSERT INTO CATEGORIA (NOME) VALUES ('FRITADEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('GELADEIRA / REFRIGERADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('GRILL ELÉTRICO / SANDUICHEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('HIGIENIZADOR A VAPOR');
INSERT INTO CATEGORIA (NOME) VALUES ('IOGURTEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('LAVA LOUÇAS');
INSERT INTO CATEGORIA (NOME) VALUES ('LAVADORA DE ALTA PRESSÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('LAVADORA DE ROUPAS INDUSTRIAL');
INSERT INTO CATEGORIA (NOME) VALUES ('LIQUIDIFICADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE COSTURA');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE CREPE');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE CUPCAKE');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE GÁS PARA BEBIDAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE GELO');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE LAVAR ROUPAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE SORVETE');
INSERT INTO CATEGORIA (NOME) VALUES ('MÁQUINA DE WAFFLE');
INSERT INTO CATEGORIA (NOME) VALUES ('MICROONDAS');
INSERT INTO CATEGORIA (NOME) VALUES ('MOEDOR DE CAFÉ');
INSERT INTO CATEGORIA (NOME) VALUES ('MOEDOR DE CARNE');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ELETRODOMÉSTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('PANELA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('PANIFICADORA DOMÉSTICA');
INSERT INTO CATEGORIA (NOME) VALUES ('PASSADEIRA A VAPOR');
INSERT INTO CATEGORIA (NOME) VALUES ('PIPOQUEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('PROCESSADORES DE ALIMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('PURIFICADOR DE ÁGUA');
INSERT INTO CATEGORIA (NOME) VALUES ('RALADOR ELÉTRICO');
INSERT INTO CATEGORIA (NOME) VALUES ('SECADORA DE ROUPAS');
INSERT INTO CATEGORIA (NOME) VALUES ('SECADORA DE ROUPAS INDUSTRIAL');
INSERT INTO CATEGORIA (NOME) VALUES ('TORRADEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('TRITURADOR DE ALIMENTOS');
INSERT INTO CATEGORIA (NOME) VALUES ('UTILIDADES DOMÉSTICAS');
INSERT INTO CATEGORIA (NOME) VALUES ('VASSOURA ELÉTRICA');
INSERT INTO CATEGORIA (NOME) VALUES ('VENTILADOR / CIRCULADOR');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS PARA ÁUDIO / VÍDEO');
INSERT INTO CATEGORIA (NOME) VALUES ('AGENDA ELETRÔNICA');
INSERT INTO CATEGORIA (NOME) VALUES ('ASSISTÊNCIA TÉCNICA PARA ELETRO-ELETRÔNICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('BLU-RAY PLAYER / HD-DVD PLAYER');
INSERT INTO CATEGORIA (NOME) VALUES ('CALCULADORA');
INSERT INTO CATEGORIA (NOME) VALUES ('CÂMERA DIGITAL');
INSERT INTO CATEGORIA (NOME) VALUES ('CARTÃO DE MEMÓRIA');
INSERT INTO CATEGORIA (NOME) VALUES ('DVD PLAYER');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUIPAMENTOS DE SOM');
INSERT INTO CATEGORIA (NOME) VALUES ('FAX');
INSERT INTO CATEGORIA (NOME) VALUES ('FILMADORA');
INSERT INTO CATEGORIA (NOME) VALUES ('GAMES');
INSERT INTO CATEGORIA (NOME) VALUES ('GPS / ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('HOME THEATER / ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('LEITOR DE E-BOOK');
INSERT INTO CATEGORIA (NOME) VALUES ('MEDIA SERVER');
INSERT INTO CATEGORIA (NOME) VALUES ('MONITOR');
INSERT INTO CATEGORIA (NOME) VALUES ('NOTEBOOK');
INSERT INTO CATEGORIA (NOME) VALUES ('PRODUTOS PARA SEGURANÇA E VIGILÂNCIA');
INSERT INTO CATEGORIA (NOME) VALUES ('TABLET');
INSERT INTO CATEGORIA (NOME) VALUES ('TELEFONIA');
INSERT INTO CATEGORIA (NOME) VALUES ('TV');
INSERT INTO CATEGORIA (NOME) VALUES ('VÍDEO CASSETE');
INSERT INTO CATEGORIA (NOME) VALUES ('VIDEOKÊ');
INSERT INTO CATEGORIA (NOME) VALUES ('WEBCAM');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS NÁUTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('ACESSÓRIOS PARA FLIPERAMA');
INSERT INTO CATEGORIA (NOME) VALUES ('AIR HOCKEY');
INSERT INTO CATEGORIA (NOME) VALUES ('APITO');
INSERT INTO CATEGORIA (NOME) VALUES ('ARCO E FLECHA');
INSERT INTO CATEGORIA (NOME) VALUES ('ARTES MARCIAIS / LUTAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ATLETISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('AUTÓDROMO / KARTÓDROMO');
INSERT INTO CATEGORIA (NOME) VALUES ('BADMINTON');
INSERT INTO CATEGORIA (NOME) VALUES ('BANDEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('BARCO');
INSERT INTO CATEGORIA (NOME) VALUES ('BASQUETE');
INSERT INTO CATEGORIA (NOME) VALUES ('BEISEBOL');
INSERT INTO CATEGORIA (NOME) VALUES ('BILHAR / SINUCA');
INSERT INTO CATEGORIA (NOME) VALUES ('BODYBOARD');
INSERT INTO CATEGORIA (NOME) VALUES ('BOLA DE HANDEBOL');
INSERT INTO CATEGORIA (NOME) VALUES ('BOMBA DE AR');
INSERT INTO CATEGORIA (NOME) VALUES ('BOTE INFLÁVEL');
INSERT INTO CATEGORIA (NOME) VALUES ('BUMERANGUE');
INSERT INTO CATEGORIA (NOME) VALUES ('CAÇA SUBMARINA');
INSERT INTO CATEGORIA (NOME) VALUES ('CAIAQUE');
INSERT INTO CATEGORIA (NOME) VALUES ('CAMPING');
INSERT INTO CATEGORIA (NOME) VALUES ('CANIVETE');
INSERT INTO CATEGORIA (NOME) VALUES ('CANOA');
INSERT INTO CATEGORIA (NOME) VALUES ('CICLISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('DANÇA');
INSERT INTO CATEGORIA (NOME) VALUES ('ELETRÔNICOS PARA ESPORTE / LAZER');
INSERT INTO CATEGORIA (NOME) VALUES ('EQUITAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESCALADA / MONTANHISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESPORTE - CURSOS / CLUBES / ESCOLAS');
INSERT INTO CATEGORIA (NOME) VALUES ('ESQUI');
INSERT INTO CATEGORIA (NOME) VALUES ('ESQUI AQUÁTICO');
INSERT INTO CATEGORIA (NOME) VALUES ('ESTÁDIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('FLIPERAMA');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEBOL');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEBOL AMERICANO');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEBOL DE BOTÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('FUTEVOLEI');
INSERT INTO CATEGORIA (NOME) VALUES ('GOLFE');
INSERT INTO CATEGORIA (NOME) VALUES ('HIDROGINÁSTICA');
INSERT INTO CATEGORIA (NOME) VALUES ('INGRESSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('INSTRUMENTOS ÓTICOS');
INSERT INTO CATEGORIA (NOME) VALUES ('JARDINAGEM');
INSERT INTO CATEGORIA (NOME) VALUES ('JET SKI');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGO DE PÔQUER');
INSERT INTO CATEGORIA (NOME) VALUES ('JOGOS DIVERSOS');
INSERT INTO CATEGORIA (NOME) VALUES ('KART');
INSERT INTO CATEGORIA (NOME) VALUES ('MALABARES');
INSERT INTO CATEGORIA (NOME) VALUES ('MEDALHA');
INSERT INTO CATEGORIA (NOME) VALUES ('MERGULHO');
INSERT INTO CATEGORIA (NOME) VALUES ('MESA PARA JOGOS');
INSERT INTO CATEGORIA (NOME) VALUES ('MINIATURAS COLECIONÁVEIS');
INSERT INTO CATEGORIA (NOME) VALUES ('MOCHILA');
INSERT INTO CATEGORIA (NOME) VALUES ('MODELISMO');
INSERT INTO CATEGORIA (NOME) VALUES ('MOTOCROSS');
INSERT INTO CATEGORIA (NOME) VALUES ('MUSCULAÇÃO / GINÁSTICA');
INSERT INTO CATEGORIA (NOME) VALUES ('NATAÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('OUTROS ARTIGOS DE ESPORTE / LAZER');
INSERT INTO CATEGORIA (NOME) VALUES ('PAINTBALL');
INSERT INTO CATEGORIA (NOME) VALUES ('PATINS');
INSERT INTO CATEGORIA (NOME) VALUES ('PEBOLIM');
INSERT INTO CATEGORIA (NOME) VALUES ('PESCA');
INSERT INTO CATEGORIA (NOME) VALUES ('PORTA-CHUTEIRA');
INSERT INTO CATEGORIA (NOME) VALUES ('PRAIA E PISCINA');
INSERT INTO CATEGORIA (NOME) VALUES ('RODEIO');
INSERT INTO CATEGORIA (NOME) VALUES ('RUGBY');
INSERT INTO CATEGORIA (NOME) VALUES ('SERVIÇOS DE COLOCAÇÃO DE REDE DE PROTEÇÃO');
INSERT INTO CATEGORIA (NOME) VALUES ('SKATE / ACESSÓRIOS');
INSERT INTO CATEGORIA (NOME) VALUES ('SNOWBOARD');
INSERT INTO CATEGORIA (NOME) VALUES ('SQUASH');
INSERT INTO CATEGORIA (NOME) VALUES ('SUPLEMENTO');
INSERT INTO CATEGORIA (NOME) VALUES ('SURF');
INSERT INTO CATEGORIA (NOME) VALUES ('TÊNIS DE CAMPO');
INSERT INTO CATEGORIA (NOME) VALUES ('TÊNIS DE MESA');
INSERT INTO CATEGORIA (NOME) VALUES ('TROFÉU');
INSERT INTO CATEGORIA (NOME) VALUES ('VESTUÁRIO ESPORTIVO');
INSERT INTO CATEGORIA (NOME) VALUES ('VÔLEI');
INSERT INTO CATEGORIA (NOME) VALUES ('WAKEBOARD');
INSERT INTO CATEGORIA (NOME) VALUES ('YOGA');


INSERT INTO LINHA_CATEGORIA VALUES(1,1);
INSERT INTO LINHA_CATEGORIA VALUES(1,2);
INSERT INTO LINHA_CATEGORIA VALUES(1,3);
INSERT INTO LINHA_CATEGORIA VALUES(1,4);
INSERT INTO LINHA_CATEGORIA VALUES(1,5);
INSERT INTO LINHA_CATEGORIA VALUES(1,6);
INSERT INTO LINHA_CATEGORIA VALUES(1,7);
INSERT INTO LINHA_CATEGORIA VALUES(1,8);
INSERT INTO LINHA_CATEGORIA VALUES(1,9);
INSERT INTO LINHA_CATEGORIA VALUES(1,10);
INSERT INTO LINHA_CATEGORIA VALUES(1,11);
INSERT INTO LINHA_CATEGORIA VALUES(1,12);
INSERT INTO LINHA_CATEGORIA VALUES(1,13);
INSERT INTO LINHA_CATEGORIA VALUES(1,14);
INSERT INTO LINHA_CATEGORIA VALUES(1,15);
INSERT INTO LINHA_CATEGORIA VALUES(1,16);
INSERT INTO LINHA_CATEGORIA VALUES(2,17);
INSERT INTO LINHA_CATEGORIA VALUES(2,18);
INSERT INTO LINHA_CATEGORIA VALUES(2,19);
INSERT INTO LINHA_CATEGORIA VALUES(2,20);
INSERT INTO LINHA_CATEGORIA VALUES(2,21);
INSERT INTO LINHA_CATEGORIA VALUES(2,22);
INSERT INTO LINHA_CATEGORIA VALUES(2,23);
INSERT INTO LINHA_CATEGORIA VALUES(2,24);
INSERT INTO LINHA_CATEGORIA VALUES(2,25);
INSERT INTO LINHA_CATEGORIA VALUES(2,26);
INSERT INTO LINHA_CATEGORIA VALUES(2,27);
INSERT INTO LINHA_CATEGORIA VALUES(2,28);
INSERT INTO LINHA_CATEGORIA VALUES(3,29);
INSERT INTO LINHA_CATEGORIA VALUES(3,30);
INSERT INTO LINHA_CATEGORIA VALUES(3,31);
INSERT INTO LINHA_CATEGORIA VALUES(3,32);
INSERT INTO LINHA_CATEGORIA VALUES(3,33);
INSERT INTO LINHA_CATEGORIA VALUES(3,34);
INSERT INTO LINHA_CATEGORIA VALUES(3,35);
INSERT INTO LINHA_CATEGORIA VALUES(3,36);
INSERT INTO LINHA_CATEGORIA VALUES(3,37);
INSERT INTO LINHA_CATEGORIA VALUES(3,38);
INSERT INTO LINHA_CATEGORIA VALUES(4,39);
INSERT INTO LINHA_CATEGORIA VALUES(4,40);
INSERT INTO LINHA_CATEGORIA VALUES(4,41);
INSERT INTO LINHA_CATEGORIA VALUES(4,42);
INSERT INTO LINHA_CATEGORIA VALUES(4,43);
INSERT INTO LINHA_CATEGORIA VALUES(4,44);
INSERT INTO LINHA_CATEGORIA VALUES(4,45);
INSERT INTO LINHA_CATEGORIA VALUES(5,46);
INSERT INTO LINHA_CATEGORIA VALUES(5,47);
INSERT INTO LINHA_CATEGORIA VALUES(5,48);
INSERT INTO LINHA_CATEGORIA VALUES(5,49);
INSERT INTO LINHA_CATEGORIA VALUES(5,50);
INSERT INTO LINHA_CATEGORIA VALUES(5,51);
INSERT INTO LINHA_CATEGORIA VALUES(5,52);
INSERT INTO LINHA_CATEGORIA VALUES(5,53);
INSERT INTO LINHA_CATEGORIA VALUES(5,54);
INSERT INTO LINHA_CATEGORIA VALUES(5,55);
INSERT INTO LINHA_CATEGORIA VALUES(5,56);
INSERT INTO LINHA_CATEGORIA VALUES(5,57);
INSERT INTO LINHA_CATEGORIA VALUES(5,58);
INSERT INTO LINHA_CATEGORIA VALUES(5,59);
INSERT INTO LINHA_CATEGORIA VALUES(5,60);
INSERT INTO LINHA_CATEGORIA VALUES(5,61);
INSERT INTO LINHA_CATEGORIA VALUES(5,62);
INSERT INTO LINHA_CATEGORIA VALUES(5,63);
INSERT INTO LINHA_CATEGORIA VALUES(5,64);
INSERT INTO LINHA_CATEGORIA VALUES(5,65);
INSERT INTO LINHA_CATEGORIA VALUES(5,66);
INSERT INTO LINHA_CATEGORIA VALUES(5,67);
INSERT INTO LINHA_CATEGORIA VALUES(5,68);
INSERT INTO LINHA_CATEGORIA VALUES(5,69);
INSERT INTO LINHA_CATEGORIA VALUES(5,70);
INSERT INTO LINHA_CATEGORIA VALUES(5,71);
INSERT INTO LINHA_CATEGORIA VALUES(5,72);
INSERT INTO LINHA_CATEGORIA VALUES(5,73);
INSERT INTO LINHA_CATEGORIA VALUES(5,74);
INSERT INTO LINHA_CATEGORIA VALUES(6,75);
INSERT INTO LINHA_CATEGORIA VALUES(6,76);
INSERT INTO LINHA_CATEGORIA VALUES(6,77);
INSERT INTO LINHA_CATEGORIA VALUES(6,78);
INSERT INTO LINHA_CATEGORIA VALUES(6,79);
INSERT INTO LINHA_CATEGORIA VALUES(6,80);
INSERT INTO LINHA_CATEGORIA VALUES(6,81);
INSERT INTO LINHA_CATEGORIA VALUES(6,82);
INSERT INTO LINHA_CATEGORIA VALUES(6,83);
INSERT INTO LINHA_CATEGORIA VALUES(6,84);
INSERT INTO LINHA_CATEGORIA VALUES(6,85);
INSERT INTO LINHA_CATEGORIA VALUES(6,86);
INSERT INTO LINHA_CATEGORIA VALUES(6,87);
INSERT INTO LINHA_CATEGORIA VALUES(6,88);
INSERT INTO LINHA_CATEGORIA VALUES(6,89);
INSERT INTO LINHA_CATEGORIA VALUES(6,90);
INSERT INTO LINHA_CATEGORIA VALUES(6,91);
INSERT INTO LINHA_CATEGORIA VALUES(6,92);
INSERT INTO LINHA_CATEGORIA VALUES(6,93);
INSERT INTO LINHA_CATEGORIA VALUES(6,94);
INSERT INTO LINHA_CATEGORIA VALUES(6,95);
INSERT INTO LINHA_CATEGORIA VALUES(6,96);
INSERT INTO LINHA_CATEGORIA VALUES(6,97);
INSERT INTO LINHA_CATEGORIA VALUES(6,98);
INSERT INTO LINHA_CATEGORIA VALUES(6,99);
INSERT INTO LINHA_CATEGORIA VALUES(6,100);
INSERT INTO LINHA_CATEGORIA VALUES(6,101);
INSERT INTO LINHA_CATEGORIA VALUES(6,102);
INSERT INTO LINHA_CATEGORIA VALUES(7,103);
INSERT INTO LINHA_CATEGORIA VALUES(7,104);
INSERT INTO LINHA_CATEGORIA VALUES(7,105);
INSERT INTO LINHA_CATEGORIA VALUES(7,106);
INSERT INTO LINHA_CATEGORIA VALUES(7,107);
INSERT INTO LINHA_CATEGORIA VALUES(7,108);
INSERT INTO LINHA_CATEGORIA VALUES(7,109);
INSERT INTO LINHA_CATEGORIA VALUES(7,110);
INSERT INTO LINHA_CATEGORIA VALUES(7,111);
INSERT INTO LINHA_CATEGORIA VALUES(7,112);
INSERT INTO LINHA_CATEGORIA VALUES(7,113);
INSERT INTO LINHA_CATEGORIA VALUES(7,114);
INSERT INTO LINHA_CATEGORIA VALUES(7,115);
INSERT INTO LINHA_CATEGORIA VALUES(7,116);
INSERT INTO LINHA_CATEGORIA VALUES(7,117);
INSERT INTO LINHA_CATEGORIA VALUES(7,118);
INSERT INTO LINHA_CATEGORIA VALUES(7,119);
INSERT INTO LINHA_CATEGORIA VALUES(7,120);
INSERT INTO LINHA_CATEGORIA VALUES(7,121);
INSERT INTO LINHA_CATEGORIA VALUES(7,122);
INSERT INTO LINHA_CATEGORIA VALUES(7,123);
INSERT INTO LINHA_CATEGORIA VALUES(7,124);
INSERT INTO LINHA_CATEGORIA VALUES(8,125);
INSERT INTO LINHA_CATEGORIA VALUES(8,126);
INSERT INTO LINHA_CATEGORIA VALUES(8,127);
INSERT INTO LINHA_CATEGORIA VALUES(8,128);
INSERT INTO LINHA_CATEGORIA VALUES(8,129);
INSERT INTO LINHA_CATEGORIA VALUES(8,130);
INSERT INTO LINHA_CATEGORIA VALUES(8,131);
INSERT INTO LINHA_CATEGORIA VALUES(8,132);
INSERT INTO LINHA_CATEGORIA VALUES(8,133);
INSERT INTO LINHA_CATEGORIA VALUES(8,134);
INSERT INTO LINHA_CATEGORIA VALUES(8,135);
INSERT INTO LINHA_CATEGORIA VALUES(8,136);
INSERT INTO LINHA_CATEGORIA VALUES(8,137);
INSERT INTO LINHA_CATEGORIA VALUES(9,138);
INSERT INTO LINHA_CATEGORIA VALUES(9,139);
INSERT INTO LINHA_CATEGORIA VALUES(9,140);
INSERT INTO LINHA_CATEGORIA VALUES(9,141);
INSERT INTO LINHA_CATEGORIA VALUES(9,142);
INSERT INTO LINHA_CATEGORIA VALUES(9,143);
INSERT INTO LINHA_CATEGORIA VALUES(9,144);
INSERT INTO LINHA_CATEGORIA VALUES(9,145);
INSERT INTO LINHA_CATEGORIA VALUES(9,146);
INSERT INTO LINHA_CATEGORIA VALUES(9,147);
INSERT INTO LINHA_CATEGORIA VALUES(9,148);
INSERT INTO LINHA_CATEGORIA VALUES(9,149);
INSERT INTO LINHA_CATEGORIA VALUES(9,150);
INSERT INTO LINHA_CATEGORIA VALUES(9,151);
INSERT INTO LINHA_CATEGORIA VALUES(9,152);
INSERT INTO LINHA_CATEGORIA VALUES(9,153);
INSERT INTO LINHA_CATEGORIA VALUES(9,154);
INSERT INTO LINHA_CATEGORIA VALUES(9,155);
INSERT INTO LINHA_CATEGORIA VALUES(9,156);
INSERT INTO LINHA_CATEGORIA VALUES(9,157);
INSERT INTO LINHA_CATEGORIA VALUES(9,158);
INSERT INTO LINHA_CATEGORIA VALUES(10,159);
INSERT INTO LINHA_CATEGORIA VALUES(10,160);
INSERT INTO LINHA_CATEGORIA VALUES(10,161);
INSERT INTO LINHA_CATEGORIA VALUES(10,162);
INSERT INTO LINHA_CATEGORIA VALUES(10,163);
INSERT INTO LINHA_CATEGORIA VALUES(10,164);
INSERT INTO LINHA_CATEGORIA VALUES(10,165);
INSERT INTO LINHA_CATEGORIA VALUES(10,166);
INSERT INTO LINHA_CATEGORIA VALUES(10,167);
INSERT INTO LINHA_CATEGORIA VALUES(10,168);
INSERT INTO LINHA_CATEGORIA VALUES(10,169);
INSERT INTO LINHA_CATEGORIA VALUES(10,170);
INSERT INTO LINHA_CATEGORIA VALUES(10,171);
INSERT INTO LINHA_CATEGORIA VALUES(10,172);
INSERT INTO LINHA_CATEGORIA VALUES(10,173);
INSERT INTO LINHA_CATEGORIA VALUES(10,174);
INSERT INTO LINHA_CATEGORIA VALUES(10,175);
INSERT INTO LINHA_CATEGORIA VALUES(10,176);
INSERT INTO LINHA_CATEGORIA VALUES(10,177);
INSERT INTO LINHA_CATEGORIA VALUES(10,178);
INSERT INTO LINHA_CATEGORIA VALUES(10,179);
INSERT INTO LINHA_CATEGORIA VALUES(10,180);
INSERT INTO LINHA_CATEGORIA VALUES(10,181);
INSERT INTO LINHA_CATEGORIA VALUES(10,182);
INSERT INTO LINHA_CATEGORIA VALUES(10,183);
INSERT INTO LINHA_CATEGORIA VALUES(10,184);
INSERT INTO LINHA_CATEGORIA VALUES(10,185);
INSERT INTO LINHA_CATEGORIA VALUES(10,186);
INSERT INTO LINHA_CATEGORIA VALUES(10,187);
INSERT INTO LINHA_CATEGORIA VALUES(10,188);
INSERT INTO LINHA_CATEGORIA VALUES(10,189);
INSERT INTO LINHA_CATEGORIA VALUES(10,190);
INSERT INTO LINHA_CATEGORIA VALUES(10,191);
INSERT INTO LINHA_CATEGORIA VALUES(10,192);
INSERT INTO LINHA_CATEGORIA VALUES(10,193);
INSERT INTO LINHA_CATEGORIA VALUES(10,194);
INSERT INTO LINHA_CATEGORIA VALUES(10,195);
INSERT INTO LINHA_CATEGORIA VALUES(10,196);
INSERT INTO LINHA_CATEGORIA VALUES(10,197);
INSERT INTO LINHA_CATEGORIA VALUES(10,198);
INSERT INTO LINHA_CATEGORIA VALUES(10,199);
INSERT INTO LINHA_CATEGORIA VALUES(10,200);
INSERT INTO LINHA_CATEGORIA VALUES(10,201);
INSERT INTO LINHA_CATEGORIA VALUES(10,202);
INSERT INTO LINHA_CATEGORIA VALUES(10,203);
INSERT INTO LINHA_CATEGORIA VALUES(10,204);
INSERT INTO LINHA_CATEGORIA VALUES(10,205);
INSERT INTO LINHA_CATEGORIA VALUES(10,206);
INSERT INTO LINHA_CATEGORIA VALUES(10,207);
INSERT INTO LINHA_CATEGORIA VALUES(10,208);
INSERT INTO LINHA_CATEGORIA VALUES(10,209);
INSERT INTO LINHA_CATEGORIA VALUES(10,210);
INSERT INTO LINHA_CATEGORIA VALUES(10,211);
INSERT INTO LINHA_CATEGORIA VALUES(10,212);
INSERT INTO LINHA_CATEGORIA VALUES(10,213);
INSERT INTO LINHA_CATEGORIA VALUES(10,214);
INSERT INTO LINHA_CATEGORIA VALUES(10,215);
INSERT INTO LINHA_CATEGORIA VALUES(10,216);
INSERT INTO LINHA_CATEGORIA VALUES(10,217);
INSERT INTO LINHA_CATEGORIA VALUES(10,218);
INSERT INTO LINHA_CATEGORIA VALUES(10,219);
INSERT INTO LINHA_CATEGORIA VALUES(10,220);
INSERT INTO LINHA_CATEGORIA VALUES(10,221);
INSERT INTO LINHA_CATEGORIA VALUES(10,222);
INSERT INTO LINHA_CATEGORIA VALUES(10,223);
INSERT INTO LINHA_CATEGORIA VALUES(10,224);
INSERT INTO LINHA_CATEGORIA VALUES(10,225);
INSERT INTO LINHA_CATEGORIA VALUES(10,226);
INSERT INTO LINHA_CATEGORIA VALUES(10,227);
INSERT INTO LINHA_CATEGORIA VALUES(11,228);
INSERT INTO LINHA_CATEGORIA VALUES(11,229);
INSERT INTO LINHA_CATEGORIA VALUES(11,230);
INSERT INTO LINHA_CATEGORIA VALUES(11,231);
INSERT INTO LINHA_CATEGORIA VALUES(11,232);
INSERT INTO LINHA_CATEGORIA VALUES(11,233);
INSERT INTO LINHA_CATEGORIA VALUES(11,234);
INSERT INTO LINHA_CATEGORIA VALUES(11,235);
INSERT INTO LINHA_CATEGORIA VALUES(11,236);
INSERT INTO LINHA_CATEGORIA VALUES(11,237);
INSERT INTO LINHA_CATEGORIA VALUES(11,238);
INSERT INTO LINHA_CATEGORIA VALUES(11,239);
INSERT INTO LINHA_CATEGORIA VALUES(11,240);
INSERT INTO LINHA_CATEGORIA VALUES(11,241);
INSERT INTO LINHA_CATEGORIA VALUES(11,242);
INSERT INTO LINHA_CATEGORIA VALUES(11,243);
INSERT INTO LINHA_CATEGORIA VALUES(11,244);
INSERT INTO LINHA_CATEGORIA VALUES(11,245);
INSERT INTO LINHA_CATEGORIA VALUES(11,246);
INSERT INTO LINHA_CATEGORIA VALUES(11,247);
INSERT INTO LINHA_CATEGORIA VALUES(11,248);
INSERT INTO LINHA_CATEGORIA VALUES(11,249);
INSERT INTO LINHA_CATEGORIA VALUES(11,250);
INSERT INTO LINHA_CATEGORIA VALUES(11,251);
INSERT INTO LINHA_CATEGORIA VALUES(11,252);
INSERT INTO LINHA_CATEGORIA VALUES(12,253);
INSERT INTO LINHA_CATEGORIA VALUES(12,254);
INSERT INTO LINHA_CATEGORIA VALUES(12,255);
INSERT INTO LINHA_CATEGORIA VALUES(12,256);
INSERT INTO LINHA_CATEGORIA VALUES(12,257);
INSERT INTO LINHA_CATEGORIA VALUES(12,258);
INSERT INTO LINHA_CATEGORIA VALUES(12,259);
INSERT INTO LINHA_CATEGORIA VALUES(12,260);
INSERT INTO LINHA_CATEGORIA VALUES(12,261);
INSERT INTO LINHA_CATEGORIA VALUES(12,262);
INSERT INTO LINHA_CATEGORIA VALUES(12,263);
INSERT INTO LINHA_CATEGORIA VALUES(12,264);
INSERT INTO LINHA_CATEGORIA VALUES(12,265);
INSERT INTO LINHA_CATEGORIA VALUES(12,266);
INSERT INTO LINHA_CATEGORIA VALUES(12,267);
INSERT INTO LINHA_CATEGORIA VALUES(12,268);
INSERT INTO LINHA_CATEGORIA VALUES(12,269);
INSERT INTO LINHA_CATEGORIA VALUES(12,270);
INSERT INTO LINHA_CATEGORIA VALUES(12,271);
INSERT INTO LINHA_CATEGORIA VALUES(12,272);
INSERT INTO LINHA_CATEGORIA VALUES(12,273);
INSERT INTO LINHA_CATEGORIA VALUES(12,274);
INSERT INTO LINHA_CATEGORIA VALUES(12,275);
INSERT INTO LINHA_CATEGORIA VALUES(12,276);
INSERT INTO LINHA_CATEGORIA VALUES(12,277);
INSERT INTO LINHA_CATEGORIA VALUES(12,278);
INSERT INTO LINHA_CATEGORIA VALUES(12,279);
INSERT INTO LINHA_CATEGORIA VALUES(12,280);
INSERT INTO LINHA_CATEGORIA VALUES(12,281);
INSERT INTO LINHA_CATEGORIA VALUES(12,282);
INSERT INTO LINHA_CATEGORIA VALUES(12,283);
INSERT INTO LINHA_CATEGORIA VALUES(12,284);
INSERT INTO LINHA_CATEGORIA VALUES(12,285);
INSERT INTO LINHA_CATEGORIA VALUES(12,286);
INSERT INTO LINHA_CATEGORIA VALUES(12,287);
INSERT INTO LINHA_CATEGORIA VALUES(12,288);
INSERT INTO LINHA_CATEGORIA VALUES(12,289);
INSERT INTO LINHA_CATEGORIA VALUES(12,290);
INSERT INTO LINHA_CATEGORIA VALUES(12,291);
INSERT INTO LINHA_CATEGORIA VALUES(12,292);
INSERT INTO LINHA_CATEGORIA VALUES(12,293);
INSERT INTO LINHA_CATEGORIA VALUES(12,294);
INSERT INTO LINHA_CATEGORIA VALUES(12,295);
INSERT INTO LINHA_CATEGORIA VALUES(12,296);
INSERT INTO LINHA_CATEGORIA VALUES(12,297);
INSERT INTO LINHA_CATEGORIA VALUES(12,298);
INSERT INTO LINHA_CATEGORIA VALUES(12,299);
INSERT INTO LINHA_CATEGORIA VALUES(12,300);
INSERT INTO LINHA_CATEGORIA VALUES(12,301);
INSERT INTO LINHA_CATEGORIA VALUES(12,302);
INSERT INTO LINHA_CATEGORIA VALUES(12,303);
INSERT INTO LINHA_CATEGORIA VALUES(12,304);
INSERT INTO LINHA_CATEGORIA VALUES(12,305);
INSERT INTO LINHA_CATEGORIA VALUES(12,306);
INSERT INTO LINHA_CATEGORIA VALUES(12,307);
INSERT INTO LINHA_CATEGORIA VALUES(12,308);
INSERT INTO LINHA_CATEGORIA VALUES(12,309);
INSERT INTO LINHA_CATEGORIA VALUES(12,310);
INSERT INTO LINHA_CATEGORIA VALUES(12,311);
INSERT INTO LINHA_CATEGORIA VALUES(12,312);
INSERT INTO LINHA_CATEGORIA VALUES(12,313);
INSERT INTO LINHA_CATEGORIA VALUES(12,314);
INSERT INTO LINHA_CATEGORIA VALUES(12,315);
INSERT INTO LINHA_CATEGORIA VALUES(12,316);
INSERT INTO LINHA_CATEGORIA VALUES(12,317);
INSERT INTO LINHA_CATEGORIA VALUES(12,318);
INSERT INTO LINHA_CATEGORIA VALUES(12,319);
INSERT INTO LINHA_CATEGORIA VALUES(12,320);
INSERT INTO LINHA_CATEGORIA VALUES(12,321);
INSERT INTO LINHA_CATEGORIA VALUES(12,322);
INSERT INTO LINHA_CATEGORIA VALUES(12,323);
INSERT INTO LINHA_CATEGORIA VALUES(12,324);
INSERT INTO LINHA_CATEGORIA VALUES(12,325);
INSERT INTO LINHA_CATEGORIA VALUES(12,326);
INSERT INTO LINHA_CATEGORIA VALUES(12,327);
INSERT INTO LINHA_CATEGORIA VALUES(12,328);
INSERT INTO LINHA_CATEGORIA VALUES(12,329);
INSERT INTO LINHA_CATEGORIA VALUES(12,330);
INSERT INTO LINHA_CATEGORIA VALUES(12,331);

INSERT INTO UMEDIDA (NOME,SIGLA) VALUES ('LITRO','L');
INSERT INTO UMEDIDA (NOME,SIGLA) VALUES ('MILILITRO','ML');
INSERT INTO UMEDIDA (NOME,SIGLA) VALUES ('UNIDADE','UN');
INSERT INTO UMEDIDA (NOME,SIGLA) VALUES ('QUILOGRAMA','KG');
INSERT INTO UMEDIDA (NOME,SIGLA) VALUES ('METRO LINEAR','MT');
INSERT INTO UMEDIDA (NOME,SIGLA) VALUES ('METRO QUADRADO','M2');
INSERT INTO UMEDIDA (NOME,SIGLA) VALUES ('METRO CÚBICO','M3');

INSERT INTO MARCA (NOME) VALUES ('COCA-COLA');
INSERT INTO MARCA (NOME) VALUES ('COCA-COLA ZERO');
INSERT INTO MARCA (NOME) VALUES ('FANTA LARANJA');
INSERT INTO MARCA (NOME) VALUES ('GUARANÁ ANTARCTICA');
INSERT INTO MARCA (NOME) VALUES ('PEPSI');
INSERT INTO MARCA (NOME) VALUES ('SKOL');
INSERT INTO MARCA (NOME) VALUES ('BRAHMA');
INSERT INTO MARCA (NOME) VALUES ('KAISER');

INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 2 L',			'',	  2,01,4.50,6.07,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA LATA 350 ML',				'', 350,01,1.58,2.99,'S',1,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 600 ML',			'', 600,01,2.19,3.99,'S',1,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 2,5 L',			'',	2.5,01,4.50,6.07,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 1,5 L',			'',	1.5,01,3.19,5.49,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA LATA 250 ML',				'',	250,01,1.01,2.45,'S',1,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 2 L 6 UNIDADES',	'',   2,06,29.90,35.50,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 1 L',			'',   1,01,2.79,3.79,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 250 ML',			'', 250,01,1.39,1.49,'S',1,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 3 L',			'',   3,01,5.21,7.65,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA GARRAFA PET 500 ML',			'',	500,01,2.89,3.21,'S',1,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA LATA 350 ML 12 UNIDADES',	'',	350,12,21.30,26.9,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('REFRIGERANTE COCA-COLA LATA 350 ML 6 UNIDADES',		'', 350,06,10.45,14.46,'S',1,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LATA 473 ML 1 UNIDADES','', 476,1, 2.19, 4.99,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LATA 350 ML 1 UNIDADES','', 350,1, 1.66, 3.49,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LONG NECK 355 ML 1 UNIDADES','', 355,1, 2.05, 3.10,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LATA 269 ML 1 UNIDADES','', 296,1, 1.40, 1.99,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LATA 350 ML 12 UNIDADES','', 350,12,20.00,35.99,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN GARRAFA 1000 ML 1 UNIDADE','', 1,1, 4.12, 4.38,'S',6,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LONG NECK 250 ML 1 UNIDADE','', 250,1, 1.68, 1.75,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL 360° PILSEN LATA 350 ML 1 UNIDADE','', 350,1, 2.19, 2.82,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LATA 269 ML 15 UNIDADES','', 269,15,21.50,29.85,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN GARRAFA 600 ML 1 UNIDADE','', 600,1, 2.58, 3.60,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('SKOL 1 LITRO CAIXA COM 12 UNIDADES','', 1,12,49.50,60.70,'S',6,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('SKOL LONG NECK 24 UNIDADES','', 350,24,48.50,55.00,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('SKOL LATÃO 473 ML','', 320,1, 2.20, 4.50,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('SKOL 330ML','', 330,1, 3.22, 4.00,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL LATA 269ML','', 269,1, 1.99, 3.50,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL LATA 269ML PCT 15 UNIDADES','', 269,15,24.75,27.00,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL LATA 350ML PCT 12 UNIDADES','', 350,12,31.99,37.20,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL LATÃO 473ML PCT 12 UNIDADES','', 473,12,42.55,49.99,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA LATA SKOL 350ML','', 350,1, 2.19, 3.78,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL LT 550ML','', 550,1, 2.35, 3.50,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN ONE WAY 300ML','', 300,1, 1.49, 2.79,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL 1L C / CASC','', 1,1, 4.99, 5.60,'S',6,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL LATA 350ML CX COM 12UN','', 350,1,22.67,26.77,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA SKOL PILSEN LATA 350ML','', 350,1, 2.47, 3.20,'S',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA AK LATÃO 473ML PCT 12 UNIDADES','', 473,12,42.55,49.99,'N',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA LATA AK 350ML','', 350,1, 2.19, 3.78,'N',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA AK LT 550ML','', 550,1, 2.35, 3.50,'N',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA AK PILSEN ONE WAY 300ML','', 300,1, 1.49, 2.79,'N',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA AK 1L C / CASC','', 1,1, 4.99, 5.60,'N',6,2);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA AK LATA 350ML CX COM 12UN','', 350,1,22.67,26.77,'N',6,1);
INSERT INTO PRODUTO (NOME,DESCRICAO,CONTEUDO,UNIDADE,PRECO_CUSTO,PRECO_VENDA,CONTROLA_LOTE,MARCA_ID,UMEDIDA_ID) VALUES ('CERVEJA AK PILSEN LATA 350ML','', 350,1, 2.47, 3.20,'N',6,1);



INSERT INTO PRODUTO_CATEGORIA VALUES (01,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (02,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (03,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (04,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (05,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (06,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (07,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (08,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (09,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (10,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (11,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (12,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (13,02);
INSERT INTO PRODUTO_CATEGORIA VALUES (14,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (15,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (16,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (17,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (18,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (19,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (20,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (21,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (22,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (23,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (24,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (25,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (26,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (27,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (28,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (29,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (30,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (31,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (32,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (33,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (34,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (35,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (36,01);
INSERT INTO PRODUTO_CATEGORIA VALUES (37,01);

INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À VISTA',1,'S');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 1+1',2,'S');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 1+2',3,'S');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 1+3',4,'S');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 1+4',5,'S');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 1+5',6,'S');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 0+1',1,'N');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 0+2',2,'N');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 0+3',3,'N');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 0+4',4,'N');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 0+5',5,'N');
INSERT INTO FPAGAMENTO (DESCRICAO,QTDE_PARCELAS,ENTRADA) VALUES ('À PRAZO 0+6',6,'N');

INSERT INTO tipo (nome, descricao) VALUES ('INDUSTRIAL','');
INSERT INTO tipo (nome, descricao) VALUES ('INDUSTRIAL TIPO A','');
INSERT INTO tipo (nome, descricao) VALUES ('INDUSTRIAL TIPO B','');
INSERT INTO tipo (nome, descricao) VALUES ('INDUSTRIAL TIPO C','');
 

INSERT INTO PRODUTO_TIPO VALUES (20,04);
INSERT INTO PRODUTO_TIPO VALUES (21,01);
INSERT INTO PRODUTO_TIPO VALUES (22,01);
INSERT INTO PRODUTO_TIPO VALUES (23,03);
INSERT INTO PRODUTO_TIPO VALUES (24,03);
INSERT INTO PRODUTO_TIPO VALUES (25,04);
INSERT INTO PRODUTO_TIPO VALUES (26,01);
INSERT INTO PRODUTO_TIPO VALUES (27,01);
INSERT INTO PRODUTO_TIPO VALUES (28,01);
INSERT INTO PRODUTO_TIPO VALUES (29,01);
INSERT INTO PRODUTO_TIPO VALUES (30,01);
INSERT INTO PRODUTO_TIPO VALUES (31,01);
INSERT INTO PRODUTO_TIPO VALUES (32,01);
INSERT INTO PRODUTO_TIPO VALUES (33,03);
INSERT INTO PRODUTO_TIPO VALUES (34,01);
INSERT INTO PRODUTO_TIPO VALUES (35,03);
INSERT INTO PRODUTO_TIPO VALUES (36,01);
INSERT INTO PRODUTO_TIPO VALUES (37,01);
INSERT INTO PRODUTO_TIPO VALUES (01,02);
INSERT INTO PRODUTO_TIPO VALUES (02,01);
INSERT INTO PRODUTO_TIPO VALUES (03,02);
INSERT INTO PRODUTO_TIPO VALUES (04,02);
INSERT INTO PRODUTO_TIPO VALUES (05,02);
INSERT INTO PRODUTO_TIPO VALUES (06,01);
INSERT INTO PRODUTO_TIPO VALUES (07,02);
INSERT INTO PRODUTO_TIPO VALUES (08,02);
INSERT INTO PRODUTO_TIPO VALUES (09,02);
INSERT INTO PRODUTO_TIPO VALUES (10,02);
INSERT INTO PRODUTO_TIPO VALUES (11,02);
INSERT INTO PRODUTO_TIPO VALUES (12,01);
INSERT INTO PRODUTO_TIPO VALUES (13,01);
INSERT INTO PRODUTO_TIPO VALUES (14,01);
INSERT INTO PRODUTO_TIPO VALUES (15,01);
INSERT INTO PRODUTO_TIPO VALUES (16,04);
INSERT INTO PRODUTO_TIPO VALUES (17,01);
INSERT INTO PRODUTO_TIPO VALUES (18,01);
INSERT INTO PRODUTO_TIPO VALUES (19,01);


-- antes demais nada é importante conhecer o contexto e os dados
-- listar todos os estados (select simples)
SELECT * FROM estado; 

-- listar todas as cidades 
SELECT * FROM cidades;

-- listar os nomes dos estados e cidades  
SELECT e.nome estado, c.cidade cidade 
FROM estado e, cidade c 
WHERE e.id = c.estado_id;
   -- (conte quantas cidades tem em cada estado)
   -- (conte quantos grupos tem)

-- GROUP BY 
-- listar o nome de estado e quantas cidades cada estado tem
SELECT e.nome estado, COUNT(c.id)  
FROM estado e, cidade c 
WHERE e.id = c.estado_id
GROUP BY e.id;


/*
PRESTE ATENÇÃO
Após o agrupamento não podemos listar linhas únicas em cada grupo, visto que, cada linha terá um grupo
Mas, podemos utilizar funções de agrupamento como MAX, MIN, AVG e GROUP_CONCAT
*/

-- outras funções max, mim, média
SELECT p.nome, MAX(p.preco_custo), MIN(p.preco_custo), AVG(p.preco_custo)
FROM produto p, produto_categori pc, categoria c
WHERE p.id = pc_produto_id 
	AND pc.categoria_id = c.id
GROUP BY p.id;

-- >>TOME CUIDDO EM ESCOLHER A COLUNA DE AGRUPAMENTO<< - EXEMPLO VERA CRUZ
SELECT cid.nome cidade, COUNT(cli.id)  
FROM cidade cid, cliente cli
WHERE cid.id = cli.cidade_id
GROUP BY cid.nome;  -- >>>> nome de cidade não é única → isso pode gerar resultados errados, pois poderá agrupar cidades diferentes com nomes iguais.

/*
EXERCÍCIOS
01) Listar o nome de cidade e quantos fornecedores tem.
02) Listar o nome de cidade e quantos clientes tem.
03) Listar o nome de cidade e quantos funcionários tem.
04) Listar o nome de cidade e os nomes dos fornecedores de cada cidade.
05) Listar o nome de estado e quantos clientes tem. 
06) Listar o nome de cidade e os nomes dos funcionários de cada cidade 
07) Listar o nome de estado e quantos funcionários tem em cada estado. Mostre somente os estados que apresentam mais que 3 funcionários.
08) Listar o nome de estado e quantos clientes tem em cada estado. Mostre somente os estados da região sul e que apresentam mais que 5 clientes em cada estado.
09) Listar o nome das categorias dos produtos que nunca foram vendidos.
10) Listar o nome das categorias dos produtos e quantos produtos tem em cada categoria. Apresente somente as categorias que tem a quantidade de prodtuos maior que a média da categoria.
11) De acordo com o script executado, elabore 5 consultas utilizando GROUP BY que podem ajudar a empresa. Exeplique.
12) De acordo com o seu estudo de caso, elabore 5 consultas utilizando GROUP BY que podem ajudar a empresa. Exeplique.
13) De acordo com o seu estudo de caso, faça pelo menos 3 exemplos de consultas utilizando GROUP BY e LEFT/RIGHT JOIN que podem ajudar a empresa. Exeplique.
*/


