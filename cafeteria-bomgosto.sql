-- =====================================================
-- Cafeteria BomGosto
-- =====================================================
-- Autor: Edimaique Maciel
-- Data: 24/10/2025
-- =====================================================

-- =====================================================
-- 1. CRIAÇÃO DAS TABELAS
-- =====================================================

-- Remove as tabelas se já existirem (para poder executar múltiplas vezes)
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

-- =====================================================
-- 2. INSERÇÃO DE DADOS DE TESTE
-- =====================================================

-- Inserindo cafés no cardápio
INSERT INTO Cardapio (nome_cafe, descricao, preco_unitario) VALUES
('Espresso', 'Café espresso tradicional', 5.00),
('Cappuccino', 'Café com leite vaporizado e espuma', 8.50),
('Café com Leite', 'Café coado com leite quente', 6.00),
('Mocha', 'Café com chocolate e chantilly', 10.00),
('Americano', 'Espresso diluído em água quente', 6.50),
('Latte', 'Café com muito leite vaporizado', 9.00);

-- Inserindo comandas
INSERT INTO Comanda (data_comanda, numero_mesa, nome_cliente) VALUES
('2025-10-20', 5, 'João Silva'),
('2025-10-20', 3, 'Maria Santos'),
('2025-10-21', 7, 'Pedro Costa'),
('2025-10-21', 2, 'Ana Oliveira'),
('2025-10-22', 4, 'Carlos Mendes');

-- Inserindo itens das comandas
INSERT INTO ItemComanda (codigo_comanda, codigo_cardapio, quantidade) VALUES
(1, 1, 2),  -- Comanda 1: 2 Espressos
(1, 2, 1),  -- Comanda 1: 1 Cappuccino
(2, 3, 3),  -- Comanda 2: 3 Cafés com Leite
(3, 1, 1),  -- Comanda 3: 1 Espresso
(3, 4, 2),  -- Comanda 3: 2 Mochas
(3, 5, 1),  -- Comanda 3: 1 Americano
(4, 2, 2),  -- Comanda 4: 2 Cappuccinos
(5, 1, 1);  -- Comanda 5: 1 Espresso

-- =====================================================
-- 3. CONSULTAS (QUESTÕES)
-- =====================================================

-- -------------------------------------------------------
-- QUESTÃO 1: Listagem do cardápio ordenada por nome
-- -------------------------------------------------------
SELECT 
    codigo_cardapio,
    nome_cafe,
    descricao,
    preco_unitario
FROM Cardapio
ORDER BY nome_cafe;

-- -------------------------------------------------------
-- QUESTÃO 2: Comandas com itens detalhados
-- -------------------------------------------------------
SELECT 
    c.codigo_comanda,
    c.data_comanda,
    c.numero_mesa,
    c.nome_cliente,
    card.nome_cafe,
    card.descricao,
    ic.quantidade,
    card.preco_unitario,
    (ic.quantidade * card.preco_unitario) AS preco_total_cafe
FROM Comanda c
INNER JOIN ItemComanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN Cardapio card ON ic.codigo_cardapio = card.codigo_cardapio
ORDER BY c.data_comanda, c.codigo_comanda, card.nome_cafe;

-- -------------------------------------------------------
-- QUESTÃO 3: Comandas com valor total
-- -------------------------------------------------------
SELECT 
    c.codigo_comanda,
    c.data_comanda,
    c.numero_mesa,
    c.nome_cliente,
    SUM(ic.quantidade * card.preco_unitario) AS valor_total_comanda
FROM Comanda c
INNER JOIN ItemComanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN Cardapio card ON ic.codigo_cardapio = card.codigo_cardapio
GROUP BY c.codigo_comanda, c.data_comanda, c.numero_mesa, c.nome_cliente
ORDER BY c.data_comanda;

-- -------------------------------------------------------
-- QUESTÃO 4: Comandas com mais de um tipo de café
-- -------------------------------------------------------
SELECT 
    c.codigo_comanda,
    c.data_comanda,
    c.numero_mesa,
    c.nome_cliente,
    SUM(ic.quantidade * card.preco_unitario) AS valor_total_comanda
FROM Comanda c
INNER JOIN ItemComanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN Cardapio card ON ic.codigo_cardapio = card.codigo_cardapio
GROUP BY c.codigo_comanda, c.data_comanda, c.numero_mesa, c.nome_cliente
HAVING COUNT(DISTINCT ic.codigo_cardapio) > 1
ORDER BY c.data_comanda;

-- -------------------------------------------------------
-- QUESTÃO 5: Faturamento total por data
-- -------------------------------------------------------
SELECT 
    c.data_comanda,
    SUM(ic.quantidade * card.preco_unitario) AS faturamento_total
FROM Comanda c
INNER JOIN ItemComanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN Cardapio card ON ic.codigo_cardapio = card.codigo_cardapio
GROUP BY c.data_comanda
ORDER BY c.data_comanda;

-- =====================================================
-- FIM DO SCRIPT
-- =====================================================