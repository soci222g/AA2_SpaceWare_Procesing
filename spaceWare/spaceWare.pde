
Player player1;
ArrayList<bullet> BulletPJ1 = new ArrayList<bullet>();
Score p1Score;

Player player2;
ArrayList<bullet> BulletPJ2 = new ArrayList<bullet>();
ArrayList<curva> curvaPJ1 = new ArrayList<curva>();
Score p2Score;

ArrayList<PowerUp> powers = new ArrayList<PowerUp>();

PImage naveImgOriginal;
PImage naveImg;

void setup() {
  size(800, 800, P3D);
  naveImgOriginal = loadImage("nave.png");
  naveImg = naveImgOriginal.copy(); // Usar copia para modificaciones
ArrayList<curva> curvaPJ2 = new ArrayList<curva>();
PImage naveImg;

//setup per la posicion de las curbas del boomerang para player 1 i player 2
PVector p1[];
PVector p2[];

void setup(){
size (800,800, P3D);
naveImg = loadImage("nave.png");
player1 = new Player(200,400,0.01,1,0.1,1, naveImg); //new Player(200,400,0.01,1,0.1,1);
player2 = new Player(600,400,0.01,1,0.1,1, naveImg); //new Player(600,400,0.01,1,0.1,1);
p1Score = new Score();
p2Score = new Score();



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
}



void draw(){
  background(0);
 
  
  
  
  
  //input pj1
  inputForwardP1();
  inputRotateP1();
  inputShootPlayer1();
    
    //logica interna player
  player1.ColldownShoot();  
  player1.PrintPlayer();
  if(player1.GetTripleShoot()){ 
      player1.TimerPowerUps();
  }

  if(BulletPJ1.size() > 0){
     for(int i = 0; i < BulletPJ1.size(); i++){
           //print bullet
           if(BulletPJ1.get(i).GetisActive()){
             BulletPJ1.get(i).PrintBullet();
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

   if(player2.GetTripleShoot()){ 
      player2.TimerPowerUps();
  }

  if(BulletPJ2.size() > 0){
     for(int i = 0; i < BulletPJ2.size(); i++){
           //print bullet
           if(BulletPJ2.get(i).GetisActive()){
             BulletPJ2.get(i).PrintBullet();
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
    if (isFlashing) {
    updateFlashEffect();
  }
  
}
