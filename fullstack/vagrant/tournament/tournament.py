#!/usr/bin/env python
 
 #tournament.py -- implementation of a Swiss-system tournament


import psycopg2


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")

# Calls the connect method to connect to database runs command and commits change
# Method used for obtaining , committing to and closing  db tournament 	

def deleteMatches():
	"""Remove all the match records from the database."""
	conn = connect()
	curs = conn.cursor()
	curs.execute("Delete FROM matches")
	conn.commit()
	conn.close()

	

def deletePlayers():
	conn = connect()
	curs = conn.cursor()
	curs.execute("Delete FROM players")
	conn.commit()
	conn.close()


def countPlayers():
	"""Returns the number of players currently registered."""
	conn = connect()
	curs = conn.cursor()
	curs.execute("Select Count(*) As Registered_Players From (Select * From players) as foo")
	RegPlayers = curs.fetchone()[0]
	return RegPlayers
	
	
def registerPlayer(name):
	"""Adds a player to the tournament database.
  	The database assigns a unique serial id number for the player.  (This
	should be handled by your SQL database schema, not in your Python code.)
  	Args:
	name: the player's full name (need not be unique).
	"""
	conn = connect()
	curs = conn.cursor()
	curs.execute("Insert Into players(player_name) Values('%s')" %(name,))
	conn.commit()
	conn.close()
	
	


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.  The first entry in the list should be the player in first place, or a player
    tied for first place if there is currently a tie.
	Returns:
    A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played"""
	conn = connect()
	curs = conn.cursor()
	curs.execute('''''')
	test = curs.fetchall()
	print test
	
	


def reportMatch(winner, loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
 
 
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.
  
    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.
  
    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """



