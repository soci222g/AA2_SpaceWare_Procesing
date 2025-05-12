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
      
      ellipse(PosX, PosY, 20,20); //en vase que mide 10
    }
    //no hacer un triangulo sino un circulo con un cubo que indique a donde esta mirando.
    void AddForWard(){
      pushMatrix();
      
       translate(PosX,PosY);
       fill(0,0,255);
       ellipse(0, 0, 25,25);
        pushMatrix();
        rotate(radians(Rotation));
        translate(25,0);
        fill(255,0,0);
        square(0,-13,25);
        
      popMatrix();
      popMatrix();
    }
  





}
 
    
    
  
