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
SELECT player_ID, Count(match_ID) as matchesPlayed 
From playersStats Group BY player_ID;

CREATE VIEW matchesWon
AS
Select player_ID, Count(Distinct match_ID) As matchesWon From (Select a.player_ID, b.match_id
From playersStats a Left Outer Join playersStats b On a.player_ID = b.winner) as foo Group By player_ID;

CREATE VIEW playerStandings
AS
Select p.player_ID, p.player_name, w.matchesWon, mp.matchesPlayed From players p 
join matchesWon w On p.player_ID = w.player_ID 
join matchesPlayed mp ON w.player_ID = mp.player_ID;






 

-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


