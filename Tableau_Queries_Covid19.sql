/*
III Queries used for Tableau Portfolio Project Covid19
*/

-- 1. 
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentageGlobal
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
ORDER BY 1,2

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentagein2020
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL and dateconverted like '%2020%'
ORDER BY 1,2

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentagein2021
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL and dateconverted like '%2021%'
ORDER BY 1,2

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentagein2022
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL and dateconverted like '%2022%'
ORDER BY 1,2

-- 2. 
SELECT location, SUM(cast(new_deaths as int)) as TotalDeathCount
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NULL 
and location NOT IN ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY TotalDeathCount DESC

--3.
SELECT location, population, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--4.
SELECT location, population, dateconverted, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
and location NOT IN ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')

GROUP BY location, population, dateconverted
ORDER BY PercentPopulationInfected DESC

--4.a
SELECT location, population, dateconverted, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location IN ('Austria', 'Poland', 'Germany', 'France') and dateconverted LIKE '%2022%'

GROUP BY location, population, dateconverted
ORDER BY PercentPopulationInfected DESC

--4.b
SELECT location, population, dateconverted, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location IN ('Austria', 'Poland', 'Germany', 'France') and dateconverted NOT LIKE '%2022%'

GROUP BY location, population, dateconverted
ORDER BY PercentPopulationInfected DESC