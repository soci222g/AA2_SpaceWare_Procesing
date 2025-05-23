// El parámetro "u"

boolean activeBullet;

int widthBullet;
int heightBullet;
// Clases
class boomerangRecorido {
  // Atributos
  
  PVector BulletBoomeranPos;
  int estado_boomerang; 
  float u;
  
  PVector[] puntos_de_ctrl;
  PVector[] coefs;
  // Constructor
  boolean activeBullet;
  boolean Player1;
  
  boomerangRecorido(PVector[] p, boolean playerAsigne) {
    //activamos bala y asignamos jugador
    activeBullet = true;
    Player1 = playerAsigne;
    
    BulletBoomeranPos = new PVector(0,0);
    estado_boomerang=1; 
    u=0.01;
    
    widthBullet = 5;
    heightBullet = 15;
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

  // getter
  boolean GetActive(){return activeBullet;}
  
  // Métodos
  void calcular_coefs(){
    //matriz de Bézier
    //c0 = p0
    //c1 = -3P0 + 3P1
    //c2 = +3P0 - 6P1 + 3P2 
    //c3 = -P0 + 3P1 - 3P2 + p3

    //c0
    coefs[0].x = puntos_de_ctrl[0].x;
    coefs[0].y = puntos_de_ctrl[0].y;
    
    //c1 
    coefs[1].x = -3*puntos_de_ctrl[0].x + 3*puntos_de_ctrl[1].x;
    coefs[1].y = -3*puntos_de_ctrl[0].y + 3*puntos_de_ctrl[1].y;

    //c2
    coefs[2].x = +3*puntos_de_ctrl[0].x - 6*puntos_de_ctrl[1].x + 3*puntos_de_ctrl[2].x; 
    coefs[2].y = +3*puntos_de_ctrl[0].y - 6*puntos_de_ctrl[1].y + 3*puntos_de_ctrl[2].y;

    //c3
    coefs[3].x = -puntos_de_ctrl[0].x + 3*puntos_de_ctrl[1].x - 3*puntos_de_ctrl[2].x +puntos_de_ctrl[3].x;
    coefs[3].y = -puntos_de_ctrl[0].y + 3*puntos_de_ctrl[1].y - 3*puntos_de_ctrl[2].y + puntos_de_ctrl[3].y;
  }
  
  //fórmula para pintar toda la curva (para hacer debug de estas)
  void pintar_curva(){
    float x,y;
  
    // pasar por toda la curva con un for
    for (float i = 0.0; i <1; i += 0.01){
      //calcular la x 
      x = coefs[0].x + coefs[1].x*i + coefs[2].x * (i * i) + coefs[3].x * (i * i * i);
      //calcular la y
      y = coefs[0].y + coefs[1].y*i + coefs[2].y * (i * i) + coefs[3].y * (i * i * i);

      //pintar un punto en esa coordenada
      point(x,y);
    }

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
  // Posicionar la bala
  void calcula_nueva_posicion_Bullet(){
    // Según el estado, nos movemos por una u otra curva
    // Cuando el parámetro "u" sea >= 1.0, toca cambiar de curva
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
    // Control del parámetro "u"
    u = u + 0.01;
    if (u >= 1.0){
      activeBullet = false;
    }
  }

  // Pintarla
  void print_Bullet(){
    fill(0,255,0);
    rectMode(CENTER);
    rect(BulletBoomeranPos.x, BulletBoomeranPos.y, 5, 15);
  }

  void SeeCollision(){
    //pillamos las paredes de las balas
    PVector Min_Bullet = new PVector(BulletBoomeranPos.x+widthBullet*0.5,BulletBoomeranPos.y+heightBullet*0.5);
    PVector Max_Bullet = new PVector(BulletBoomeranPos.x+widthBullet*0.5,BulletBoomeranPos.y+heightBullet*0.5); 
  
    //obtenemos uno de los dos jugadores en función de quién ha disparado
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

    if((Max_Bullet.x < Min_Player.x)||(Max_Bullet.y < Min_Player.y)||(Max_Player.x< Min_Bullet.x) || (Max_Player.y< Min_Bullet.y)){ 
      //no colisión
    }
    else{ //sí colisión
      if(Player1){
         p1Score.AddPlayerScore(100);
      }
      else{
        p2Score.AddPlayerScore(100);
      }
      activeBullet = false;
    }
  }
}
