import wollok.game.*
import niveles.*
import cursor.*
import comandante.*
import tirador.*

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
		
		var comandanteBueno = new Comandante(position = game.at(1,8), image = "comandanteBuenoIddle1.png", rangoDeAccion = 2, vida = 10, nivelAtaque = 20, nivelDefensa = 20)
		game.addVisual(comandanteBueno)	
		var unSoldadoBueno = new Tirador(position = game.at(2,9), image = "soldadoBuenoIddle1.png", comandante = comandanteBueno, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(unSoldadoBueno)
		var otroSoldadoBueno = new Tirador(position = game.at(2,7), image = "soldadoBuenoIddle1.png", comandante = comandanteBueno, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(otroSoldadoBueno)
		
		var comandanteMalo = new Comandante(position = game.at(game.width()-2,8), image = "comandanteMalo.png", rangoDeAccion = 2, vida = 10, nivelAtaque = 20, nivelDefensa = 20)
		game.addVisual(comandanteMalo)	
		var unArqueroMalo = new Tirador(position = game.at(game.width()-3,9), image = "arqueroBueno.png", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(unArqueroMalo)		
		var otroArqueroMalo = new Tirador(position = game.at(game.width()-3,7), image = "arqueroBueno.png", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(otroArqueroMalo)		
		
		// End Pruebas
		
		
		
		game.addVisual(cursor)
	}
	
	method twilightZone(character){
		character.position(game.at(100,100))
		game.at(100, 100).clear()
	}
	
}


