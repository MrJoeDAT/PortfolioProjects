--select *
--from PortfolioProject..Covid_Deaths
--where continent is not null
--order by 3, 4

--select *
--from PortfolioProject..Covid_Vaccinations
--where continent is not null
--order by 3, 4

--select location, date, total_cases, new_cases, total_deaths, population
--from PortfolioProject..Covid_Deaths
--where continent is not null
--order by 1, 2

--select location, date, population, total_cases, total_deaths, (CONVERT (decimal(15, 3), total_cases) / CONVERT (decimal(15, 3), population)) * 100 as DeathPercentage
--from PortfolioProject..Covid_Deaths
--Where Location like '%nigeria%'
--and continent is not null
--order by 3, 4

--select location, population, max(cast(total_cases as int)) as HighestInfectionCount, max((CONVERT (decimal(15, 3), total_cases) / CONVERT (decimal(15, 3), population))) * 100 as PercentPopulationInfected
--from PortfolioProject..Covid_Deaths
----Where Location like '%nigeria%'
--where continent is not null
--group by location, population
--order by PercentPopulationInfected desc

--select location, max(cast(total_deaths as int)) as TotalDeathCount
--from PortfolioProject..Covid_Deaths
----Where Location like '%nigeria%'
--where continent is not null
--group by location
--order by TotalDeathCount desc


--select location, max(cast(total_deaths as int)) as TotalDeathCount
--from PortfolioProject..Covid_Deaths
----Where Location like '%nigeria%'
--where continent is not null
--group by location
--order by TotalDeathCount desc

--select location, max(cast(total_deaths as int)) as TotalDeathCount
--from PortfolioProject..Covid_Deaths
--where continent is null
--group by location
--order by TotalDeathCount desc

--select date, sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths, sum(cast(new_deaths as int)) / sum(new_cases) * 100 as DeathPercentage
--from PortfolioProjectAlex..CovidDeaths
--where continent is not null
--group by date
--order by 1, 2

--select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths, sum(cast(new_deaths as int)) / sum(new_cases) * 100 as DeathPercentage
--from PortfolioProjectAlex..CovidDeaths
--where continent is not null
--group by date
--order by 1, 2



--with PopvsVac (continent, location, date, population, New_Vaccination, RollingPeopleVaccinated)
--as
--(
--select dth.continent, dth.location, dth.date, dth.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over (partition by dth.location order by dth.location, dth.date) as RollingPeopleVaccinated
--from PortfolioProject..Covid_Deaths dth
--join PortfolioProject..Covid_Vaccinations vac
--	on dth.location = vac.location
--	and dth.date = vac.date
--where dth.continent is not null
----and dth.location like '%state%'
----order by 2, 3
--)
--select *, (RollingPeopleVaccinated/population) * 100
--from PopvsVac


--Drop table if exists #PercentPopulationVaccinated
--create table #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_Vaccinations numeric,
--RollingPeopleVaccinated numeric
--)

--insert into #PercentPopulationVaccinated
--select dth.continent, dth.location, dth.date, dth.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over (partition by dth.location order by dth.location, dth.date) as RollingPeopleVaccinated
--from PortfolioProject..Covid_Deaths dth
--join PortfolioProject..Covid_Vaccinations vac
--	on dth.location = vac.location
--	and dth.date = vac.date
----where dth.continent is not null
----and dth.location like '%state%'
----order by 2, 3

--select *, (RollingPeopleVaccinated / population) * 100
--from #PercentPopulationVaccinated



Create View PercentPopulationVaccinated as
select dth.continent, dth.location, dth.date, dth.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over (partition by dth.location order by dth.location, dth.date) as RollingPeopleVaccinated
from PortfolioProject..Covid_Deaths dth
join PortfolioProject..Covid_Vaccinations vac
	on dth.location = vac.location
	and dth.date = vac.date
where dth.continent is not null
--and dth.location like '%state%'
--order by 2, 3

--drop view dbo.PercentPopulationVaccinated

select *
from PercentPopulationVaccinated