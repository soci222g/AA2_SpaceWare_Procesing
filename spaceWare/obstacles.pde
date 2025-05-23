


class obsatclaCurba{

PVector obstaclePosition;
int estado_boomerang; 
float u;
 int spierRadius;
  
  PVector[] puntos_de_ctrl;
  PVector[] coefs;
  // Constructor
  boolean activeObstacle;
 
  obsatclaCurba(PVector[] p, int radisuSphier) {
    activeObstacle = true;
  
    
     obstaclePosition = new PVector(0,0);
     estado_boomerang=1; 
     u=0.01;
    spierRadius = radisuSphier;
   
    // Reservamos memoria
    puntos_de_ctrl = new PVector[4];
    coefs = new PVector[4];
    // Inicializamos
    for (int i=0; i<4; i++) {
      puntos_de_ctrl[i]=new PVector(0.0, 0.0);
      coefs[i]=new PVector(0.0, 0.0);
      // Copiamos los puntos recibidos
      puntos_de_ctrl[i]=p[i];
    }
  }
  //geter
  boolean GetActive(){return activeObstacle;}
  
  // Metodos
  void calcular_coefs(){
       //utilitzan la matriu de interpolacio
      //4 equacions calculem les c's
      // c0 = p0
      // c1 = -5.5P0+9P1-4.5p2+p3
      //c2 = p0*9 - p1*22.5 + p1 * 18 +
      //
  //c0
    coefs[0].x = puntos_de_ctrl[0].x;
    coefs[0].y = puntos_de_ctrl[0].y;

  
  //c1
    coefs[1].x = -5.5*puntos_de_ctrl[0].x 
      + 9*puntos_de_ctrl[1].x
      - 4.5*puntos_de_ctrl[2].x 
      + puntos_de_ctrl[3].x;
     
    coefs[1].y = -5.5*puntos_de_ctrl[0].y 
      + 9*puntos_de_ctrl[1].y 
      - 4.5*puntos_de_ctrl[2].y 
      + puntos_de_ctrl[3].y;


  //c2
    coefs[2].x = 9*puntos_de_ctrl[0].x 
      -22.5*puntos_de_ctrl[1].x
      +18*puntos_de_ctrl[2].x 
      -4.5*puntos_de_ctrl[3].x;
      
    coefs[2].y = 9*puntos_de_ctrl[0].y 
      -22.5*puntos_de_ctrl[1].y
      +18*puntos_de_ctrl[2].y
      -4.5*puntos_de_ctrl[3].y;
    
    
    
    //c3
     coefs[3].x = -4.5*puntos_de_ctrl[0].x 
        +13.5*puntos_de_ctrl[1].x
        -13.5*puntos_de_ctrl[2].x 
        +4.5*puntos_de_ctrl[3].x;
        
     coefs[3].y = -4.5*puntos_de_ctrl[0].y 
        +13.5*puntos_de_ctrl[1].y
        -13.5*puntos_de_ctrl[2].y 
        +4.5*puntos_de_ctrl[3].y ;   

  
  }
  
  void pintar_curva(){
    float x,y;
  
    strokeWeight(5); // pixeles de grosor
    stroke(255,255,0); // color de la curba
    for (float i = 0.0; i <1; i += 0.01){
        //calcular la x 
           x = coefs[0].x + coefs[1].x*i + coefs[2].x * (i * i) + coefs[3].x * (i * i * i);
        //calcuclar la y
          y = coefs[0].y + coefs[1].y*i + coefs[2].y * (i * i) + coefs[3].y * (i * i * i);
  
        //pintar un punto en esa cordenada
         point(x,y);
    }
     strokeWeight(10); // pixeles de grosor
    stroke(255,0,0); 
  for(int i  = 0; i < 4; i++){
   point(puntos_de_ctrl[i].x,puntos_de_ctrl[i].y); 
  }
    
    
  }

  void pintar_puntos_de_ctrl() {
    strokeWeight(15.0);
    stroke(255, 0, 0);
    for (int i=0; i<4; i++) {
      point(puntos_de_ctrl[i].x, puntos_de_ctrl[i].y);
    }
  }


// Funciones
// Posicionar al PNJ
  void calcula_nueva_posicion_Obstacle(){
    // Segun el estado, nos movemos por una u otra curva
    // Cuando el parametro "u" sea >= 1.0, toca cambiar de curva
    if (estado_boomerang==1){ // Estoy en p(u)
      obstaclePosition.x = coefs[0].x +
      coefs[1].x * u +
      coefs[2].x * u * u +
      coefs[3].x * u * u * u;
      obstaclePosition.y =coefs[0].y +
      coefs[1].y * u +
      coefs[2].y * u * u +
      coefs[3].y * u * u * u;
    } 
    // Control del parametro "u"
    u = u + 0.01;
    if (u >= 1.0){
    
     activeObstacle = false;
    }
  }
// Pintarlo
  void print_Bullet(){
            fill(255,255,0);
            ellipse(obstaclePosition.x,obstaclePosition.y,spierRadius,spierRadius);
  }
  
  void SeeCollision(){
    //pillamos la pas paredes de las ballas
     //pillamos la paret
    float base_position_x_PJ1 = player1.getX() - player1.getSquareLenght() * 0.5;
    float base_position_y_PJ1 =  player1.getY() - player1.getSquareLenght() * 0.5;
    //esfera
    float posPowerX = obstaclePosition.x;
    float posPowerY = obstaclePosition.y;
    
    //quina de les 2 X del player esta mes aprop el collider
    if(obstaclePosition.x < base_position_x_PJ1){
        posPowerX = base_position_x_PJ1;
    }
    else if(obstaclePosition.x > (base_position_x_PJ1 + player1.getSquareLenght())){
      posPowerX = base_position_x_PJ1 + player1.getSquareLenght();
    }
    
    if(obstaclePosition.y < base_position_y_PJ1){
        posPowerY = base_position_y_PJ1;
    }
    else if(obstaclePosition.y > (base_position_y_PJ1 + player1.getSquareLenght())){
      posPowerY = base_position_y_PJ1 + player1.getSquareLenght();
    }
    
    float ClosDisX = obstaclePosition.x - posPowerX;
    float ClosDisY = obstaclePosition.y - posPowerY;
    
     float Distanca = sqrt((ClosDisX*ClosDisX)+ (ClosDisY*ClosDisY));
     
     if(Distanca <= spierRadius){
         activeObstacle = false;
          p1Score.AddPlayerScore(-100);
     } 
     
     //player 2
     
    float base_position_x_PJ2 = player2.getX() - player2.getSquareLenght() * 0.5;
    float base_position_y_PJ2 =  player2.getY() - player2.getSquareLenght() * 0.5;
    //esfera
       
    //quina de les 2 X del player esta mes aprop el collider
    if(obstaclePosition.x < base_position_x_PJ2){
        posPowerX = base_position_x_PJ2;
    }
    else if(obstaclePosition.x > (base_position_x_PJ2 + player2.getSquareLenght())){
      posPowerX = base_position_x_PJ2 + player2.getSquareLenght();
    }
    
    if(obstaclePosition.y < base_position_y_PJ2){
        posPowerY = base_position_y_PJ2;
    }
    else if(obstaclePosition.y > (base_position_y_PJ2 + player2.getSquareLenght())){
      posPowerY = base_position_y_PJ2 + player2.getSquareLenght();
    }
   
     ClosDisX = obstaclePosition.x - posPowerX;
     ClosDisY = obstaclePosition.y - posPowerY;
    
     Distanca = sqrt((ClosDisX*ClosDisX)+ (ClosDisY*ClosDisY));
          
     if(Distanca <= spierRadius){
         activeObstacle = false;
          p2Score.AddPlayerScore(-100);
     } 
     

    
}

}
