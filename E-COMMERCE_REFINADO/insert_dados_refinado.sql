-- Criação do banco de dados para um E-commerce - Estrutura Refinada
-- Esta seção cria um banco de dados para armazenar informações de um sistema de e-commerce.

-- DROP DATABASE IF EXISTS ecommerce;
-- Verifica se um banco de dados chamado "ecommerce" já existe e, se existir, exclui-o.

CREATE DATABASE IF NOT EXISTS ecommerce;
-- Cria um novo banco de dados chamado "ecommerce" se ele ainda não existir.

USE ecommerce;
-- Seleciona o banco de dados "ecommerce" para uso.

-- Tabela de Produtos
-- Esta tabela contém detalhes sobre os produtos disponíveis no e-commerce.

CREATE TABLE produtos (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nomeProduto VARCHAR(100) NOT NULL,
    categoria ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    descricao TEXT,
    valor DECIMAL(10, 2) NOT NULL,
    avaliacao DECIMAL(3, 2) NOT NULL DEFAULT 0
);

-- Tabela de Fornecedores
-- Esta tabela armazena informações sobre os fornecedores dos produtos.

CREATE TABLE fornecedores (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    razaoSocial VARCHAR(100) NOT NULL,
    contato CHAR(11) NOT NULL
);

-- Tabela de Vendedores
-- Esta tabela registra informações sobre os vendedores.

CREATE TABLE vendedores (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE,
    cpf CHAR(11) UNIQUE,
    localidade VARCHAR(50),
    nomeFantasia VARCHAR(100)
);

-- Tabela de Estoque
-- Esta tabela mantém o controle do estoque de produtos.

CREATE TABLE estoqueProdutos (
    idProduto INT,
    quantidade INT DEFAULT 0,
    localidade VARCHAR(50),
    PRIMARY KEY (idProduto, localidade),
    FOREIGN KEY (idProduto) REFERENCES produtos(idProduto)
);

-- Tabela de Clientes
-- Esta tabela armazena informações sobre os clientes do e-commerce.

CREATE TABLE clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    tipoCliente ENUM('Pessoa Física', 'Pessoa Jurídica') NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpfCnpj CHAR(14) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    dataNascimento DATE
);

-- Tabela de Pedidos
-- Esta tabela registra informações sobre os pedidos feitos pelos clientes.

CREATE TABLE pedidos (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    statusPedido ENUM('Em andamento', 'Em processamento', 'Enviado', 'Entregue') DEFAULT 'Em andamento',
    descricao TEXT,
    frete DECIMAL(10, 2) DEFAULT 10,
    pagamento BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de Entrega
-- Esta tabela registra informações sobre as entregas dos pedidos.

CREATE TABLE entregas (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT,
    statusEntrega ENUM('Em trânsito', 'Entregue') NOT NULL,
    codigoRastreio VARCHAR(50) NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido)
);

-- Tabela de Pagamentos
-- Esta tabela armazena informações sobre as formas de pagamento cadastradas pelos clientes.

CREATE TABLE pagamentos (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    formaPagamento VARCHAR(50) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de Produtos Vendidos por Vendedor
-- Esta tabela estabelece uma relação entre produtos e vendedores.

CREATE TABLE produtosVendedores (
    idProduto INT,
    idVendedor INT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (idProduto, idVendedor),
    FOREIGN KEY (idProduto) REFERENCES produtos(idProduto),
    FOREIGN KEY (idVendedor) REFERENCES vendedores(idVendedor)
);

-- Tabela de Produtos em Pedidos
-- Esta tabela relaciona produtos e pedidos.

CREATE TABLE produtosPedidos (
    idProduto INT,
    idPedido INT,
    quantidade INT DEFAULT 1,
    statusPedido ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idProduto, idPedido),
    FOREIGN KEY (idProduto) REFERENCES produtos(idProduto),
    FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido)
);

