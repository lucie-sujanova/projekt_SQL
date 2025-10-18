/*
projekt do Engeto Online Akademie, Datový analytik s Pythonem 5.3.2025
projekt z SQL
verze č.1
otázka č. 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
author: Lucie Šujanová
email: lsujanova@seznam.cz
 */

-- Řešení 4. otázky

-- 4.1 bez členění mezd dle odvětví

WITH entry AS (
    SELECT
        year,
        avg(avg_price) AS avg_price,
        avg(avg_payroll_per_year) AS avg_payroll
    FROM t_lucie_sujanova_project_SQL_primary_final
    GROUP BY year
),
calc_1 AS (
    SELECT 
        *,
        lag(avg_price) OVER (ORDER BY year) AS previous_year_avg_price,
        lag(avg_payroll) OVER (ORDER BY year) AS previous_year_avg_payroll
    FROM entry
),      
calc_2 AS (
    SELECT 
        *,
        CASE 
            WHEN previous_year_avg_price IS NOT NULL AND previous_year_avg_price <> 0 THEN
                round(((avg_price - previous_year_avg_price) / previous_year_avg_price) * 100, 2) 
            ELSE NULL
        END AS price_percentage_change,
        CASE 
            WHEN previous_year_avg_payroll IS NOT NULL AND previous_year_avg_payroll <> 0 THEN
                round(((avg_payroll - previous_year_avg_payroll) / previous_year_avg_payroll) * 100, 2) 
            ELSE NULL
        END AS payroll_percentage_change
    FROM calc_1
)
SELECT  
    year,
    round(avg(price_percentage_change),2) AS avg_price_change,
    round(avg(payroll_percentage_change), 2) AS avg_payroll_change,
    round(avg(price_percentage_change), 2) - round(avg(payroll_percentage_change), 2) AS diff_price_minus_payroll_percent
FROM calc_2
GROUP BY YEAR
HAVING round(avg(price_percentage_change), 2) - round(avg(payroll_percentage_change), 2) > 10
ORDER BY year ASC;



-- 4.2 včetně členění mezd dle odvětví

WITH entry AS (
    SELECT
        year,
        branch_code,
        industry_branch_name,
        avg(avg_price) AS avg_price,
        avg(avg_payroll_per_year) AS avg_payroll
    FROM t_lucie_sujanova_project_SQL_primary_final
    GROUP BY 
    	year, 
    	branch_code, 
    	industry_branch_name
),
calc_1 AS (
    SELECT 
        *,
        lag(avg_price) OVER (PARTITION BY branch_code ORDER BY year) AS previous_year_avg_price,
        lag(avg_payroll) OVER (PARTITION BY branch_code ORDER BY year) AS previous_year_avg_payroll
    FROM entry
),      
calc_2 AS (
    SELECT 
        *,
        CASE 
            WHEN previous_year_avg_price IS NOT NULL AND previous_year_avg_price <> 0 THEN
                round(((avg_price - previous_year_avg_price) / previous_year_avg_price) * 100, 2) 
            ELSE NULL
        END AS price_percentage_change,
        CASE 
            WHEN previous_year_avg_payroll IS NOT NULL AND previous_year_avg_payroll <> 0 THEN
                round(((avg_payroll - previous_year_avg_payroll) / previous_year_avg_payroll) * 100, 2) 
            ELSE NULL
        END AS payroll_percentage_change
    FROM calc_1
)
SELECT  
    year,
    branch_code,
    industry_branch_name,
    round(avg(price_percentage_change),2) AS avg_price_change,    
    round(avg(payroll_percentage_change), 2) AS avg_payroll_change,    
    round(avg(price_percentage_change), 2) - round(avg(payroll_percentage_change), 2)   AS diff_price_minus_payroll_percent
FROM calc_2
GROUP BY 
	year, 
	branch_code, 
	industry_branch_name
HAVING round(avg(price_percentage_change), 2) - round(avg(payroll_percentage_change), 2) >= 10
ORDER BY year ASC, branch_code ASC;