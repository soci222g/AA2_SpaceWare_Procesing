
Player player;


void setup(){
size (800,800);
player = new Player(100,100);

}



void draw(){
  background(0);
  
  player.AddForWard();
  
  
}
