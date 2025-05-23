class Player { 
  float PosX;
  float PosY;
  int squareLenght;
  
  //rotate
  float Rotation;
  float Current_rotate;
  float Current_rotate_speed;
  float Max_rotation_Speed;
  
  //speed
  float Speed;
  float max_Speed;
  float current_speed;
  
  
  float shootColdown;
  float currentColdown;
  float LastSavePlayerShoot;
  boolean CanShoot;
  
  
  int timerPowerUp;
  float currentTimePowerUp;
  float LastSavePlayerPowerUps;
  
  //powerUpsTrigers
  boolean tripleShotActive;
  boolean boomeranShoot;
  boolean invincibilityActive;
  
  PImage navePJ;
  PImage navePJ_original;
  
  PVector PositonText;
  int TextoDistancia;
  float TextoSpeed;
  
  
  Player (float x, float y, float speed, float max_S, float Rotate_speed, float MaxRotationSpeed, PImage img) {  
    
   PosX = x;
   PosY = y;
   Rotation = Rotate_speed;
   Speed = speed;
   max_Speed = max_S;
   current_speed = 0;

   //rotation
   Current_rotate = 270;
   Current_rotate_speed= 0;
   Max_rotation_Speed = MaxRotationSpeed;
   squareLenght = 40;
    
    //imagne player
    navePJ = img;
    navePJ_original = img.copy();
    
    //colldown shoot
    shootColdown = 4000;
    currentColdown = 0;
    LastSavePlayerShoot = -4000;
    CanShoot = true;
    
    //condocionales power up
    tripleShotActive = false;
    boomeranShoot = false;
    invincibilityActive = false;
    
    //timer power up
    timerPowerUp = 10000;
    currentTimePowerUp = 0;
    LastSavePlayerPowerUps = 0;
    
    //posicion inical texto
    PositonText = new PVector(x - 50,y - 50);
    TextoDistancia = 50;
    TextoSpeed = 0.1;
    
  } 
  
  
//geters
  float getCurrentRotation(){ return Current_rotate; }
  float getX(){ return PosX;}
  float getY(){ return PosY;}
  int getSquareLenght() { return squareLenght;}
  
  
  float Get_Current_Speed(){   return current_speed;}
  
  boolean Get_CanShoot(){ return CanShoot;}
  
  boolean GetTripleShoot(){ return tripleShotActive;}
  boolean GetBoomeranShoot(){ return boomeranShoot;}
  boolean GetInvincibility() { return invincibilityActive;}
  
  int GetSquareLengt(){return squareLenght;}
  
  //print mediante transforma contando la speed del jugador
    void PrintPlayer(){
      pushMatrix();
      
       translate(PosX,PosY);
       rotate(radians(Current_rotate));
       translate(current_speed,0);
      
        pushMatrix();
        
        //debujar al jugador (qui le pasa la imagen)
          //fill(0,0,255);
          //rectMode(CENTER);
          //square(0, 0, squareLenght);
          imageMode(CENTER);
          image(navePJ, 0,0,squareLenght,squareLenght);
        
        PosX = modelX(0,0,0);
        PosY = modelY(0,0,0);
        
        popMatrix();
      
      popMatrix();
      
     //Amb això aqui el player es printeja al moment de canviar d'un costat de la pantalla a l'altre
      PlayerBorders();
      
      
    }

//sistema de anyadir speed de forma progresiva
  void addSpeed(){
      if (current_speed < max_Speed){
        current_speed += Speed; 
      }
      
    
  }
  //reduccion de speed de forma prograsiva
  void ReduceSpeed(){
   
    if(current_speed  > 0.1){
         current_speed -= Speed; 
      }
      else{
        current_speed = 0;
      }
     

  }
  //colldown del disparo meditante millis
  void activateColldown(){ LastSavePlayerShoot = millis(); }
  
  //shoot coldown
  void ColldownShoot(){
    currentColdown = millis() - LastSavePlayerShoot;
      if(currentColdown > shootColdown){
          CanShoot = true;
        }
        else{
          CanShoot = false;
        }
         
  }
  

  
  //rotation progresiva, misma logica que la speed pero rotando (no tiene drag final para mayor control)
  
  void RotateLeft(){
    
    
     if(Current_rotate_speed > (Max_rotation_Speed * -1)){
      Current_rotate_speed -= Rotation;
     }
      Current_rotate += Current_rotate_speed; 
  
  
  
  
  if(Current_rotate <= 0){
      Current_rotate = 360;
     }

      
  }
  
  void RotateRight(){
    
 
 //miramos si la totacion ha alcanzado la velocidad maxima, si no sige hacelerando   
    if(Current_rotate_speed < Max_rotation_Speed){
      
      Current_rotate_speed += Rotation; 
    }
    
      Current_rotate += Current_rotate_speed;
      
      //condicional para que no se aumente el int de forma infinita de la rotacion.
     if(Current_rotate >= 360){
      Current_rotate = 0;
      }
   
 
  }

void stopRotation(){
  Current_rotate_speed = 0;
}

//si se sobrepaas del obrde tp al otro lado

void PlayerBorders() { // Movimiento del PJ
 

    // Reapareixer al creuar els bordes esquerre i dret de la pantalla augmantem una mica el valor perque no es fagi tp en el centra de la imatge sino al final
    if (PosX > width + 10) {
        PosX = -10;
    } else if (PosX < -10) {
        PosX = width + 10;
    }

    // Reapareixer al creuar els bordes de dalt i abaix de la pantalla augmantem una mica el valor perque no es fagi tp en el centra de la imatge sino al final
    if (PosY > height + 10) {
        PosY = -10;
    } else if (PosY < -10) {
        PosY = height + 10;
    }
}

//cuna el player collisona amb un powwer up activals
  void activate_powerUp(int NumPower){
    if(NumPower == 0){
      tripleShotActive = true;
      //currentTimePowerUp = timerPowerUp;
      LastSavePlayerPowerUps = millis();
      activeLutPW = true;

    }
    if(NumPower == 1){
        boomeranShoot = true;
         //currentTimePowerUp = timerPowerUp;
        LastSavePlayerPowerUps = millis();
        activeLutPW = true;  
    }
    if(NumPower == 2){
      println("AZULLLLL");
      invincibilityActive = true;
      //currentTimePowerUp = timerPowerUp;
      LastSavePlayerPowerUps = millis();
      activeLutPW = true;
    }
  }

String tipoLut = "";

//timer de los power ups, pro millis();
void TimerPowerUps(){
        if(tripleShotActive){
          tipoLut = "red";
            
            currentTimePowerUp = millis() - LastSavePlayerPowerUps;
          if(currentTimePowerUp > timerPowerUp){
             tripleShotActive = false;
              activeLutPW = false;  //hem de normalitzar aixo (utilitzar funcio millis)

          }
          else{
          LUT_PW(navePJ, tipoLut); 
          }
                   
        }
        if(boomeranShoot){
           tipoLut = "green";
          
           currentTimePowerUp = millis() - LastSavePlayerPowerUps;
          if(currentTimePowerUp > timerPowerUp){
           
                boomeranShoot = false;
                activeLutPW = false;
                 //hem de normalitzar aixo (utilitzar funcio millis)
               
          }
            else{
                LUT_PW(navePJ, tipoLut); 
            } 
          }
        
        
         if(invincibilityActive){
            tipoLut = "blue";
           currentTimePowerUp = millis() - LastSavePlayerPowerUps;
          if(currentTimePowerUp > timerPowerUp){
               invincibilityActive = false;
              
            } else {
             LUT_PW(navePJ, tipoLut); 
            }
         }
        
      if (activeLutPW) {
        applyLUTToPlayer(this, tipoLut);  // Aplica LUT a copia segura
      } else {
        navePJ = navePJ_original.copy();  // Restaura
      }

          
  }

//sistam de padfinding del texto con la puntuacion.
void FollowText(int Score){

  //generamos un vector que apunte a donde esta la jugador (restando posicion de inicio - posicion final)
  PVector CallDistance = new PVector(PositonText.x - PosX, PositonText.y - PosY);
  
  //normalize il vector de la distancia entre el text i el player;
   float Distance_Normal = sqrt(CallDistance.x*CallDistance.x + CallDistance.y * CallDistance.y);
//en caso de que el texto este mas lejos de la distancia despaza el texto.
  if(TextoDistancia <= Distance_Normal){
    //formular del padfinding = (1-Alfa) * posicionA + posicionB * alfa;
    PositonText.x = (1-TextoSpeed) *  PositonText.x + PosX * TextoSpeed;
    PositonText.y = (1-TextoSpeed) *  PositonText.y + PosY * TextoSpeed;
  }
  fill(0, 255, 255);
  textSize(12);
  text("Puntuacion: " + Score,PositonText.x, PositonText.y);

  
}

  

}
 
    
    
  
