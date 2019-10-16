import subordinado.*
import cursor.*

class Tirador inherits Subordinado {

	method habilidadEspecial() {
		cursor.unidadEn(cursor.position())
		//self.combatir()
	}

}