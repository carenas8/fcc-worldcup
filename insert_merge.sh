#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# ~~~~~~~~~~~~


cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS 
do
  if [[ $YEAR == 2014 && $ROUND == 'Eighth-Final' ]]
    then
    # get winner team_id
    W_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    O_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    TG_WINNER=$($PSQL "INSERT INTO teams_games(year,round,team_id,team) VALUES($YEAR,'$ROUND',$W_ID,'$WINNER')")

    TG_OPPONENT=$($PSQL "INSERT INTO teams_games(year,round,team_id,team) VALUES($YEAR,'$ROUND',$O_ID,'$OPPONENT')")

  fi

  


done

