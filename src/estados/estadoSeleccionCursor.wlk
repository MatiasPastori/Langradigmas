import wollok.game.*
import utilidades.distancia.*
import utilidades.acciones.*
import utilidades.comentarios.*
import unidades.unidad.*
import turnos.*

class EstadoAgarrado {
	var unidad
	
	method accion(cursor) {
		if (cursor.esCasillaOcupable(cursor.position()) && unidad.puedeLlegar(distancia.distanciaEntre(unidad.position(),cursor.position()))) {
			cursor.descaptarEnemigosCercanos()
			unidad.mover(cursor.position())
			cursor.borrarRango()
			unidad.cambiarSprite(iddle)
			cursor.captarEnemigosCercanos()
			if (cursor.noHayEnemigosCerca()) {
				game.removeTickEvent("iddle" + unidad.getIdUnico().toString())
				unidad.cambiarSprite(deseleccion)
				cursor.unidad(null)
				cursor.estadoSeleccion(estadoVacio)				
			}
		} else if (unidad.position() == cursor.position()) { 
			cursor.descaptarEnemigosCercanos()
			cursor.borrarRango()
			cursor.unidad(null)
			cursor.estadoSeleccion(estadoVacio)
			unidad.cambiarSprite(deseleccion)
		} else { game.say(unidad,error.msgmovimientoInvalido()) }
	}
}

object estadoVacio {
	var unidad
	
	method accion(cursor) {
		unidad = cursor.unidadEn(cursor.position())
		if (unidad != null && turnoManager.esDelJugadorActual(unidad)) {
			self.verificarSiSeMovioEnEsteTurno()
			cursor.unidad(unidad)
			cursor.captarEnemigosCercanos()
		 	cursor.mostrarRango(unidad.rangoDeAccion(), "rango_transitable.png")
			cursor.estadoSeleccion(new EstadoAgarrado(unidad = unidad))
			unidad.cambiarSprite(seleccion)
		} else {
			cursor.unidad(null)
		}
	}
	method verificarSiSeMovioEnEsteTurno() {
		if (!turnoManager.puedeMoverse(unidad))
			unidad.error(error.msgmovimientoUsado())
	}
}