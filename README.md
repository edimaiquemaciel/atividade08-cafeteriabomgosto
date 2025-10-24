# 🍵 Sistema de Controle de Vendas - Cafeteria BomGosto

Sistema de banco de dados para gerenciamento de vendas de café através de comandas digitais.

[![SQL](https://img.shields.io/badge/SQL-MySQL-blue)](https://www.mysql.com/)
[![Status](https://img.shields.io/badge/Status-Completo-success)](https://github.com)
[![License](https://img.shields.io/badge/License-Academic-yellow)](https://github.com)

---

## 📋 Sobre o Projeto

A cafeteria **BomGosto** necessita de um sistema para controlar suas vendas de café. O sistema registra comandas com informações do cliente e permite associar múltiplos produtos do cardápio a cada venda, controlando quantidades e calculando valores totais.

### Funcionalidades
- ✅ Cadastro de produtos no cardápio
- ✅ Registro de comandas por mesa/cliente
- ✅ Controle de itens vendidos por comanda
- ✅ Cálculo automático de valores
- ✅ Relatórios de vendas e faturamento

---

## 🗄️ Tecnologias Utilizadas

- **SQL** - Linguagem de consulta estruturada
- **MySQL 8.0+** - Sistema gerenciador de banco de dados
- **Git/GitHub** - Controle de versão

---

## 📊 Modelagem do Banco de Dados

### Entidades Principais

**CARDAPIO**
- `codigo_cardapio` (PK): Identificador único do produto
- `nome_cafe` (UNIQUE): Nome do café
- `descricao`: Descrição da composição
- `preco_unitario`: Preço por unidade

**COMANDA**
- `codigo_comanda` (PK): Identificador único da comanda
- `data_comanda`: Data da venda
- `numero_mesa`: Número da mesa do cliente
- `nome_cliente`: Nome do cliente

**ITEMCOMANDA**
- `codigo_comanda` (PK, FK): Referência à comanda
- `codigo_cardapio` (PK, FK): Referência ao produto
- `quantidade`: Quantidade vendida

### Relacionamentos
```
CARDAPIO (1) ----< (N) ITEMCOMANDA (N) >---- (1) COMANDA
```

---

## 🚀 Como Executar

### Pré-requisitos
- MySQL 8.0 ou superior instalado
- Cliente MySQL (mysql-client, MySQL Workbench, etc.)

### Opção 1: Executar arquivo completo
```bash
mysql -u root -p nome_do_banco < cafeteria-bomgosto.sql
```

### Opção 2: Executar por etapas
```bash
# 1. Criar tabelas
mysql -u root -p nome_do_banco < database/01-create-tables.sql

# 2. Inserir dados
mysql -u root -p nome_do_banco < database/02-insert-data.sql

# 3. Executar consultas
mysql -u root -p nome_do_banco < database/03-queries.sql
```

### Opção 3: Executar questões individuais
```bash
mysql -u root -p nome_do_banco < scripts/questao-01.sql
mysql -u root -p nome_do_banco < scripts/questao-02.sql
# ... e assim por diante
```

---

## 📝 Questões Resolvidas

### QUESTÃO 1: Cardápio Ordenado por Nome

**Objetivo:** Listar todos os cafés do cardápio em ordem alfabética.

**Query:**
```sql
SELECT 
    codigo_cardapio,
    nome_cafe,
    descricao,
    preco_unitario
FROM Cardapio
ORDER BY nome_cafe;
```

**Resultado:**
```
+------------------+----------------+---------------------------------------+----------------+
| codigo_cardapio  | nome_cafe      | descricao                             | preco_unitario |
+------------------+----------------+---------------------------------------+----------------+
|        5         | Americano      | Espresso diluído em água quente       |     6.50       |
|        3         | Café com Leite | Café coado com leite quente           |     6.00       |
|        2         | Cappuccino     | Café com leite vaporizado e espuma    |     8.50       |
|        1         | Espresso       | Café espresso tradicional             |     5.00       |
|        6         | Latte          | Café com muito leite vaporizado       |     9.00       |
|        4         | Mocha          | Café com chocolate e chantilly        |    10.00       |
+------------------+----------------+---------------------------------------+----------------+
6 rows in set (0.00 sec)
```

---

### QUESTÃO 2: Comandas com Itens Detalhados

**Objetivo:** Exibir todas as comandas com seus respectivos itens, incluindo detalhes do café e cálculo do preço total de cada item.

**Query:**
```sql
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
```

**Resultado:**
```
+----------------+--------------+-------------+----------------+----------------+---------------------------------------+------------+----------------+------------------+
| codigo_comanda | data_comanda | numero_mesa | nome_cliente   | nome_cafe      | descricao                             | quantidade | preco_unitario | preco_total_cafe |
+----------------+--------------+-------------+----------------+----------------+---------------------------------------+------------+----------------+------------------+
|       1        | 2025-10-20   |      5      | João Silva     | Cappuccino     | Café com leite vaporizado e espuma    |     1      |     8.50       |      8.50        |
|       1        | 2025-10-20   |      5      | João Silva     | Espresso       | Café espresso tradicional             |     2      |     5.00       |     10.00        |
|       2        | 2025-10-20   |      3      | Maria Santos   | Café com Leite | Café coado com leite quente           |     3      |     6.00       |     18.00        |
|       3        | 2025-10-21   |      7      | Pedro Costa    | Americano      | Espresso diluído em água quente       |     1      |     6.50       |      6.50        |
|       3        | 2025-10-21   |      7      | Pedro Costa    | Espresso       | Café espresso tradicional             |     1      |     5.00       |      5.00        |
|       3        | 2025-10-21   |      7      | Pedro Costa    | Mocha          | Café com chocolate e chantilly        |     2      |    10.00       |     20.00        |
|       4        | 2025-10-21   |      2      | Ana Oliveira   | Cappuccino     | Café com leite vaporizado e espuma    |     2      |     8.50       |     17.00        |
|       5        | 2025-10-22   |      4      | Carlos Mendes  | Espresso       | Café espresso tradicional             |     1      |     5.00       |      5.00        |
+----------------+--------------+-------------+----------------+----------------+---------------------------------------+------------+----------------+------------------+
8 rows in set (0.01 sec)
```

**Insights:**
- A comanda 1 (João Silva) pediu 2 Espressos e 1 Cappuccino
- A comanda 3 (Pedro Costa) foi a mais variada com 3 tipos de café diferentes
- Maria Santos pediu 3 unidades do mesmo café (Café com Leite)

---

### QUESTÃO 3: Comandas com Valor Total

**Objetivo:** Listar todas as comandas com o valor total de cada uma, ordenadas por data.

**Query:**
```sql
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
```

**Resultado:**
```
+----------------+--------------+-------------+----------------+---------------------+
| codigo_comanda | data_comanda | numero_mesa | nome_cliente   | valor_total_comanda |
+----------------+--------------+-------------+----------------+---------------------+
|       1        | 2025-10-20   |      5      | João Silva     |        18.50        |
|       2        | 2025-10-20   |      3      | Maria Santos   |        18.00        |
|       3        | 2025-10-21   |      7      | Pedro Costa    |        31.50        |
|       4        | 2025-10-21   |      2      | Ana Oliveira   |        17.00        |
|       5        | 2025-10-22   |      4      | Carlos Mendes  |         5.00        |
+----------------+--------------+-------------+----------------+---------------------+
5 rows in set (0.00 sec)
```

**Análise:**
- **Maior venda:** Pedro Costa (R$ 31,50) - 3 tipos de café
- **Menor venda:** Carlos Mendes (R$ 5,00) - apenas 1 Espresso
- **Ticket médio:** R$ 18,00

---

### QUESTÃO 4: Comandas com Mais de Um Tipo de Café

**Objetivo:** Mostrar apenas as comandas que possuem mais de um tipo de café diferente.

**Query:**
```sql
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
```

**Resultado:**
```
+----------------+--------------+-------------+--------------+---------------------+
| codigo_comanda | data_comanda | numero_mesa | nome_cliente | valor_total_comanda |
+----------------+--------------+-------------+--------------+---------------------+
|       1        | 2025-10-20   |      5      | João Silva   |        18.50        |
|       3        | 2025-10-21   |      7      | Pedro Costa  |        31.50        |
+----------------+--------------+-------------+--------------+---------------------+
2 rows in set (0.00 sec)
```

**Observações:**
- Apenas 2 comandas (40%) tiveram mais de um tipo de café
- João Silva pediu 2 tipos diferentes
- Pedro Costa pediu 3 tipos diferentes (mais variado)
- As comandas 2, 4 e 5 ficaram de fora por terem apenas 1 tipo de café

---

### QUESTÃO 5: Faturamento Total por Data

**Objetivo:** Calcular o faturamento total de cada dia, ordenado cronologicamente.

**Query:**
```sql
SELECT 
    c.data_comanda,
    SUM(ic.quantidade * card.preco_unitario) AS faturamento_total
FROM Comanda c
INNER JOIN ItemComanda ic ON c.codigo_comanda = ic.codigo_comanda
INNER JOIN Cardapio card ON ic.codigo_cardapio = card.codigo_cardapio
GROUP BY c.data_comanda
ORDER BY c.data_comanda;
```

**Resultado:**
```
+--------------+-------------------+
| data_comanda | faturamento_total |
+--------------+-------------------+
| 2025-10-20   |       36.50       |
| 2025-10-21   |       48.50       |
| 2025-10-22   |        5.00       |
+--------------+-------------------+
3 rows in set (0.00 sec)
```

**Dashboard de Vendas:**
```
📊 Análise de Faturamento (3 dias)

20/10/2025: R$ 36,50  ████████████████░░░░  (40.6%)
21/10/2025: R$ 48,50  ████████████████████  (53.9%)  ⭐ Melhor dia
22/10/2025: R$  5,00  ██░░░░░░░░░░░░░░░░░░  ( 5.6%)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TOTAL:      R$ 90,00
MÉDIA:      R$ 30,00/dia
COMANDAS:   5 vendas
```

**Insights Comerciais:**
- 📈 Melhor dia: 21/10 com R$ 48,50 (crescimento de 33% em relação ao dia anterior)
- 📉 Queda significativa no dia 22/10 (apenas 1 comanda)
- 💰 Faturamento total do período: R$ 90,00
- 📊 Média diária: R$ 30,00

---

## 📈 Estatísticas do Sistema

### Produtos Mais Vendidos
```
1. Espresso      - 4 vendas (50% das comandas)
2. Cappuccino    - 2 vendas (25% das comandas)
3. Café com Leite - 1 venda
4. Mocha         - 1 venda
5. Americano     - 1 venda
```

### Análise de Ticket Médio
```
Ticket Médio por Comanda: R$ 18,00
Maior Ticket:            R$ 31,50 (Comanda 3)
Menor Ticket:            R$  5,00 (Comanda 5)
```

---

## 📂 Estrutura do Repositório

```
cafeteria-bomgosto/
│
├── README.md                              ← Você está aqui
├── cafeteria-bomgosto.sql                 ← Script completo (tudo em um)
│
├── database/
│   ├── 01-create-tables.sql               ← Criação das tabelas
│   ├── 02-insert-data.sql                 ← Dados de teste
│   └── 03-queries.sql                     ← Todas as consultas
│
├── scripts/
│   ├── questao-01.sql                     ← Query da questão 1
│   ├── questao-02.sql                     ← Query da questão 2
│   ├── questao-03.sql                     ← Query da questão 3
│   ├── questao-04.sql                     ← Query da questão 4
│   └── questao-05.sql                     ← Query da questão 5
│
```

---

## 🎯 Regras de Negócio Implementadas

✅ **Unicidade de Produtos:** Cada café no cardápio possui nome único  
✅ **Restrição de Duplicação:** Não é possível inserir o mesmo café mais de uma vez na mesma comanda  
✅ **Integridade Referencial:** Uso de chaves estrangeiras para manter consistência  
✅ **Validação de Dados:** Campos obrigatórios e tipos adequados  
✅ **Cálculos Automáticos:** Preço total calculado via SQL (quantidade × preço unitário)


