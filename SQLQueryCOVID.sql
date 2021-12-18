--SELECT *
--FROM PortfolioProject..CovidDeaths

--SELECT *
--FROM PortfolioProject..CovidVaccinations

--select Data that we are going to be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2 

--Looking at the Total Cases vs Total Deaths
SELECT location, date, total_cases, total_deaths, (cast(total_cases as float))/(cast(total_deaths as float))* 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

--Looking at the Total Cases vs Total Deaths for specific country
SELECT location, date, total_cases, total_deaths, (cast(total_cases as float))/(cast(total_deaths as float))*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%africa%'
ORDER BY 1,2

--Looking at the total cases vs population 
SELECT location, date, population, total_cases, (cast(total_cases as float))/(cast(population as float))*100 AS PercentOfPopulationGotCovid
FROM PortfolioProject..CovidDeaths
--WHERE location like '%africa%'
ORDER BY 1,2

--looking at countries with highest infection rate compared to population
SELECT location, population, MAX(cast(total_cases as float)) AS HighestInfectionCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%africa%'
GROUP BY location, population
ORDER BY 1,2

--looking at countries with highest infection rate compared to population
SELECT location, population, MAX(cast(total_cases as float)) AS HighestInfectionCount, MAX(cast(total_cases as float))/(cast(population as float))*100 AS PercentOfPopulationGotCovid
FROM PortfolioProject..CovidDeaths
--WHERE location like '%africa%'
GROUP BY location, population
ORDER BY PercentOfPopulationGotCovid DESC

--showing the countries with the highest death count per population
SELECT location, MAX(cast(total_deaths as float)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

-- lets break things down by continent
SELECT continent, MAX(cast(total_deaths as float)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

--Global numbers
SELECT date, SUM(cast(new_cases as float)) AS Total_Cases, SUM(cast(new_deaths as float))  AS Total_Deaths, 
	SUM(cast(new_deaths as float))/ SUM(cast(new_cases as float)) *100 AS DeathPercantageGLobally
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

SELECT SUM(cast(new_cases as float)) AS Total_Cases, SUM(cast(new_deaths as float))  AS Total_Deaths, 
	SUM(cast(new_deaths as float))/ SUM(cast(new_cases as float)) *100 AS DeathPercantageGLobally
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1,2

SELECT *
FROM PortfolioProject..CovidVaccinations

--Join two tables
SELECT *
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac. date


-- total population vs vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac. date
WHERE dea.continent is not null
ORDER BY 1,2,3

-- total vaccinations with rolling count of vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS VaccinationsCOUNT
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac. date
WHERE dea.continent is not null
ORDER BY 1,2,3

-- total population vs vaccinations with rolling count of vaccinations (using CTE)
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, VaccinationsCOUNT)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) 
	AS VaccinationsCOUNT
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac. date
WHERE dea.continent is not null
)
SELECT *, (VaccinationsCOUNT/Population) * 100 AS PercentageOFPopulationVaccinated
FROM PopvsVac

-- total population vs vaccinations with rolling count of vaccinations (using temp table)
DROP TABLE if exists PercantPopulationVaccinated
CREATE TABLE PercantPopulationVaccinated
(
	Continent nvarchar(255),
	Location nvarchar(255),
	Date datetime,
	Population numeric,
	New_vaccinations numeric,
	VaccinationsCOUNT numeric
)
INSERT INTO PercantPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(convert(float, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) 
	AS VaccinationsCOUNT
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac. date
WHERE dea.continent is not null

SELECT *, (VaccinationsCOUNT/Population) * 100 AS PercentageOFPopulationVaccinated
FROM PercantPopulationVaccinated


--creating view to store data for later visualizations
CREATE VIEW VaccinationsCOUNT AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.location ORDER BY dea.location, dea.date) AS VaccinationsCOUNT
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac. date
WHERE dea.continent is not null











