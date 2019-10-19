import wollok.game.*
import unidad.*
import comandante.*
import utilidades.distancia.*
import utilidades.visuals.*

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
	
	method buff(bloque) = if (distancia.distanciaEntre(position, comandante.position()) < 3) bloque.apply() else 0
	
	override method morir() {
		comandante.subordinados().remove(self)
		super()
	}
}
