Avaliação 2 : respostas.

Nome: Jean Arnhold.

=================================================================
Questão 1:

SELECT CONCAT(f.Pnome, ' ', f.Unome) AS Nome_Completo, f.Salario
FROM funcionario f
JOIN departamento d ON f.Dnr = d.Dnumero
JOIN trabalha_em t ON f.Cpf = t.Fcpf
JOIN projeto p ON t.Pnr = p.Projnumero
WHERE d.Dnome = 'Administração'
  AND p.Projnome = 'Informatização'
  AND t.Horas BETWEEN 10 AND 20
ORDER BY Nome_Completo;

=================================================================
Questão 2:

SELECT f.Pnome, COUNT(t.Pnr) AS Num_Projetos
FROM funcionario f
JOIN departamento d ON f.Dnr = d.Dnumero
JOIN trabalha_em t ON f.Cpf = t.Fcpf
JOIN projeto p ON t.Pnr = p.Projnumero
WHERE f.Endereco LIKE '%São Paulo%'
  AND d.Dnome = 'Pesquisa'
GROUP BY f.Cpf
HAVING COUNT(t.Pnr) >= 2;


=================================================================
Questão 3:

SELECT CONCAT(f.Pnome, ' ', f.Unome) AS Nome_Completo
FROM funcionario f
JOIN trabalha_em t ON f.Cpf = t.Fcpf
JOIN projeto p ON t.Pnr = p.Projnumero
GROUP BY f.Cpf
HAVING COUNT(DISTINCT p.Projnome) = 1
   AND MAX(p.Projnome) = 'ProdutoZ';


=================================================================
Questão 4:
SELECT CONCAT(f.Pnome, ' ', f.Unome) AS Nome_Completo
FROM funcionario f
JOIN trabalha_em t ON f.Cpf = t.Fcpf
JOIN projeto p ON t.Pnr = p.Projnumero
WHERE p.Projnome = 'ProdutoZ'
AND f.Cpf NOT IN (
    SELECT t2.Fcpf
    FROM trabalha_em t2
    JOIN projeto p2 ON t2.Pnr = p2.Projnumero
    WHERE p2.Projnome = 'ProdutoY')

GROUP BY f.Cpf;


=================================================================
Questão 5:

SELECT p.Projnome,
       SUM(t.Horas) AS Total_Horas,
       SUM(t.Horas * (f.Salario / 160)) AS Custo_Total
FROM projeto p
JOIN trabalha_em t ON p.Projnumero = t.Pnr
JOIN funcionario f ON t.Fcpf = f.Cpf
GROUP BY p.Projnome
HAVING Custo_Total > 10000;


=================================================================




