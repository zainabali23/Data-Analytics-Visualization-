/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

SELECT *
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL 
ORDER BY 3,4


-- SELECT Data that we are going to be starting with

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths$
WHERE continent IS NOT NULL 
ORDER BY 1,2

--------------------------------------------------------------------------------------------------------------------------

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS FLOAT) / total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths$
WHERE location = 'India'
and continent IS NOT NULL 
ORDER BY 1,2

--------------------------------------------------------------------------------------------------------------------------

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths$
-- WHERE location = 'India'
ORDER BY 1,2

--------------------------------------------------------------------------------------------------------------------------

-- Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(CAST(total_cases AS bigint)) AS HighestInfectionCount,
MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths$
-- WHERE location = 'India'
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

--------------------------------------------------------------------------------------------------------------------------

-- Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths AS bigint)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
-- WHERE location = 'India'
WHERE continent IS NOT NULL 
GROUP BY location
ORDER BY TotalDeathCount DESC

--------------------------------------------------------------------------------------------------------------------------

-- Showing continents with the highest death count per population

SELECT location, MAX(CAST(total_deaths AS bigint)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths$
-- WHERE location = 'India'
WHERE continent IS NULL 
GROUP BY location
ORDER BY TotalDeathCount DESC

--------------------------------------------------------------------------------------------------------------------------

-- Global Numbers

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS bigint)) AS total_deaths,
(SUM(CAST(new_deaths AS bigint)) / SUM(New_Cases))*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths$
-- WHERE location = 'India'
WHERE continent IS NOT NULL 
--GROUP BY date
ORDER BY 1,2

--------------------------------------------------------------------------------------------------------------------------

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(CONVERT(bigint, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS TotalPeopleVaccinated
--, (TotalPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL 
ORDER BY 2,3


-- Using CTE to perform Calculation on Partition By in previous query

WITH PopvsVac (continent, location, date, population, new_vaccinations, TotalPeopleVaccinated)
AS
(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, 
SUM(CONVERT(bigint,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS TotalPeopleVaccinated
--, (TotalPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL 
--ORDER BY 2,3
)
SELECT *, (TotalPeopleVaccinated/Population)*100
FROM PopvsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
TotalPeopleVaccinated numeric
)

SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, 
SUM(CONVERT(bigint,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS TotalPeopleVaccinated
--, (TotalPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
	ON cd.location = cv.location
	AND cd.date = cv.date
--WHERE cd.continent IS NOT NULL 
--ORDER BY 2,3

SELECT *, (TotalPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated

--------------------------------------------------------------------------------------------------------------------------

-- Creating View to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, 
SUM(CONVERT(bigint,cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) AS TotalPeopleVaccinated
--, (TotalPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
	ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL 
--ORDER BY 2,3
