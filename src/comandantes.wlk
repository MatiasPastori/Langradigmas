import wollok.game.*

class Comandante {
	const movimientos = 1
	var movimientosRestantes = 1 // Recordar hacer movimientosRestantes = movimientos al finalizar CADA TURNO
	var vida = 10
	
	var property position
	var property image
	
	method esSeleccionable() = true
	
	method mover(new_position) {
		position = game.at(new_position.x(),new_position.y())
		
//		var n_p_x = (new_position.x() - position.x()).limitBetween(-movimientos, movimientos)
//		var n_p_y = (new_position.y() - position.y()).limitBetween(-movimientos, movimientos)
//
//		position = game.at(position.x() + n_p_x, position.y() + n_p_y)
	}
	
	method combatir() {
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
	}
	
	method puedeLlegar(movimientosNecesarios) = movimientosNecesarios <= movimientosRestantes

	method disminuirMovimientosRestantes(movs) { movimientosRestantes -= movs }
}
