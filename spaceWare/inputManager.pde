


void inputForwardP1() {    
        if (key == 'w'  || key == 'W'){
           player1.addSpeed();
           
           
        } 
        
        
    if(keyPressed == false){
            player1.ReduceSpeed();  
            player1.stopRotation(); 
   }   
    

}

void inputRotateP1() {
 
   
     
        if (key == 'a'  || key == 'A'){
           player1.RotateLeft();
        }    
        else if (key == 'd'  || key == 'D'){
           player1.RotateRight();
        }  
        else if (key != 'a'  || key != 'A' && key == 'd'  || key == 'D'){
                    player1.stopRotation(); 
        }  
    

}


void inputShootPlayer1(){
 if(keyPressed == true){
    if (key == ' ' && player1.Get_ShootColdown() <= 0){
      BulletPJ1.add(new bullet(true,player1.getCurrentPositionX(),player1.getCurrentPositionY(), player1.getCurrentRotation()));
      player1.activateColldown();
    }
 }
}

//aixo es crida quan una tecla es presa
