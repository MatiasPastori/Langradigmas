import wollok.game.*
import cursor.*


object stage {

	method configurate() {
		// CONFIGURACIÓN DEL JUEGO
		game.title("Langradigmas")
		game.height(17)
		game.width(31)
		//game.ground("magnaCastle.png")
		//game.boardGround("store.png")
		game.addVisual(cursor)
		movimiento.configurarFlechas(cursor)
	}
	
}


