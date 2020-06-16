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
 ttt.*,Table_R.Value
FROM Table_L as ttt
left join Table_R  on ttt.Row = Table_R.Row

-- select * from Table_R

-- SELECT * FROM Roster LEFT JOIN TeamMascot
-- ON Roster.SchoolID = TeamMascot.SchoolID;

-- select * from Table_L