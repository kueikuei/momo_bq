-- SELECT RANK ,
--     CASE RANK
--         WHEN (RANK > MAX(RANK)) THEN 't'
--     END
--     AS RES
-- FROM `momo-develop._script2c0037fd6eb32cd04a50af588f91ebcd31d5e3de.Example` 
-- -- ORDER BY rank

SELECT 90 as A, 2 as B UNION ALL
  SELECT 50, 8 UNION ALL
  SELECT 60, 6 UNION ALL
  SELECT 50, 10