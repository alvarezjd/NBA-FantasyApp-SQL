-----------------------------------------------
-- Jock MKT NBA Dataset Project - Import Data
-----------------------------------------------

-- Create Database
USE Master
Go

CREATE DATABASE JockMktNBA
GO

USE JockMktNBA
GO

-- Import tables from csv files

-- Create Teams table with script and then import the csv file to fill it in
CREATE TABLE Teams
(
team_id VARCHAR(50) PRIMARY KEY,
[object] CHAR(10),
league CHAR(10),
[name] VARCHAR(20),
[location] CHAR(30),
abbreviation VARCHAR(10)
)

-- Insert the csv file to file in Teams table
BULK INSERT dbo.Teams
FROM 'C:\Users\alvar\Documents\Portfolio Project\R-Portfolio\Portfolio\teamssql.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
-- Create Events Table

CREATE TABLE dbo.Events (
event_id VARCHAR(50) PRIMARY KEY,
[object] VARCHAR(30),
[name] VARCHAR(50),
[description] VARCHAR(50),
[type] VARCHAR(30),
[status] VARCHAR(50),
league VARCHAR(10),
updated_at DATE,
event_date DATE,
ipo_at TIME,
live_at_estimated TIME,
close_at_estimated TIME,
current_shares varchar(50),
ipo_completed_at TIME,
event_end_at TIME
)

BULK INSERT dbo.Events
FROM 'C:\Users\alvar\Documents\Portfolio Project\R-Portfolio\Portfolio\eventssql.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)

-- Create Games table
CREATE TABLE dbo.Games (
game_id VARCHAR(50) PRIMARY KEY,
[object] VARCHAR(50),
[name] VARCHAR(50),
league VARCHAR(10),
game_date DATE,
scheduled_start TIME,
[status] VARCHAR(50),
home_team_id VARCHAR(50),
away_team_id VARCHAR(50)
)
BULK INSERT dbo.Games
FROM 'C:\Users\alvar\Documents\Portfolio Project\R-Portfolio\Portfolio\gamessql.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)

-- Set foreign key for home team
ALTER TABLE Games
ADD CONSTRAINT FK_Home_Team_ID
FOREIGN KEY (home_team_id)
REFERENCES Teams (team_id)
--Set foreign key for away team
ALTER TABLE Games
ADD CONSTRAINT FK_Away_Team_ID
FOREIGN KEY (away_team_id)
REFERENCES Teams (team_id)

-- Create Entities table
CREATE TABLE dbo.Entities (
[entity_id] VARCHAR(50) PRIMARY KEY,
[object] VARCHAR(50),
[name] VARCHAR(50),
[league] VARCHAR(50),
[image_url] VARCHAR(200),
current_team_id VARCHAR(50),
first_name VARCHAR(50),
preferred_name VARCHAR(50),
last_name VARCHAR(50),
position VARCHAR(50),
height VARCHAR(50),
[weight] VARCHAR(50),
jersey_number VARCHAR(50),
birthdate VARCHAR(50),
rookie_year VARCHAR(50),
[status] VARCHAR(50),
updated_at DATE,
injury_status VARCHAR(50),
injury_type VARCHAR(50),
image_key VARCHAR(50)
)

BULK INSERT dbo.Entities
FROM 'C:\Users\alvar\Documents\Portfolio Project\R-Portfolio\Portfolio\entitiessql.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)

-- Set foreign key for current team
ALTER TABLE Entities
ADD CONSTRAINT FK_Current_Team_ID
FOREIGN KEY (current_team_id)
REFERENCES Teams (team_id)

-- Alter Etities datatypes: birthdate
/*ALTER TABLE Entities
ADD new_birthdate date;
UPDATE Entities
SET new_birthdate = CONVERT(date, birthdate, 101);
ALTER TABLE Entities
DROP COLUMN new_birthdate;
EXEC sp_rename 'Entities.new_birthdate', 'birthdate', 'COLUMN';*/

-- Create Tradeables table
CREATE TABLE dbo.Tradeables (
tradeable_id VARCHAR(50) PRIMARY KEY,
[object] VARCHAR(50),
[entity_id] VARCHAR(50),
event_id VARCHAR(50),
updated_at DATE,
projected VARCHAR(50),
scored VARCHAR(50),
projected_rank VARCHAR(50),
scored_rank VARCHAR(50),
ipo VARCHAR(50),
final_price VARCHAR(50),
blocks INT,
points INT,
steals INT,
assists INT,
game_id VARCHAR(50),
[minutes] INT,
[seconds] INT,
rebounds INT,
turnovers INT,
field_goals_att INT,
free_throws_att INT,
field_goals_made INT,
free_throws_made INT,
three_points_att INT,
three_points_made INT,
defensive_rebounds INT,
offensive_rebounds INT
)

BULK INSERT dbo.Tradeables
FROM 'C:\Users\alvar\Documents\Portfolio Project\R-Portfolio\Portfolio\tradeablessql.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)

select * from Tradeables

-- Set foreign key for entity_id
ALTER TABLE Tradeables
ADD CONSTRAINT FK_Entity_ID
FOREIGN KEY (entity_id)
REFERENCES Entities (entity_id)

-- Set foreign key for event_id
ALTER TABLE Tradeables
ADD CONSTRAINT FK_Event_ID
FOREIGN KEY (event_id)
REFERENCES Events (event_id)

/*ALTER TABLE dbo.YourTableName
ADD new_date_time datetime;

UPDATE dbo.YourTableName
SET new_date_time = CONVERT(datetime, old_date_time, 101);

ALTER TABLE dbo.YourTableName
DROP COLUMN old_date_time;

EXEC sp_rename 'dbo.YourTableName.new_date_time', 'date_time', 'COLUMN';*/
