import wollok.game.*
import cursor.*
import comandantes.*


object escenario {

	method configurar() {
		// CONFIGURACIÓN DEL JUEGO
		game.title("Langradigmas")
		game.height(17)
		game.width(31)
		//game.ground("magnaCastle.png")
		//game.boardGround("store.png")
		game.addVisual(cursor)
		movimiento.configurarFlechas(cursor)
		
		// Pruebas
		var unComandante = new Comandante(gameAt(0,0), "comandanteBueno.png")
//		unComandante.posicion().gameAt(0,0)
		game.addVisual(unComandante)


		
	}
	
}


