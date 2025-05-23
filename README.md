# AA2_SpaceWare_Procesing

	- Nombres completos de integrantes del equipo
		Máximo Albero Fernández y Jordi Gratacòs Gamper


	Explicación powerUps:
	El juego cuenta con 3 powerUps en total, que son los siguientes:

	 - Triple disparo. Al obtener este powerUp (que se obtiene de las esferas rojas), el jugador efectuará un disparo triple en lugar del disparo normal.
	 - Disparo búmerang. Al obtener este powerUp (obtenido por parte de las esferas verdes), el jugador realizará un disparo que seguira una curva, que hara que
		regrese al lugar desde donde se ha disparado haciendo una curva, precisamente como lo hace un búmerang.
	 - Invencibilidad. Al obtener este powerUp (obtenido por parte de las esferas azules), el jugador que lo use será invencible durante el tiempo que el powerUp este activo
		y no será afectado por las balas del contrincante.
		
	Gameplay:
	El gameplay se basa en un juego 1 contra 1, donde controlamos a 2 naves espaciales que se tendrán que disparar entre ellas
	para poder sumar puntuación y tener más que el contrario. En el escenario también hay obstaculos que siguen una ruta por la pantalla
	que si colisionan contra uno de los jugadores, le restarán puntos.
	Los jugadores podrán acelerar hacia delante y rotar sobre si mismos para poder moverse y esquivar los disparos enemigos y los obstaculos.
	Además de eso, el juego cuenta con 3 powerUps, 2 que afectan al disparo y 1 que afecta al propio jugador.

	Controles:
	 Player 1:
		- WASD - movimiento
		- Barra espaciadora - disparo

	 Player 2:
		- Flechas direccionales - movimento
		- Shift - disparo

	Que ha hecho cada uno:
		Máximo
		LUTs, powerUp Invencibilidad, puntuación, 
		cambio de lado de pantalla al sobrepasar los bordes, poder usar inputs simultaneos

		Jordi
		movimento, disparo , powerUps disparo triple y disparo búmerang, obstaculos, colisiones. 


	 -Transformaciones Homogeneas:
		El movimiento de los jugadores y el disparo funcionan con transforms, en primer lugar movemos a los elementos a la posición que se encuentra en el mundo, luego rotamos a estos en función de la angulación que esta marcada. por ultimo desplazamos hacia delante (X) a los elementos en función de que velocidad llevan. en el caso de la balla es constante i en el jugador tiene una aceleración i frenado. 

	 -LUTs
		Hemos usado LUTs en 2 casos distintos:
		 - El primero se usa cuando un jugador coge un powerUp, donde este cambiará de color al mismo que el del powerUp que haya obtenido:
		  rojo para el disparo triple, verde para el disparo búmerang y azul para la invencibilidad. Este efecto se mantiene mientras el powerUp
		  este activo. Una vez se ha terminado su efecto, el player vuelve a tener su aspecto original.
		 - El segundo se usa cuando un jugador es impactado por una bala enemiga o a chocado contra un obstaculo, donde se pondra a parpadear en blanco y negro
		  durante unos segundos para dejar claro que ha sido golpeado. Una vez se termine el efecto, el player vuelve a tener su aspecto original.  
	  
	 -Curvas:
		Hemos usado 2 curvas:
		 - Bezier: La hemos usado para realizar el powerUp del disparo búmerang, haciendo que este realize una curva desde donde se dispara 
		  hasta volver a la misma posición.
		 - Interpolación: La hemos usado para realizar el recorrido que siguen los obstáculos por en medio de la pantalla.
	 

	Tematica escogida:
		Hemos escogido hacer la tematica homenage a un juego, que en este caso se trata de "SpaceWar!".




POSTMORTEM
	En relación a aspectos técnicos y de trabajo en equipo
	-- Lo que SI ha ido bien
	Nos hemos coordinado bien con tal de realizar los requerimientos estipulados para la práctica.
	Hemos sabido trabajar bien en equipo, dedicandonos a realizar tareas que no se pisarán entre ellas.
	Esto nos a permitido tener un ritmo de trabajo fluido que nos a dejado avanzar en el trabajo a un muy buen ritmo.

	-- Lo que NO tanto y podemos mejorar 
	A pesar de habernos coordinado bien y haber trabajado en equipo, hemos ido más apurados de tiempo de lo que nos gustaria, 
	haciendo que haya ciertos aspectos que podriamos a ver mejorado y pulido.


ELEMENTOS DE ALGEBRA VISTOS EN CLASE:

	1. Pathfinding: Se ha utilizado para que el texto de la puntuación de los players los sigan mientras estos se mueven.
	2. Colision esfera-quadrat: Se han utilizado para las colisiones entre los players y los powerUps, además de los players y los obstaculos
	3. Colisiones cuadrado-cuadrado: Se han utilizado para las colisiones entre el player y las balas