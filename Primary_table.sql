/*
projekt do Engeto Online Akademie, Datový analytik s Pythonem 5.3.2025
projekt z SQL
verze č.1
author: Lucie Šujanová
email: lsujanova@seznam.cz
 */

--Tvorba primární tabulky
CREATE TABLE IF NOT EXISTS t_lucie_sujanova_project_SQL_primary_final AS
SELECT
	cpayt.year,
	cpayt.branch_code,
	cpayt.industry_branch_name,
	cpayt.avg_payroll_per_year,
	cpayt.payroll_unit,
	cpt.price_category_code,
	cpt.price_category_name,
	cpt.category_quantity_unit,				
	cpt.avg_price,
	cpt.category_price_unit
FROM 
	(SELECT
		cp.payroll_year AS year,
		cpib.code AS branch_code,
		cpib.name AS industry_branch_name,
		round(avg(CP.value):: NUMERIC) AS avg_payroll_per_year,		--průměr z kvartálů
		concat(cpu.name, '/měsíc') AS payroll_unit
	FROM czechia_payroll cp
	LEFT JOIN czechia_payroll_industry_branch cpib 				
		ON cp.industry_branch_code = cpib.code
	LEFT JOIN czechia_payroll_unit cpu 
		ON cp.unit_code != cpu.code								-- 200 x 80403 - nesrovnalost cpu
	WHERE cp.value_type_code = 5958 							-- 5958 = průměrná hrubá mzda
		AND cp.calculation_code = 200 							-- 200 =  přepočtený počet na plný pracovní úvazek
		AND cp.payroll_year BETWEEN 2006 AND 2018				-- omezeno kvůli datům v czechia_price (2006 - 2018)
		AND cp.industry_branch_code IS NOT NULL
	GROUP BY 
		cp.payroll_year,
		cpib.code, 
		cpib.name,
		cpu.name) AS cpayt
JOIN 
	(SELECT
		EXTRACT (YEAR FROM cp.date_from) AS year, 
		cpc.code AS price_category_code,
		cpc.name AS price_category_name,
		cpc.price_unit AS category_quantity_unit,				
		round(avg(cp.value :: numeric),2) AS avg_price, 
		concat('Kč/', cpc.price_unit) AS category_price_unit
	FROM czechia_price cp
	JOIN czechia_price_category cpc
		ON cp.category_code = cpc.code 
	GROUP BY 
		YEAR, 
		cpc.code, 
		cpc.name, 
		cpc.price_unit
	) AS cpt
ON cpayt.year = cpt.year
ORDER BY 
	cpayt.year, 
	cpayt.branch_code,
	cpt.price_category_code;



-- Zobrazení primární tabulky
SELECT *
FROM t_lucie_sujanova_project_SQL_primary_final




