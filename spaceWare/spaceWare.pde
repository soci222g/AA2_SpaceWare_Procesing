
Player player;


void setup(){
size (800,800, P3D);
player = new Player(100,100,0.01,1,0.1,1);

}



void draw(){
  background(0);
  //input pj1
  inputForwardP1();
  inputRotateP1();
  
  
  
  player.PrintPlayer();
  
 
  
 
  
  
}
