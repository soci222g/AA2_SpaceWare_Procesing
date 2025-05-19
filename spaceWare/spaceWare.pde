
Player player1;
ArrayList<bullet> BulletPJ1 = new ArrayList<bullet>();

Player player2;
ArrayList<bullet> BulletPJ2 = new ArrayList<bullet>();


void setup(){
size (800,800, P3D);
player1 = new Player(200,400,0.01,1,0.1,1);
player2 = new Player(600,400,0.01,1,0.1,1);
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
 
  
  
}
