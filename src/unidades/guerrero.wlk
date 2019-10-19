import subordinado.*

class Guerrero inherits Subordinado {
	method habilidadEspecial(cursor) {
		var enemigos = cursor.enemigosAmenazantes(self.position())
		enemigos.forEach { enemigo => enemigo.recibirDanio(2)}		
		cooldown = 4
	}
}