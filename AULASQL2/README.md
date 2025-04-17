## Crie comandos SQL para o solicitado abaixo:

# 1. Recuperar o número do pedido, a data do pedido e o nome do cliente de cada pedido. 

```sql
SELECT pedido.numpedido, pedido.datapedido, cliente.nomecliente FROM cliente JOIN pedido ON cliente.numcliente = pedido.numcliente;
```

# Recuperar o número do pedido, a descrição dos itens e a quantidade de itens de cada pedido.

```sql
SELECT ip.numpedido, i.descricao, ip.quantidade FROM item_pedido ip join item i ON i.numItem= ip.numItem;
``` 

# Recuperar o nome dos clientes que compraram o item “TV LED 32”.
```sql
SELECT c.nomecliente from cliente c join pedido p JOIN item i join item_pedido ip on c.numCliente=p.numCliente and p.numPedido=ip.numPedido and i.numItem=ip.numItem WHERE i.descricao="TV LED 32";
``` 