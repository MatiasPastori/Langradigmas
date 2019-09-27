import wollok.game.*
import escenario.*

class Arquero {
	const movimiento = 2
	const comandante
	var vida = 8
	var property posicion
	var property image
	
	method mover() {}
	method combatir() {
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
	}
	
}
