-- Table definitions for the tournament project.
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.

-- Commands for Deleting current database and schema, creating new database and connecting to it
\c vagrant
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

-- Commands to ensure that table are not already created.
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS matches;

-- Command that creates the players table in which player's name and player ID or stored
CREATE TABLE players(
player_id SERIAL NOT NULL PRIMARY KEY,
player_name varchar(25)
);

-- Commad that creates the matches table in which the match ID, winning player ID and 
-- losing player ID of each particular match are stored. 
CREATE TABLE matches(
match_id SERIAL NOT NULL PRIMARY KEY,
winner int references players(player_id),
loser int references players(player_id)
);

CREATE TABLE swiss_pairings

-- View that shows a player's ID number, match_id and the winner and or loser of that match ID

CREATE VIEW players_stats
AS
SELECT p.player_id, m.winner, m.loser, m.match_id 
from matches m 
Right Outer Join players p  On p.player_id=m.loser OR p.player_id=m.winner;


-- View that shows the number of matches that were played by a particular player ID
CREATE VIEW matches_played
AS
SELECT player_id, Count(match_id) as played_matches
From players_stats Group BY player_id Order by player_id;

--  View that shows the number of matches one per player ID
CREATE VIEW matches_won
AS
Select player_id, Count(Distinct match_id) As won_matches From (Select a.player_id, b.match_id
From players_stats a Left Outer Join players_stats b On a.player_id = b.winner) as combplayer_match Group By player_id;

-- View that shows the name of a player, the number of matches they have won and played collectively per Player ID
CREATE VIEW player_standings
AS
Select p.player_id, p.player_name, w.won_matches, mp.played_matches From players p 
join matches_won w On p.player_id = w.player_id 
join matches_played mp ON w.player_id = mp.player_id; 

-- View that shows the pairings for a particular round of matches. 
CREATE VIEW swiss_pairings
AS
select p1.player_id as P1_ID , p1.player_name AS P1_Name , p2.player_id as P2_ID, p2.player_name as P2_Name From player_standings p1
