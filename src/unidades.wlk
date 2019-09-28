import wollok.game.*
import escenario.*

class Arquero {
	const comandante
	const movimientos = 2
	var puedeMoverse = true // Recordar hacer puedeMoverse = true al finalizar CADA TURNO
	var puedeAtacar = true  // Recordar hacer puedeAtacar = true al finalizar CADA TURNO
	var vida = 8
	
	var property position
	var property image
	
	method esSeleccionable() = true
	
	method mover(new_position) {
		position = game.at(new_position.x(), new_position.y())
		puedeMoverse = false
	}
	
	method combatir() {
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
		puedeAtacar = false
	}
	
	method puedeLlegar(movimientosNecesarios) = movimientosNecesarios <= movimientos && puedeMoverse


}
																				