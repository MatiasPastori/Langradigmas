import wollok.game.*
import utilidades.teclado.*
import escenario.niveles.*
import escenario.tienda.*
import escenario.casillas.*
import cursor.*
import utilidades.visuals.*
import utilidades.pantallaCarga.*

object escenario {
	var nivelActual = nivel1

	method iniciar() {
		pantallaCarga.iniciarPantallaCarga()
		game.schedule(500, {
			
			mapManager.generarCasillas()
			mapManager.generarBordes()
			
			teclado.setearTeclasMovimiento(cursor)
			teclado.setearTeclasAccion(cursor)
			teclado.setearTeclasTienda()
			teclado.setearTeclasTurno()
			
			pantallaCarga.desactivarPantallaCarga()
			self.iniciarNivel()
		})
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


