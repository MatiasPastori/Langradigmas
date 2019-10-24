import subordinado.*
import cursor.*

class Tirador inherits Subordinado { 
	method habilidadEspecial(cursor) {
		cooldown = 3
		if(cursor.hayAtacableEn(cursor.position()) and cursor.enRangoEspecial() and !cursor.unidadEn(cursor.position()).equals(self)) 
			cursor.unidadEn(cursor.position()).recibirDanio(1.randomUpTo(3).roundUp())
	}
}