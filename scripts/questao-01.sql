-- =====================================================
-- QUESTÃO 1: Listagem do cardápio ordenada por nome
-- =====================================================

SELECT 
    codigo_cardapio,
    nome_cafe,
    descricao,
    preco_unitario
FROM Cardapio
ORDER BY nome_cafe;