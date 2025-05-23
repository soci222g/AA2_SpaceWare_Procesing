class Score {
  int playerScore = 0;
  //int p1Score = 0;
  //int p2Score = 0;
  
  
  //geter
  
  int GetScore(){ return playerScore;}
  
  
  void AddPlayerScore( int score){
    
    
      playerScore += score;
    
    
      
     println("Puntos actuales: " + playerScore);
  }
  
  
}
