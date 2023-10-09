/*
    Select the following columns from the declared table @SuperCup:
	- Row - descending order by points
	- Team
	- Points
	Use descending order by points.
*/
DECLARE @SuperCup TABLE (Team NVARCHAR(100), Points INT, [Group] NVARCHAR(1))
INSERT INTO @SuperCup (Team, Points, [Group]) VALUES
('Liverpool', 11, 'A'), ('Real Madrid', 8, 'B'), ('Barcelona', 9, 'A'), ('Ajax', 7, 'B'),
('PSG', 7, 'A'), ('Bayern', 9, 'A'), ('Juventus', 10, 'B'), ('Manchaster City', 10, 'B')

SELECT
	Row = ROW_NUMBER() OVER (ORDER BY sc.Points DESC),
    sc.Team,
    sc.Points
FROM
	@SuperCup sc;


/*
    Select the following columns from the declared table @SuperCup:
	- Group
    - Position - Number of a position of the team in a group.
    - Team
    - Points
    Use ascending order by the group and then descending order by points.
*/
DECLARE @SuperCup TABLE (Team NVARCHAR(100), Points INT, [Group] NVARCHAR(1))
INSERT INTO @SuperCup (Team, Points, [Group]) VALUES
('Liverpool', 11, 'A'), ('Real Madrid', 8, 'B'), ('Barcelona', 9, 'A'), ('Ajax', 7, 'B'),
('PSG', 7, 'A'), ('Bayern', 9, 'A'), ('Juventus', 10, 'B'), ('Manchaster City', 10, 'B')

SELECT 
	sc.[Group],
    'Position' = ROW_NUMBER() OVER (PARTITION BY sc.[Group] ORDER BY sc.Points DESC),
    sc.Team,
    sc.Points
FROM 
	@SuperCup sc
    ORDER BY sc.[Group], sc.Points DESC;

/*
    Select the following columns from the declared table @SuperCup
    for the first two teams of each group:
    - Group
    - Position - Number of a position of the team in a group.
    - Team
    - Points
    Use ascending order by the group and then descending order by points.
*/
DECLARE @SuperCup TABLE (Team NVARCHAR(100), Points INT, [Group] NVARCHAR(1))
INSERT INTO @SuperCup (Team, Points, [Group]) VALUES
('Liverpool', 11, 'A'), ('Real Madrid', 8, 'B'), ('Barcelona', 9, 'A'), ('Ajax', 7, 'B'),
('PSG', 7, 'A'), ('Bayern', 9, 'A'), ('Juventus', 10, 'B'), ('Manchaster City', 10, 'B')

;
WITH RankedTeams AS 
(
SELECT 
	sc.[Group],
    ROW_NUMBER() OVER (PARTITION BY sc.[Group] ORDER BY sc.Points DESC) AS Position,
   	sc.Team,
    sc.Points
FROM 
	@SuperCup sc
)
SELECT 
	[Group],
    Position, 
    Team,
    Points
FROM 
	RankedTeams
WHERE 
	Position <=2;


/*
    Select the following columns from the deckared table @Supercup:
    - Group
    - Position - Number of a position of the team in a group.
    - Team
    - Points
	- Info - If the position is 1 or 2, then value 'Playoff' otherwise NULL.
    Use ascending order by the group and then descending order by points.
*/
DECLARE @SuperCup TABLE (Team NVARCHAR(100), Points INT, [Group] NVARCHAR(1))
INSERT INTO @SuperCup (Team, Points, [Group]) VALUES
('Liverpool', 11, 'A'), ('Real Madrid', 8, 'B'), ('Barcelona', 9, 'A'), ('Ajax', 7, 'B'),
('PSG', 7, 'A'), ('Bayern', 9, 'A'), ('Juventus', 10, 'B'), ('Manchaster City', 10, 'B')

;

WITH RankedTeams AS(
SELECT
	sc.[Group],
    ROW_NUMBER() OVER (PARTITION BY sc.[Group] ORDER BY sc.Points DESC) AS Position,
    sc.Team,
    sc.Points
FROM 
	@SuperCup sc
)

SELECT 
	[Group],
    Position,
    Team,
    Points,
    'Info' = CASE
    			WHEN Position <= 2 THEN 'Playoff'
    		 END
FROM 
	RankedTeams;

/*
    Select the following columns from the deckared table @Supercup:
    - RowNumber - Number of a position of the team by points.
    - RankNumber - Number of a position of the team by points
                 - If two teams have the same amount of points, they have the same rank number.
    - Team
    - Points
    Use descending order by points.
*/
DECLARE @SuperCup TABLE (Team NVARCHAR(100), Points INT, [Group] NVARCHAR(1))
INSERT INTO @SuperCup (Team, Points, [Group]) VALUES
('Liverpool', 11, 'A'), ('Real Madrid', 8, 'B'), ('Barcelona', 9, 'A'), ('Ajax', 7, 'B'),
('PSG', 7, 'A'), ('Bayern', 9, 'A'), ('Juventus', 10, 'B'), ('Manchaster City', 10, 'B')


SELECT 
	ROW_NUMBER() OVER (ORDER BY sc.Points DESC) AS RowNumber,
    RANK() OVER (ORDER BY sc.Points DESC) AS RankNumber,
    sc.Team,
    sc.Points
FROM @SuperCup sc
