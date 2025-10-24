-- =====================================================
-- QUESTÃO 3: Comandas com valor total
-- =====================================================

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