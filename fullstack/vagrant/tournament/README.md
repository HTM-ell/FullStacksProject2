
Synopsis
This project is to create a keeptrack of players and matches in a game tournament.

Motivation
The game tournament will use Swiss systems for pairing players and assumes an even number of players to be entered into the game

Installation/Execution
Python
postsql
Vagrant file

After installing Python and PostSql on you machine (Lauching Vagrant file with these applications already installed) change directory to FullStacksProject2/fullstack/vagrant/tournament from shell

Type psql into command line to open PostSql command line
Type: "/i tournament.sql" to create database 'tournament and to create the needed tables and views from tournament.sql file
Type: "/c tournament to connect to tournament datadase
Proceed to type sql statems such as " Select * From players" to view tables or view
To exit psql command line press "Ctrl+d"

To run the python file please enter the following in the main shell:
python tournament_test.py (to run the test file)

To debug python code file please enter python command line by enter "python" into the shell
Once in the python commandline type:
import tournament as t
Use the following syntax to execute functions with in the tournament.py file

t.swissPairing()
