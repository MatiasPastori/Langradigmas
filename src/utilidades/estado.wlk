import wollok.game.*
import utilidades.distancia.*
import utilidades.acciones.*
import utilidades.comentarios.*
import unidades.unidad.*
import turnos.*

class EstadoAgarrado {
	var unidad
	
	method accion(cursor) {
		var distanciaEnMovimientos = new Distancia(position = unidad.position())
		if (cursor.esCasillaOcupable() && unidad.puedeLlegar(distanciaEnMovimientos.distanciaA(cursor.position()))) {
			cursor.descaptarEnemigosCercanos()
			unidad.mover(cursor.position())
			cursor.captarEnemigosCercanos(1)
			unidad.cambiarSprite(deseleccion)
		} else if (unidad.position() == cursor.position()) { 
			cursor.descaptarEnemigosCercanos()
			cursor.unidad(null)
			cursor.estado(estadoVacio)
			unidad.cambiarSprite(deseleccion)
		} else { game.say(unidad,error.msgmovimientoInvalido()) }
	}

}

object estadoVacio {
	var unidad
	
	method accion(cursor) {
		unidad = cursor.unidadEn(cursor.position())
		if (unidad != null && turnoManager.puedeAtacar(unidad) && turnoManager.esDelJugadorActual(unidad)) {
			cursor.captarEnemigosCercanos(1)
			cursor.unidad(unidad)
			cursor.estado(new EstadoAgarrado(unidad = unidad))
			unidad.cambiarSprite(seleccion)
		} else {
			cursor.unidad(null)
		}
	}
}