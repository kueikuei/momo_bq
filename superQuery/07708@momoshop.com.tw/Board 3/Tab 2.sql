-- CREATE TEMP TABLE HELLO_IPAC AS
-- select * from `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon05c0a3b26f28da7166f58c5060ef378e2df4d256`;
-- select * from HELLO_IPAC
-- -- where t.info.HEIGHT is NULL OR t.info.HEIGHT is NULL OR t.info.WIDTH is NULL 


-- CREATE TABLE `momo-develop.ipacking.ipack_temp`
-- OPTIONS(
-- expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 3 DAY)
-- ) AS
-- SELECT *
-- FROM `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon05c0a3b26f28da7166f58c5060ef378e2df4d256`
-- -- GROUP BY corpus

select * from `momo-develop.ipacking.ipack_temp`

-- select * from HELLO_IPAC