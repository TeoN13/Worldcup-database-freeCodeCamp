#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals+opponent_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo  "$($PSQL "SELECT AVG(winner_goals+opponent_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(GREATEST(winner_goals, opponent_goals)) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE GREATEST(winner_goals, opponent_goals)>2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM teams FULL JOIN games ON teams.team_id=games.winner_id WHERE year=2018 AND round='Final'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo  "$($PSQL "SELECT DISTINCT 
    winner_team.name as team_name
FROM 
    games
JOIN teams as winner_team 
ON games.winner_id = winner_team.team_id
WHERE games.year = 2014 AND games.round='Eighth-Final'
UNION
SELECT DISTINCT 
    opponent_team.name as team_name
FROM 
    games
JOIN teams as opponent_team
ON games.opponent_id = opponent_team.team_id
WHERE games.year = 2014 AND games.round='Eighth-Final'
ORDER BY team_name;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo  "$($PSQL "SELECT DISTINCT(name) FROM games LEFT JOIN teams ON games.winner_id=teams.team_id ORDER BY name")"

echo -e "\nYear and team name of all the champions:"
echo  "$($PSQL "SELECT year, name FROM games LEFT JOIN teams ON games.winner_id=teams.team_id WHERE round='Final' ORDER BY year")"

echo -e "\nList of teams that start with 'Co':"
echo  "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"