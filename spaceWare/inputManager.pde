///faltra mirar una forma de fer multiples input a l'hora

//PJ1
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




//PJ2

void inputForwardP2() {    
        if (keyCode == UP){
           player2.addSpeed();
        } 
        
        
    if(keyPressed == false){
            player2.ReduceSpeed();  
            player2.stopRotation(); 
   }   
    

}
void inputRotateP2() {
 
      
        if (keyCode == LEFT){
           player2.RotateLeft();
        }    
        else if (keyCode == RIGHT  || key == 'D'){
           player2.RotateRight();
        }  
       

}


void inputShootPlayer2(){
 if(keyPressed == true){
    if (keyCode == SHIFT && player2.Get_ShootColdown() <= 0){
      BulletPJ2.add(new bullet(false,player2.getCurrentPositionX(),player2.getCurrentPositionY(), player2.getCurrentRotation()));
      player2.activateColldown();
    }
 }
}
