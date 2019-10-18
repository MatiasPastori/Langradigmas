class EstadoEspecial {
	method accion(cursor) {

	}
}

object estadoNoEspecial {
	method accion(cursor) {
		var unidad = cursor.unidad()
		cursor.estadoEspecial(new EstadoEspecial())
		cursor.descaptarEnemigosCercanos()
		//cursor.captarEnemigosCercanos(unidad.rangoEspecial())
	}
}