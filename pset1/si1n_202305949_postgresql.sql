

--EXCLUIR O BANCO DE DADOS UVV CASO JA EXISTA

DROP DATABASE IF EXISTS uvv;

--EXCLUIR O USUARIO SE JA EXISTIR

DROP USER IF EXISTS luizzatta;

--CRIANDO USUARIO PARA SER DONO DO BANCO DE DADOS

CREATE USER luizzatta WITH
CREATEDB
CREATEROLE
INHERIT
ENCRYPTED PASSWORD 'luiz';


--CRIANDO O BANCO DE DADOS UVV

CREATE DATABASE uvv WITH 
TEMPLATE = 'template0'
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = 'true'
OWNER = 'luizzatta';

--PARA FAZER CONEXAO COM O BANCO DE DADOS

\c "dbname=uvv user=luizzatta password=luiz"
SET ROLE luizzatta;


--CRIANDO SCHEMA

CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION luizzatta;


--DEFINIÇAO PADRAO PARA LOJAS

SET SEARCH_PATH TO lojas, "$user", public;


--ALTERAÇAO DE USUARIO

ALTER USER luizzatta
SET SEARCH_PATH TO lojas, "$user", public;








--CRIAÇAO DA TABELA PRODUTOS

CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produto PRIMARY KEY (produto_id)
                
                --COMENTARIOS DA TABELA PRODUTOS
);
COMMENT ON TABLE produtos IS 'armazena os dados dos produtos';
COMMENT ON COLUMN produtos.produto_id IS 'armazena o id do produto';
COMMENT ON COLUMN produtos.nome IS 'armazena o nome dos produtos';
COMMENT ON COLUMN produtos.preco_unitario IS 'armazena o preço de apenas um produto';
COMMENT ON COLUMN produtos.detalhes IS 'armazena detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'armazena a imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'armazena dados da imagem que a web nao identifica';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'armazena o arquivo da imagem';
COMMENT ON COLUMN produtos.imagem_charset IS 'armazena os caracteres da imagem';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'armazena a data da ultima atualizaçao feita';



--CRIAÇAO DA TANELA LOJAS

CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_loja PRIMARY KEY (loja_id)
                
                
 --COMENTARIOS DA TABELA LOJAS               
);
COMMENT ON TABLE lojas IS 'armazena os dados da loja';
COMMENT ON COLUMN lojas.loja_id IS 'armazena o id da loja';
COMMENT ON COLUMN lojas.nome IS 'armazena os nomes das lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'armazena o endereço web da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'armazena o endereço fisico da loja';
COMMENT ON COLUMN lojas.latitude IS 'armazena a latitude da loja';
COMMENT ON COLUMN lojas.longitude IS 'armazena a latitude da loja';
COMMENT ON COLUMN lojas.logo IS 'armazena a logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'armazena dados que a web nao consegue interpretar';
COMMENT ON COLUMN lojas.logo_arquivo IS 'armazena os arquivos da logo';
COMMENT ON COLUMN lojas.logo_charset IS 'armazena os caracteres da logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'armazena a data da ultima atualizaçao feita';



--CRIAÇAO DA TABELA ESTOQUES

CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoque PRIMARY KEY (estoque_id)
                
                
 --COMENTARIOS DA TABELA ESTOQUES   
                
);
COMMENT ON TABLE estoques IS 'armazena os produtos em estoque';
COMMENT ON COLUMN estoques.estoque_id IS 'armazena o id dos produtos em estoque';
COMMENT ON COLUMN estoques.quantidade IS 'armazena a quantidade em estoque';
COMMENT ON COLUMN estoques.produto_id IS 'armazena o id do produto em estoque';
COMMENT ON COLUMN estoques.loja_id IS 'armazena o id da loja';





--CRIAÇAO DA TABELA CLIENTES

CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                email VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_cliente PRIMARY KEY (cliente_id)
                
                
--COMENTARIOS DA TABELA CLIENTES                
                
);
COMMENT ON TABLE clientes IS 'armazena os clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'armazena o id dos clientes';
COMMENT ON COLUMN clientes.nome IS 'armazena os nomes dos clientes';
COMMENT ON COLUMN clientes.email IS 'armazena os emails';
COMMENT ON COLUMN clientes.telefone1 IS 'armazena o telefone de contato principal do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'armazena um telefone secundario para contato do cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'armazena um terceiro telefone para contato do cliente';





--CRIAÇAO DA TABELA ENVIOS

CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envio PRIMARY KEY (envio_id),
                
                
                --CRIAÇAO DA CHECK STATUS ENVIO
                
                CONSTRAINT ck_envios_status
                CHECK (status IN ('CRIADO','ENVIADO','TRANSITO','ENTREGUE')));
               
             
                
                
--COMENTARIOS DA TABELA ENVIOS                
                

COMMENT ON TABLE envios IS 'armazena os envios';
COMMENT ON COLUMN envios.envio_id IS 'armazena o id de envio';
COMMENT ON COLUMN envios.endereco_entrega IS 'armazena o endereço para o envio';
COMMENT ON COLUMN envios.cliente_id IS 'armazena o id do cliente para envio';
COMMENT ON COLUMN envios.loja_id IS 'armazena o id da loja para envio';
COMMENT ON COLUMN envios.status IS 'armazena o status do envio';



--CRIAÇAO DA TABELA PEDIDOS

CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedido PRIMARY KEY (pedido_id),
                
                
                --CRIAÇAO DA CHECK STATUS DO PEDIDO
                
                CONSTRAINT ck_pedidos_status
                CHECK (status IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO')));
                
                
 --COMENTARIOS DA TABELA PEDIDOS               
                

COMMENT ON TABLE pedidos IS 'armazena os pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'armazeno o id dos pedidos';
COMMENT ON COLUMN pedidos.data_hora IS 'armazena a hora e data do pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'armazena o id do cliente que fez o pedido';
COMMENT ON COLUMN pedidos.status IS 'armazena o status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'armazena o id da loja que fez o pedido';



--CRIAÇAO DA TABELA PEDIDOS ITENS

CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_pk PRIMARY KEY (pedido_id, produto_id)
                
                
 --COMENTARIOS DA TABELA PEDIDOS ITENS       
                
);
COMMENT ON TABLE pedidos_itens IS 'armazena os itens pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'armazena o id dos itens pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'armazena o id do produto pedido';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'armazena o numero da linha em que o produto foi pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'preço dos itens pedidos';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'armazena a quantidade de itens pedidos';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'armazena o id de envio';


--RELACIONAMENTO DA TABELA ESTOQUES COM A TABELA PRODUTOS

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--RELACIONAMENTO DA TABELA PEDIDOS ITENS COM A TABELA PEDIDOS

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--RELACIONAMENTO DA TABELA ENVIOS COM A TABELA LOJAS

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--RELACIONAMENTO DA TABELA ESTOQUES COM A TABELA LOJAS

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--RELACIONAMENTO DA TABELA PEDIDOS COM A TABELA LOJAS

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--RELACIONAMENTO DA TABELA PEDIDOS COM A TABELA CLIENTES

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--RELACIONAMENTO DA TABELA ENVIOS COM A TABELA CLIENTES

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--RELACIONAMENTO DA TABELA PEDIDOS ITENS COM A TABELA ENVIOS

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--RELACIONAMENTO DA TABELA PEDIDOS ITENS COM A TABELA PEDIDOS

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
