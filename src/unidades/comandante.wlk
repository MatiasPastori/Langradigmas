import wollok.game.*
import unidad.*
import subordinado.*
import escenario.escenario.*
import utilidades.visuals.*

class Comandante inherits Unidad {
	const property subordinados = []
	
	method buffAtaqueQueOtorga() = 0
	method buffDefensaQueOtorga() = 0
	
	method reclutar(subordinado) = subordinados.add(subordinado)	

	method curarSubordinadosCerca() {}
	
	override method morir() {
		super()
		escenario.nivelActual().terminarNivel()
	}
	
	method habilidadEspecial() {
		
	}
}
