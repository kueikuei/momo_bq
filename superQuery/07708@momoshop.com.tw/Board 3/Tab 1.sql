WITH races AS (
  SELECT "800M" AS race,
    [STRUCT("Rudisha" as name, [23.4, 26.3, 26.4, 26.1] as splits),
     STRUCT("Makhloufi" as name, [24.5, 25.4, 26.6, 26.1] as splits),
     STRUCT("Murphy" as name, [23.9, 26.0, 27.0, 26.0] as splits),
     STRUCT("Bosse" as name, [23.6, 26.2, 26.5, 27.1] as splits),
     STRUCT("Rotich" as name, [24.7, 25.6, 26.9, 26.4] as splits),
     STRUCT("Lewandowski" as name, [25.0, 25.7, 26.3, 27.2] as splits),
     STRUCT("Kipketer" as name, [23.2, 26.1, 27.3, 29.4] as splits),
     STRUCT("Berian" as name, [23.7, 26.1, 27.0, 29.3] as splits)]
       AS participants)
       
SELECT SUM(duration)
FROM UNNEST(splits) AS duration) ASC
LIMIT 1