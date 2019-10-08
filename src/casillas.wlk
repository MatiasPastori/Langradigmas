import wollok.game.*

class My_position {
	var property position
	var property image = "casillaPasto.png"
	
	method esSeleccionable() = false
}

object map_manager {
	const ancho = game.width()
    const alto = game.height()
	var eje_x = [] // casillas internas
	var borde = []
	
	
	method generar_casillas() {
		(ancho-2).times({ 
			i =>
			var eje_y = []
			(alto-2).times({ 
				j =>
				var casilla = new My_position(position = game.at(i, j))
				game.addVisual(casilla)
				eje_y.add(casilla)
			})
			eje_x.add(eje_y)
		})
	}
	method access(_x, _y) = eje_x.get(_x).get(_y) 

	method generar_bordes() {
		var posCasillas = []
			(0 .. ancho-1).forEach{ i => posCasillas.add(new Position(x=i, y=0)) } // borde abajo
			(0 .. ancho-1).forEach{ i => posCasillas.add(new Position(x=i, y=alto-1)) } // borde arriba
			(1 .. alto-2).forEach{ i => posCasillas.add(new Position(x=0, y=i)) } // borde izquierdo
			(1 .. alto-2).forEach{ i => posCasillas.add(new Position(x=ancho-1, y=i)) } // borde derecho
			
			posCasillas.forEach { posicion => 
				var casilla = new My_position(position = posicion, image = "casillaMontana.png")
				game.addVisual(casilla)
				borde.add(casilla)	
			}
		}
	method access_bordes(_x,_y) = borde.get{casilla => casilla.position(_x,_y)}	
}




















