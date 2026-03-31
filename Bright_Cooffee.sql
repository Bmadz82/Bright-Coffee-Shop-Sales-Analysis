select * from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1` limit 100;

-----Cheking the date range 
select min(transaction_date) as minimum_date, 
max(transaction_date) as maximum_date
from `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;


---3 checking the differnt store location
SELECT DISTINCT store_location 
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---4 checking Products sold our store
SELECT DISTINCT product_category
 FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;


 ------4 Checking product detail sold at our store - 29 different products
SELECT DISTINCT product_detail
 FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

----5-Checking product types  sold at our stores  - 80 different product types
select distinct product_type
 FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

-----6 cheking checking nulls in various columns
 SELECT *
 FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
 WHERE Unit_price is NULL
 OR  transaction_date is NULL
 OR  transaction_time is NULL;

 ---7-Checking lowest and highest unit price 
 Select
min(unit_price) as lowest_price, 
max(unit_price) as highest_price
 FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

 ---8-extracting the day and month names 
 select transaction_date,
 Dayname(transaction_date) as day_name,
 Monthname(transaction_date) as month_name
 FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

----9-calculating the revenue
SELECT unit_price,
transaction_qty,
unit_price*transaction_qty as revenue
 FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

Select *
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`;

---Combining functions to get clean and enhanced data set 
SELECT
    Transaction_id,
    transaction_date,
    transaction_time,
    transaction_qty,
    store_id,
    store_location,
    product_id,
    unit_price,
    product_category,
    product_type,
    product_detail,
-----adding new columns  to enhance the table for better insights
-----New column added  1 
Dayname(transaction_date) as day_name,
---New column added 2
Monthname(transaction_date) as month_name,
--New colum added 3
Dayofmonth(transaction_date) as date_of_month,
--New column added  4 -determining the weekday/weekend
CASE 
    WHEN DAYNAME(transaction_date) IN ('Sunday', 'Saturday') THEN 'Weekend.' 
    ELSE 'Weekday'
END AS day_classification,
------New Column added 5 -  Time buckets 
Case
when date_format(transaction_time,'HH:mm:ss') between '05:00:00' and '08:59:59' then 'Rush hour'
when date_format(transaction_time,'HH:mm:ss') between '09:00:00' and '11:59:59' then '02.mid Morning'
when date_format(transaction_time,'HH:mm:ss') between '12:00:00' and '15:59:59' then '03. Afternoon'
when date_format(transaction_time,'HH:mm:ss') between '16:00:00' and '18:00:00' then '01. Rush hour'
Else '05.Night'
End As Time_classification,
---NEW Column added -spend buckts
Case
when (transaction_qty*unit_price) <=50 then'01.Low spend'
when (transaction_qty*unit_price) between 51 and 200 then '02.Medium spend'
when (transaction_qty*unit_price) between 201 and 300 then '03. Moreki'
Else '04. blesser'
End As spend_buckets,
-----New Column added 7 - Revenue 
 transaction_qty* unit_price as Revenue
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1`
