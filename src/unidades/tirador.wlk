import subordinado.*
import cursor.*

class Tirador inherits Subordinado {
	const property rangoEspecial = 2

	method habilidadEspecial() {
		cursor.unidadEn(cursor.position())
		//self.combatir()
	}

}