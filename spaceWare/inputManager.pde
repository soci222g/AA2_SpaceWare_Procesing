


void inputForwardP1() {
 
   
     
        if (key == 'w'  || key == 'W'){
           player.addSpeed();
           
           
        } 
       
  
      
    if(keyPressed == false){
            player.ReduceSpeed();  
            player.stopRotation(); 

   }   
    

}

void inputRotateP1() {
 
   
     
        if (key == 'a'  || key == 'A'){
           player.RotateLeft();
        }    
        else if (key == 'd'  || key == 'D'){
           player.RotateRight();
        }  
        else if (key != 'a'  || key != 'A' && key == 'd'  || key == 'D'){
                    player.stopRotation(); 
        }  
    

}

void keyReleased(){
 if (key != 'a'  || key != 'A' && key == 'd'  || key == 'D'){
                    player.stopRotation(); 
        }  
}
//aixo es crida quan una tecla es presa
