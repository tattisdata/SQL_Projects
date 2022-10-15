/*
II Data Exploration after Cleaning Data in SQL Queries
*/

--------------------------------------------------------------
-- Select Data 
SELECT location, dateconverted, total_cases, new_cases, total_deaths, population
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
ORDER BY 1,2

--------------------------------------------------------------
---- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in a) Poland b) Europe c) United States
--------------------------------------------------------------
-- a) Poland
--------------------------------------------------------------

SELECT location, dateconverted, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like 'Poland'
and continent is NOT NULL 
ORDER BY 1,2

--------------------------------------------------------------
-- b) Europe
--------------------------------------------------------------

SELECT continent, location, dateconverted, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent like 'Europe'
ORDER BY 2,3

--------------------------------------------------------------
-- c) United States
--------------------------------------------------------------

SELECT location, dateconverted, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like '%states%'
and continent is NOT NULL 
ORDER BY 1,2

--------------------------------------------------------------
-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
--------------------------------------------------------------

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
ORDER BY 1,2
--------------------------------------------------------------
-- a) Poland
--------------------------------------------------------------

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like 'Poland'
and continent is NOT NULL 
ORDER BY 1,2

-- i) Poland 2020

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like 'Poland'
and continent is NOT NULL 
and dateconverted like '%2020%'
ORDER BY 1,2

-- ii) Poland 2021

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like 'Poland'
and continent is NOT NULL 
and dateconverted like '%2021%'
ORDER BY 1,2

-- iii) Poland 2022

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like 'Poland'
and continent is NOT NULL 
and dateconverted like '%2022%'
ORDER BY 1,2

--------------------------------------------------------------
-- b) Europe
--------------------------------------------------------------

SELECT continent,location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent like 'Europe'
ORDER BY 2,3

-- i) Europe 2020

SELECT continent,location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent like 'Europe'
and dateconverted like '%2020%'
ORDER BY 2,3

-- ii) Europe 2021

SELECT continent,location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent like 'Europe'
and dateconverted like '%2021%'
ORDER BY 2,3

-- iii) Europe 2022

SELECT continent,location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent like 'Europe'
and dateconverted like '%2021%'
ORDER BY 2,3

--------------------------------------------------------------
-- c) United States
--------------------------------------------------------------

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like '%states%'
and continent is NOT NULL 
ORDER BY 1,2

-- i) United States 2020

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like '%states%'
and continent is NOT NULL 
and dateconverted like '%2020%'
ORDER BY 1,2

-- i) United States 2021

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like '%states%'
and continent is NOT NULL 
and dateconverted like '%2021%'
ORDER BY 1,2

-- iii) United States 2022

SELECT location, dateconverted, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE location like '%states%'
and continent is NOT NULL 
and dateconverted like '%2021%'
ORDER BY 1,2

--------------------------------------------------------------
-- Countries with Highest Infection Rate compared to Population
--------------------------------------------------------------

SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)*100) as PercentPopulationInfected
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
GROUP BY location, population
ORDER BY PercentPopulationInfected desc

--------------------------------------------------------------
-- Countries with Highest Death Count per Population
--------------------------------------------------------------

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
GROUP BY location
ORDER BY TotalDeathCount desc

--------------------------------------------------------------
-- Contintents with the Highest Death Count per Population
--------------------------------------------------------------

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount desc

--------------------------------------------------------------
-- Global Numbers
--------------------------------------------------------------

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
ORDER BY 1,2

-- a) Global Numbers 2020

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
and dateconverted like '%2020%'
ORDER BY 1,2

-- b) Global Numbers 2021

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
and dateconverted like '%2021%'
ORDER BY 1,2

-- c) Global Numbers 2022

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProjectDataBase.dbo.DeathsCovidDataCleaning
WHERE continent is NOT NULL 
and dateconverted like '%2022%'
ORDER BY 1,2

