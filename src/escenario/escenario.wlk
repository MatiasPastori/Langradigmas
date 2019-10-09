import wollok.game.*
import utilidades.teclado.*
import escenario.niveles.*
import escenario.tienda.*
import escenario.casillas.*
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
		game.boardGround("tienda.png")
		
		teclado.setearTeclasMovimiento(cursor)
		teclado.setearTeclasAccion(cursor)
		teclado.setearTeclasTienda()
		
		mapManager.generarCasillas()
		mapManager.generarBordes()
		
		game.addVisual(cursor)
	}
	method nivelActual() = nivelActual
	method actualizarNivel() { nivelActual = nivelActual.siguiente() }
	method twilightZone(character) {
		character.imagenVida().position(game.at(100,100))
		character.position(game.at(100,100))
		game.at(100, 100).clear()
	}
}


