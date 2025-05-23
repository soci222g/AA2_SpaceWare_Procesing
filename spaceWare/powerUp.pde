//timer global

float SaveLastTimePower;
final int TimeToCreateAPower = 10000; //60 segundos
float currentTimerPower;

class PowerUp{
  
  int numPowerUp; //0 = tripleShoot, 1 = boomerang, 2 = per definir
  float posX;
  float posY;
  
  boolean isActive;
  int spierRadius;
  
  PowerUp(){
    posX = random(width);
    posY = random(height);
    isActive = true;
    spierRadius = 20;
    numPowerUp = int(random(0,2)); //poner random qunado programado los otros
  }
  
  boolean GetIsActive() {return isActive;}
  void printPowerUp(){
  
    if(numPowerUp == 0){
     fill(255,0,0);
     ellipse(posX,posY,spierRadius,spierRadius);
    }
    else if(numPowerUp == 1){
      fill(0,255,0);
       ellipse(posX,posY,spierRadius,spierRadius);
    }
    
  
  
  }
  
  void seePlayer1Collide(){
    //player1 (cubo)
    //pillamos la paret
    float base_position_x_PJ1 = player1.getX() - player1.getSquareLenght() * 0.5;
    float base_position_y_PJ1 =  player1.getY() - player1.getSquareLenght() * 0.5;
    //esfera
    float posPowerX = posX;
    float posPowerY = posY;
    
    //quina de les 2 X del player esta mes aprop el collider
    if(posX < base_position_x_PJ1){
        posPowerX = base_position_x_PJ1;
    }
    else if(posX > (base_position_x_PJ1 + player1.getSquareLenght())){
      posPowerX = base_position_x_PJ1 + player1.getSquareLenght();
    }
    
    if(posY < base_position_y_PJ1){
        posPowerY = base_position_y_PJ1;
    }
    else if(posY > (base_position_y_PJ1 + player1.getSquareLenght())){
      posPowerY = base_position_y_PJ1 + player1.getSquareLenght();
    }
    
    float ClosDisX = posX - posPowerX;
    float ClosDisY = posY - posPowerY;
    
     float Distanca = sqrt((ClosDisX*ClosDisX)+ (ClosDisY*ClosDisY));
     
     if(Distanca <= spierRadius){
         isActive = false;
         player1.activate_powerUp(numPowerUp);
     } 
  }  
  
  void seePlayer2Collide(){
    //player1 (cubo)
    //pillamos la paret
    float base_position_x_PJ2 = player2.getX() - player2.getSquareLenght() * 0.5;
    float base_position_y_PJ2 =  player2.getY() - player2.getSquareLenght() * 0.5;
    //esfera
    float posPowerX = posX;
    float posPowerY = posY;
    
    //quina de les 2 X del player esta mes aprop el collider
    if(posX < base_position_x_PJ2){
        posPowerX = base_position_x_PJ2;
    }
    else if(posX > (base_position_x_PJ2 + player2.getSquareLenght())){
      posPowerX = base_position_x_PJ2 + player2.getSquareLenght();
    }
    
    if(posY < base_position_y_PJ2){
        posPowerY = base_position_y_PJ2;
    }
    else if(posY > (base_position_y_PJ2 + player2.getSquareLenght())){
      posPowerY = base_position_y_PJ2 + player2.getSquareLenght();
    }
    
    float ClosDisX = posX - posPowerX;
    float ClosDisY = posY - posPowerY;
    
     float Distanca = sqrt((ClosDisX*ClosDisX)+ (ClosDisY*ClosDisY));
     
     if(Distanca <= spierRadius){
         isActive = false;
         player2.activate_powerUp(numPowerUp);
     } 
  }    
}


void GenerateRandomPowerUp(){
  currentTimerPower = millis() - SaveLastTimePower;
  if(currentTimerPower > TimeToCreateAPower){
    SaveLastTimePower = millis();
    powers.add(new PowerUp());
  }

  
  
}
