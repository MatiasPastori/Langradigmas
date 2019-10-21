import estados.estadoSeleccionCursor.*
import utilidades.acciones.*
import turnos.*

class EstadoEspecial {
	method accion(cursor) {
		var unidad = cursor.unidad()
		unidad.habilidadEspecial(cursor)
		cursor.borrarRango()
		turnoManager.yaAtaco(unidad)
		unidad.cambiarSprite(deseleccion)
		cursor.unidad(null)
		cursor.estadoSeleccion(estadoVacio)	
		cursor.estadoEspecial(estadoNoEspecial)	
	}
}

object estadoNoEspecial {
	method accion(cursor) {
		var unidad = cursor.unidad()
		cursor.descaptarEnemigosCercanos()
		cursor.borrarRango()
		cursor.mostrarRango(unidad.rangoEspecial(), "rango_especial.png")
		cursor.estadoEspecial(new EstadoEspecial())
	}
}