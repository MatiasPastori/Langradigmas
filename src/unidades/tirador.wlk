import subordinado.*
import cursor.*

class Tirador inherits Subordinado { 
	method habilidadEspecial(cursor) {
		cooldown = 3
		if(cursor.hayAtacableEn(cursor.position()) and cursor.enRangoEspecial()) 
			cursor.unidadEn(cursor.position()).recibirDanio(3)
	}
}