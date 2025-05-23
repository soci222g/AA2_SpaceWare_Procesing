class Score {
  int playerScore = 0;
  //int p1Score = 0;
  //int p2Score = 0;
  
  //getter
  int GetScore(){ return playerScore;}
  
  //modificamos la score segun el valor que nos pasan.
  void AddPlayerScore( int score){
      playerScore += score;
  }
}
