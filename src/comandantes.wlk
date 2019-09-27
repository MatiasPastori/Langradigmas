import wollok.game.*

class Comandante {
	var property position
	var property image
	
	method esSeleccionable() = true
	method mover(new_position) {
		position = game.at(new_position.x(), new_position.y())
	}
}
