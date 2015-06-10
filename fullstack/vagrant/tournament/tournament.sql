-- Table definitions for the tournament project.
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
\c vagrant
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

DROP TABLE players;
DROP TABLE matches;

CREATE TABLE players(
player_ID SERIAL NOT NULL PRIMARY KEY,
player_Name varchar(25)
);

CREATE TABLE matches(
match_ID SERIAL NOT NULL PRIMARY KEY,
winner int ,
loser int
);

CREATE VIEW playersStats
AS
SELECT p.player_ID, m.winner, m.loser, m.match_ID 
from matches m 
Right Outer Join players p  On p.player_ID=m.loser OR p.player_ID=m.winner;

CREATE VIEW matchesPlayed
AS
SELECT player_ID, Count(match_ID) as matches_Played 
From playersStats Group BY player_ID;

CREATE VIEW matchesWon
AS
Select player_ID, Count(Distinct match_ID) As matches_Won From (Select a.player_ID, b.match_id
From playersStats a Left Outer Join playersStats b On a.player_ID = b.winner) as foo Group By player_ID;

CREATE VIEW playerStandings
AS
Select p.player_ID, p.player_name, w.matches_Won, mp.matches_Played From players p 
join matchesWon w On p.player_ID = w.player_ID 
join matchesPlayed mp ON w.player_ID = mp.player_ID; 

CREATE VIEW swissPairings
AS
select p1.player_id as P1_ID , p1.player_name AS P1_Name , p2.player_Id as P2_ID, p2.player_name as P2_Name From playerStandings p1
Join playerStandings p2 on p1.matches_won = p2.matches_won and p1.player_ID < p2.player_ID
WHERE p1.player_ID != p2.player_ID;


-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


