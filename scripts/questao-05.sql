-- =====================================================
-- QUESTÃO 5: Faturamento total por data
-- =====================================================

SELECT 
    c.data_comanda,
    SUM(ic.quantidade * card.preco_unitario) AS faturamento_total
FROM Comanda c
INNER JOIN ItemComanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN Cardapio card ON ic.codigo_cardapio = card.codigo_cardapio
GROUP BY c.data_comanda
ORDER BY c.data_comanda;