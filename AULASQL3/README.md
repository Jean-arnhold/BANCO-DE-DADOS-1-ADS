## 1. Recuperar o nome dos funcionários que tem salário maior que ‘30.000’.

```sql
SELECT
funcionario.Pnome,
funcionario.Salario
FROM funcionario
WHERE Salario > 30000;
``` 

## 2. Recuperar o nome dos funcionários que tem salário menor que ‘30.000’ e que seja do sexo feminino.


```sql
SELECT
funcionario.Sexo,
funcionario.Pnome,
funcionario.Salario
FROM funcionario
WHERE
Salario < 30000 AND
Sexo ="F";
```

## 3. Listar a soma total dos salários por sexo.

```sql
SELECT
funcionario.Sexo,
SUM(funcionario.Salario)
FROM funcionario
GROUP BY Sexo;
```

## 4. Listar o menor, o maior e a média dos salários por departamento.

```sql
SELECT
funcionario.Dnr,
MAX(funcionario.Salario),
MIN(funcionario.Salario),
AVG(funcionario.Salario)
FROM funcionario
GROUP BY funcionario.dnr;
```

## 5. Retornar a quantidade de dependentes por sexo.

```sql

SELECT
COUNT(dependente.Fcpf),
dependente.Sexo
FROM dependente
GROUP BY Sexo;

```

## 6. Retornar a quantidade de dependentes por sexo do funcionário.

```sql
SELECT
COUNT(dependente.Fcpf),
funcionario.Sexo
FROM dependente JOIN funcionario on funcionario.Cpf = dependente.Fcpf
GROUP BY Sexo;
```

## 7. Recuperar o nome e o endereço de todos os funcionários que trabalham para o departamento de ‘Pesquisa’.

```sql
SELECT
funcionario.pnome,
funcionario.Unome,	
funcionario.Endereco
FROM departamento JOIN funcionario ON funcionario.Dnr = departamento.Dnumero 
WHERE departamento.dnome="pesquisa";
```
