import wollok.game.*
import utilidades.teclado.*
import escenario.niveles.*
import escenario.tienda.*
import escenario.casillas.*
import cursor.*
import utilidades.visuals.*

object escenario {
	var nivelActual = nivel3

	method iniciar() {
		teclado.setearTeclasMovimiento(cursor)
		teclado.setearTeclasAccion(cursor)
		teclado.setearTeclasTienda()
		teclado.setearTeclasTurno()
		
		mapManager.generarCasillas()
		mapManager.generarBordes()
		
		self.iniciarNivel()
		return 0
	}
	method iniciarNivel() = nivelActual.generarNivel() 
	method nivelActual() = nivelActual
	method actualizarNivel() { nivelActual = nivelActual.siguiente() }
	method twilightZone(character) {
		character.imagenVida().position(game.at(100,100))
		character.position(game.at(100,100))
		game.at(100, 100).clear()
	}
}


