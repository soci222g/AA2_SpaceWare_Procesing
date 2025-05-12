class Player { 
  int PosX;
  int PosY;
  int Rotation;
  
  Player (int x, int y) {  
   PosX = x;
   PosY = y;
   Rotation = 180;
   
    
  } 
   
    void printPlayer(){
      
      triangle(PosX, PosY, PosX + 10, PosY -20, PosX - 10, PosY -20); //en vase que mide 10
    }
    
    void AddForWard(){
      pushMatrix();
         rotate(radians(Rotation));
       translate(PosX,PosY);
     
       fill(0,0,255);
       triangle(0,0 , 10, -20,  -10, -20);
      popMatrix();
    }
  





}
 
    
    
  
