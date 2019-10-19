import wollok.game.*
import unidad.*
import subordinado.*
import escenario.escenario.*
import utilidades.visuals.*
import utilidades.distancia.*

class Comandante inherits Unidad {
	const property subordinados = []
	
	method buffAtaqueQueOtorga() = 5
	method buffDefensaQueOtorga() = 2
	
	method reclutar(subordinado) = subordinados.add(subordinado)	

	override method morir() {
		super()
		escenario.nivelActual().terminarNivel()
	}
	
	method habilidadEspecial(cursor) {
		cooldown = 6
		if(cursor.hayEnemigoEn(cursor.position()) and cursor.enRangoEspecial()) {
			var enemigos = cursor.enemigosAmenazantes(cursor.position())
			enemigos.forEach { enemigo => enemigo.recibirDanio(2)}		
			cursor.unidadEn(cursor.position()).recibirDanio(6)
		}
	}
}
