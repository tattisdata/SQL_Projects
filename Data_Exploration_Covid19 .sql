/*
Data Exploration before Cleaning Data in SQL Queries
*/


SELECT *
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
ORDER BY 3,4

SELECT *
FROM PortfolioProjectDataBase.dbo.VaccinationsCovid
ORDER BY 3,4

-- Select Data 
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
ORDER BY 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in a) Poland b) Europe c) United States
-- a) Poland
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like 'Poland'
and continent is NOT NULL 
ORDER BY 1,2

-- b) Europe
SELECT continent, location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent like 'Europe'
ORDER BY 2,3

-- c) United States
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like '%states%'
and continent is NOT NULL 
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
ORDER BY 1,2

-- a) Poland
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like 'Poland'
and continent is NOT NULL 
ORDER BY 1,2

-- i) Poland 2020
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like 'Poland'
and continent is NOT NULL 
and date like '%2020%'
ORDER BY 1,2

-- ii) Poland 2021
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like 'Poland'
and continent is NOT NULL 
and date like '%2021%'
ORDER BY 1,2

-- iii) Poland 2022
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like 'Poland'
and continent is NOT NULL 
and date like '%2022%'
ORDER BY 1,2

-- b) Europe
SELECT continent,location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent like 'Europe'
ORDER BY 2,3

-- i) Europe 2020
SELECT continent,location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent like 'Europe'
and date like '%2020%'
ORDER BY 2,3

-- ii) Europe 2021
SELECT continent,location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent like 'Europe'
and date like '%2021%'
ORDER BY 2,3

-- iii) Europe 2022
SELECT continent,location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent like 'Europe'
and date like '%2021%'
ORDER BY 2,3

-- c) United States
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like '%states%'
and continent is NOT NULL 
ORDER BY 1,2

-- i) United States 2020
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like '%states%'
and continent is NOT NULL 
and date like '%2020%'
ORDER BY 1,2

-- i) United States 2021
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like '%states%'
and continent is NOT NULL 
and date like '%2021%'
ORDER BY 1,2

-- iii) United States 2022
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE location like '%states%'
and continent is NOT NULL 
and date like '%2021%'
ORDER BY 1,2

-- Countries with Highest Infection Rate compared to Population
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)*100) as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovid
GROUP BY location, population
ORDER BY PercentPopulationInfected desc

-- Countries with Highest Death Count per Population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
GROUP BY location
ORDER BY TotalDeathCount desc

-- Contintents with the Highest Death Count per Population
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount desc

-- Global Numbers
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
ORDER BY 1,2

-- Global Numbers 2020
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
and date like '%2020%'
ORDER BY 1,2

-- Global Numbers 2021
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
and date like '%2021%'
ORDER BY 1,2

-- Global Numbers 2022
SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovid
WHERE continent is NOT NULL 
and date like '%2022%'
ORDER BY 1,2

-- Total Population vs Vaccinations
SELECT *
FROM PortfolioProjectDataBase.dbo.DeathsCovid dea
JOIN PortfolioProjectDataBase.dbo.VaccinationsCovid vac
     ON dea.location = vac.location
	 AND dea.date = vac.date

-- Shows New Vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProjectDataBase.dbo.DeathsCovid dea
JOIN PortfolioProjectDataBase.dbo.VaccinationsCovid vac
	ON dea.location = vac.location
	and dea.date = vac.date
	WHERE dea.continent is NOT NULL 
	and vac.new_vaccinations is NOT NULL 
ORDER BY 2,3

-- Shows Percentage of Population that received the new vaccination
-- USE CTE
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, New)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, cast(vac.new_vaccinations as int) as New 
FROM PortfolioProjectDataBase.dbo.DeathsCovid dea
JOIN PortfolioProjectDataBase.dbo.VaccinationsCovid vac
     ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent is NOT NULL and vac.new_vaccinations is NOT NULL
)
SELECT *, (New/Population)*100 as PercentNewVaccVSPopulation
FROM PopvsVac
ORDER BY  PercentNewVaccVSPopulation desc

--TEMP TABLE
DROP TABLE IF exists #PercentPopulationNewVaccinated
CREATE TABLE #PercentPopulationNewVaccinated
(
Continent nvarchar(255), 
Location nvarchar(255), 
Date datetime,
Population numeric, 
New_Vaccinations numeric,
New numeric
)

INSERT INTO #PercentPopulationNewVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, cast(vac.new_vaccinations as int) as New 
FROM PortfolioProjectDataBase.dbo.DeathsCovid dea
JOIN PortfolioProjectDataBase.dbo.VaccinationsCovid vac
     ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent is NOT NULL and vac.new_vaccinations is NOT NULL
SELECT *, (New/Population)*100 as PercentNewVaccVSPopulation
FROM #PercentPopulationNewVaccinated
ORDER BY  PercentNewVaccVSPopulation desc

-- Creating View to store data for later visualizations

CREATE VIEW PercentPopulationNewVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, cast(vac.new_vaccinations as int) as New
FROM PortfolioProjectDataBase.dbo.DeathsCovid dea
JOIN PortfolioProjectDataBase.dbo.VaccinationsCovid vac
     ON dea.location = vac.location
	 AND dea.date = vac.date
WHERE dea.continent is NOT NULL and vac.new_vaccinations is NOT NULL

SELECT *
FROM PercentPopulationNewVaccinated






