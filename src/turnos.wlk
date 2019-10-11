import jugadores.*
import cursor.*
import utilidades.estado.*

object turnoManager {
	var jugadorActual = jugador1
	var unidadesLibres = []
	var unidadesMovidas = []
	var unidadesUsadas = []
	
	method getJugadorActual() = jugadorActual
	
	method iniciarTurno() {
		cursor.estado(estadoVacio)
		cursor.image(jugadorActual.cursorImage())
		unidadesLibres = jugadorActual.getUnidades().copy()
	}
	
	method finalizarTurno() {
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
}