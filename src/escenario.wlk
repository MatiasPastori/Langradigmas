import wollok.game.*
import teclado.*
import niveles.*
import casillas.*
import cursor.*
import comandante.*
import tirador.*

object escenario {
	const height = 17
	const width = 31
	var nivelActual = nivel1

	method configurar() {
		// CONFIGURACIÓN DEL JUEGO
		game.title("Langradigmas")
		game.height(height)
		game.width(width)
		//game.ground("original.gif")
		//game.boardGround("algo.gif")
		
		teclado.setearTeclasMovimiento(cursor)
		teclado.setearTeclasAccion(cursor)
		
		// Esto no funka todavia
		//mapaCasillas.setearCasillasInternas()
		//mapaCasillas.setearCasillasBorde()
		
			
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
		
		map_manager.generar_casillas()
		
		// End Pruebas
		
		
		
		game.addVisual(cursor)
	}
	method actualizarNivel() {
		nivelActual.nivelSiguiente()
	}
	method twilightZone(character) {
		character.position(game.at(100,100))
		game.at(100, 100).clear()
	}
}


