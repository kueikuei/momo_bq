WITH Table_L AS (
SELECT 1 AS Row, 'A' AS Hour UNION ALL
SELECT 2 AS Row, 'B' AS Hour UNION ALL
SELECT 3 AS Row, 'C' AS Hour 
),
Table_R AS (
SELECT 1 AS Row, 10 AS Value UNION ALL
SELECT 2 AS Row, 20 AS Value UNION ALL
SELECT 3 AS Row, 30 AS Value 
)
SELECT 
  Row, 
  Hour, 
  (SELECT AVG(Value) FROM Table_R) AS AverageOfR,
  1 AS Key
FROM Table_L 

-- select * from Table_L