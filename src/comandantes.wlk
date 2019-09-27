import wollok.game.*

class Comandante {
	var property position
	var property image
	const seleccionable = true
	
	method mover(new_position) {
		position = game.at(new_position.x(), new_position.y())
	}
	
	method esSeleccionable() = seleccionable
}