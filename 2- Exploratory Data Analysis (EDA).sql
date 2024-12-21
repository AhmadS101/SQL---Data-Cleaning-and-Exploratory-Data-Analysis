-- Exploratory Data Analysis (EDA) -- 

SELECT MAX(total_laid_off)
FROM layoffs_copy2;

SELECT DISTINCT company, YEAR (`date`)
FROM layoffs_copy2
WHERE percentage_laid_off = 1
AND  YEAR (`date`) = 2020
ORDER BY 2 ASC;

SELECT DISTINCT company, YEAR (`date`)
FROM layoffs_copy2
WHERE percentage_laid_off = 1
AND  YEAR (`date`) = 2022
ORDER BY 2 ASC;

SELECT company, SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY company
ORDER BY 2 DESC;


SELECT industry, SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_copy2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY 1 ASC;

WITH Rolling_Total AS 
(
SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS Total_laid
FROM layoffs_copy2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `Month` 
ORDER BY 1 ASC
)
SELECT `Month`, Total_laid ,SUM(Total_laid) OVER(ORDER BY `Month`) AS Rolling_Total
FROM Rolling_Total;

WITH company_year (company, years, total_laid) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_copy2
GROUP BY company, YEAR(`date`)
), company_year_rank AS
(
SELECT *, 
DENSE_RANK () OVER(PARTITION BY years ORDER BY Total_laid DESC) AS Ranking
FROM company_year 
WHERE years IS NOT NULL 
)
SELECT *
FROM company_year_rank
WHERE Ranking <= 5;















