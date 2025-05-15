-- Criar o banco de dados (opcional)
CREATE DATABASE DB_SalesAnalytics;
GO

USE DB_SalesAnalytics;
GO

-- Tabela de Clientes
IF OBJECT_ID('Clientes', 'U') IS NOT NULL DROP TABLE Clientes;
CREATE TABLE Clientes (
    ID_Cliente NVARCHAR(20) PRIMARY KEY,
    Nome_Cliente NVARCHAR(100),
    Cidade NVARCHAR(100),
    Estado NVARCHAR(100),
    Pais NVARCHAR(100),
    Regiao NVARCHAR(100),
    Mercado NVARCHAR(50),
    Segmento NVARCHAR(50)
);

-- Tabela de Pedidos
IF OBJECT_ID('Pedidos', 'U') IS NOT NULL DROP TABLE Pedidos;
CREATE TABLE Pedidos (
    ID_Pedido NVARCHAR(20) PRIMARY KEY,
    Ano INT,
    Mes NVARCHAR(20),
    Dia INT,
    Modo_Envio NVARCHAR(100),
    Prioridade_Pedido NVARCHAR(50)
);

-- Tabela de Produtos
IF OBJECT_ID('Produtos', 'U') IS NOT NULL DROP TABLE Produtos;
CREATE TABLE Produtos (
    ID_Produto NVARCHAR(20) PRIMARY KEY,
    Nome_Produto NVARCHAR(100),
    Categoria NVARCHAR(100),
    SubCategoria NVARCHAR(100)
);

-- Tabela de Vendas
IF OBJECT_ID('Vendas', 'U') IS NOT NULL DROP TABLE Vendas;
CREATE TABLE Vendas (
    Pedido NVARCHAR(20),
    Produto NVARCHAR(20),
    Cliente NVARCHAR(20),
    Quantidade_Vendida INT,
    Valor_Venda FLOAT,
    Custo_Envio FLOAT,
    PRIMARY KEY (Pedido, Produto, Cliente),
    FOREIGN KEY (Pedido) REFERENCES Pedidos(ID_Pedido),
    FOREIGN KEY (Produto) REFERENCES Produtos(ID_Produto),
    FOREIGN KEY (Cliente) REFERENCES Clientes(ID_Cliente)
);
