import unidades.unidad.*
import wollok.game.*

/*
	Existen dos jugadores que heredan de Jugador para evitar repetir lógica compartida.
	@unidades: lista de unidades de un jugador.
	@id: identificador que representa al jugador.
	cursorImage: método que retorna la imagen png del cursor correspondiente al jugador.
*/

class Jugador {
	var unidades = []
	var id
	
	method getUnidades() = unidades
	method getId() = id
	method comprar(unidad) = unidades.add(unidad)
	method curarUnidades() { unidades.forEach({unidad => unidad.curar()})}
	method cursorImage() = "cursor"+ id + ".png"	
	
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
	method siguiente() = jugador2	
}

object jugador2 inherits Jugador(id = "J2"){
	method siguiente() = jugador1		
}
