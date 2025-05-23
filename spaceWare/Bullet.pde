



class bullet{
  boolean isActive;
  boolean Player1;
  
  float PosX;
  float PosY;
    
  float Rotation;
  int FlySpeed;
  
  int lifeTime;
  float currentLifeTime;
  float saveSpawnTime;
  
  int widthBullet;
  int heightBullet;
  
  //en funion de los elementos del jugaodr este endra una rotacion i una posicion especifica.
  bullet(boolean playerAsigne, float P_PosX, float P_PosY, float P_Rotation){
    isActive = true;
    Player1 = playerAsigne;
    PosX = P_PosX;
    PosY = P_PosY;
    Rotation = P_Rotation;
    //timer bullet
    lifeTime = 3000;
    currentLifeTime = 0;
    saveSpawnTime = millis();

    
    widthBullet = 5;
    heightBullet = 15;
    FlySpeed = 4;
  }
//bullets geters
boolean GetisActive(){return isActive; }
 
  // dibujamos la balla sigiendo usando los trnasforms.(voviendo la balla a donde esta, rodandola, moviendo hacia adelante i guadnado la nueva posicion.)
  
  void PrintBullet(){
      pushMatrix();
      
       translate(PosX,PosY);
       rotate(radians(Rotation));
       translate(FlySpeed,0);
      
        pushMatrix();
        
        //debujar al jugador (qui le pasa la imagen)
          fill(0,255,0);
          rectMode(CENTER);
          rect(0, 0, widthBullet, heightBullet);
        
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
  currentLifeTime = millis() - saveSpawnTime;
  if(currentLifeTime > lifeTime){
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
  
  
void SeeCollision(){
    //pillamos la pas paredes de las ballas
    PVector Min_Bullet = new PVector(PosX+widthBullet*0.5,PosY+heightBullet*0.5);
    PVector Max_Bullet = new PVector(PosX+widthBullet*0.5,PosY+heightBullet*0.5); 
  
    //cogemos la posicines de las 4 paredes de un juegador, en funcion esto de quien a disparado la balla 
    
    PVector Min_Player;
    PVector Max_Player;
    
    if(Player1){
      Min_Player = new PVector(player2.getX()-player2.GetSquareLengt()*0.5, player2.getY()-player2.GetSquareLengt()*0.5);
      Max_Player = new PVector(player2.getX()+player2.GetSquareLengt()*0.5, player2.getY()+player2.GetSquareLengt()*0.5);
    }
    else{
      Min_Player = new PVector(player1.getX()-player2.GetSquareLengt()*0.5, player1.getY()-player2.GetSquareLengt()*0.5);
      Max_Player = new PVector(player1.getX()+player2.GetSquareLengt()*0.5, player1.getY()+player2.GetSquareLengt()*0.5);
    }

//comrobamos los casos donde no hay collison (en estos no pasa nada)
      if((Max_Bullet.x < Min_Player.x)||(Max_Bullet.y < Min_Player.y)||(Max_Player.x< Min_Bullet.x) || (Max_Player.y< Min_Bullet.y)){ //no collision
     
      }
      else{ //si collision
       if (Player1) {
      if (player2.GetInvincibility()) {
        // Si el jugador 2 está invencible, no hacer nada
        println("Player 2 is invincible. Bullet has no effect.");
        isActive = false;
      } else {
        p1Score.AddPlayerScore(100);
        startFlashPlayer2();
        isActive = false;
      }
    } else {
      if (player1.GetInvincibility()) {
        // Si el jugador 1 está invencible, no hacer nada
        println("Player 1 is invincible. Bullet has no effect.");
        isActive = false;
      } else {
        p2Score.AddPlayerScore(100);
        startFlashPlayer1();
        isActive = false;
      }
    }
  }
}


}
