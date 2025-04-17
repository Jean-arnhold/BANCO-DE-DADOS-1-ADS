## Crie comandos SQL para o solicitado abaixo:

# Recuperar o número do pedido, a data do pedido e o nome do cliente de cada pedido. 

```sql
SELECT p.numPedido, p.dataPedido, c.nomeCliente
FROM pedido p 
JOIN cliente c ON c.numCliente=p.numCliente;
```

# Recuperar o número do pedido, a descrição dos itens e a quantidade de itens de cada pedido.

```sql
SELECT ip.numpedido, i.descricao, ip.quantidade 
FROM item_pedido ip 
JOIN item i ON i.numItem= ip.numItem;
``` 

# Recuperar o nome dos clientes que compraram o item “TV LED 32”.

```sql
SELECT c.nomeCliente
FROM pedido p 
JOIN item_pedido ip ON p.numPedido=ip.numPedido
JOIN item i ON ip.numItem=i.numItem
JOIN cliente c ON c.numCliente=p.numCliente
where i.descricao="TV LED 32";
``` 

## ATIVIDADES 2

# Recuperar o nome, a data de nascimento e o nome do departamento dos funcionários.
# Ordenar o resultado pelo nome do departamento seguido da data de nascimento.


```sql
SELECT f.pnome, f.unome,d.dnome, f.datanasc 
FROM funcionario f 
JOIN departamento d 
ON d.Dnumero=f.Dnr 
ORDER BY d.Dnome, f.Datanasc;
```

# Listar os nomes dos departamentos que possuem funcionários do sexo masculino. Os nomes dos departamentos não podem aparecer repetidos no resultado.


```sql
SELECT DISTINCT d.Dnome 
FROM departamento d JOIN funcionario f 
ON d.Dnumero=f.Dnr 
WHERE f.Sexo='M';
```
# Listar os nomes dos funcionários que tenham a letra “a” no nome e que o sobrenome termine com a letra “o”.

```sql
SELECT f.pnome, f.unome, d.dnome 
FROM funcionario f join departamento d 
ON f.Dnr=d.dnumero 
where f.Pnome LIKE '%a%' AND f.Unome LIKE '%o';
```
# Listar os nomes dos funcionários, seu salário e o possível salário se fosse dado um aumento de 25%. 

```sql
SELECT funcionario.Pnome, funcionario.Salario, funcionario.salario * 1.25 AS salario_com_aumento 
FROM funcionario;
``` 