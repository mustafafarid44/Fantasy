SELECT*FROM players$
--CHECKING FOR NULL PLAYERS VALUES
SELECT NAME FROM players$
WHERE NAME IS NULL
--NO NULL VALUES FOUND
--CHECKING FOR DUPLICATES
SELECT NAME, COUNT(*) FROM players$
GROUP BY NAME
HAVING COUNT(*)>1
--NO DUPLICATES FOUND
-- DEF STATS
CREATE VIEW [DEF] AS 
SELECT ID, NAME,TEAM,POSITION, goals_conceded, expected_goals_conceded, 
goals_conceded_per_90, expected_goals_conceded_per_90, selected_by_percent, own_goals, clean_sheets, clean_sheets_per_90, total_points FROM players$
--ATT STATS
CREATE VIEW [ATT] AS
SELECT ID, NAME,TEAM,POSITION, goals_scored, expected_goals,assists, expected_assists, [goals_scored]+[ASSISTS] AS GOAL_INVOLVEMENTS, expected_goal_involvements,
expected_goal_involvements_per_90, penalties_order, penalties_missed, selected_by_percent, threat, creativity,total_points FROM players$

SELECT*FROM ATT


