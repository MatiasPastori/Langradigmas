import wollok.game.*

class Comandante {
	const movimientos = 1
	var vida = 10
	var puedeMoverse = true // Recordar hacer puedeMoverse = true al finalizar CADA TURNO
	var puedeAtacar = true  // Recordar hacer puedeAtacar = true al finalizar CADA TURNO
	
	var property position
	var property image
	
	method esSeleccionable() = true
	
	method mover(new_position) {
		position = game.at(new_position.x(),new_position.y())
		puedeMoverse = false
		
//		var n_p_x = (new_position.x() - position.x()).limitBetween(-movimientos, movimientos)
//		var n_p_y = (new_position.y() - position.y()).limitBetween(-movimientos, movimientos)
//
//		position = game.at(position.x() + n_p_x, position.y() + n_p_y)
	}
	
	method combatir() {
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
		puedeAtacar = false
	}
	
	method puedeLlegar(movimientosNecesarios) = movimientosNecesarios <= movimientos && puedeMoverse
}
