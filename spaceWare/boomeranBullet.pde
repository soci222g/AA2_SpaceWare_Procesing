 // El parametro "u"

boolean activeBullet;
// Clases
class curva {
  // Atributos
  
PVector BulletBoomeranPos;
int estado_boomerang; 
float u;
  
  
  PVector[] puntos_de_ctrl;
  PVector[] coefs;
  // Constructor
  boolean activeBullet;
  boolean Player1;
  curva(PVector[] p, boolean playerAsigne) {
    activeBullet = true;
    Player1 = playerAsigne;
    
     BulletBoomeranPos = new PVector(0,0);
     estado_boomerang=1; 
     u=0.01;
    
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
  boolean GetActive(){return activeBullet;}
  
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
    coefs[1].x = -3*puntos_de_ctrl[0].x + 3*puntos_de_ctrl[1].x;
    coefs[1].y = -3*puntos_de_ctrl[0].y + 3*puntos_de_ctrl[1].y;

// c2

    coefs[2].x = +3*puntos_de_ctrl[0].x - 6*puntos_de_ctrl[1].x + 3*puntos_de_ctrl[2].x; 
    coefs[2].y = +3*puntos_de_ctrl[0].y - 6*puntos_de_ctrl[1].y + 3*puntos_de_ctrl[2].y;


  //c3
    coefs[3].x = -puntos_de_ctrl[0].x + 3*puntos_de_ctrl[1].x - 3*puntos_de_ctrl[2].x +puntos_de_ctrl[3].x;
    coefs[3].y = -puntos_de_ctrl[0].y + 3*puntos_de_ctrl[1].y - 3*puntos_de_ctrl[2].y + puntos_de_ctrl[3].y;

  
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
  void calcula_nueva_posicion_Bullet(){
    // Segun el estado, nos movemos por una u otra curva
    // Cuando el parametro "u" sea >= 1.0, toca cambiar de curva
    if (estado_boomerang==1){ // Estoy en p(u)
      BulletBoomeranPos.x = coefs[0].x +
      coefs[1].x * u +
      coefs[2].x * u * u +
      coefs[3].x * u * u * u;
      BulletBoomeranPos.y =coefs[0].y +
      coefs[1].y * u +
      coefs[2].y * u * u +
      coefs[3].y * u * u * u;
    } 
    // Control del parametro "u"
    u = u + 0.01;
    if (u >= 1.0){
    
     activeBullet = false;
    }
  }
// Pintarlo
  void print_Bullet(){
            fill(0,255,0);
            rectMode(CENTER);
            rect(BulletBoomeranPos.x, BulletBoomeranPos.y, 5, 15);
  }
}
