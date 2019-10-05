import wollok.game.*

class My_position {
	var property position
	method image() = "cursorGood.png"
}

object map_manager {
	var lista_x = []
	
	
	method mapear_casillas() {
		game.width().times({ i =>
			var lista_y = []
			game.height().times({ j =>
				var casilla = new My_position(position = game.at(i, j))
				game.addVisual(casilla)
				lista_y.add(casilla)
			})
			lista_x.add(lista_y)
		})
	}
	
	method access(_x, _y) = lista_x.get(_x).get(_y) 
}




















