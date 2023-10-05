-- Checking for duplicated rows
SELECT
	  first_name
	, last_name
	, age
	, Happy_Sad_group
	, Dosage
	, Drug
	, Mem_Score_Before
	, Mem_Score_After
	, Diff
	, COUNT(*)
FROM
	  my-data-project-1337-387221.islander.islander
GROUP BY
	  first_name
	, last_name
	, age
	, Happy_Sad_group
	, Dosage
	, Drug
	, Mem_Score_Before
	, Mem_Score_After
	, Diff
HAVING COUNT(*) > 1;
-- RESULTS: Query returned no results.
-- End of checking for duplicated rows.

-- Checking for missing values.
SELECT 
	  COUNT(CASE WHEN first_name IS NULL THEN 1 END) AS missing_first_name
	, COUNT(CASE WHEN last_name IS NULL THEN 1 END) AS missing_last_name
	, COUNT(CASE WHEN age IS NULL THEN 1 END) AS missing_age
	, COUNT(CASE WHEN Happy_Sad_group IS NULL THEN 1 END) AS missing_Happy_Sad_group
	, COUNT(CASE WHEN Dosage IS NULL THEN 1 END) AS missing_Dosage
	, COUNT(CASE WHEN Mem_Score_Before IS NULL THEN 1 END) AS missing_Mem_Score_Before
	, COUNT(CASE WHEN Mem_Score_After IS NULL THEN 1 END) AS missing_Mem_Score_After
	, COUNT(CASE WHEN Diff IS NULL THEN 1 END) AS missing_Diff
FROM
	  my-data-project-1337-387221.islander.islander;
-- RESULTS: Query returned 0 for every category.
-- End of checking for missing values.

-- Checking distributions for normality.
-- For the 'age' column:
SELECT 
      FLOOR(age/10) * 10 AS bin_start
    , FLOOR(age/10) * 10 + 9 AS bin_end
    , COUNT(*) AS count
FROM
	  my-data-project-1337-387221.islander.islander
GROUP BY
	  bin_start
    , bin_end;

-- For the 'Mem_Score_Before' column:
SELECT 
      FLOOR(Mem_Score_Before/10) * 10 AS bin_start
    , FLOOR(Mem_Score_Before/10) * 10 + 9.9 AS bin_end
    , COUNT(*) AS count
FROM
	  my-data-project-1337-387221.islander.islander
GROUP BY
	  bin_start
    , bin_end
ORDER BY
	  bin_start ASC;

-- For the 'Mem_Score_After' column:
SELECT 
      FLOOR(Mem_Score_After/10) * 10 AS bin_start
    , FLOOR(Mem_Score_After/10) * 10 + 9.9 AS bin_end
    , COUNT(*) AS count
FROM
	my-data-project-1337-387221.islander.islander
GROUP BY
	  bin_start
    , bin_end
ORDER BY
			bin_start ASC;

-- For the 'Diff' column:
SELECT 
      FLOOR(Diff/10) * 10 AS bin_start
    , FLOOR(Diff/10) * 10 + 9.9 AS bin_end
    , COUNT(*) AS count
FROM
	my-data-project-1337-387221.islander.islander
GROUP BY
	  bin_start
    , bin_end
ORDER BY
      bin_start ASC;
-- End of Checking distributions for normality.

-- Start Checking Qualitative Distributions
SELECT
	  Happy_Sad_group
	, COUNT(*) 
FROM
	  my-data-project-1337-387221.islander.islander
GROUP BY
	  Happy_Sad_group;
-- Uniformly distributed

SELECT
	  Drug
	, COUNT(*) 
FROM
	  my-data-project-1337-387221.islander.islander
GROUP BY
	  Drug;
-- Uniformly distributed
-- End of Checking Qualitative Distributions

-- Verifying Diff column calculations.
SELECT
      *
    , (Mem_Score_After - Mem_Score_Before) AS Difference
FROM
      my-data-project-1337-387221.islander.islander
WHERE
      ABS((Mem_Score_After - Mem_Score_Before) - Diff) > 0.01;
-- Query returns no results. Calculations confirmed.
-- End of Verifying Diff column calculations.