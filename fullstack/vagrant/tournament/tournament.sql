-- Table definitions for the tournament project.
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
DROP TABLE players;
DROP TABLE matches;

CREATE TABLE players(
player_ID int,
player_Name varchar(25)
);

CREATE TABLE matches(
match_ID int,
winner_ID int,
loser_ID int
);


-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


