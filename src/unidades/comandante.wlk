import wollok.game.*
import unidad.*
import subordinado.*
import turnos.*
import utilidades.visuals.*
import utilidades.distancia.*

class Comandante inherits Unidad {
	const property subordinados = []
	
	method buffAtaqueQueOtorga() = 5
	method buffDefensaQueOtorga() = 2
	
	method reclutar(subordinado) = subordinados.add(subordinado)	

	override method curar() {
		self.modificarVida(10.min(vida + 3))
		self.imagenVida().image(self.getVida().toString() + ".png")
	}
	
	override method morir() {
		super()
		turnoManager.comandanteMuerto(self)
	}
	
	method habilidadEspecial(cursor) {
		cooldown = 6
		if(cursor.hayAtacableEn(cursor.position()) and cursor.enRangoEspecial() and !cursor.unidadEn(cursor.position()).equals(self)) {
			var enemigos = cursor.objetosAmenazantes(cursor.position())
			enemigos.forEach { enemigo => enemigo.recibirDanio(1.randomUpTo(2).truncante(0))}		
			cursor.unidadEn(cursor.position()).recibirDanio(6)
		}
	}
}
