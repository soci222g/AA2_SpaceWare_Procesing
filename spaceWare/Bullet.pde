



class bullet{
  boolean isActive;
  boolean Player1;
  
  float PosX;
  float PosY;
    
  float Rotation;
  int FlySpeed;
  
  int lifeTime;
  float currentLifeTime;
  
  
  
  bullet(boolean playerAsigne, float P_PosX, float P_PosY, float P_Rotation){
    isActive = true;
    Player1 = playerAsigne;
    PosX = P_PosX;
    PosY = P_PosY;
    Rotation = P_Rotation;
    lifeTime = 10;
    currentLifeTime = 0;
        
    FlySpeed = 2;
  }
//bullets geters
boolean GetisActive(){return isActive; }
 
  //
  
  void PrintBullet(){
      pushMatrix();
      
       translate(PosX,PosY);
       rotate(radians(Rotation));
       translate(FlySpeed,0);
      
        pushMatrix();
        
        //debujar al jugador (qui le pasa la imagen)
          fill(0,255,0);
          rectMode(CENTER);
          rect(0, 0, 5, 15);
        
        PosX = modelX(0,0,0);
        PosY = modelY(0,0,0);
        
        popMatrix();
      
      popMatrix();
      
     //Amb això aqui el player es printeja al moment de canviar d'un costat de la pantalla a l'altre
      BulletBoard();
      SetCurrentLife();
      
  }

  
//lifetime Bullets  
void SetCurrentLife(){
  if(currentLifeTime < lifeTime){
      currentLifeTime += 0.1;
  }
  else{
    isActive = false;
  }
}
 
  
  
  //traspasar els bordes amb la bullet
  void BulletBoard() { 
 

    // Reapareixer al creuar els bordes esquerre i dret de la pantalla augmantem una mica el valor perque no es fagi tp en el centra de la imatge sino al final
    if (PosX > width + 10) {
        PosX = -10;
    } 
    else if (PosX < -10) {
        PosX = width + 10;
    }

    // Reapareixer al creuar els bordes de dalt i abaix de la pantalla augmantem una mica el valor perque no es fagi tp en el centra de la imatge sino al final
    if (PosY > height + 10) {
        PosY = -10;
    }
    else if (PosY < -10) {
        PosY = height + 10;
    }
  }

}
