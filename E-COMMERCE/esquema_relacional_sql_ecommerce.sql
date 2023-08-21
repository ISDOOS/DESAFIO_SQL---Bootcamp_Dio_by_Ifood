-- Criação do banco de dados para um E-commerce
-- DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tabela de Clientes
CREATE TABLE clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    primeiroNome VARCHAR(50) NOT NULL,
    nomeMeio CHAR(3),
    sobrenome VARCHAR(50),
    cpf CHAR(11) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    dataNascimento DATE NOT NULL
);

-- Tabela de Produtos
CREATE TABLE produtos (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    nomeProduto VARCHAR(100) NOT NULL,
    classificacaoCrianca BOOLEAN DEFAULT FALSE,
    categoria ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    descricao TEXT,
    valor DECIMAL(10, 2) NOT NULL,
    avaliacao DECIMAL(3, 2) NOT NULL DEFAULT 0,
    dimensoes VARCHAR(20)
);

-- Tabela de Pedidos
CREATE TABLE pedidos (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    statusPedido ENUM('Em andamento', 'Em processamento', 'Enviado', 'Entregue') DEFAULT 'Em processamento',
    descricao TEXT,
    frete DECIMAL(10, 2) DEFAULT 10,
    pagamento BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

-- Tabela de Estoque
CREATE TABLE estoqueProdutos (
    idEstoqueProduto INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT DEFAULT 0,
    localidade VARCHAR(50)
);

-- Tabela de Fornecedores
CREATE TABLE fornecedores (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    razaoSocial VARCHAR(100) NOT NULL,
    contato CHAR(11) NOT NULL
);

-- Tabela de Vendedores
CREATE TABLE vendedores (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14),
    cpf CHAR(11),
    localidade VARCHAR(50),
    nomeFantasia VARCHAR(100),
    UNIQUE (razaoSocial, cnpj, cpf)
);

-- Tabela de Produtos Vendidos por Vendedor
CREATE TABLE produtosVendedores (
    idProduto INT,
    idVendedor INT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (idProduto, idVendedor),
    FOREIGN KEY (idProduto) REFERENCES produtos(idProduto),
    FOREIGN KEY (idVendedor) REFERENCES vendedores(idVendedor)
);

-- Tabela de Produtos em Pedidos
CREATE TABLE produtosPedidos (
    idProduto INT,
    idPedido INT,
    quantidade INT DEFAULT 1,
    statusPedido ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idProduto, idPedido),
    FOREIGN KEY (idProduto) REFERENCES produtos(idProduto),
    FOREIGN KEY (idPedido) REFERENCES pedidos(idPedido)
);

-- Tabela de Localidades de Estoque
CREATE TABLE estoquesLocalidades (
    idEstoqueProduto INT,
    idEstoque INT,
    localidade VARCHAR(50) NOT NULL,
    PRIMARY KEY (idEstoqueProduto, idEstoque),
    FOREIGN KEY (idEstoqueProduto) REFERENCES produtos(idProduto),
    FOREIGN KEY (idEstoque) REFERENCES estoqueProdutos(idEstoqueProduto)
);

-- Tabela de Produtos Fornecidos por Fornecedor
CREATE TABLE produtosFornecedores (
    idProduto INT,
    idFornecedor INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (idProduto, idFornecedor),
    FOREIGN KEY (idProduto) REFERENCES produtos(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES fornecedores(idFornecedor)
);
