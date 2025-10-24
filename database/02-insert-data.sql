-- =====================================================
-- INSERÇÃO DE DADOS DE TESTE
-- Sistema de Controle de Vendas - Cafeteria BomGosto
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