import wollok.game.*

object comandanteBueno inherits Comandante(game.at(0,0),"comandante.png")  {
	
}

//object comandanteMalo inherits Comandante() {
//	
//}

class Comandante {
	const movimiento = 1
	var vida = 10
	var property posicion
	var tropa = []
	var property image
	
	constructor(posicionInicial, imagen) {
		image = imagen
		posicion = posicionInicial
	}
	
	method mover() {}
	method combatir() {
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
	}
	method reclutar(soldado) = tropa.add(soldado)

}
