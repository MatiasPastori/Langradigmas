import wollok.game.*

class Casilla {
	var property image //= "transparente.png" deben inicializarse todas asi y despues cada nivel las modifica
	var property position

    method casillasBorde() {
    	// Retorna una lista de posiciones que corresponden a las casillas del borde del mapa
   		const ancho = game.width() - 1 // debemos restarles uno para 
   		const alto = game.height() - 1 // que las posiciones se generen bien.
   		var casillasDelBorde = []
		
   		(0 .. ancho).forEach{ num => casillasDelBorde.add(new Position(x=num, y=alto))} // lado superior
   		(0 .. ancho).forEach{ num => casillasDelBorde.add(new Position(x=num, y=0))} // lado inferior
   		(0 .. alto).forEach{ num => casillasDelBorde.add(new Position(x=ancho, y=num))} // lado derecho
   		(0 .. alto).forEach{ num => casillasDelBorde.add(new Position(x=0, y=num))} // lado izquierdo
    
   		return casillasDelBorde.forEach {posicion => game.addVisualIn(self,posicion)}
	}
}

object mapaCasillas {
	const ancho = game.width() - 1 // debemos restarles uno para 
    const alto = game.height() - 1 // que las posiciones se generen bien.
	
	var casillasInternas = []
	var casillasBorde = []
	
	method setearCasillasInternas() {
		var cantCasillasInternas = ancho*alto - (2*ancho+2*alto)-4 // cantCasillasTot - bordes
		var posX = 1
		var posY = 1
		cantCasillasInternas.times{
			casillasInternas.add(new Casilla(position = new Position(x=posX, y=posY), image="casillaTest1.png"))
			if (posX != ancho) posX++
			else { 
				posX = 1
				posY++
			}	
		}
		casillasInternas.forEach {casilla => game.addVisualIn(self,casilla.position())}
	}
	method setearCasillasBorde() {
		(0 .. ancho).forEach{ num => casillasBorde.add(new Casilla(position = new Position(x=num, y=alto), image="casillaTest2.png"))} // lado superior
   		(0 .. ancho).forEach{ num => casillasBorde.add(new Casilla(position = new Position(x=num, y=0), image="casillaTest2.png"))} // lado inferior
   		(0 .. alto).forEach{ num => casillasBorde.add(new Casilla(position = new Position(x=ancho, y=num), image="casillaTest2.png"))} // lado derecho
   		(0 .. alto).forEach{ num => casillasBorde.add(new Casilla(position = new Position(x=0, y=num), image="casillaTest2.png"))} // lado izquierdo
   		casillasBorde.forEach {casilla => game.addVisualIn(self,casilla.position())}
	}
}