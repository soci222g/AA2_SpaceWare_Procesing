class Player { 
  float PosX;
  float PosY;
  
  //rotate
  float Rotation;
  float Current_rotate;
  
  //speed
  float Speed;
  float max_Speed;
  float current_speed;
  
  Player (float x, float y, float speed, float max_S, float Rotate_speed) {  
   PosX = x;
   PosY = y;
   Rotation = Rotate_speed;
   Speed = speed;
   max_Speed = max_S;
   current_speed = 0;
   
   Current_rotate = 0;
   
    
  } 
   
    void printPlayer(){
      
      ellipse(PosX, PosY, 20,20); //en vase que mide 10
    }
    //no hacer un triangulo sino un circulo con un cubo que indique a donde esta mirando.
    void AddForWard(){
      pushMatrix();
      
       translate(PosX,PosY);
       rotate(radians(Current_rotate));
       translate(current_speed,0);
      
        pushMatrix();
        
          fill(0,0,255);
          ellipse(PosX, PosY, 25,25);
        
        translate(25,0);
        fill(255,0,0);
        square(0, 0,25);
        
        popMatrix();
      popMatrix();
      
      // pillar la nueva posicipon del player aqui (en X i en Y)
    }
  
  float Get_Current_Speed(){
   return current_speed;
  }
  
  void addSpeed(){
      if (current_speed < max_Speed){
        current_speed += Speed; 
      }
      
    
  }
  void ReduceSpeed(){
      if(current_speed  > 0.1){
         current_speed -= Speed; 
      }
      else{
        current_speed = 0;
      }
  }





}
 
    
    
  
