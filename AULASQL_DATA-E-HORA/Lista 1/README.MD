## LISTA 1

## 1. Faça uma consulta que retorne o nome de cada funcionário e qual foi o dia da semana (segunda, terça, ...) do primeiro aniversário do funcionário.

```sql
SELECT funcionario.Pnome, 
	DATE_FORMAT(DATE_ADD(funcionario.Datanasc, INTERVAL 1 YEAR), '%W')
FROM funcionario;
```

## 2. Faça uma consulta que retorne o nome do funcionário em letras maiúsculas, seu departamento e o número de dias que o funcionário trabalhou em Agosto (mês 08) de acordo com as informações que estão no ponto dos funcionários (tabela folha_ponto). A consulta deve restringir para retornar somente funcionários que tenham trabalhado menos de 20 dias no mês de acordo com o que consta na tabela folha_ponto.

```sql 
SELECT 
    UPPER(f.Pnome) AS NOME_FUNCIONARIO,
    d.Dnome AS DEPARTAMENTO,
    COUNT(DISTINCT fp.entrada) AS DIAS_TRABALHADOS_AGOSTO
FROM 
    funcionario f
JOIN 
    departamento d ON f.Dnr = d.Dnumero
JOIN 
    folha_ponto fp ON f.Cpf = fp.cpf
WHERE 
    MONTH(fp.entrada) = 8  -- Filtra apenas o mês de agosto (mês 8)
GROUP BY 
    f.Pnome, d.Dnome
HAVING 
    COUNT(DISTINCT fp.ENTRADA) < 20  -- Filtra funcionários com menos de 20 dias trabalhados
ORDER BY 
    DIAS_TRABALHADOS_AGOSTO;
```

ou

```sql
SELECT UPPER(f.Pnome), d.Dnome, COUNT(fp.cpf) Dias_trabalhados
FROM funcionario f
JOIN departamento d ON f.Dnr = d.Dnumero
JOIN folha_ponto fp ON f.Cpf = fp.cpf
WHERE MONTH(fp.entrada) = 8
GROUP BY f.Cpf
HAVING Dias_trabalhados < 20;
```


## 3 . Faça uma consulta que atenda a seguinte situação: quando o nome e o sobrenome do funcionário concatenados (ex.: 'Fernando Wong Xu') tiverem mais de 12 caracteres, retornar o nome do funcionário concatenado com o sobrenome, porém, abreviando o sobrenome colocando apenas a primeira letra seguida de um ponto (.) (exe. "Fernando W."). Para os demais nomes retornar nome e sobrenome concatenados completos.

```SQL
SELECT 
    CASE 
        WHEN LENGTH(CONCAT(f.Pnome, ' ', f.Unome)) > 12 THEN
            CONCAT(f.Pnome, ' ', LEFT(f.Unome, 1), '.')
        ELSE
            CONCAT(f.Pnome, ' ', f.Unome)
    END AS nome_formatado
FROM 
    funcionario f;
```

ou

```sql
SELECT CONCAT(f.Pnome, ' ', f.Unome) AS Nome_formatado
FROM funcionario f
WHERE CHAR_LENGTH(CONCAT(f.Pnome, ' ', f.Unome)) <= 12
UNION
SELECT CONCAT(f.Pnome, ' ', LEFT(f.Unome, 1), '.') AS Nome_formatado
FROM funcionario f
WHERE CHAR_LENGTH(CONCAT(f.Pnome, ' ', f.Unome)) > 12;
```


## 4. Faça uma consulta que retorne os dias que o funcionário fez hora extra, ou seja, os dias em que o funcionário trabalhou mais de 8h (considerar que existe 1 hora de intervalo para almoço no tempo marcado no ponto). Retornar na consulta o nome do funcionário, o dia do ponto, a hora de entrada, a hora de saída, o total de horas contabilizadas no dia, uma coluna para representar as horas extras e outra para os minutos extras.


```sql
SELECT 
    CONCAT(f.Pnome, ' ', f.Unome) AS nome_funcionario,
    DAY(fp.entrada) AS dia_ponto,
    fp.entrada AS hora_entrada,
    fp.saida AS hora_saida,
    -- Cálculo do tempo total trabalhado (considerando 1h de almoço)
    CONCAT(
        TIMESTAMPDIFF(HOUR, fp.entrada, fp.saida) - 1, 'h ',
        TIMESTAMPDIFF(MINUTE, fp.entrada, fp.saida) % 60, 'm'
    ) AS total_horas_dia,
    -- Cálculo das horas extras (acima de 8h)
    GREATEST(TIMESTAMPDIFF(HOUR, fp.entrada, fp.saida) - 1 - 8, 0) AS horas_extras,
    -- Cálculo dos minutos extras
    CASE 
        WHEN TIMESTAMPDIFF(HOUR, fp.entrada, fp.saida) - 1 > 8 THEN
            TIMESTAMPDIFF(MINUTE, fp.entrada, fp.saida) % 60
        ELSE 0
    END AS minutos_extras
FROM 
    folha_ponto fp
JOIN 
    funcionario f ON fp.cpf = f.cpf
WHERE 
    -- Filtra apenas dias com mais de 8h trabalhadas (já descontando 1h de almoço)
    TIMESTAMPDIFF(HOUR, fp.entrada, fp.saida) - 1 > 8
ORDER BY 
    nome_funcionario, dia_ponto;

```

ou

```sql
SELECT pnome funcionario, 
DAY(entrada) dia, 
TIME(entrada) entrada,
TIME(saida) saida,
TIMEDIFF(saida,entrada) totalHorasPonto,
HOUR(TIMEDIFF(saida,entrada))-9 horasExtras,
MINUTE(TIMEDIFF(saida,entrada)) minutosExtras
FROM funcionario JOIN folha_ponto ON funcionario.Cpf=folha_ponto.cpf
WHERE
(
 HOUR(TIMEDIFF(saida,entrada)) > 9
 OR
 (HOUR(TIMEDIFF(saida,entrada)) = 9 AND
MINUTE(TIMEDIFF(saida,entrada)) > 0)
)
ORDER BY pnome, dia, entrada;
```