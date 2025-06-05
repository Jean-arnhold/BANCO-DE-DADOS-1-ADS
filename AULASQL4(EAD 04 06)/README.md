## LISTA DE ATIVIDADES

 # 1. INNER JOIN: Liste todos os pedidos, incluindo o nome do cliente e a data do pedido.

 ```sql
SELECT pedidos.PedidoID, pedidos.DataPedido, clientes.Nome
FROM pedidos JOIN clientes ON clientes.ClienteID = pedidos.ClienteID;
 ```

 # 2. LEFT JOIN: Liste o nome de todos os clientes e a quantidade de pedidos de cada cliente.
 
 ```sql 
SELECT clientes.Nome, COUNT(pedidos.PedidoID) as TotalPedidos
FROM clientes LEFT JOIN pedidos ON pedidos.ClienteID = clientes.ClienteID
GROUP BY
clientes.Nome;
 ```

# 3. LEFT JOIN: Liste o título de todos os livros e o total de pedidos em que o livro aparece.
 
 ```sql
SELECT livros.Titulo, COUNT(DISTINCT detalhespedidos.PedidoID) AS TotalPedidos
FROM livros 
LEFT JOIN detalhespedidos ON detalhespedidos.LivroID = livros.LivroID
GROUP BY livros.Titulo;
 ```

 # 4. LEFT JOIN: Liste o título de todos os livros, o total de pedidos em que o livro aparece e a quantidade total solicitada de cada livro nesses pedidos.

```sql
SELECT livros.Titulo, COUNT(DISTINCT detalhespedidos.PedidoID) AS TotalPedidos, SUM(detalhespedidos.Quantidade)
FROM livros 
LEFT JOIN detalhespedidos ON detalhespedidos.LivroID = livros.LivroID
GROUP BY livros.Titulo;
```

# 5. RIGHT JOIN: Liste o nome de todos os clientes e, se houver, os id dos pedidos relacionados, incluindo a data do pedido.


```sql
SELECT clientes.Nome, pedidos.PedidoID, pedidos.DataPedido
FROM pedidos RIGHT JOIN clientes on clientes.ClienteID = pedidos.ClienteID;
```

# 6. LEFT JOIN: Liste o título de todos os livros e, se houver, a data dos pedidos relacionados ao livro bem como o nome do cliente que comprou o livro.

```SQL
SELECT livros.Titulo, pedidos.DataPedido, clientes.Nome
FROM livros 
LEFT JOIN detalhespedidos ON detalhespedidos.LivroID = livros.LivroID
LEFT JOIN pedidos ON detalhespedidos.PedidoID = pedidos.PedidoID
LEFT JOIN clientes ON pedidos.ClienteID = clientes.ClienteID
ORDER BY 
    livros.Titulo, pedidos.DataPedido;
```