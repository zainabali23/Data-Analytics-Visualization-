-- Queries used for Tableau Project

--------------------------------------------------------------------------------------------------------------------------

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS bigint)) AS total_deaths,
(SUM(CAST(new_deaths AS bigint)) / SUM(new_cases))*100 AS DeathPercentage
From PortfolioProject..CovidDeaths$
--WHERE location = 'India'
WHERE continent IS NOT NULL 
--GROUP BY date
ORDER BY 1,2

--------------------------------------------------------------------------------------------------------------------------

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

SELECT location, SUM(CAST(new_deaths AS bigint)) AS TotalDeathCount
From PortfolioProject..CovidDeaths$
--WHERE location = 'India'
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International', 'High income', 'Upper middle income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY TotalDeathCount DESC

--------------------------------------------------------------------------------------------------------------------------

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/Population))*100 AS PercentPopulationInfected
From PortfolioProject..CovidDeaths$
--WHERE location = 'India'
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

--------------------------------------------------------------------------------------------------------------------------

SELECT Location, Population, date, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/Population))*100 AS PercentPopulationInfected
From PortfolioProject..CovidDeaths$
--WHERE location = 'India'
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC