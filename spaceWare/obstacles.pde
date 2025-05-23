

RutaObstaculo Mi_primera_Curva;
RutaObstaculo Mi_segunda_Curva;
RutaObstaculo Mi_tercera_Curva;
RutaObstaculo Mi_quarta_Curva;

obstaculo PNJ1;
obstaculo PNJ2;
obstaculo PNJ3;
obstaculo PNJ4;


//obstaculo rutacio
class RutaObstaculo{

  PVector[] puntos_de_ctrl; // Las P
  PVector[] coefs; //las C
  
  int spierRadius;
  boolean activeObstacle;
  
   
  
  RutaObstaculo(PVector[] p){
    puntos_de_ctrl = new PVector[4];
    coefs = new PVector[4];
    

    
    for(int i = 0; i < 4; i++){
      puntos_de_ctrl[i] = new PVector(0.0,0.0);
      coefs[i] = new PVector(0.0,0.0);
      
      puntos_de_ctrl[i] = p[i];
    }
    calcular_coefs();
   
  }
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
  }
  
  void PintarPuntosControl(){
      strokeWeight(10); // pixeles de grosor
      stroke(255,0,0); 
      for(int i  = 0; i < 4; i++){
         point(puntos_de_ctrl[i].x,puntos_de_ctrl[i].y); 
    }
  }
    
  
}

//clase obstaculo fisico
class obstaculo{
  PVector PNJ;
  int State_PNJ;
  float u; 

  int spierRadius;
  boolean activeObstacle;

  obstaculo(int StageStart){
     PNJ = new PVector(0,0);
     State_PNJ = StageStart;
     u=0.0; 
      spierRadius = 30;
      activeObstacle = true;
  }
    
    void ClaculaPositionPNJ( float speed, RutaObstaculo[4] ruta){
    //segons el estat i la U ens movem per les curvas
    
    
    
    switch (State_PNJ){
      case 1:
       PNJ.x = ruta[0].coefs[0].x + ruta[0].coefs[1].x*u + ruta[0].coefs[2].x * (u * u) + ruta[0].coefs[3].x * (u * u * u);
       PNJ.y = rut[0].coefs[0].y + ruta[0].coefs[1].y*u + ruta[0].coefs[2].y * (u * u) + ruta[0].coefs[3].y * (u * u * u);
        break;
      case 2:
       PNJ.x = ruta[1].coefs[0].x + ruta[1].coefs[1].x*u + ruta[1].coefs[2].x * (u * u) +  ruta[1].coefs[3].x * (u * u * u);
       PNJ.y =  ruta[1].coefs[0].y +  ruta[1].coefs[1].y*u +  ruta[1].coefs[2].y * (u * u) +  ruta[1].coefs[3].y * (u * u * u);
        break;
      case 3:
       PNJ.x =  ruta[2].coefs[0].x + Mi_tercera_Curva.coefs[1].x*u + Mi_tercera_Curva.coefs[2].x * (u * u) + ruta[2].coefs[3].x * (u * u * u);
       PNJ.y = ruta[2].coefs[0].y + ruta[2].coefs[1].y*u + ruta[2].coefs[2].y * (u * u) + ruta[2].coefs[3].y * (u * u * u);
        break;
      case 4:
       PNJ.x = ruta[3].coefs[0].x + ruta[3].coefs[1].x*u + ruta[3].coefs[2].x * (u * u) + ruta[3].coefs[3].x * (u * u * u);
       PNJ.y = ruta[3].coefs[0].y + ruta[3].coefs[1].y*u + ruta[3].coefs[2].y * (u * u) + ruta[3].coefs[3].y * (u * u * u);
        break;
    }
      
    
        if(u < 1){
        u += speed;
        }
        else if(u >= 1){
          
          if(State_PNJ == 4){
              State_PNJ = 1;
            }
          else{
              State_PNJ++;
            }
            u = 0;
          
        }
        
  }
  
  void ClaculaPositionPNJPistaModolar(float speed, RutaObstaculo[] arrayCorva){
    //segons el estat i la U ens movem per les curvas
    
    
    for (int i = 0; i < arrayCorva.length; i++){
        PNJ.x = arrayCorva[i].coefs[0].x + arrayCorva[i].coefs[1].x*u + arrayCorva[i].coefs[2].x * (u * u) + arrayCorva[i].coefs[3].x * (u * u * u);
        PNJ.y = arrayCorva[i].coefs[0].y + arrayCorva[i].coefs[1].y*u + arrayCorva[i].coefs[2].y * (u * u) + arrayCorva[i].coefs[3].y * (u * u * u);
    
    
     if(u < 1){
        u += speed;
        break;
        }
        else if(u >= 1){
          
          if(State_PNJ ==  arrayCorva.length){
              i = 0;
            }
          else{
              i++;
              
            }
            u = 0;
            break;
        }
    }
      
    
    
        
  }

  void PrintaPNJ(){
      strokeWeight(50); // pixeles de grosor
    stroke(0,255,0); 
    ellipse(PNJ.x,PNJ.y, spierRadius, spierRadius);
  }
  
  
  
  void SeeCollision(){
    //pillamos la pas paredes de las ballas
     //pillamos la paret
    float base_position_x_PJ1 = player1.getX() - player1.getSquareLenght() * 0.5;
    float base_position_y_PJ1 =  player1.getY() - player1.getSquareLenght() * 0.5;
    //esfera
    float posPowerX = PNJ.x;
    float posPowerY = PNJ.y;
    
    //quina de les 2 X del player esta mes aprop el collider
    if(PNJ.x < base_position_x_PJ1){
        posPowerX = base_position_x_PJ1;
    }
    else if(PNJ.x > (base_position_x_PJ1 + player1.getSquareLenght())){
      posPowerX = base_position_x_PJ1 + player1.getSquareLenght();
    }
    
    if(PNJ.y < base_position_y_PJ1){
        posPowerY = base_position_y_PJ1;
    }
    else if(PNJ.y > (base_position_y_PJ1 + player1.getSquareLenght())){
      posPowerY = base_position_y_PJ1 + player1.getSquareLenght();
    }
    
    float ClosDisX = PNJ.x - posPowerX;
    float ClosDisY = PNJ.y - posPowerY;
    
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
    if(PNJ.x < base_position_x_PJ2){
        posPowerX = base_position_x_PJ2;
    }
    else if(PNJ.x > (base_position_x_PJ2 + player2.getSquareLenght())){
      posPowerX = base_position_x_PJ2 + player2.getSquareLenght();
    }
    
    if(PNJ.y < base_position_y_PJ2){
        posPowerY = base_position_y_PJ2;
    }
    else if(PNJ.y > (base_position_y_PJ2 + player2.getSquareLenght())){
      posPowerY = base_position_y_PJ2 + player2.getSquareLenght();
    }
   
     ClosDisX = PNJ.x - posPowerX;
     ClosDisY = PNJ.y - posPowerY;
    
     Distanca = sqrt((ClosDisX*ClosDisX)+ (ClosDisY*ClosDisY));
          
     if(Distanca <= spierRadius){
         activeObstacle = false;
         p2Score.AddPlayerScore(-100);
     } 
     

    
  }
  
}
