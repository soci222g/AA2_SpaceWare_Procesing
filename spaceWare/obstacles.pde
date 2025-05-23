RutaObstaculo Seccion_Obstacle1;
RutaObstaculo Seccion_Obstacle2;
RutaObstaculo Seccion_Obstacle3;
RutaObstaculo seccion_Obstacle4;

obstaculo Obstaculo1;
obstaculo Obstaculo2;

// Tiempo de reaparición de obstáculos
float SaveLastTimeObstacles;
final int TimeToRespawnAObstacle = 5000; // 5 segundos
float currentTimerObstacle;

// Ruta de movimiento del obstáculo
class RutaObstaculo {

  PVector[] puntos_de_ctrl; // Puntos de control
  PVector[] coefs; // Coeficientes de la curva
  
  int spierRadius;
  boolean activeObstacle;
  
  RutaObstaculo(PVector[] p) {
    puntos_de_ctrl = new PVector[4];
    coefs = new PVector[4];

    for (int i = 0; i < 4; i++) {
      puntos_de_ctrl[i] = new PVector(0.0, 0.0);
      coefs[i] = new PVector(0.0, 0.0);
      puntos_de_ctrl[i] = p[i];
    }
    calcular_coefs();
  }

  void calcular_coefs() {
    // Usando la matriz de interpolación
    // 4 ecuaciones para calcular los coeficientes
    // c0 = p0
    // c1 = -5.5P0 + 9P1 - 4.5P2 + P3
    // c2 = 9P0 - 22.5P1 + 18P2 - 4.5P3
    // c3 = -4.5P0 + 13.5P1 - 13.5P2 + 4.5P3
    
    // c0
    coefs[0].x = puntos_de_ctrl[0].x;
    coefs[0].y = puntos_de_ctrl[0].y;

    // c1
    coefs[1].x = -5.5*puntos_de_ctrl[0].x 
      + 9*puntos_de_ctrl[1].x
      - 4.5*puntos_de_ctrl[2].x 
      + puntos_de_ctrl[3].x;
     
    coefs[1].y = -5.5*puntos_de_ctrl[0].y 
      + 9*puntos_de_ctrl[1].y 
      - 4.5*puntos_de_ctrl[2].y 
      + puntos_de_ctrl[3].y;

    // c2
    coefs[2].x = 9*puntos_de_ctrl[0].x 
      - 22.5*puntos_de_ctrl[1].x
      + 18*puntos_de_ctrl[2].x 
      - 4.5*puntos_de_ctrl[3].x;
      
    coefs[2].y = 9*puntos_de_ctrl[0].y 
      - 22.5*puntos_de_ctrl[1].y
      + 18*puntos_de_ctrl[2].y
      - 4.5*puntos_de_ctrl[3].y;
    
    // c3
    coefs[3].x = -4.5*puntos_de_ctrl[0].x 
      + 13.5*puntos_de_ctrl[1].x
      - 13.5*puntos_de_ctrl[2].x 
      + 4.5*puntos_de_ctrl[3].x;
        
    coefs[3].y = -4.5*puntos_de_ctrl[0].y 
      + 13.5*puntos_de_ctrl[1].y
      - 13.5*puntos_de_ctrl[2].y 
      + 4.5*puntos_de_ctrl[3].y;     
  }
  
  void pintar_curva() {
    float x, y;
    strokeWeight(5); // Grosor de la línea
    stroke(255, 255, 0); // Color de la curva

    for (float i = 0.0; i < 1; i += 0.01) {
      x = coefs[0].x + coefs[1].x*i + coefs[2].x * (i * i) + coefs[3].x * (i * i * i);
      y = coefs[0].y + coefs[1].y*i + coefs[2].y * (i * i) + coefs[3].y * (i * i * i);
      point(x, y); // Dibuja el punto
    }
  }

  void PintarPuntosControl() {
    for (int i = 0; i < 4; i++) {
      point(puntos_de_ctrl[i].x, puntos_de_ctrl[i].y);
    }
  }
}

// Clase del obstáculo físico
class obstaculo {
  PVector PNJ;
  int State_PNJ;
  float u;

  int spierRadius;
  boolean activeObstacle;

  obstaculo(int StageStart) {
    PNJ = new PVector(0, 0);
    State_PNJ = StageStart;
    u = 0.0;
    spierRadius = 30;
    activeObstacle = true;
  }

  // Getter
  boolean GetActivateObstacle() { return activeObstacle; }

