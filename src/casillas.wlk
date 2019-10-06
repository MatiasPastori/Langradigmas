import wollok.game.*

class My_position {
	var property position
	var property image = "casillaPasto.png"
	
	method esSeleccionable() = false
}

object map_manager {
	var eje_x = []
	var borde = []
	
	
	method generar_casillas() {
		(game.width()-2).times({ 
			i =>
			var eje_y = []
			(game.height()-2).times({ 
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
		var casilla = new My_position(position = game.at(0,0), image = "casillaMontana.png") // No me agrega el 0,0 en el algoritmo de abajo
		game.addVisual(casilla)
		borde.add(casilla)
		(game.width()-1).times({
			i => 
			casilla = new My_position(position = game.at(i,0), image = "casillaMontana.png")
			game.addVisual(casilla)
			borde.add(casilla)
			casilla = new My_position(position = game.at(i,game.height()-1), image = "casillaMontana.png")
			game.addVisual(casilla)
			borde.add(casilla)
		})
		(game.height()-1).times({
			j => 
			casilla = new My_position(position = game.at(0,j), image = "casillaMontana.png")
			game.addVisual(casilla)
			borde.add(casilla)
			casilla = new My_position(position = game.at(game.width()-1,j), image = "casillaMontana.png")
			game.addVisual(casilla)
			borde.add(casilla)
		})
	}
	method access_bordes(_x,_y) = borde.get{casilla => casilla.position(_x,_y)}	
}




















