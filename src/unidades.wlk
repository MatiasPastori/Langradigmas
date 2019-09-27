import wollok.game.*
import escenario.*

class Arquero {
	const comandante
	const movimiento = 2
	var movimientosRestantes = 2 // Recordar hacer movimientosRestantes = movimientos al finalizar CADA TURNO
	var vida = 8
	
	var property position
	var property image
	
	method esSeleccionable() = true
	
	method mover(new_position) {
		position = game.at(new_position.x(), new_position.y())
	}
	
	method combatir() {
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
	}
	
	method puedeLlegar(movimientosNecesarios) = movimientosNecesarios <= movimientosRestantes

	method disminuirMovimientosRestantes(movs) { movimientosRestantes -= movs }
}
																				