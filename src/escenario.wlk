import wollok.game.*
import niveles.*
import cursor.*
import comandantes.*
import unidades.*

object escenario {

	method configurar() {
		// CONFIGURACIÓN DEL JUEGO
		game.title("Langradigmas")
		game.height(17)
		game.width(31)
		//game.ground("original.gif")
		//game.boardGround("algo.gif")
		movimiento.configurarFlechas(cursor)

		
		keyboard.s().onPressDo { cursor.seleccionar() }	
		keyboard.a().onPressDo { cursor.atacar() }	
		keyboard.d().onPressDo { cursor.atacarEspecial() }
		
			
		// Start Pruebas
		
		var comandanteBueno = new Comandante(position = game.at(1,8), image = "comandanteBuenoIddle1.png")
		game.addVisual(comandanteBueno)	
		var unArqueroBueno = new Arquero(position = game.at(2,9), image = "soldadoBuenoIddle1.png", comandante = comandanteBueno)
		game.addVisual(unArqueroBueno)
		var otroArqueroBueno = new Arquero(position = game.at(2,7), image = "soldadoBuenoIddle1.png", comandante = comandanteBueno)
		game.addVisual(otroArqueroBueno)
		
		var comandanteMalo = new Comandante(position = game.at(game.width()-2,8), image = "comandanteMalo.png")
		game.addVisual(comandanteMalo)	
		var unCaballeroMalo = new Arquero(position = game.at(game.width()-3,9), image = "arqueroBueno.png", comandante = comandanteBueno)
		game.addVisual(unCaballeroMalo)		
		var unSoldadoMalo = new Arquero(position = game.at(game.width()-3,7), image = "arqueroBueno.png", comandante = comandanteBueno)
		game.addVisual(unSoldadoMalo)		
		
		// End Pruebas
		
		
		
		game.addVisual(cursor)
	}
	
	method twilightZone(character){
		character.position(game.at(100,100))
		game.at(100, 100).clear()
	}
	
}


