# SQL Data Cleaning and Exploratory Data Analysis
Using the global layoffs dataset from 2020 to 2023, perform data cleaning and exploratory analysis with MySQ.
![green-divider](https://user-images.githubusercontent.com/7065401/52071924-c003ad80-2562-11e9-8297-1c6595f8a7ff.png)
## Overview 
In recent years, the world has grappled with significant crises, including the COVID-19 pandemic and various conflicts, impacting numerous sectors. From this perspective, we will conduct a comprehensive analysis of global layoffs, focusing on data cleaning and exploration to uncover the insights hidden within the dataset.

## Dataset 
The dataset is included in the repository files as CSV.
The dataset on global layoffs includes key information such as the company name, location, industry, total number of employees laid off, percentage of layoffs, date of layoffs, company stage (e.g., startup or established), country, and funds raised.

## Project Goals
- **Clean the data:**
First, create a copy of the dataset to protect the original database from any potential damage. Next, address duplicate data; one effective method is to remove duplicates that do not impact our analysis. To facilitate this, a Common Table Expression (CTE) can be used to create a temporary result set, with two methods implemented in the script.

The third step involves standardizing the data, which includes handling spaces in words, ensuring consistent data types, and aligning similar fields and locations. Finally, address any NULL values by utilizing available data from the dataset, or if that’s not possible, consider deleting those records.

- **Explore the data:**
In this step doing some exploratory techniques to analyze the dataset.

  ## Project Output
1. The maximum number of layoffs at a single company reached 12,000 employees, representing the company's full capacity.
2. The years 2020 and 2022 saw the highest number of layoffs.
3. The major tech companies, often referred to as FANG (Facebook, Amazon, Netflix, Google), accounted for significant layoffs: Amazon with 36,300, Google with 24,000, and Meta with 22,000 employees over four years.
4. The consumer and retail sectors experienced the largest layoffs.
5. The top three countries with the most layoffs were the USA, India, and the Netherlands.
6. The peak year for layoffs was 2020, with a total of 161,996 layoffs attributed to the COVID-19 crisis.

![green-divider](https://user-images.githubusercontent.com/7065401/52071924-c003ad80-2562-11e9-8297-1c6595f8a7ff.png)

This project illustrates the application of data analytics skills to extract meaningful insights from layoff data. It highlights the crucial role of data in guiding decision-making and showcases expertise in data exploration and analysis



