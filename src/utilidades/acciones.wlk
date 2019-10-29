import wollok.game.*
import unidades.unidad.*
import cursor.*
import turnos.*

/*
 	iddle: setea la animación de movimiento de las unidades que no realizaron acción
 	seleccion: maneja el cambio de sprite cuando el cursor selecciona una unidad
 	deseleccion: maneja el cambio de sprite cuando el cursor deselecciona una unidad 
*/

object iddle {
	method cambiarSprite(unidad, id_xjug) {
		unidad.imagenVida().position(game.at(unidad.position().x(), unidad.position().y()))
		unidad.imagenCD().position(game.at(unidad.position().x(), unidad.position().y()))
		unidad.imagenVida().image(unidad.getVida().toString() + ".png")
		if (unidad.habilidadEspecialDisponible()) {
			unidad.imagenCD().image("especial_ready.png")		
		}
		game.onTick(1000,"iddle" + unidad.getIdUnico().toString(),{ 
			unidad.image(id_xjug + "iddle1.png")
			game.schedule(500, {unidad.image(id_xjug + "iddle2.png")})
		})
	}	
}
object seleccion {
	method cambiarSprite(unidad, id_xjug) {
		game.removeTickEvent("iddle" + unidad.getIdUnico().toString())
		unidad.imagenVida().image("transparente.png")
		unidad.imagenCD().image("transparente.png")	
		unidad.image("transparente.png")
		cursor.image(id_xjug + "Hold.png") 
	}
}
object deseleccion {
	method cambiarSprite(unidad, id_xjug) {
		if (unidad.getVida() > 0 ) {
			unidad.image(unidad.getTipo() + unidad.idJugador() + "gris.png")
			unidad.imagenVida().image(unidad.getVida().toString() + ".png")	
		}
		if (unidad.habilidadEspecialDisponible()) {
			unidad.imagenCD().image("especial_ready.png")		
		}
		cursor.image(turnoManager.getJugadorActual().cursorImage())
	}
}