import jugadores.*
import cursor.*

object turnoManager {
	var jugadorActual = jugador1
	
	method getJugadorActual() = jugadorActual
	
	method iniciarTurno() {
		cursor.image(jugadorActual.cursorImage())
	}
	
	method finalizarTurno() {
		self.cambiarJugador()
		self.iniciarTurno()
	}
	method cambiarJugador() {jugadorActual = jugadorActual.siguiente()}
	
	method esDelJugador(messi) = jugadorActual.getUnidades().contains(messi)
}
