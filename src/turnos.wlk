import wollok.game.*
import jugadores.*
import cursor.*
import estados.estadoSeleccionCursor.*
import utilidades.visuals.*
import utilidades.acciones.*
import escenario.escenario.*

object turnoManager {
	var property habilitado = false
	var jugadorActual = jugador1
	var unidadesLibres = []
	var unidadesMovidas = []
	var unidadesUsadas = []
	
	method getJugadorActual() = jugadorActual
	method setJugadorActual(jugador) {jugadorActual = jugador}
	
	method iniciarTurno() {
		cursor.estadoSeleccion(estadoVacio)
		cursor.image(jugadorActual.cursorImage())
		cursor.position(game.center())
		jugadorActual.curarUnidades()
		jugadorActual.reducirCooldowns()
		unidadesLibres = jugadorActual.getUnidades().copy()
	}
	
	method finalizarTurno() {
//		jugadorActual.getUnidades().forEach{ unidad =>
//			try {
//				game.removeTickEvent("iddle" + unidad.getIdUnico().toString())
//			} catch e {
//				// Necesito catchear el error que tira wlk cuando removes un tick que no existe y no hacer nada.
//				// Esto porque despues de atacar las unidades pierden su tick y se ponen grises. Entonces cuando
//				// remuevo el tick de todas las unidades del jugador, hay algunas (las que atacaron) que ya no tienen
//				// tick y tira error. Sin embargo, el juego puede seguir, no rompe nada. 
//				// Me parece esta solución mucho mas simple que andar guardando en una lista los ticks activos y demás
//				// Estaría bueno que game (quizás lo hace y no lo sé) guarde en una lista los ticks activos como hace
//				// con los visuals.
//			}
//			then always unidad.cambiarSprite(iddle) // Perdon
			
//		}
		self.reiniciarTicks(unidadesMovidas)
		self.reiniciarTicks(unidadesUsadas)
		unidadesMovidas.clear()
		unidadesUsadas.clear()
		self.cambiarJugador()
		self.iniciarTurno()
	}
	
	method puedeMoverse(unidad) = unidadesLibres.contains(unidad)
	method seMovio(unidad) {
		unidadesLibres.remove(unidad)
		unidadesMovidas.add(unidad)
	}
	method puedeAtacar(unidad) = unidadesLibres.contains(unidad) || unidadesMovidas.contains(unidad)
	method yaAtaco(unidad) {
		unidadesLibres.remove(unidad)
		unidadesMovidas.remove(unidad)
		unidadesUsadas.add(unidad)
	} 
	
	method cambiarJugador() {jugadorActual = jugadorActual.siguiente()}
	
	method esDelJugadorActual(messi) = jugadorActual.getUnidades().contains(messi)
	
	method comandanteMuerto(comandante) {
		if (habilitado) {
			habilitado = false
			escenario.nivelActual().terminarNivel(self.ganador(comandante))
		}
	}
	
	method ganador(comandantePerdedor) = if(self.esDelJugadorActual(comandantePerdedor)) jugadorActual.siguiente() else jugadorActual
	
	method reiniciarTicks(unidades) { unidades.forEach{ unidad => unidad.cambiarSprite(iddle)} }
}
