import subordinado.*

class Guerrero inherits Subordinado {
	method habilidadEspecial(cursor) {
		cooldown = 4
		if(cursor.hayEnemigoEn(cursor.position()) and cursor.enRangoEspecial()) {
			var enemigosCercanos = []
			cursor.posicionesAmenazantes().forEach{ pos => enemigosCercanos.add(cursor.unidadEn(pos)) }
			enemigosCercanos.forEach{}

			
			cursor.unidadEn(cursor.position()).recibirDanio(2)
			
		}
			
	}

}