


void input() {
 
    if(keyPressed == true){
     
        if (key == 'w'  || key == 'W'){
           player.addSpeed();
        }  
        if (key == 'a'  || key == 'A'){
           player.RotateLeft();
        }    
        if (key == 'd'  || key == 'D'){
           player.RotateRight();
        }  
    }
      
    if(keyPressed == false){
            player.ReduceSpeed();
            player.stopRotation();  
   }   
    

}
//aixo es crida quan una tecla es presa
