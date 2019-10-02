import wollok.game.*
import escenario.*
import cursor.*
import distancia.*

class Arquero {
	const comandante
	const rangoDeAccion = 50
	var property vida = 10
	var puedeMoverse = true // Recordar hacer puedeMoverse = true al finalizar CADA TURNO
	var property puedeAtacar = true  // Recordar hacer puedeAtacar = true al finalizar CADA TURNO
	
	var property position
	var property image
	
	const property nivelAtaque = 20
	const property nivelDefensa = 20
	
	method buffAtaque() = self.buffAtaquePorComandanteCerca() // + method buff depende de casillas ataque
	method buffDefensa() = self.buffDefensaPorComandanteCerca() // + method buff depende de casillas defensa
	
	method esSeleccionable() = true
	
	method mover(nuevaPos) {
		position = game.at(nuevaPos.x(), nuevaPos.y())
		puedeMoverse = false
	}
	
	method puedeLlegar(movimientosNecesarios) = movimientosNecesarios <= rangoDeAccion && puedeMoverse
	
	method combatir(enemigo) {
		var danio = (self.nivelAtaque() + self.buffAtaque() - enemigo.nivelDefensa() - enemigo.buffDefensa()).limitBetween(0,10).randomUpTo(10).truncate(0)
		enemigo.recibirDanio(danio) 
		self.puedeAtacar(false)
	}
	
	method recibirDanio(danio) { vida -= danio } // if vida <= 0, matar unidad aca

	method buffAtaquePorComandanteCerca() {
		var distanciaAlComandante = new Distancia(position = self.position() )
		return if (distanciaAlComandante.distanciaA(comandante.position())<3) comandante.buffAtaqueQueOtorga() else 0
	}
	method buffDefensaPorComandanteCerca() {
		var distanciaAlComandante = new Distancia(position = self.position() )
		return if (distanciaAlComandante.distanciaA(comandante.position())<3) comandante.buffDefensaQueOtorga() else 0
	}

}
																				