/*
I Cleaning Data in SQL Queries
*/
SELECT *
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning

--------------------------------------------------------------
-- Standardize Date Format
SELECT date, CONVERT(Date, date)
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning

-- date ---> dateconverted
ALTER TABLE DeathsCovidDataCleaning
ADD  dateconverted Date;

UPDATE DeathsCovidDataCleaning
SET dateconverted = CONVERT(Date, date)

--
SELECT dateconverted
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning

--------------------------------------------------------------
-- Cleaning NULL values
-- a) deleting rows with NULL values that don't contain useful data
-- 1 query
SELECT *
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE total_cases IS NULL and total_deaths IS NULL

-- 2 deleting rows
-- SELECT
WITH RowNumCTE AS(
SELECT *,
     ROW_NUMBER() OVER (
	 PARTITION BY total_cases,
                  new_cases,
				  total_deaths,
				  new_deaths,
				  total_cases_per_million
				  ORDER BY
				      location, date
					  ) row_num
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
)
SELECT *
FROM RowNumCTE
WHERE total_cases IS NULL and total_deaths IS NULL and row_num > 0
ORDER BY location

-- DELETE (-9146 rows)
WITH RowNumCTE AS(
SELECT *,
     ROW_NUMBER() OVER (
	 PARTITION BY total_cases,
                  new_cases,
				  total_deaths,
				  new_deaths,
				  total_cases_per_million
				  ORDER BY
				      location, date
					  ) row_num
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
)
DELETE
FROM RowNumCTE
WHERE total_cases IS NULL and total_deaths IS NULL and row_num > 0

--b) change NULL to 0 
-- 19621 rows
SELECT *
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE total_deaths IS NULL OR new_deaths IS NULL OR new_cases IS NULL

-- 19621 rows
SELECT location, date, total_deaths, new_deaths, new_cases, ISNULL(total_deaths, 0), ISNULL(new_deaths, 0), ISNULL(new_cases, 0)
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE total_deaths IS NULL OR new_deaths IS NULL OR new_cases IS NULL

-- total_deaths --> total_deaths_converted (19142 rows)
-- SELECT
SELECT location, date, total_deaths, new_deaths, new_cases
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE total_deaths IS NULL 

-- UPDATE
UPDATE DeathsCovidDataCleaning
SET total_deaths = ISNULL(total_deaths, 0)
WHERE total_deaths IS NULL 

-- new_deaths --> deaths_converted
-- SELECT (19225 rows)
SELECT location, date, total_deaths, new_deaths, new_cases
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE new_deaths IS NULL 

-- UPDATE
UPDATE DeathsCovidDataCleaning
SET new_deaths = ISNULL(new_deaths, 0)
WHERE new_deaths IS NULL 

-- new_cases --> new_cases_converted
-- SELECT (317 rows)
SELECT location, date, total_deaths, new_deaths, new_cases
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE new_cases IS NULL 

-- UPDATE
UPDATE DeathsCovidDataCleaning
SET new_cases = ISNULL(new_cases, 0)
WHERE new_cases IS NULL 

-- c) change NULL to 0 others (new_cases_smoothed, ...)

UPDATE DeathsCovidDataCleaning
SET new_cases_smoothed = ISNULL(new_cases_smoothed, 0)
WHERE new_cases_smoothed IS NULL 

UPDATE DeathsCovidDataCleaning
SET new_deaths_smoothed = ISNULL(new_deaths_smoothed, 0)
WHERE new_deaths_smoothed IS NULL 

UPDATE DeathsCovidDataCleaning
SET new_cases_smoothed_per_million= ISNULL(new_cases_smoothed_per_million, 0)
WHERE new_cases_smoothed_per_million IS NULL

UPDATE DeathsCovidDataCleaning
SET total_deaths_per_million= ISNULL(total_deaths_per_million, 0)
WHERE total_deaths_per_million IS NULL

UPDATE DeathsCovidDataCleaning
SET new_deaths_per_million= ISNULL(new_deaths_per_million, 0)
WHERE new_deaths_per_million IS NULL

UPDATE DeathsCovidDataCleaning
SET new_cases_per_million= ISNULL(new_cases_per_million, 0)
WHERE new_cases_per_million IS NULL

UPDATE DeathsCovidDataCleaning
SET new_deaths_smoothed_per_million = ISNULL(new_deaths_smoothed_per_million, 0)
WHERE new_deaths_smoothed_per_million IS NULL

SELECT *
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
--WHERE new_deaths_smoothed_per_million IS NULL 

--------------------------------------------------------------
-- Delete Unused Columns
--
SELECT *
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning

--
ALTER TABLE PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
DROP COLUMN date, weekly_hosp_admissions, weekly_hosp_admissions_per_million, weekly_icu_admissions, weekly_icu_admissions_per_million, hosp_patients_per_million, hosp_patients, icu_patients, icu_patients_per_million, reproduction_rate