
PImage Bg_Imag;



Player player1;
ArrayList<bullet> BulletPJ1 = new ArrayList<bullet>();
ArrayList<boomerangRecorido> curvaPJ1 = new ArrayList<boomerangRecorido>();
Score p1Score;

Player player2;
ArrayList<bullet> BulletPJ2 = new ArrayList<bullet>();
ArrayList<boomerangRecorido> curvaPJ2 = new ArrayList<boomerangRecorido>();

Score p2Score;

ArrayList<PowerUp> powers = new ArrayList<PowerUp>();

PImage naveImgOriginal;
PImage nave1Img;
PImage nave2Img;

//setup per la posicion de las curbas del boomerang para player 1 i player 2
PVector p1[];
PVector p2[];

void setup() {
  size(800, 800, P3D);
  naveImgOriginal = loadImage("nave.png");
  nave1Img = naveImgOriginal.copy(); // Usar copia para modificaciones
  nave2Img = naveImgOriginal.copy(); // Usar copia para modificaciones
player1 = new Player(250,400,0.01,2,0.1,2, nave1Img); //new Player(200,400,0.01,1,0.1,1);
player2 = new Player(450,400,0.01,2,0.1,2, nave2Img); //new Player(600,400,0.01,1,0.1,1);

p1Score = new Score();
p2Score = new Score();


//posicion para las curvas de becier
  p1 = new PVector[4];
  p1[0] = new PVector(0, 0); // Este es el punto de ctrl P0
  p1[1] = new PVector(0, 0); // Y este es el P1
  p1[2] = new PVector(0, 0); // El P2
  p1[3] = new PVector(0, 0);
  
    p2 = new PVector[4];
  p2[0] = new PVector(0, 0); // Este es el punto de ctrl P0
  p2[1] = new PVector(0, 0); // Y este es el P1
  p2[2] = new PVector(0, 0); // El P2
  p2[3] = new PVector(0, 0);

  //Desactivar luts als principio
  activeLutPW = false;
  activeLutPJ = false;
  
  
  //obstaculo
  PVector q[]; //primera posicion de la curba
  q = new PVector[4];
  q[0] = new PVector(200,100); //este el el punto inicial P0
  q[1] = new PVector(300,150); // p1
  q[2] = new PVector(400,50); // P2
  q[3] = new PVector(700,200); // P3
  Seccion_Obstacle1 = new RutaObstaculo(q);
  
  PVector k[]; //segunda seccion de la curba
  k = new PVector[4];
  k[0] = new PVector(700,200); //este el el punto inicial P0
  k[1] = new PVector(650,400); // p1
  k[2] = new PVector(750,550); // P2
  k[3] = new PVector(600,750); // P3
  Seccion_Obstacle2 = new RutaObstaculo(k);
  
   PVector w[]; //tercera seccion de la curba
  w = new PVector[4];
  w[0] = new PVector(600,750); //este el el punto inicial P0
  w[1] = new PVector(500,700); // p1
  w[2] = new PVector(450,550); // P2
  w[3] = new PVector(250,500); // P3
  Seccion_Obstacle3 = new RutaObstaculo(w);
  
  PVector l[]; //quarta seccion de la curba
  l = new PVector[4];
  l[0] = new PVector(250,500); //este el el punto inicial P0
  l[1] = new PVector(125,400); // p1
  l[2] = new PVector(100,200); // P2
  l[3] = new PVector(200,100); // P3
  seccion_Obstacle4 = new RutaObstaculo(l);
  
  
  Obstaculo1 = new obstaculo(1);
  Obstaculo2 = new obstaculo(3);
 
 
 Bg_Imag = loadImage("BackGround.png");
}



void draw(){
  background(Bg_Imag);
  //obstaculo
  
  
Obstaculo1.ClaculaPositionObstaculo(0.005);
    if(Obstaculo1.GetActivateObstacle()){
      Obstaculo1.PrintaObstaculo();
      Obstaculo1.SeeCollision1();
      Obstaculo1.SeeCollision2();

    }
    else{
       Obstaculo1.ReActivateObstacle();
         
    }
    
    Obstaculo2.ClaculaPositionObstaculo(0.005);
  if(Obstaculo2.GetActivateObstacle()){
      Obstaculo2.PrintaObstaculo();
      Obstaculo2.SeeCollision1();
      Obstaculo2.SeeCollision2();
  }
   else{
       Obstaculo2.ReActivateObstacle();
      
    }
  
  
  //input pj1
  inputForwardP1();
  inputRotateP1();
  inputShootPlayer1();
    
    //logica interna player
  player1.ColldownShoot();  
  player1.PrintPlayer();
  player1.FollowText(p1Score.GetScore());
  
  if(player1.GetTripleShoot() || player1.GetBoomeranShoot() ||player1.GetInvincibility()){ 
          
      player1.TimerPowerUps();
  }

  if(BulletPJ1.size() > 0){
     for(int i = 0; i < BulletPJ1.size(); i++){
           //print bullet
           if(BulletPJ1.get(i).GetisActive()){
             BulletPJ1.get(i).PrintBullet();
             BulletPJ1.get(i).SeeCollision();
           }
           else{
             BulletPJ1.remove(i);
           }
     }
  
  }
  
  inputForwardP2();
  inputRotateP2();
  inputShootPlayer2();
  
  player2.ColldownShoot();  
  player2.PrintPlayer();
  player2.FollowText(p2Score.GetScore());
   if(player2.GetTripleShoot() || player2.GetBoomeranShoot()){ 
      player2.TimerPowerUps();
  }

  if(BulletPJ2.size() > 0){
     for(int i = 0; i < BulletPJ2.size(); i++){
           //print bullet
           if(BulletPJ2.get(i).GetisActive()){
             BulletPJ2.get(i).PrintBullet();
             BulletPJ2.get(i).SeeCollision();
           }
           else{
             BulletPJ2.remove(i);
           }
     }
  
  }
  
  if(curvaPJ1.size() > 0){
    
    for(int i = 0; i < curvaPJ1.size(); i++){
    if(curvaPJ1.get(i).GetActive()){
      curvaPJ1.get(i).calcular_coefs();
      curvaPJ1.get(i).calcula_nueva_posicion_Bullet();
      curvaPJ1.get(i).print_Bullet();
      curvaPJ1.get(i).SeeCollision();
      }
      else{
        curvaPJ1.remove(i);
      }
    }
  }
  
    if(curvaPJ2.size() > 0){
    
    for(int i = 0; i < curvaPJ2.size(); i++){
    if(curvaPJ2.get(i).GetActive()){
      curvaPJ2.get(i).calcular_coefs();
      curvaPJ2.get(i).calcula_nueva_posicion_Bullet();
      curvaPJ2.get(i).print_Bullet();
      curvaPJ2.get(i).SeeCollision();
      }
      else{
        curvaPJ2.remove(i);
      }
    }
  }
 GenerateRandomPowerUp();
  
  if(powers.size() > 0){
  
    for(int i = 0; i < powers.size(); i++){
        if(powers.get(i).GetIsActive()){
          powers.get(i).printPowerUp();
          powers.get(i).seePlayer1Collide();
          powers.get(i).seePlayer2Collide();
        }
      else
      {
       powers.remove(i);
      }
  
  }
    
    
  }
 
  //Prova per a veure si funciona la LUT del parpadeig
  if (isFlashingP1) {
    updateFlashEffect(player1, flashStartTimeP1, 1);
  }
  if (isFlashingP2) {
    updateFlashEffect(player2, flashStartTimeP2, 2);
  }


  
}
