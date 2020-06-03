CREATE TEMP FUNCTION plusOne(x FLOAT64)
RETURNS FLOAT64
LANGUAGE js
AS "return x+1;";

SELECT val, plusOne(val) AS result
FROM UNNEST([1, 2, 3, 4, 5]) AS val