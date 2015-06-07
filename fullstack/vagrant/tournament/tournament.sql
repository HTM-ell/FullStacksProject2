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
CREATE VIEW playerStats
AS
SELECT p.player_ID, m.winner, m.loser, m.match_ID 
from matches m 
Right Outer Join players p  On p.player_ID=m.loser OR p.player_ID=m.winner;

CREATE VIEW playersWins
AS
select player_Id, Count(player_ID = winner) as WinCount 
from playerstats Group By player_ID;

CREATE VIEW matchesPlayed
AS
SELECT player_ID, Count(match_ID) as matchesPlayed 
From playerStats Group BY player_ID;

CREATE VIEW playerStandings
AS
Select p.player_ID, p.player_name, w.WinCount, mp.matchesPlayed From players p 
join playersWins w ON p.player_ID = w.player_ID 
join matchesPlayed mp ON w.player_ID = mp.player_ID;






 

-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


