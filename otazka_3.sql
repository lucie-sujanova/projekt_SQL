/*
projekt do Engeto Online Akademie, Datový analytik s Pythonem 5.3.2025
projekt z SQL
verze č.1
otázka č. 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
author: Lucie Šujanová
email: lsujanova@seznam.cz
 */

-- Řešení 3. otázky

WITH entry AS (  
		SELECT DISTINCT 
			year, 
			price_category_code,
			price_category_name,
			avg_price
		FROM t_lucie_sujanova_project_SQL_primary_final
		),
	calc_1 AS (
		SELECT 
			*,
			lag(avg_price, 1) OVER (PARTITION BY price_category_name ORDER BY year) AS previous_year_avg_price
		FROM entry en
		),
	calc_2 AS (
		SELECT 
			*,
			CASE 
				WHEN previous_year_avg_price IS NOT NULL AND previous_year_avg_price <> 0 THEN
					round(((avg_price - previous_year_avg_price)/ previous_year_avg_price) * 100, 2) 
				ELSE NULL
				END AS price_percentage_change
		FROM calc_1  c1
		)
SELECT 
	price_category_code,
	price_category_name,
	round(avg(price_percentage_change), 2) AS avg_price_percentage_change
FROM calc_2  c2
GROUP BY 
	price_category_code, 
	price_category_name
ORDER BY avg_price_percentage_change ASC;

