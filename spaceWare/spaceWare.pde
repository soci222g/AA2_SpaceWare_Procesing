
Player player;


void setup(){
size (800,800);
player = new Player(100,100,0.01,1,1);

}



void draw(){
  background(0);
  
  if (player.Get_Current_Speed() > 0){
     player.AddForWard();
  }
  else{
   player.printPlayer();
  }
  
 
  
  
}
