/*
projekt do Engeto Online Akademie, Datový analytik s Pythonem 5.3.2025
projekt z SQL
verze č.1
otázka č. 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? 
	Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
email: lsujanova@seznam.cz
 */

-- Řešení 5. otázky

WITH entry AS (
    SELECT
        tpm1.year,
        round(avg(tpm1.avg_price), 2) AS avg_price,
        round(avg(tpm1.avg_payroll_per_year), 2) AS avg_payroll,
        round((tpm2.gdp)::numeric, 2) AS gdp  
    FROM t_lucie_sujanova_project_SQL_primary_final tpm1
    LEFT JOIN t_lucie_sujanova_project_SQL_secondary_final tpm2
        ON tpm1.year = tpm2.year
    GROUP BY tpm1.year, tpm2.gdp
),
calc_1 AS (
    SELECT 
        *,
        lag(avg_price) OVER (ORDER BY year) AS previous_year_avg_price,
        lag(avg_payroll) OVER (ORDER BY year) AS previous_year_avg_payroll,
        lag(gdp) OVER (ORDER BY year) AS previous_year_gdp
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
        END AS payroll_percentage_change,
        CASE 
            WHEN previous_year_gdp IS NOT NULL AND previous_year_gdp <> 0 THEN
                round(((gdp - previous_year_gdp) / previous_year_gdp) * 100, 2) 
            ELSE NULL
        END AS gdp_percentage_change        
    FROM calc_1
)
SELECT 
    c2.year,
    c2.gdp,
    c2.previous_year_gdp,
    c2.avg_price AS avg_price,
    c2.previous_year_avg_price,
    c2.avg_payroll AS avg_payroll,
    c2.previous_year_avg_payroll,
    c2.gdp_percentage_change,
    c2.price_percentage_change,
    c2.payroll_percentage_change
FROM calc_2 c2
WHERE c2.previous_year_avg_price IS NOT NULL
GROUP BY 
	c2.year, 
	c2.gdp, 
	c2.gdp_percentage_change, 
	c2.price_percentage_change, 
	c2.payroll_percentage_change,
	c2.avg_price,
	c2.avg_payroll,
	c2.previous_year_gdp,
	c2.previous_year_avg_payroll,
	previous_year_avg_price
ORDER BY c2.year ASC;
