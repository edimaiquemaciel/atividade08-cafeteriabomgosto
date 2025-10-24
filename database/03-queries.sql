-- =====================================================
-- TODAS AS CONSULTAS
-- Sistema de Controle de Vendas - Cafeteria BomGosto
-- =====================================================

-- QUESTÃO 1: Listagem do cardápio ordenada por nome
SELECT 
    codigo_cardapio,
    nome_cafe,
    descricao,
    preco_unitario
FROM Cardapio
ORDER BY nome_cafe;

-- QUESTÃO 2: Comandas com itens detalhados
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

-- QUESTÃO 3: Comandas com valor total
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

-- QUESTÃO 4: Comandas com mais de um tipo de café
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

-- QUESTÃO 5: Faturamento total por data
SELECT 
    c.data_comanda,
    SUM(ic.quantidade * card.preco_unitario) AS faturamento_total
FROM Comanda c
INNER JOIN ItemComanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN Cardapio card ON ic.codigo_cardapio = card.codigo_cardapio
GROUP BY c.data_comanda
ORDER BY c.data_comanda;