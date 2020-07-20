SELECT 
    IF(date(INSERT_DATE)  >= date_sub(current_date, interval 1 month),true,false),
    * 
FROM `momo-develop._scriptcfd0a84ff2415dba64c139518b670410e782e721.GrayGoods`