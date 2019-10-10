import wollok.game.*
import utilidades.distancia.*
import unidades.unidad.*

class EstadoAgarrado {
	var unidad
	
	method accion(cursor) {
		var distanciaEnMovimientos = new Distancia(position = unidad.position())
		if (cursor.esCasillaOcupable() && unidad.puedeLlegar(distanciaEnMovimientos.distanciaA(cursor.position()))) {
			cursor.descaptarEnemigosCercanos()
			unidad.mover(cursor.position())
			cursor.captarEnemigosCercanos()
		} else if (unidad.position() == cursor.position()) { 
			cursor.descaptarEnemigosCercanos()
			cursor.unidad(null)
			cursor.estado(estadoVacio)
			unidad.cambiarSprite(deseleccion)
		} else { game.say(unidad,"No puedo llegar allí :(") }
	}
}

object estadoVacio {
	var unidad
	
	method accion(cursor) {
		unidad = cursor.unidadEn(cursor.position())
		if (unidad != null && unidad.puedeAtacar()) {
			cursor.captarEnemigosCercanos()
			cursor.unidad(unidad)
			cursor.estado(new EstadoAgarrado(unidad = unidad))
			unidad.cambiarSprite(seleccion)
		} else {
			cursor.unidad(null)
		}
	}
}