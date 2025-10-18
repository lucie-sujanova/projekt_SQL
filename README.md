# Projekt z SQL – Engeto Online Akademie  
**Kurz:** Datový analytik s Pythonem  
**Datum odevzdání:** 5. 3. 2025  
**Verze:** 1.0  
**Autor:** Lucie Šujanová  
**Email:** lsujanova@sezna.cz  

---

## Popis projektu  
Cílem projektu je získat odpovědi na zadané otázky týkající se dostupnosti základních potravin široké veřejnosti v České republice.  

---

## Zdrojové databáze  

### A. Datové tabulky a číselníky (poskytnuté Engetem, původ z Portálu otevřených dat ČR)

#### a) Mzdy  
- `czechia_payroll`  
- `czechia_payroll_calculation`  
- `czechia_payroll_industry_branch`  
- `czechia_payroll_unit`  
- `czechia_payroll_value_type`  

#### b) Ceny potravin  
- `czechia_price`  
- `czechia_price_category`  

#### c) Údaje o regionech a ekonomikách  
- `czechia_region`  
- `czechia_district`  
- `countries`  
- `economies`  

### B. Jiné veřejně dostupné podklady  
- [Dokumentace datové sady ČSÚ](https://csu.gov.cz/docs/107508/a7309d97-c5be-4ef4-de2f-d2962e385b93/110079-22dds.htm)

---

## Výzkumné otázky  

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?  
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?  
3. Která kategorie potravin zdražuje nejpomaleji (má nejnižší percentuální meziroční nárůst)?  
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (více než o 10 %)?  
5. Má výška HDP vliv na změny ve mzdách a cenách potravin?

---

## Otázka č. 1  
### Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?  

Oproti roku 2006 byly všechny mzdy v roce 2018 vyšší.  
Meziročně však mzdy ve všech odvětvích nerostou – dohromady bylo nalezeno 25 záznamů se zápornou meziroční změnou.  

#### Poklesy mezd podle roku:
| Rok | Odvětví |
|-----|----------|
| 2009 | A, B, I, L |
| 2010 | M, O, P |
| 2011 | D, H, I, O |
| 2013 | B, D, E, F, G, J, K, L, M, N, R |
| 2014 | B |
| 2015 | D |

Nejvíce poklesů bylo zaznamenáno v roce 2013.  
Nejčastějším odvětvím s poklesem mezd bylo B – těžba a dobývání.  

---

## Otázka č. 2  
### Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období?

Porovnány jsou roky 2006 a 2018, pro které jsou dostupná potřebná data.  
Výsledné množství litrů mléka a kilogramů chleba, které lze koupit za jednu měsíční mzdu, je uvedeno ve výstupu dotazu.  

- Odvětví s nejnižším nákupem obou surovin: Ubytování a pohostinství  
- Odvětví s nejvyšším nákupem:  
  - v roce 2006 – Peněžnictví a pojišťovnictví  
  - v roce 2018 – Informační a komunikační činnosti

---

## Otázka č. 3  
### Která kategorie potravin zdražuje nejpomaleji?

- Nejpomaleji zdražuje: Banány žluté (+0,81 %)  
- Položky s poklesem cen (2006–2018):  
  - Cukr krystalový (−1,92 %)  
  - Rajská jablka červená (−0,74 %)

---

## Otázka č. 4  
### Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (více než o 10 %)?

Pro výpočet byly použity dva dotazy:  
- bez rozdělení podle odvětví  
- s rozdělením podle odvětví

#### 4.1 Bez rozdělení podle odvětví  
Neexistuje rok, ve kterém by byl meziroční nárůst cen potravin vyšší o více než 10 % oproti růstu mezd.

#### 4.2 S rozdělením podle odvětví  
Existuje jeden případ:  
- Rok 2013, odvětví Peněžnictví a pojišťovnictví – růst mezd o 13 % při poklesu cen o 8,83 %.  
Celkový rozdíl činil 13,93 %.

---

## Otázka č. 5  
### Má výška HDP vliv na změny ve mzdách a cenách potravin?

#### Vliv HDP na mzdy  
Z grafického zobrazení vyplývá, že vývoj HDP se promítá do vývoje mezd se zpožděním přibližně 1–2 roky.  
Růst HDP zvyšuje zisky podniků a s mírným zpožděním se promítá do růstu mezd.  

![Vývoj změn HDP a mezd](images/HDP_Mzdy.png)

#### Vliv HDP na ceny potravin  
Ceny potravin jsou ovlivněny více faktory (např. inflací, cenami surovin, počasím, dovozy a vývozy).  
Změny HDP se do nich projevují jen částečně a vývoj cen je výrazně volatilnější než vývoj HDP nebo mezd.

![Vývoj HDP a cen potravin](images/HDP_potraviny.png)

---

## Závěr  
Projekt ukazuje, že růst ekonomiky se projevuje především ve mzdách, nikoli přímo v cenách potravin.  
Ceny potravin jsou proměnlivější a ovlivněné řadou externích faktorů.  
