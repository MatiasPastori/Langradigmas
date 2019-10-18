import unidades.unidad.*

class Jugador {
	var unidades = []
	var id
	
	method getUnidades() = unidades
	method getId() = id
	method comprar(unidad) = unidades.add(unidad)
	method curarUnidades() { unidades.forEach({unidad => unidad.curar()})}
	
	method reducirCooldowns() { 
		unidades.forEach{
			unidad => 
			unidad.cooldown(0.max(unidad.cooldown()-1))
			if (unidad.habilidadEspecialDisponible()) {
				unidad.imagenCD().image("especial_ready.png")
			}
		}
	}
}

object jugador1 inherits Jugador(id = "J1"){
	method cursorImage() = "cursorJ1.png"	
	method siguiente() = jugador2	
}

object jugador2 inherits Jugador(id = "J2"){
	method cursorImage() = "cursorJ2.png"
	method siguiente() = jugador1		
}
