import subordinado.*

class Guerrero inherits Subordinado {
	method habilidadEspecial(cursor) {
		cooldown = 4
		if(cursor.hayEnemigoEn(cursor.position()) and cursor.enRangoEspecial()) {
			var enemigosCerca = []

			
			cursor.unidadEn(cursor.position()).recibirDanio(2)
			
		}
			
	}

}