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

## LISTA 2

## 1. Fazer uma lista dos números de projeto nos quais trabalham funcionários cujo último nome seja ‘Silva’. A lista também deve conter os números dos projetos que pertencem ao departamento “Pesquisa”. Uso obrigatório de UNION ou UNION ALL para apresentar os números dos projetos, considerando que eles não devem aparecer de forma repetida.


```sql
SELECT DISTINCT projeto.projnumero
FROM funcionario JOIN projeto on funcionario.Dnr = projeto.dnum
WHERE funcionario.Unome="Silva"
UNION 
SELECT projeto.Projnumero
FROM departamento JOIN projeto ON departamento.Dnumero = projeto.Dnum
WHERE departamento.Dnome = "Pesquisa";
```

## 2. Encontre o nome de todos os funcionários que nasceram entre '1960-01-01' AND '1969-12-31'. Uso obrigatório do BETWEEN.

```sql
SELECT DISTINCT funcionario.pnome
FROM funcionario
WHERE funcionario.Datanasc BETWEEN '1960-01-01' AND '1969-12-31'
ORDER BY funcionario.Pnome;
```

## 3. Recuperar o nome e o sobrenome dos funcionários que não possuem dependentes. Uso obrigatório de IN ou NOT IN conforme necessidade.

```sql
SELECT DISTINCT f.pnome, f.unome
FROM funcionario f
WHERE f.cpf NOT IN (
    SELECT d.fcpf 
    FROM dependente d
    WHERE d.fcpf IS NOT NULL
)
ORDER BY f.pnome, f.unome;
 ```

 ## 4. Recuperar a quantidade de funcionários por projeto, considerando apenas os funcionários que tenham horas de trabalho associado ao projeto. Isso significa que horas com valor em branco ou nulos não devem se contabilizados. Uso obrigatório de IS NULL ou IS NOT NULL conforme necessidade.

 ```sql
 SELECT trabalha_em.Pnr, COUNT(trabalha_em.Fcpf)
from trabalha_em
WHERE trabalha_em.Horas is not null and trabalha_em.Horas !=''
GROUP BY trabalha_em.pnr;
 ```


 ## LISTA 3

 ## 8. Para cada projeto localizado em ‘Mauá’, liste o número do projeto, o número do departamento que o controla e o último nome, endereço e data de nascimento do gerente do departamento

 ```sql
 SELECT 
projeto.Projnumero,
projeto.Dnum,
funcionario.Unome,
funcionario.Endereco,
funcionario.Datanasc
FROM projeto
JOIN departamento ON projeto.Dnum = departamento.Dnumero
JOIN funcionario ON departamento.Cpf_gerente = funcionario.Cpf
WHERE projeto.Projlocal= "Mauá";
 ```

 ## 9. Descobrir os nomes dos funcionários que trabalham em todos os projetos controlados pelo departamento número 5.

 ```sql 
 SELECT f.Pnome
FROM funcionario f
JOIN trabalha_em te ON f.Cpf = te.Fcpf
JOIN projeto p ON te.Pnr = p.Projnumero
WHERE p.Dnum = 5
GROUP BY f.Cpf, f.pnome
HAVING COUNT(DISTINCT p.Projnumero) = (
  SELECT COUNT(*) FROM projeto WHERE Dnum = 5
);
 ```

 ## 10. Fazer uma lista dos números de projeto para aqueles que envolvem um funcionário cujo último nome é ‘Silva’, seja como um trabalhador ou como um gerente do departamento que controla o projeto. 

 ```sql
 SELECT DISTINCT p.Projnumero
FROM projeto p
LEFT JOIN departamento d ON p.Dnum = d.Dnumero
LEFT JOIN trabalha_em te ON p.Projnumero = te.Pnr
LEFT JOIN funcionario f ON te.Fcpf = f.Cpf
WHERE f.Unome = 'Silva';
 ```

 ## 11. Listar os nomes dos funcionários com dois ou mais dependentes.

 ```sql 
 SELECT f.pnome, f.unome
from funcionario f JOIN dependente d ON f.Cpf =d.Fcpf
GROUP BY d.Fcpf
HAVING COUNT(fcpf) > 2;
 ```

 ## 12. Recuperar os nomes dos funcionários que não possuem dependentes.

 ```sql
 SELECT f.pnome, f.Unome
FROM funcionario f
WHERE f.Cpf NOT IN (
  SELECT d.Fcpf
  FROM dependente d
);
 ```

 ## 13. Listar os nomes dos gerentes que têm pelo menos um dependente.