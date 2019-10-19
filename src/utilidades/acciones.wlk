import wollok.game.*
import unidades.unidad.*
import cursor.*
import turnos.*

object iddle {
	method cambiarSprite(unidad, id_xjug) {
		unidad.imagenVida().position(game.at(unidad.position().x(), unidad.position().y()))
		unidad.imagenCD().position(game.at(unidad.position().x(), unidad.position().y()))
		game.onTick(1000,"iddle1",{ 
			unidad.image(id_xjug + "iddle1.png")
			game.onTick(500,"iddle2", {unidad.image(id_xjug + "iddle2.png")
				game.removeTickEvent("iddle2")
			})
		})
	}	
}
object seleccion {
	method cambiarSprite(unidad, id_xjug) {
		unidad.imagenVida().image("transparente.png")
		unidad.imagenCD().image("transparente.png")	
		unidad.image("transparente.png")
		cursor.image(id_xjug + "Hold.png") 
	}
}
object deseleccion {
	method cambiarSprite(unidad, id_xjug) {
		if (unidad.getVida() > 0 ) {
			unidad.cambiarSprite(iddle)
			unidad.imagenVida().image(unidad.getVida().toString() + ".png")	
		}
		if (unidad.habilidadEspecialDisponible()) {
			unidad.imagenCD().image("especial_ready.png")		
		}
		cursor.image(turnoManager.getJugadorActual().cursorImage())
	}
}
object ataque {
	method cambiarSprite(unidad, id_xjug) {

	}	
}