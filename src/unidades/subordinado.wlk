import unidad.*
import comandante.*
import utilidades.distancia.*

class Subordinado inherits Unidad {
	var comandante
	
	override method buffAtaque() = super() + self.buffAtaquePorComandanteCerca()
	override method buffDefensa() = super() + self.buffDefensaPorComandanteCerca()
	
	method buffAtaquePorComandanteCerca() {
		return self.buff({comandante.buffAtaqueQueOtorga()})
	}
	
	method buffDefensaPorComandanteCerca() {
		return self.buff({comandante.buffDefensaQueOtorga()})
	}
	
	method buff(bloque) {
		var distanciaAlComandante = new Distancia(position = self.position() )
		return if (distanciaAlComandante.distanciaA(comandante.position())<3) bloque.apply() else 0
	}
	
	method serReclutado(unComandante) { comandante = unComandante }
}
