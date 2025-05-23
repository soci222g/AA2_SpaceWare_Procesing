class bullet {
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
  
  // Dependiendo de la posición y rotación del jugador, se inicializa la bala en consecuencia.
  bullet(boolean playerAsigne, float P_PosX, float P_PosY, float P_Rotation){
    isActive = true;
    Player1 = playerAsigne;
    PosX = P_PosX;
    PosY = P_PosY;
    Rotation = P_Rotation;
    
    // Temporizador de vida de la bala
    lifeTime = 3000;
    currentLifeTime = 0;
    saveSpawnTime = millis();

    widthBullet = 5;
    heightBullet = 15;
    FlySpeed = 4;
  }

  // Getter de estado activo
  boolean GetisActive() {
    return isActive;
  }

  // Dibuja la bala con transformaciones: traslación, rotación y avance, y actualiza su posición.
  void PrintBullet(){
    pushMatrix();
    
    translate(PosX, PosY);
    rotate(radians(Rotation));
    translate(FlySpeed, 0);
    
    pushMatrix();
    fill(0, 255, 0);
    rectMode(CENTER);
    rect(0, 0, widthBullet, heightBullet);
    
    PosX = modelX(0, 0, 0);
    PosY = modelY(0, 0, 0);
    
    popMatrix();
    popMatrix();
    
    BulletBoard();
    SetCurrentLife();
  }

  // Actualiza el tiempo de vida de la bala y la desactiva si ha expirado.
  void SetCurrentLife() {
    currentLifeTime = millis() - saveSpawnTime;
    if (currentLifeTime > lifeTime) {
      isActive = false;
    }
  }

  // Permite que las balas atraviesen los bordes de la pantalla y reaparezcan del otro lado.
  void BulletBoard() { 
    if (PosX > width + 10) {
      PosX = -10;
    } else if (PosX < -10) {
      PosX = width + 10;
    }

    if (PosY > height + 10) {
      PosY = -10;
    } else if (PosY < -10) {
      PosY = height + 10;
    }
  }

  // Detección de colisión con el otro jugador
  void SeeCollision() {
    // Coordenadas mínimas y máximas de la bala
    PVector Min_Bullet = new PVector(PosX - widthBullet * 0.5, PosY - heightBullet * 0.5);
    PVector Max_Bullet = new PVector(PosX + widthBullet * 0.5, PosY + heightBullet * 0.5); 

    PVector Min_Player;
    PVector Max_Player;
    
    // Define los límites del jugador objetivo según quién disparó
    if (Player1) {
      Min_Player = new PVector(player2.getX() - player2.GetSquareLengt() * 0.5, player2.getY() - player2.GetSquareLengt() * 0.5);
      Max_Player = new PVector(player2.getX() + player2.GetSquareLengt() * 0.5, player2.getY() + player2.GetSquareLengt() * 0.5);
    } else {
      Min_Player = new PVector(player1.getX() - player1.GetSquareLengt() * 0.5, player1.getY() - player1.GetSquareLengt() * 0.5);
      Max_Player = new PVector(player1.getX() + player1.GetSquareLengt() * 0.5, player1.getY() + player1.GetSquareLengt() * 0.5);
    }

    // Si no hay colisión, salir
    if ((Max_Bullet.x < Min_Player.x) || (Max_Bullet.y < Min_Player.y) || 
        (Max_Player.x < Min_Bullet.x) || (Max_Player.y < Min_Bullet.y)) {
      return;
    }

    // Si hay colisión:
    if (Player1) {
      if (player2.GetInvincibility()) {
        println("Player 2 está invencible. La bala no tiene efecto.");
        isActive = false;
      } else {
        p1Score.AddPlayerScore(100);
        startFlashPlayer2();
        isActive = false;
      }
    } else {
      if (player1.GetInvincibility()) {
        println("Player 1 está invencible. La bala no tiene efecto.");
        isActive = false;
      } else {
        p2Score.AddPlayerScore(100);
        startFlashPlayer1();
        isActive = false;
      }
    }
  }
}
