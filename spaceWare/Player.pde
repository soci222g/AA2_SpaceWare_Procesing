class Player { 
  int PosX;
  int PosY;
  int Rotation;
  
  Player (int x, int y) {  
   PosX = x;
   PosY = y;
   Rotation = 0;
   
    
  } 
   
    void printPlayer(){
      
      triangle(PosX, PosY, PosX + 10, PosY -20, PosX - 10, PosY -20); //en vase que mide 10
    }
  





}
 
    
    
  
