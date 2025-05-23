class Player { 
  float PosX;
  float PosY;
  int squareLenght;
  
  // Rotación
  float Rotation;
  float Current_rotate;
  float Current_rotate_speed;
  float Max_rotation_Speed;
  
  // Velocidad
  float Speed;
  float max_Speed;
  float current_speed;
  
  // Disparo
  float shootColdown;
  float currentColdown;
  float LastSavePlayerShoot;
  boolean CanShoot;
  
  // Power-ups
  int timerPowerUp;
  float currentTimePowerUp;
  float LastSavePlayerPowerUps;
  
  // Estados de power-ups
  boolean tripleShotActive;
  boolean boomeranShoot;
  boolean invincibilityActive;
  
  // Imágenes
  PImage navePJ;
  PImage navePJ_original;
  
  // Texto flotante
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

    // Rotación
    Current_rotate = 270;
    Current_rotate_speed = 0;
    Max_rotation_Speed = MaxRotationSpeed;
    squareLenght = 40;
    
    // Imagen del jugador
    navePJ = img;
    navePJ_original = img.copy();
    
    // Tiempo de recarga del disparo
    shootColdown = 4000;
    currentColdown = 0;
    LastSavePlayerShoot = -4000;
    CanShoot = true;
    
    // Estados de power-up
    tripleShotActive = false;
    boomeranShoot = false;
    invincibilityActive = false;
    
    // Temporizador de power-up
    timerPowerUp = 10000;
    currentTimePowerUp = 0;
    LastSavePlayerPowerUps = 0;
    
    // Posición inicial del texto flotante
    PositonText = new PVector(x - 50, y - 50);
    TextoDistancia = 50;
    TextoSpeed = 0.1;
  } 
  
  // Getters
  float getCurrentRotation() { return Current_rotate; }
  float getX() { return PosX; }
  float getY() { return PosY; }
  int getSquareLenght() { return squareLenght; }
  float Get_Current_Speed() { return current_speed; }
  boolean Get_CanShoot() { return CanShoot; }
  boolean GetTripleShoot() { return tripleShotActive; }
  boolean GetBoomeranShoot() { return boomeranShoot; }
  boolean GetInvincibility() { return invincibilityActive; }
  int GetSquareLengt() { return squareLenght; }

  // Dibuja al jugador con su rotación y desplazamiento actuales
  void PrintPlayer() {
    pushMatrix();
    translate(PosX, PosY);
    rotate(radians(Current_rotate));
    translate(current_speed, 0);
    pushMatrix();

    imageMode(CENTER);
    image(navePJ, 0, 0, squareLenght, squareLenght);

    PosX = modelX(0, 0, 0);
    PosY = modelY(0, 0, 0);

    popMatrix();
    popMatrix();

    // Reaparece al cambiar de borde de la pantalla
    PlayerBorders();
  }

  // Aumenta la velocidad progresivamente
  void addSpeed() {
    if (current_speed < max_Speed) {
      current_speed += Speed;
    }
  }

  // Reduce la velocidad progresivamente
  void ReduceSpeed() {
    if (current_speed > 0.1) {
      current_speed -= Speed;
    } else {
      current_speed = 0;
    }
  }

  // Inicia el cooldown del disparo
  void activateColldown() {
    LastSavePlayerShoot = millis();
  }

  // Controla el estado del cooldown de disparo
  void ColldownShoot() {
    currentColdown = millis() - LastSavePlayerShoot;
    CanShoot = currentColdown > shootColdown;
  }

  // Rotación progresiva hacia la izquierda
  void RotateLeft() {
    if (Current_rotate_speed > (Max_rotation_Speed * -1)) {
      Current_rotate_speed -= Rotation;
    }
    Current_rotate += Current_rotate_speed;

    if (Current_rotate <= 0) {
      Current_rotate = 360;
    }
  }

  // Rotación progresiva hacia la derecha
  void RotateRight() {
    if (Current_rotate_speed < Max_rotation_Speed) {
      Current_rotate_speed += Rotation;
    }
    Current_rotate += Current_rotate_speed;

    if (Current_rotate >= 360) {
      Current_rotate = 0;
    }
  }

  // Detiene la rotación
  void stopRotation() {
    Current_rotate_speed = 0;
  }

  // Teletransporta al jugador al lado opuesto si sale de los bordes
  void PlayerBorders() {
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

  // Activa el power-up correspondiente según el número
  void activate_powerUp(int NumPower) {
    if (NumPower == 0) {
      tripleShotActive = true;
      LastSavePlayerPowerUps = millis();
      activeLutPW = true;
    }
    if (NumPower == 1) {
      boomeranShoot = true;
      LastSavePlayerPowerUps = millis();
      activeLutPW = true;
    }
    if (NumPower == 2) {
      println("AZULLLLL");
      invincibilityActive = true;
      LastSavePlayerPowerUps = millis();
      activeLutPW = true;
    }
  }

  String tipoLut = "";

  // Temporizador para los power-ups basado en millis()
  void TimerPowerUps() {
    if (tripleShotActive) {
      tipoLut = "red";
      currentTimePowerUp = millis() - LastSavePlayerPowerUps;
      if (currentTimePowerUp > timerPowerUp) {
        tripleShotActive = false;
        activeLutPW = false;
      } else {
        LUT_PW(navePJ, tipoLut);
      }
    }

    if (boomeranShoot) {
      tipoLut = "green";
      currentTimePowerUp = millis() - LastSavePlayerPowerUps;
      if (currentTimePowerUp > timerPowerUp) {
        boomeranShoot = false;
        activeLutPW = false;
      } else {
        LUT_PW(navePJ, tipoLut);
      }
    }

    if (invincibilityActive) {
      tipoLut = "blue";
      currentTimePowerUp = millis() - LastSavePlayerPowerUps;
      if (currentTimePowerUp > timerPowerUp) {
        invincibilityActive = false;
        activeLutPW = false;
      } else {
        LUT_PW(navePJ, tipoLut);
      }
    }

    if (activeLutPW) {
      applyLUTToPlayer(this, tipoLut);  // Aplica LUT a la copia segura
    } else {
      navePJ = navePJ_original.copy();  // Restaura la imagen original
    }
  }

  // Movimiento del texto de puntuación hacia el jugador
  void FollowText(int Score) {
    // Calcula la distancia entre el texto y el jugador
    PVector CallDistance = new PVector(PositonText.x - PosX, PositonText.y - PosY);
    float Distance_Normal = sqrt(CallDistance.x * CallDistance.x + CallDistance.y * CallDistance.y);

    // Si el texto está lejos, lo acercamos con interpolación
    if (TextoDistancia <= Distance_Normal) {
      PositonText.x = (1 - TextoSpeed) * PositonText.x + PosX * TextoSpeed;
      PositonText.y = (1 - TextoSpeed) * PositonText.y + PosY * TextoSpeed;
    }

    fill(0, 255, 255);
    textSize(12);
    text("Puntuación: " + Score, PositonText.x, PositonText.y);
  }
}
