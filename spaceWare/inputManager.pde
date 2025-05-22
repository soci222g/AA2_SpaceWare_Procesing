///faltra mirar una forma de fer multiples input a l'hora
boolean[] keys = new boolean[128];

void keyPressed() {
  if (key < 128) {
    keys[key] = true;
  }
  if (keyCode < 128) {
    keys[keyCode] = true;
  }
  
  if (keys['H']) {
  LUT_HitPJ(); // Llama al parpadeo cuando se presiona 'h'
}
}

void keyReleased() {
  if (key < 128) {
    keys[key] = false;
  }
  if (keyCode < 128) {
    keys[keyCode] = false;
  }
}



//PJ1
void inputForwardP1() {    
    if (keys['W']) {
    player1.addSpeed();
  } else {
    player1.ReduceSpeed();
    
  }
    

}
void inputRotateP1() {
   if (keys['A']) {
      player1.RotateLeft();
    }
    if (keys['D']) {
      player1.RotateRight();
    }

     if(!keys['A'] && !keys['D']){
     player1.stopRotation();
  }
}


void inputShootPlayer1(){
  if (keys[' '] && player1.Get_ShootColdown() <= 0) {
    if(player1.GetTripleShoot()){
         BulletPJ1.add(new bullet(true, player1.getX(), player1.getY(), player1.getCurrentRotation()));
         BulletPJ1.add(new bullet(true, player1.getX(), player1.getY(), player1.getCurrentRotation() + 25));
         BulletPJ1.add(new bullet(true, player1.getX(), player1.getY(), player1.getCurrentRotation() - 25));
         player1.activateColldown();
    }
    else if(player1.GetBoomeranShoot()){
      
        p1[0] = new PVector(player1.getX(), player1.getY()); // Este es el punto de ctrl P0
        //trnafomr para setear los puntos en funcion del player
       print(p1[0].x,",",p1[0].y, " ");
        pushMatrix();
      
           translate(player1.getX(),player1.getY());
           rotate(radians(player1.getCurrentRotation()));
           
           translate(250,-125);
           
        p1[1] = new PVector(modelX(0,0,0), modelY(0,0,0));// Y este es el P1
          popMatrix();
       print(p1[1].x,",", p1[1].y, " ");
        
         pushMatrix();
      
           translate(player1.getX(),player1.getY());
           rotate(radians(player1.getCurrentRotation()));
           
           translate(250,125);
           
        p1[2] = new PVector(modelX(0,0,0), modelY(0,0,0)); // El P2
          print(p1[2].x,",", p1[2].y, " ");
        popMatrix();
        
        p1[3] = new PVector(player1.getX(), player1.getY()); //el punto de control final
        
           print(p1[3].x,",", p1[3].y, " ");
         
         curvaPJ1.add(new curva (p1,true));
         
         player1.activateColldown();
      }
    else{
      BulletPJ1.add(new bullet(true, player1.getX(), player1.getY(), player1.getCurrentRotation()));
       player1.activateColldown();
    }
    
          //AIXÒ ESTA AQUI PER PROVAR QUE FUNCIONA
          //p1Score.AddPlayerScore();
   
  }

}




//PJ2

void inputForwardP2() {    
  if (keys[UP]) {
      player2.addSpeed();
    } else {
      player2.ReduceSpeed();
     
    }

}
void inputRotateP2() {
  if (keys[LEFT]) {
    player2.RotateLeft();
  }
  if (keys[RIGHT]) {
    player2.RotateRight();
  }
 

}


void inputShootPlayer2(){
  if (keys[SHIFT] && player2.Get_ShootColdown() <= 0) {
     if(player2.GetTripleShoot()){
         BulletPJ2.add(new bullet(false, player2.getX(), player2.getY(), player2.getCurrentRotation()));
         BulletPJ2.add(new bullet(false, player2.getX(), player2.getY(), player2.getCurrentRotation() + 25));
         BulletPJ2.add(new bullet(false, player2.getX(), player2.getY(), player2.getCurrentRotation() - 25));
         player2.activateColldown();
    }
     else if(player2.GetBoomeranShoot()){
      
        p2[0] = new PVector(player2.getX(), player2.getY()); // Este es el punto de ctrl P0
        //trnafomr para setear los puntos en funcion del player
        pushMatrix();
      
           translate(player2.getX(),player2.getY());
           rotate(radians(player2.getCurrentRotation()));
           
           translate(250,-125);
           
        p2[1] = new PVector(modelX(0,0,0), modelY(0,0,0));// Y este es el P1
          popMatrix();
        
         pushMatrix();
      
           translate(player2.getX(),player2.getY());
           rotate(radians(player2.getCurrentRotation()));
           
           translate(250,125);
           
        p2[2] = new PVector(modelX(0,0,0), modelY(0,0,0)); // El P2
        popMatrix();
        
        p2[3] = new PVector(player2.getX(), player2.getY()); //el punto de control final
        
         
         curvaPJ1.add(new curva (p2,true));
         
         player2.activateColldown();
      }
    else{
      BulletPJ2.add(new bullet(false, player2.getX(), player2.getY(), player2.getCurrentRotation()));
      player2.activateColldown();
    }
  }
}
