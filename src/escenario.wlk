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

		
		//keyboard.s().onPressDo { cursor.seleccionar() }	
		
			
		// Pruebas
		var comandanteBueno = new Comandante(position = game.center(), image = "comandanteBueno.png")
		game.addVisual(comandanteBueno)	
		var unArqueroBueno = new Arquero(position = game.at(15,15), image = "arqueroBueno.png", comandante = comandanteBueno)
		game.addVisual(unArqueroBueno)				
		
		/////////////////////////////////////////////
		// Guardo constantemente lo que haya detras del cursor NO ME IMPORTA QUE, unidades, piedras, objetos
		// Cualquier cosa con colision
		// Lo pienso asi porque capaz mas adelante queremos poder seleccionar otras cosas que no sean comandantes
		game.whenCollideDo(cursor, { algo => cursor.setObjetoColisionado(algo) })
		keyboard.s().onPressDo { cursor.seleccionar() }	
		
		
	}
	
}


