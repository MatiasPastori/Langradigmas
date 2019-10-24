import subordinado.*

class Guerrero inherits Subordinado {
	method habilidadEspecial(cursor) {
		var enemigos = cursor.objetosAmenazantes(self.position())
		enemigos.forEach { enemigo => enemigo.recibirDanio(1.randomUpTo(3).roundUp())}		
		cooldown = 4
	}
}