-- DATA CLEAING -- 
-- --------- 1. First of all create a copy of DataSet ---------

CREATE TABLE layoffs_copy
LIKE layoffs;

INSERT layoffs_copy 
SELECT * 
FROM layoffs;

SELECT * 
FROM layoffs_copy; 

-- --------- 2. Remove Duplicates ---------
-- Create a Common Table Expression (CTE) is used here to create a temporary result set
WITH duplicate_laid AS 
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country) AS row_num
FROM layoffs_copy
)
SELECT * 
FROM duplicate_laid 
WHERE row_num > 1;

/* 
to delet the duplicates there're two methodes one fro "duplicate_laid".
another one create an new table with "row_num" then delete it.
*/

WITH duplicate_laid AS 
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country) AS row_num
FROM layoffs_copy
)
DELETE 
FROM duplicate_laid 
WHERE row_num > 1;
-- -------------------------------------------------------- --
/* Create a copy of the dataset that includes the new columns and other modifications, 
and then delete the rows that are unwanted or unnecessary.*/

CREATE TABLE `layoffs_copy2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_copy2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country) AS row_num
FROM layoffs_copy;

DELETE
FROM layoffs_copy2
WHERE row_num > 1;

-- --------- 3. Standarize Data ----------------

SELECT company, TRIM(company), industry, TRIM(industry)
FROM layoffs_copy2;

UPDATE layoffs_copy2
SET company = TRIM(company);
-- ------------------------ --
SELECT  distinct(industry)
FROM layoffs_copy2
ORDER BY 1;

UPDATE layoffs_copy2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';
-- ------------------------ --
SELECT  distinct(country)
FROM layoffs_copy2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_copy2
ORDER BY 1;

UPDATE layoffs_copy2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';
-- ------------------------ --
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_copy2;

UPDATE layoffs_copy2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_copy2
MODIFY COLUMN `date` DATE;

-- --------- 4. Dealing with NULL Values ---------
-- exploring NULL values

SELECT DISTINCT industry
FROM layoffs_copy2;

SELECT *
FROM layoffs_copy2
WHERE industry IS NULL
OR industry = '';

SELECT t1.industry, t2.industry
FROM layoffs_copy2 t1
JOIN layoffs_copy2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- Convert the "BLANK" to "NULL" to deals with them
UPDATE layoffs_copy2
SET industry = NULL
WHERE industry  = '';

UPDATE layoffs_copy2 t1
JOIN layoffs_copy2 t2
	ON t1.company = t2.company
SET  t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- Check the NULLS
SELECT * 
FROM layoffs_copy2
WHERE industry IS NULL;

/*
There's one company didn't affect due to there's no smiller data to populating it 
So we can drop it if we need 
*/

DELETE 
FROM layoffs_copy2
WHERE industry IS NULL;
-- ------------------------ --

SELECT * 
FROM layoffs_copy2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
-- There're alot data of NULL values, and for this case we can't deal with it.
-- So we can delete it.

DELETE 
FROM layoffs_copy2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- --------- 5. Remove unwanted columns ---------
ALTER TABLE layoffs_copy2
DROP COLUMN row_num;



