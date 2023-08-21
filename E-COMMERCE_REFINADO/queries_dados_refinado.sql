-- Essas consultas abrangem diferentes aspectos da base de dados com o intuito de satisfazer o Desafio.
-- Elas podem ser úteis para testar e validar o funcionamento do código e para extrair étricas
-- Todos os dados inseridos foram gerados de forma randomica apenas para criterio de avaliação.

-- Consulta 1: Total de pedidos feitos por cada cliente
SELECT c.nome AS Cliente, COUNT(p.idPedido) AS TotalPedidos
FROM clientes c
LEFT JOIN pedidos p ON c.idCliente = p.idCliente
GROUP BY c.nome;

-- Consulta 2: Vendedores que também são fornecedores
SELECT v.nomeFantasia AS Vendedor, f.razaoSocial AS Fornecedor
FROM vendedores v
INNER JOIN produtosVendedores pv ON v.idVendedor = pv.idVendedor
INNER JOIN produtosFornecedores pf ON pv.idProduto = pf.idProduto
INNER JOIN fornecedores f ON pf.idFornecedor = f.idFornecedor;

-- Consulta 3: Produtos fornecidos e seus estoques
SELECT p.nomeProduto AS Produto, f.razaoSocial AS Fornecedor, e.quantidade AS Estoque
FROM produtos p
INNER JOIN produtosFornecedores pf ON p.idProduto = pf.idProduto
INNER JOIN fornecedores f ON pf.idFornecedor = f.idFornecedor
INNER JOIN estoqueProdutos e ON p.idProduto = e.idProduto;

-- Consulta 4: Nomes dos fornecedores e nomes dos produtos
SELECT f.razaoSocial AS Fornecedor, p.nomeProduto AS Produto
FROM fornecedores f
INNER JOIN produtosFornecedores pf ON f.idFornecedor = pf.idFornecedor
INNER JOIN produtos p ON pf.idProduto = p.idProduto;

-- Consulta 5: Total de produtos em estoque por categoria
SELECT categoria, COUNT(idProduto) AS TotalProdutos
FROM produtos
GROUP BY categoria;

-- Consulta 6: Produtos mais avaliados
SELECT nomeProduto, avaliacao
FROM produtos
ORDER BY avaliacao DESC
LIMIT 5;

-- Consulta 7: Média de valor de frete por status de entrega
SELECT statusEntrega, AVG(frete) AS MediaFrete
FROM entregas e
INNER JOIN pedidos p ON e.idPedido = p.idPedido
GROUP BY statusEntrega;
