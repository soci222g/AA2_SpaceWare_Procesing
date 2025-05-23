boolean activeLutPW;
boolean activeLutPJ;
//geters
//boolean GetLUT_PW(){return activeLutPW;}
//boolean GetLUT_PJ(){return activeLutPJ;}
//LUT 1

void LUT_PW(PImage img, String tipoEfecto) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    color c = img.pixels[i];
    float alpha = alpha(c);

    // Solo modificar si no es transparente
    if (alpha > 0) {
      float r = red(c);
      float g = green(c);
      float b = blue(c);

      if (tipoEfecto.equals("red")) {
        img.pixels[i] = color(255, 0, 0, alpha);
      } else if (tipoEfecto.equals("green")) {
        img.pixels[i] = color(0, 255, 0, alpha);
      }
        else if (tipoEfecto.equals("blue")) {
        img.pixels[i] = color(0, 0, 255, alpha);
      } else {
        img.pixels[i] = color(r, g, b, alpha);
      }
    }
  }
  img.updatePixels();
}

    


void applyLUTToPlayer(Player pj, String tipoEfecto) {
  PImage copy = pj.navePJ_original.copy();
  LUT_PW(copy, tipoEfecto);
  pj.navePJ = copy;
}




//LUT 2
boolean isFlashingP1 = false;
boolean isFlashingP2 = false;

int flashStartTimeP1 = 0;
int flashStartTimeP2 = 0;

boolean flashWhiteP1 = true;
boolean flashWhiteP2 = true;

int flashInterval = 200;   // ms entre parpadeos
int flashDuration = 2000;  // ms total del efecto


void updateFlashEffect(Player pj, int flashStartTime, int playerId) {
  int currentTime = millis();
  int elapsedTime = currentTime - flashStartTime;

  if (elapsedTime > flashDuration) {
    if (playerId == 1) isFlashingP1 = false;
    if (playerId == 2) isFlashingP2 = false;
    pj.navePJ = pj.navePJ_original.copy();  // Restaurar imagen original
    return;
  }

  if ((elapsedTime / flashInterval) % 2 == 0) {
    if (playerId == 1 && !flashWhiteP1) {
      applyFlashColor(pj, 255);
      flashWhiteP1 = true;
    }
    if (playerId == 2 && !flashWhiteP2) {
      applyFlashColor(pj, 255);
      flashWhiteP2 = true;
    }
  } else {
    if (playerId == 1 && flashWhiteP1) {
      applyFlashColor(pj, 0);
      flashWhiteP1 = false;
    }
    if (playerId == 2 && flashWhiteP2) {
      applyFlashColor(pj, 0);
      flashWhiteP2 = false;
    }
  }
}

void applyFlashColor(Player pj, float gray) {
  pj.navePJ.loadPixels();  // Accede a los píxeles del jugador
  for (int i = 0; i < pj.navePJ.pixels.length; i++) {
    color c = pj.navePJ.pixels[i];
    if (alpha(c) == 0) continue;  // Mantener transparencia
    pj.navePJ.pixels[i] = color(gray, gray, gray, alpha(c));
  }
  pj.navePJ.updatePixels();  // Refresca la imagen después de los cambios
}

void startFlashPlayer1() {
  isFlashingP1 = true;
  flashStartTimeP1 = millis();
  flashWhiteP1 = true;
}

void startFlashPlayer2() {
  isFlashingP2 = true;
  flashStartTimeP2 = millis();
  flashWhiteP2 = true;
}
