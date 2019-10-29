import wollok.game.*
import unidad.*
import comandante.*
import utilidades.distancia.*
import utilidades.visuals.*

/*
	Clase abstracta. De ella heredan las unidades del jugador distintas al comandante.
	A su vez, hereda de Unidad, la superclase de todas las unidades. 
*/
class Subordinado inherits Unidad {
	var comandante
	
	override method buffAtaque(casilla) = super(casilla) + self.buffAtaquePorComandanteCerca()
	override method buffDefensa(casilla) = super(casilla) + self.buffDefensaPorComandanteCerca()
	
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
