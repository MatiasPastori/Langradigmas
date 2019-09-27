import wollok.game.*
import cursor.*
import comandantes.*
import unidades.*

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

		
		keyboard.s().onPressDo { cursor.seleccionar() }	
		keyboard.a().onPressDo { cursor.atacar() }	
		keyboard.d().onPressDo { cursor.atacarEspecial() }
		
			
		// Pruebas
		var comandanteBueno = new Comandante(position = game.center(), image = "comandanteBueno.png")
		game.addVisual(comandanteBueno)	
		var unArqueroBueno = new Arquero(position = game.at(15,15), image = "arqueroBueno.png", comandante = comandanteBueno)
		game.addVisual(unArqueroBueno)	
		
	}
	
}


