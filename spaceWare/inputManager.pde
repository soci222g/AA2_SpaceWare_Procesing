///faltra mirar una forma de fer multiples input a l'hora
boolean[] keys = new boolean[128];

void keyPressed() {
  if (key < 128) {
    keys[key] = true;
  }
  if (keyCode < 128) {
    keys[keyCode] = true;
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
    player1.stopRotation();
  }
    

}
void inputRotateP1() {
   if (keys['A']) {
      player1.RotateLeft();
    }
    if (keys['D']) {
      player1.RotateRight();
    }

}


void inputShootPlayer1(){
  if (keys[' '] && player1.Get_ShootColdown() <= 0) {
    BulletPJ1.add(new bullet(true, player1.getCurrentPositionX(), player1.getCurrentPositionY(), player1.getCurrentRotation()));
    player1.activateColldown();
  }
}




//PJ2

void inputForwardP2() {    
  if (keys[UP]) {
      player2.addSpeed();
    } else {
      player2.ReduceSpeed();
      player2.stopRotation();
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
    BulletPJ2.add(new bullet(false, player2.getCurrentPositionX(), player2.getCurrentPositionY(), player2.getCurrentRotation()));
    player2.activateColldown();
  }
}
