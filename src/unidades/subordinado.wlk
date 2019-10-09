import unidad.*
import comandante.*
import utilidades.distancia.*

class Subordinado inherits Unidad {
	var comandante
	
	override method buffAtaque() = super() + self.buffAtaquePorComandanteCerca()
	override method buffDefensa() = super() + self.buffDefensaPorComandanteCerca()
	
	method buffAtaquePorComandanteCerca() {
		var distanciaAlComandante = new Distancia(position = self.position() )
		return if (distanciaAlComandante.distanciaA(comandante.position())<3) comandante.buffAtaqueQueOtorga() else 0
	}
	
	method buffDefensaPorComandanteCerca() {
		var distanciaAlComandante = new Distancia(position = self.position() )
		return if (distanciaAlComandante.distanciaA(comandante.position())<3) comandante.buffDefensaQueOtorga() else 0
	}
	
	method serReclutado(unComandante) { comandante = unComandante }
}