/*
projekt do Engeto Online Akademie, Datový analytik s Pythonem 5.3.2025
projekt z SQL
verze č.1
otázka č. 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
author: Lucie Šujanová
email: lsujanova@seznam.cz
 */

-- Řešení 2. otázky 

SELECT
	YEAR,
	branch_code,
	industry_branch_name,
	price_category_code,
	price_category_name,
	round((avg_payroll_per_year / avg_price), 2) AS avg_quantity_to_buy,
	concat(category_quantity_unit || '/month_avg') AS quantity_unit
FROM t_lucie_sujanova_project_SQL_primary_final
WHERE 	price_category_code	IN ('111301', '114201')
	AND YEAR IN ('2006', '2018')
GROUP BY  
	YEAR, 
	branch_code,
	industry_branch_name, 
	category_quantity_unit, 
	price_category_code,
	avg_payroll_per_year,
	avg_price,
	price_category_name
ORDER BY 	
	YEAR, 
	price_category_name, 
	avg_quantity_to_buy;


