/*
projekt do Engeto Online Akademie, Datový analytik s Pythonem 5.3.2025
projekt z SQL
verze č.1
author: Lucie Šujanová
email: lsujanova@seznam.cz
 */

--Tvorba sekundární tabulky
CREATE TABLE IF NOT EXISTS t_lucie_sujanova_project_SQL_secondary_final AS
SELECT 
	YEAR,
	country,
	gdp
FROM economies
WHERE country = 'Czech Republic'
AND YEAR BETWEEN '2006' and '2018';
ORDER BY year;

--Zobrazení sekundární tabulky
SELECT *
FROM t_lucie_sujanova_project_SQL_secondary_final