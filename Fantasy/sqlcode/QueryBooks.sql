--CLEANING DATA
SELECT  REPLACE (genre,'genre fiction','fiction') FROM Books_Data_Clean$
UPDATE Books_Data_Clean$
SET genre =REPLACE(genre,'genre fiction','fiction')
SELECT*FROM Books_Data_Clean$
ALTER TABLE Books_Data_Clean$
DROP COLUMN [INDEX]
SELECT COUNT(*) FROM Books_Data_Clean$
WHERE [Book Name] IS NULL
DELETE FROM Books_Data_Clean$
WHERE [Book Name] IS NULL
--CHANGING YEAR TYPE TO INT
SELECT*FROM Books_Data_Clean$$
ALTER TABLE Books_Data_Clean$$ ALTER COLUMN [PUBLISHING YEAR] INT
SELECT COUNT(*)FROM Books_Data_Clean$$
SELECT*FROM Books_Data_Clean$$
--ANALYZING SALES
--1-SALES BY GENRE
SELECT GENRE, CAST(SUM([GROSS SALES]) AS INT) FROM Books_Data_Clean$$
GROUP BY genre
ORDER BY 2 DESC
--2- SALES BY LANGUAGE
SELECT language_code, CAST(SUM([gross sales]) AS INT) FROM Books_Data_Clean$$
WHERE language_code IS NOT NULL
GROUP BY language_code
ORDER BY 2 DESC
SELECT*FROM Books_Data_Clean$$
--3- SALES BY YEAR
SELECT [PUBLISHING YEAR], SUM([GROSS SALES]) FROM Books_Data_Clean$$
WHERE [Publishing Year] IS NOT NULL AND [Publishing Year] >1000
GROUP BY [Publishing Year]
ORDER BY 2 DESC
--------------------------
--ANALYZING EACH AUTHOR AVG RATING
SELECT AUTHOR, AVG([Book_average_rating]) FROM Books_Data_Clean$$
WHERE AUTHOR IS NOT NULL
GROUP BY AUTHOR
ORDER BY 2 DESC

SELECT AUTHOR, [FICTION], [NONFICTION] FROM (SELECT AUTHOR, GENRE FROM Books_Data_Clean$$) AS Y
PIVOT( COUNT(GENRE) FOR GENRE IN([FICTION], [NONFICTION])
) AS PV


SELECT * FROM Books_Data_Clean$$
PIVOT(COUNT(GENRE) FOR GENRE IN(FICTION, NONFICTION, CHILDREN)) AS PVT

SELECT AUTHOR, [FICTION], [NONFICTION], [CHILDREN] FROM ( SELECT AUTHOR, GENRE, [GROSS SALES] FROM Books_Data_Clean$$) AS L
PIVOT(SUM([GROSS SALES]) FOR GENRE IN ([FICTION],[NONFICTION],[CHILDREN])) AS T
WHERE [FICTION] IS NOT NULL AND [NONFICTION] IS NOT NULL AND [CHILDREN] IS NOT NULL

SELECT AUTHOR, [FICTION], [NONFICTION], [CHILDREN] FROM ( SELECT AUTHOR, GENRE FROM Books_Data_Clean$$) AS L
PIVOT(COUNT([GENRE]) FOR GENRE IN ([FICTION],[NONFICTION],[CHILDREN])) AS T
WHERE AUTHOR LIKE 'William Shakespeare'

select * from Books_Data_Clean$$
where author like'William%'

select distinct cast(Book_average_rating as int) from Books_Data_Clean$$
SELECT CASE
WHEN Book_average_rating >=2 AND Book_average_rating<3.5 THEN 'POOR'
WHEN Book_average_rating >=3.5 AND Book_average_rating<4 THEN 'AVG'
WHEN Book_average_rating >=4 AND Book_average_rating<5 THEN 'GOOD'
END RATING
FROM Books_Data_Clean$$
ALTER TABLE Books_Data_Clean$$ ADD RATING VARCHAR(50);
UPDATE Books_Data_Clean$$
SET RATING = CASE WHEN Book_average_rating >=2 AND Book_average_rating<3.5 THEN 'POOR'
WHEN Book_average_rating >=3.5 AND Book_average_rating<4 THEN 'AVG'
WHEN Book_average_rating >=4 AND Book_average_rating<5 THEN 'GOOD'
END 

SELECT*FROM Books_Data_Clean$$

SELECT GENRE, [POOR], [AVG], [GOOD] FROM ( SELECT GENRE, RATING FROM Books_Data_Clean$$) AS T
PIVOT( COUNT(RATING) FOR RATING IN ([POOR],[AVG],[GOOD])

) AS PVT
