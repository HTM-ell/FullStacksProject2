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
	"""Remove all the players records from the database."""
	conn = connect()
	curs = conn.cursor()
	curs.execute("Delete FROM players")
	conn.commit()
	conn.close()


def countPlayers():
	"""Returns the number of players currently registered."""
	conn = connect()
	curs = conn.cursor()
	curs.execute("Select Count(*) As registered_players From players as in_tournament")
	RegPlayers = curs.fetchone()[0]
	return RegPlayers
	conn.close()
	
	
def registerPlayer(name):
	"""Adds a player to the tournament database.
  	The database assigns a unique serial id number for the player.  (This
	should be handled by your SQL database schema, not in your Python code.)
  	Args:
	name: the player's full name (need not be unique).
	"""
	conn = connect()
	curs = conn.cursor()
	curs.execute("Insert Into players(player_name) Values(%s)" ,(name,))
	conn.commit()
	conn.close()
	
	


def playerStandings():

	conn = connect()
	curs = conn.cursor()
	curs.execute("Select * From player_standings")
	standings = curs.fetchall()
	return standings
	conn.close()
	
	


def reportMatch(winner, loser):
   
	conn = connect()
	curs = conn.cursor()
	curs.execute("Insert Into matches(winner, loser) Values(%s,%s)", (winner,loser,))
	conn.commit()
	conn.close()
 
 
def swissPairings():
    # Returns a list of pairs of players for the next round of a match.
    # Assuming that there are an even number of players registered, each player
    # appears exactly once in the pairings.  Each player is paired with another
    # player with an equal or nearly-equal win record, that is, a player adjacent
    # to him or her in the standings.
    #  Returns:
    # A list of tuples, each of which contains (id1, name1, id2, name2)
    #    id1: the first player's unique id
    #   name1: the first player's name
    #    id2: the second player's unique id
    #   name2: the second player's name1
	afterPairing = []
	
	conn = connect()
	curs = conn.cursor()
	curs.execute("Select * from player_standings")
	beforePairing = curs.fetchall()
	for index in range(len(beforePairing)):
	
		if(beforePairing[index][3] == beforePairing[index+1][3]):
			if(beforePairing[2] == beforePairing[index+1][2]):
				afterPairing[index].append(beforePairing[index][0],beforePairing[index][1],beforePairing[index+i][0],beforePairing[index+i][1])
				beforePairing.remove(index)
				beforePairing.remove(index+i)
	print afterPairing
			
		
	return afterPairing
	conn.close()
	



