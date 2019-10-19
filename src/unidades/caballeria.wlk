import subordinado.*

class Caballeria inherits Subordinado {	
	method habilidadEspecial(cursor) {
		cooldown = 3
		if(cursor.hayEnemigoEn(cursor.position()) and cursor.enRangoEspecial()) 
			cursor.unidadEn(cursor.position()).recibirDanio(3)
	}

}