-- =====================================================
-- CRIAÇÃO DAS TABELAS
-- Sistema de Controle de Vendas - Cafeteria BomGosto
-- =====================================================

-- Remove as tabelas se já existirem
DROP TABLE IF EXISTS ItemComanda;
DROP TABLE IF EXISTS Comanda;
DROP TABLE IF EXISTS Cardapio;

-- Tabela Cardápio
CREATE TABLE Cardapio (
    codigo_cardapio INT PRIMARY KEY AUTO_INCREMENT,
    nome_cafe VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT,
    preco_unitario DECIMAL(10, 2) NOT NULL
);

-- Tabela Comanda
CREATE TABLE Comanda (
    codigo_comanda INT PRIMARY KEY AUTO_INCREMENT,
    data_comanda DATE NOT NULL,
    numero_mesa INT NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL
);

-- Tabela Itens da Comanda
CREATE TABLE ItemComanda (
    codigo_comanda INT NOT NULL,
    codigo_cardapio INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (codigo_comanda, codigo_cardapio),
    FOREIGN KEY (codigo_comanda) REFERENCES Comanda(codigo_comanda),
    FOREIGN KEY (codigo_cardapio) REFERENCES Cardapio(codigo_cardapio)
);