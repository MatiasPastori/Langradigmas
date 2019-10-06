import wollok.game.*

class My_position {
	var property position
	var property image = "casillaPasto.png"
	
	method esSeleccionable() = false
}

object map_manager {
	var eje_x = []
	
	
	method generar_casillas() {
		game.width().times({ 
			i =>
			var eje_y = []
			game.height().times({ 
				j =>
				var casilla = new My_position(position = game.at(i-1, j-1))
				game.addVisual(casilla)
				eje_y.add(casilla)
			})
			eje_x.add(eje_y)
		})
	}
	
	method access(_x, _y) = eje_x.get(_x).get(_y) 
}




















