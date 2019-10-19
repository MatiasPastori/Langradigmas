import wollok.game.*

class MyPosition {
	var property position
	var property image = "transparente.png"
	
	method esSeleccionable() = false
}

object mapManager {
	const ancho = game.width()
    const alto = game.height()
	var internas = []
	var borde = []
	
	method getBorde() = borde	
	method getInternas() = internas
	
	method generarCasillas() {
		var eje_x = [] // casillas internas
		(ancho-2).times({ 
			i =>
			var eje_y = []
			(alto-2).times({ 
				j =>
				var casilla = new MyPosition(position = game.at(i, j))
				game.addVisual(casilla)
				eje_y.add(casilla)
			})
			eje_x.add(eje_y)
		})
		internas = eje_x.flatten()
	}
	method accederAInterna(_x, _y) = internas.find{casilla => casilla.position() == game.at(_x,_y)}
	method estaEnInternas(posicionCursor) = internas.findOrDefault({myPos => myPos.position() == posicionCursor},null)

	method generarBordes() {
		var posCasillas = []
			(0 .. ancho-1).forEach{ i => posCasillas.add(new Position(x=i, y=0)) } // borde abajo
			(0 .. ancho-1).forEach{ i => posCasillas.add(new Position(x=i, y=alto-1)) } // borde arriba
			(1 .. alto-2).forEach{ i => posCasillas.add(new Position(x=0, y=i)) } // borde izquierdo
			(1 .. alto-2).forEach{ i => posCasillas.add(new Position(x=ancho-1, y=i)) } // borde derecho
			
			posCasillas.forEach { posicion => 
				var casilla = new MyPosition(position = posicion)
				game.addVisual(casilla)
				borde.add(casilla)	
			}
		}
	method accessBorde(_x,_y) = borde.find{casilla => casilla.position() == game.at(_x,_y)}	
}




















