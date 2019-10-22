import wollok.game.*
import jugadores.*
import cursor.*
import estados.estadoSeleccionCursor.*
import utilidades.visuals.*
import escenario.escenario.*

object turnoManager {
	var property habilitado = false
	var jugadorActual = jugador1
	var unidadesLibres = []
	var unidadesMovidas = []
	var unidadesUsadas = []
	
	method getJugadorActual() = jugadorActual
	
	method iniciarTurno() {
		game.sound(jugadorActual.musica())
		cursor.estadoSeleccion(estadoVacio)
		cursor.image(jugadorActual.cursorImage())
		cursor.position(game.center())
		jugadorActual.curarUnidades()
		jugadorActual.reducirCooldowns()
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
	
	method comandanteMuerto(comandante) {
		if (habilitado) {
			habilitado = false
			escenario.nivelActual().terminarNivel(self.ganador(comandante))
		}
	}
	
	method ganador(comandantePerdedor) = if(self.esDelJugadorActual(comandantePerdedor)) jugadorActual.siguiente() 
											else jugadorActual
}
