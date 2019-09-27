import wollok.game.*

class Comandante {
	var property position
	var property image
	
	method esSeleccionable() = true
	method mover(new_position) {
		var n_p_x = (new_position.x() - position.x()).limitBetween(-2, 2)
		var n_p_y = (new_position.y() - position.y()).limitBetween(-2, 2)

		position = game.at(position.x() + n_p_x, position.y() + n_p_y)
	}
}
