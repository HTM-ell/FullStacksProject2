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

-- View that shows a player's ID number, match_id and the winner and or loser of that match ID

CREATE VIEW players_stats
AS
SELECT p.player_id, m.winner, m.loser, m.match_id 
FROM matches m 
RIGHT OUTER JOIN players p  On p.player_id=m.loser OR p.player_id=m.winner;


-- View that shows the number of matches that were played BY a particular player ID
CREATE VIEW matches_played
AS
SELECT player_id, COUNT(match_id) as played_matches
FROM players_stats GROUP BY player_id ORDER BY player_id;

--  View that shows the number of matches one per player ID
CREATE VIEW matches_won
AS
SELECT player_id, COUNT(Distinct match_id) As won_matches FROM (SELECT a.player_id, b.match_id
FROM players_stats a LEFT OUTER JOIN players_stats b On a.player_id = b.winner) as combplayer_match GROUP BY player_id;

-- View that shows the name of a player, the number of matches they have won and played collectively per Player ID
CREATE VIEW player_standings
AS
SELECT p.player_id, p.player_name, w.won_matches, mp.played_matches FROM players p 
JOIN matches_won w On p.player_id = w.player_id 
JOIN matches_played mp ON w.player_id = mp.player_id 
ORDER BY w.won_matches, mp.played_matches; 