  void ClaculaPositionObstaculo(float speed) {
    // Según el estado y la u nos movemos por las curvas

    // Va saltando de curva en curva
    switch (State_PNJ) {
      case 1:
        PNJ.x = Seccion_Obstacle1.coefs[0].x + Seccion_Obstacle1.coefs[1].x*u + Seccion_Obstacle1.coefs[2].x * (u * u) + Seccion_Obstacle1.coefs[3].x * (u * u * u);
        PNJ.y = Seccion_Obstacle1.coefs[0].y + Seccion_Obstacle1.coefs[1].y*u + Seccion_Obstacle1.coefs[2].y * (u * u) + Seccion_Obstacle1.coefs[3].y * (u * u * u);
        break;
      case 2:
        PNJ.x = Seccion_Obstacle2.coefs[0].x + Seccion_Obstacle2.coefs[1].x*u + Seccion_Obstacle2.coefs[2].x * (u * u) + Seccion_Obstacle2.coefs[3].x * (u * u * u);
        PNJ.y = Seccion_Obstacle2.coefs[0].y + Seccion_Obstacle2.coefs[1].y*u + Seccion_Obstacle2.coefs[2].y * (u * u) + Seccion_Obstacle2.coefs[3].y * (u * u * u);
        break;
      case 3:
        PNJ.x = Seccion_Obstacle3.coefs[0].x + Seccion_Obstacle3.coefs[1].x*u + Seccion_Obstacle3.coefs[2].x * (u * u) + Seccion_Obstacle3.coefs[3].x * (u * u * u);
        PNJ.y = Seccion_Obstacle3.coefs[0].y + Seccion_Obstacle3.coefs[1].y*u + Seccion_Obstacle3.coefs[2].y * (u * u) + Seccion_Obstacle3.coefs[3].y * (u * u * u);
        break;
      case 4:
        PNJ.x = seccion_Obstacle4.coefs[0].x + seccion_Obstacle4.coefs[1].x*u + seccion_Obstacle4.coefs[2].x * (u * u) + seccion_Obstacle4.coefs[3].x * (u * u * u);
        PNJ.y = seccion_Obstacle4.coefs[0].y + seccion_Obstacle4.coefs[1].y*u + seccion_Obstacle4.coefs[2].y * (u * u) + seccion_Obstacle4.coefs[3].y * (u * u * u);
        break;
    }

    if (u < 1) {
      u += speed;
    } else if (u >= 1) {
      if (State_PNJ == 4) {
        State_PNJ = 1;
      } else {
        State_PNJ++;
      }
      u = 0;
    }
  }

  void PrintaObstaculo() {
    fill(255, 255, 0); 
    ellipse(PNJ.x, PNJ.y, spierRadius, spierRadius);
  }

  void SeeCollision1() {
    // Detectar colisión con jugador 1
    float base_position_x_PJ1 = player1.getX() - player1.getSquareLenght() * 0.5;
    float base_position_y_PJ1 = player1.getY() - player1.getSquareLenght() * 0.5;

    float posPowerX = PNJ.x;
    float posPowerY = PNJ.y;

    if (PNJ.x < base_position_x_PJ1) {
      posPowerX = base_position_x_PJ1;
    } else if (PNJ.x > (base_position_x_PJ1 + player1.getSquareLenght())) {
      posPowerX = base_position_x_PJ1 + player1.getSquareLenght();
    }

    if (PNJ.y < base_position_y_PJ1) {
      posPowerY = base_position_y_PJ1;
    } else if (PNJ.y > (base_position_y_PJ1 + player1.getSquareLenght())) {
      posPowerY = base_position_y_PJ1 + player1.getSquareLenght();
    }

    float ClosDisX = PNJ.x - posPowerX;
    float ClosDisY = PNJ.y - posPowerY;

    float Distanca = sqrt((ClosDisX * ClosDisX) + (ClosDisY * ClosDisY));

    if (Distanca <= spierRadius) {
      p1Score.AddPlayerScore(-100);
      startFlashPlayer1();
      activeObstacle = false;
    }
  }

  void SeeCollision2() {
    // Detectar colisión con jugador 2
    float base_position_x_PJ2 = player2.getX() - player2.getSquareLenght() * 0.5;
    float base_position_y_PJ2 = player2.getY() - player2.getSquareLenght() * 0.5;

    float posPowerX = PNJ.x;
    float posPowerY = PNJ.y;

    if (PNJ.x < base_position_x_PJ2) {
      posPowerX = base_position_x_PJ2;
    } else if (PNJ.x > (base_position_x_PJ2 + player2.getSquareLenght())) {
      posPowerX = base_position_x_PJ2 + player2.getSquareLenght();
    }

    if (PNJ.y < base_position_y_PJ2) {
      posPowerY = base_position_y_PJ2;
    } else if (PNJ.y > (base_position_y_PJ2 + player2.getSquareLenght())) {
      posPowerY = base_position_y_PJ2 + player2.getSquareLenght();
    }

    float ClosDisX = PNJ.x - posPowerX;
    float ClosDisY = PNJ.y - posPowerY;

    float Distanca = sqrt((ClosDisX * ClosDisX) + (ClosDisY * ClosDisY));

    if (Distanca <= spierRadius) {
      p2Score.AddPlayerScore(-100);
      startFlashPlayer2();
      activeObstacle = false;
    }
  }

  void ReActivateObstacle() {
    currentTimerObstacle = millis() - SaveLastTimeObstacles;
    if (currentTimerObstacle > TimeToRespawnAObstacle) {
      SaveLastTimeObstacles = millis();
      activeObstacle = true;
    }
  }
}
