#!/usr/bin/env python
 
 #tournament.py -- implementation of a Swiss-system tournament


import psycopg2


def connect(database_name="tournament"):
    try:
        db = psycopg2.connect("dbname={}".format(database_name))
        cursor = db.cursor()
        return db, cursor
    except:
        print("Please check the try block for errors")

# Calls the connect method to connect to database runs command and commits change
# Method used for obtaining , committing to and closing  db tournament 	

def deleteMatches():
	"""Remove all the match records FROM the database."""
	db, cursor = connect()
	query = "DELETE FROM matches;"
	cursor.execute(query)
	db.commit()
	db.close()

	

def deletePlayers():
	"""Remove all the players records FROM the database."""
	db, cursor = connect()
	query = "DELETE FROM players;"
	cursor.execute(query)
	db.commit()
	db.close()


def countPlayers():
	"""Returns the number of players currently registered."""
	db, cursor = connect()
	query = "SELECT COUNT(*) FROM players;"
	cursor.execute(query)
	RegPlayers = cursor.fetchone()[0]
	db.close()
	return RegPlayers
	
def registerPlayer(name):
	"""Adds a player to the tournament database.
  	The database assigns a unique serial id number for the player.  (This
	should be handled by your SQL database schema, not in your Python code.)
  	Args:
	name: the player's full name (need not be unique).
	"""
	db, cursor = connect()

	query = "INSERT INTO players(player_name) VALUES(%s);"
	parameter = (name,)
	cursor.execute(query, parameter)

	db.commit()
	db.close()
	

def playerStandings():

	db, cursor = connect()
	query = "SELECT * FROM player_standings;"
	cursor.execute(query)
	standings = cursor.fetchall()
	db.close()
	return standings
	


def reportMatch(winner, loser):
   
	db, cursor = connect()
	query = ("INSERT INTO matches(winner, loser) VALUES(%s,%s)")
	parameter = (winner,loser,) 
	cursor.execute(query, parameter)
	db.commit()
	db.close()
 
 
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

	beforePairing = playerStandings()
	afterPairing =[]
	
	for i in range(1, len(beforePairing),2):
		player1 = beforePairing[i - 1]
		player2 = beforePairing[i]
		afterPairing.append((player1[0:2] + player2[0:2]))
	
	return afterPairing
	


