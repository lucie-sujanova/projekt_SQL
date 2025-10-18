/*
projekt do Engeto Online Akademie, Datový analytik s Pythonem 5.3.2025
projekt z SQL
verze č.1
otázka č. 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
author: Lucie Šujanová
email: lsujanova@seznam.cz
 */


-- Řešení 1. otázky

-- 1.1 Celková změna mezd 2018 vs 2006 dle odvětví

WITH payroll_avg AS (
    SELECT
        year,
        branch_code,
        industry_branch_name,
        ROUND(AVG(avg_payroll_per_year)) AS avg_payroll_per_year
    FROM t_lucie_sujanova_project_SQL_primary_final
    GROUP BY year, branch_code, industry_branch_name
),
payroll_first_last AS (
    SELECT 
        branch_code,
        industry_branch_name,
        MAX(CASE WHEN year = 2006 THEN avg_payroll_per_year END) AS payroll_2006,
        MAX(CASE WHEN year = 2018 THEN avg_payroll_per_year END) AS payroll_2018
    FROM payroll_avg
    GROUP BY branch_code, industry_branch_name
)
SELECT
    branch_code,
    industry_branch_name,
    payroll_2006,
    payroll_2018,
    ROUND(payroll_2018 - payroll_2006, 2) AS absolute_change,
    ROUND(((payroll_2018 - payroll_2006) * 100.0 / payroll_2006), 2) AS percent_change,
    CASE 
        WHEN payroll_2018 > payroll_2006 THEN 'increasing'
        WHEN payroll_2018 < payroll_2006 THEN 'decreasing'
        ELSE 'unchanged'
    END AS overall_trend
FROM payroll_first_last
ORDER BY percent_change;


-- 1.2 Meziroční změny

WITH payroll_differences AS (
	SELECT 
		year,
		branch_code, 
		industry_branch_name,
		payroll_unit,
		avg_payroll_per_year,
		lag(avg_payroll_per_year,1) OVER (PARTITION BY industry_branch_name ORDER BY YEAR) AS previous_year_avg_payroll,
		round(((avg_payroll_per_year - lag(avg_payroll_per_year,1 ) OVER (PARTITION BY industry_branch_name ORDER BY YEAR)) * 100 / lag(avg_payroll_per_year,1) OVER (PARTITION BY industry_branch_name ORDER BY YEAR)),2) AS avg_payroll_percentage_change,
		CASE 
			WHEN avg_payroll_per_year > lag(avg_payroll_per_year,1) OVER (PARTITION BY industry_branch_name ORDER BY YEAR) THEN 'increasing' 
			WHEN avg_payroll_per_year < lag(avg_payroll_per_year,1) OVER (PARTITION BY industry_branch_name ORDER BY YEAR) THEN 'decreasing'
			ELSE  'unchanged'
		END year_on_year_trend
	FROM t_lucie_sujanova_project_SQL_primary_final
	GROUP BY  
		YEAR, 
		branch_code,
		industry_branch_name, 
		avg_payroll_per_year, 
		payroll_unit 
	)
SELECT * 
FROM payroll_differences
WHERE previous_year_avg_payroll IS NOT NULL			--mimo rok 2006
ORDER BY
	year_on_year_trend,
	YEAR, 
	branch_code;