-- Tabela de Produtos Fornecidos por Fornecedor
-- Esta tabela estabelece uma relação entre produtos e fornecedores.

CREATE TABLE produtosFornecedores (
    idProduto INT,
    idFornecedor INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (idProduto, idFornecedor),
    FOREIGN KEY (idProduto) REFERENCES produtos(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES fornecedores(idFornecedor)
);

INSERT INTO clientes (tipoCliente, nome, cpfCnpj, endereco, dataNascimento) VALUES
('Pessoa Física', 'João Silva', '12345678900', 'Rua das Flores, 123', '1990-05-15'),
('Pessoa Física', 'Maria Santos', '98765432100', 'Rua das Árvores, 789', '1985-08-20'),
('Pessoa Física', 'Pedro Oliveira', '11122233344', 'Rua dos Mares, 101', '1998-12-10'),
('Pessoa Física', 'Ana Pereira', '55566677788', 'Rua do Sol, 55', '1980-03-25'),
('Pessoa Física', 'Carlos Mendes', '99988877766', 'Rua das Estrelas, 77', '1975-06-30');


-- Supondo que esses são os métodos de pagamento para os cinco clientes fictícios.
INSERT INTO pagamentos (idCliente, formaPagamento) VALUES
(1, 'Cartão de Crédito'),
(2, 'Boleto Bancário'),
(3, 'Transferência Bancária'),
(4, 'Cartão de Débito'),
(5, 'PayPal');


-- Supondo que esses são os dados de entrega para alguns pedidos fictícios.
INSERT INTO entregas (idPedido, statusEntrega, codigoRastreio) VALUES
(1, 'Entregue', 'AB123456789'),
(2, 'Em trânsito', 'CD987654321'),
(3, 'Entregue', 'EF111222333'),
(4, 'Em trânsito', 'GH555666777'),
(5, 'Entregue', 'IJ999888777');

-- Supondo que esses são alguns produtos fictícios disponíveis.
INSERT INTO produtos (nomeProduto, categoria, descricao, valor, avaliacao) VALUES
('Smartphone XYZ', 'Eletrônico', 'Smartphone de última geração', 999.99, 4.5),
('Camiseta Estampada', 'Vestimenta', 'Camiseta com estampa exclusiva', 29.99, 4.0),
('Brinquedo Educativo', 'Brinquedos', 'Brinquedo para desenvolvimento infantil', 19.99, 4.2),
('Arroz Integral', 'Alimentos', 'Arroz integral de alta qualidade', 5.99, 4.8),
('Sofá de Couro', 'Móveis', 'Sofá de couro confortável', 599.99, 4.3);


-- Supondo que esses são alguns pedidos fictícios relacionados aos clientes fictícios.
INSERT INTO pedidos (idCliente, statusPedido, descricao, frete, pagamento) VALUES
(1, 'Entregue', 'Pedido entregue com sucesso', 10.00, TRUE),
(2, 'Em andamento', 'Aguardando confirmação de pagamento', 10.00, FALSE),
(3, 'Em processamento', 'Pedido em processo de preparação', 15.00, TRUE),
(4, 'Entregue', 'Pedido entregue com sucesso', 10.00, TRUE),
(5, 'Enviado', 'Pedido enviado para entrega', 12.00, TRUE);

-- Supondo que esses são alguns dados de estoque fictícios para produtos.
INSERT INTO estoqueProdutos (idProduto, quantidade, localidade) VALUES
(1, 50, 'Centro de Distribuição A'),
(2, 100, 'Centro de Distribuição B'),
(3, 30, 'Centro de Distribuição A'),
(4, 80, 'Centro de Distribuição C'),
(5, 60, 'Centro de Distribuição B');

-- Supondo que esses são alguns fornecedores fictícios.
INSERT INTO fornecedores (cnpj, razaoSocial, contato) VALUES
('12345678900', 'Fornecedor A', 'ABOUBAKAR');


