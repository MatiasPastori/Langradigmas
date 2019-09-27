import wollok.game.*

class Comandante {
	var property position
	var property image
	
	const movimiento = 1
	var vida = 10
	var tropa = []
	
	method mover() {}
	method combatir() {
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
	}
	method reclutar(soldado) = tropa.add(soldado)
}
