import wollok.game.*

object casillas {

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
