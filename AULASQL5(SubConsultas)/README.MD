# 1. Retornar o nome completo (primeiro e último nome concatenados) de todos os funcionários que trabalham mais de 8 horas no projeto "ProdutoX" ou no "ProdutoY" e que tenham mais de um dependente. Os nomes não podem aparecer repetidos e devem estar em ordem alfabética. 

```sql
SELECT DISTINCT CONCAT(f.Pnome, ' ', f.Unome) NomeCompleto 
FROM funcionario f JOIN trabalha_em te on te.Fcpf = f.Cpf 
JOIN projeto p on p.Projnumero = te.Pnr
JOIN dependente d ON f.Cpf = d.Fcpf
WHERE (p.Projnome = 'ProdutoX' OR p.Projnome = 'ProdutoY')
  AND te.Horas > 8
GROUP BY f.Cpf, f.Pnome, f.Unome
HAVING COUNT(d.Fcpf) > 1
ORDER BY NomeCompleto;
```

# 2. Listar o nome do funcionário, seu cpf e seu número de dependentes considerando todos os funcionários que tenham pelo menos 1 dependente do sexo masculino e 1 dependente do sexo feminino.

```sql 
SELECT CONCAT(f.Pnome, ' ', f.Unome) NomeCompleto, f.Cpf, 
COUNT(d.Fcpf) AS numero_dependentes
FROM 
    funcionario f
JOIN 
    dependente d ON f.Cpf = d.Fcpf
WHERE 
    f.Cpf IN (
      
        SELECT Fcpf 
        FROM dependente 
        WHERE Sexo = 'M'
    )
    AND f.Cpf IN (
        
        SELECT Fcpf 
        FROM dependente 
        WHERE Sexo = 'F'
    )
GROUP BY 
    f.Cpf, f.Pnome, f.Unome
HAVING 
    COUNT(d.Fcpf) >= 2 
ORDER BY 
    NomeCompleto;
```

# 3. Listar o nome e o salário dos funcionários que trabalham no departamento localizado em “Itu”, que tenham nascido na década de 60 e que tenham salário abaixo da média salarial do departamento onde trabalha.

```sql
SELECT CONCAT(f.Pnome, ' ', f.Unome) NomeCompleto, f.Salario
FROM 
    funcionario f
JOIN 
    departamento d ON f.Dnr = d.Dnumero
JOIN 
    localizacao_dep l ON d.Dnumero = l.Dnumero
WHERE 
    l.Dlocal = 'Itu'
    AND EXTRACT(YEAR FROM f.Datanasc) BETWEEN 1960 AND 1969
    AND f.Salario < (
        SELECT AVG(f2.Salario)
        FROM funcionario f2
        WHERE f2.Dnr = f.Dnr
    )
ORDER BY 
    f.Salario DESC;
```

# Questão 4 - Refazer a questão 3 do exercício anterior sem usar a subconsulta no WHERE.

```sql
SELECT CONCAT(f.Pnome, ' ', f.Unome) NomeCompleto, f.Salario
FROM 
    funcionario f
JOIN 
    departamento d ON f.Dnr = d.Dnumero
JOIN 
    localizacao_dep l ON d.Dnumero = l.Dnumero
JOIN 
    (
        SELECT 
            Dnr AS departamento_numero, 
            AVG(Salario) AS media_salarial
        FROM 
            funcionario
        GROUP BY 
            Dnr
    ) media_dept
ON f.Dnr = media_dept.departamento_numero
WHERE 
    l.Dlocal = 'Itu'
    AND EXTRACT(YEAR FROM f.Datanasc) BETWEEN 1960 AND 1969
    AND f.Salario < media_dept.media_salarial
ORDER BY 
    f.Salario DESC;
    
```