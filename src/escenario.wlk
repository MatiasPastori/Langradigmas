import wollok.game.*
import teclado.*
import niveles.*
import casillas.*
import cursor.*

object escenario {
	const height = 17
	const width = 31
	var nivelActual = nivel1

	method configurar() {
		// CONFIGURACIÓN DEL JUEGO
		game.title("Langradigmas")
		game.height(height)
		game.width(width)
		
		teclado.setearTeclasMovimiento(cursor)
		teclado.setearTeclasAccion(cursor)
		
		mapManager.generarCasillas()
		mapManager.generarBordes()
		
		nivelActual.iniciar()
		
		game.addVisual(cursor)
	}
	method actualizarNivel() {
		nivelActual = nivelActual.siguiente()
	}
	method twilightZone(character) {
		character.imagenVida().position(game.at(100,100))
		character.position(game.at(100,100))
		game.at(100, 100).clear()
	}
}


