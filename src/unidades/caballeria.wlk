import wollok.game.*
import subordinado.*
import utilidades.distancia.*

class Caballeria inherits Subordinado {	
	method habilidadEspecial(cursor) {
		var difX = distancia.diferenciaEntre(cursor.position().x(), self.position().x())
		var difY = distancia.diferenciaEntre(cursor.position().y(), self.position().y())	
		var nuevaPos = game.at(cursor.position().x() + difX, cursor.position().y() + difY)
		cooldown = 2	
		
		if (cursor.hayEnemigoEn(cursor.position()) and cursor.enRangoEspecial() and !cursor.unidadEn(cursor.position()).equals(self)) {
			cursor.unidadEn(cursor.position()).recibirDanio(3)
			if (!cursor.esCasillaOcupable(nuevaPos))  {
				self.recibirDanio(1.randomUpTo(3).truncate(0))
				game.say(self, "Hay alguien detrás y recibí daño al volver")			
			}
			else {
				self.mover(nuevaPos)
				imagenCD.position(game.at(position.x(), position.y()))
			}
		} 
	}
}

