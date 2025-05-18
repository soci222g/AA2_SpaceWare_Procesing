class Player { 
  float PosX;
  float PosY;
  
  //rotate
  float Rotation;
  float Current_rotate;
  float Current_rotate_speed;
  float Max_rotation_Speed;
  //speed
  float Speed;
  float max_Speed;
  float current_speed;
  
  Player (float x, float y, float speed, float max_S, float Rotate_speed, float MaxRotationSpeed) {  
   PosX = x;
   PosY = y;
   Rotation = Rotate_speed;
   Speed = speed;
   max_Speed = max_S;
   current_speed = 0;
   
   Current_rotate = 0;
   Current_rotate_speed= 0;
   Max_rotation_Speed = MaxRotationSpeed;
    
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
          rectMode(CENTER);
          square(0, 0, 25);
        
        PosX = modelX(0,0,0);
        PosY = modelY(0,0,0);
        
        popMatrix();
      
      popMatrix();
      
     
      
      
      // pillar la nueva posicipon del player aqui (en X i en Y)
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
  
  
  
  //rotation
  
  void RotateLeft(){
    
    Current_rotate_speed -= Rotation;
    
     if(Current_rotate_speed > (Max_rotation_Speed * -1)){
       Current_rotate -= Current_rotate_speed; 
        print(Current_rotate);
     }
   if(Current_rotate <= 0){
      Current_rotate = 360;
     }

      print(Current_rotate);
  }
  
  void RotateRight(){
    
    Current_rotate_speed += Rotation;
    
    if(Current_rotate_speed < Max_rotation_Speed){
      Current_rotate += Current_rotate_speed;
      
      if(Current_rotate >= 360){
      Current_rotate = 0;
      }
      
    }
   
 
  }

void stopRotation(){
  Current_rotate_speed = 0;
}




//geters
  float getCurrentRotation(){

    return Current_rotate;
}

  
  float Get_Current_Speed(){
   return current_speed;
  }
  

}
 
    
    
  
