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

		
		
<<<<<<< HEAD
			
		// Pruebas
		var comandanteBueno = new Comandante(position = game.center(), image = "comandanteBueno.png")
		game.addVisual(comandanteBueno)		
		
=======
				
	// Pruebas
	var comandanteBueno = new Comandante(position = game.at(10, 10), image = "comandanteBueno.png")
	game.addVisual(comandanteBueno)



>>>>>>> 95859357fff49f4fce61ff21ed80ac79e894c82b
		
		keyboard.s().onPressDo { cursor.seleccionar() }	
	}
	
}


