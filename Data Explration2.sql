-- The code answered some questions in the CosmeticsChemical database

SELECT *
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`

SELECT *
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`

-- Find out which chemicals were used the most in cosmetics and personal care products
SELECT ChemicalName, count(ChemicalName) as ChemicalNameCount
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
GROUP BY ChemicalName
ORDER BY 2 DESC

-- Find out which companies used the most reported chemicals in their cosmetics and personal care products
SELECT CompanyName, count(InitialDateReported) as ReportCount
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
GROUP BY 1
ORDER BY 2 DESC

-- Which brands had chemicals that were removed and discontinued? Identify the chemicals
SELECT distinct(BrandName), ChemicalName
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE ChemicalDateRemoved IS NOT NULL AND DiscontinuedDate IS NOT NULL
ORDER BY 1

-- Identify the brands that had chemicals which were mostly reported in 2018
SELECT BrandName, count(InitialDateReported) as NoTimesReportedin2018
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE extract(year from initialdatereported) = 2018
GROUP BY 1
ORDER BY 2 DESC

-- Which brands had chemicals discontinued and removed?
SELECT distinct BrandName
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE (ChemicalDateRemoved IS NOT NULL) and (DiscontinuedDate IS NOT NULL)

-- Identify the period between the creation of the removed chemicals and when they were actually removed
SELECT distinct(ChemicalName), DATE_DIFF(ChemicalDateRemoved, ChemicalCreatedAt, day)
as DayDifference
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE ChemicalDateRemoved IS NOT NULL
ORDER BY 2 DESC

-- Can you tell if discontinued chemicals in bath products were removed
SELECT count(DiscontinuedDate) as DiscontinuedDateCount, count(ChemicalDateRemoved) as DateRemovedCount
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE (PrimaryCategory = 'Bath Products') AND DiscontinuedDate IS NOT NULL

-- How long were removed chemicals in baby products used? (Tip: Use creation date to tell)
SELECT ChemicalName, ChemicalCreatedAt, ChemicalDateRemoved, 
      date_diff(ChemicalDateRemoved, ChemicalCreatedAt, day) as DayDifference
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE (PrimaryCategory = 'Baby Products') AND (ChemicalDateRemoved) IS NOT NULL
ORDER BY 4 DESC

-- Identify the relationship between chemicals that were mostly recently reported and discontinued.
-- (Does most recently reported chemicals equal discontinuation of such chemicals?)
SELECT ChemicalName, count(MostRecentDateReported) as CountOfMostRecent, count(DiscontinuedDate) as CountofDiscontinued
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
GROUP BY 1
ORDER BY 2 DESC


-- Identify the relationship between CSF and chemicals used in the most manufactured sub categories.
-- (Tip: Which chemicals gave a certain type of CSF in sub categories?)
SELECT CSF, ChemicalName, SubCategory, count(SubCategory) as SubCartegoryCount
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE CSF IS NOT NULL
GROUP BY 1, 2, 3
ORDER BY 4 DESC

