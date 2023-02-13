-- The code answered some questions in the CosmeticsChemical database

SELECT *
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`

-- Find out which chemicals were used the most in cosmetics and personal care products
SELECT ChemicalName, count(ChemicalName) as ChemicalNameCount
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
GROUP BY ChemicalName
ORDER BY 2 DESC

-- Find out which companies used the most reported chemicals in their cosmetics and personal care products
SELECT CompanyName, count(InitialDateReported) as CountofInitialReportDate
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
GROUP BY 1
ORDER BY 2 DESC

-- Which brands had chemicals that were removed and discontinued? Identify the chemicals
SELECT BrandName, count(brandname) as CountOfBrandName, ChemicalName, ChemicalDateRemoved as DateRemoved
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE ChemicalDateRemoved IS NOT NULL
GROUP BY 1, 3, 4
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
WHERE ChemicalDateRemoved IS NOT NULL and DiscontinuedDate IS NOT NULL

-- Identify the period between the creation of the removed chemicals and when they were actually removed
SELECT ChemicalCreatedAt, ChemicalDateRemoved, DATE_DIFF(ChemicalCreatedAt, ChemicalDateRemoved, month)
FROM `portfolio-project-375106.sqlproject.chemicals_in_cosmetics`
WHERE ChemicalDateRemoved IS NOT NULL
ORDER BY 1
