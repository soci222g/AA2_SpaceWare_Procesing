boolean activeLutPW;
boolean activeLutPJ;
//geters
//boolean GetLUT_PW(){return activeLutPW;}
//boolean GetLUT_PJ(){return activeLutPJ;}
//LUT 1
void LUT_PW(PImage img) {
  println("Changed Color");
  for(int i = 0; i <  img.width;i++){ //Recorre columnas, osea en X
      for(int j = 0; j <  img.height;j++){ //Recorre filas, osea en Y
        //Ya estoy en el pixel i,j de la imagen
        //1) Get de los valores RGB del pixel
        color p_color =  img.get(i,j);
        //2) Aplicar la formula, la LUT
        float r = red(p_color);
        float g = green(p_color);
        float b = blue(p_color);
        float y = 0.299 * r + 0.587 * g + 0.114 * b;//aplicar la formula
        color n_color = color(y);
        //3) Set de los nuevos valores al pixel
        img.set(i,j,n_color);
        if (y<125.0) y=0.0;
        else y=255.0;
        n_color = color(y);
        img.set(i,j,n_color);
      }
    }
}


//LUT 2
boolean isFlashing = false;
int flashStartTime = 0;
int flashInterval = 200;  // Cambia de color cada 200ms
int flashDuration = 2000; // Duración total de 2 segundos
boolean flashWhite = true;

void LUT_HitPJ() {
  isFlashing = true;
  flashStartTime = millis();
}

void updateFlashEffect() {
  int currentTime = millis();
  int elapsedTime = currentTime - flashStartTime;

  if (elapsedTime > flashDuration) {
    isFlashing = false;
    return; // termina el parpadeo
  }

  // Cambiar color cada flashInterval
  if ((elapsedTime / flashInterval) % 2 == 0) {
    if (!flashWhite) {
      applyFlashColor(255);  // blanco
      flashWhite = true;
    }
  } else {
    if (flashWhite) {
      applyFlashColor(0);  // negro
      flashWhite = false;
    }
  }
}

void applyFlashColor(float gray) {
  //naveImg.loadPixels(); // Accede a los píxeles crudos
  //for (int i = 0; i < naveImg.pixels.length; i++) {
  //  color c = naveImg.pixels[i];
  //  if (alpha(c) == 0) continue; // Mantener transparencia
  //  naveImg.pixels[i] = color(gray, gray, gray, alpha(c));
  //}
  //naveImg.updatePixels(); // Refresca la imagen después de los cambios
}
