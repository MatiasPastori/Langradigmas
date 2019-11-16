import wollok.game.*
import jugadores.*
import cursor.*
import estados.estadoSeleccionCursor.*
import utilidades.visuals.*
import utilidades.acciones.*
import escenario.escenario.*

/*
	Este objeto maneja la lógica de los turnos. Decide quien es el jugador que puede realizar sus acciones.
	@habilitado: true cuando el nivel comienza, false cuando termina
	@jugadorActual: indica de qué jugador es el turno
	@unidadesLibres: unidades del jugadorActual que aún no realizaron ninguna acción
	@unidadesMovidas: unidades que el jugadorActual movió
	@unidadesUsadas: unidades con las que el jugadorActual atacó a un rival
*/

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
