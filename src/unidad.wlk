import wollok.game.*
import escenario.*
import cursor.*

// Superclase
class Unidad {
	const rangoDeAccion
	var property vida
	var property puedeAtacar = true
	var puedeMoverse = true
	
	var property position
	var property image
	
	const property nivelAtaque
	const property nivelDefensa
	
	method esSeleccionable() = true
	
	method buffAtaque() = 0 // depende de casillas
	method buffDefensa() = 0 // depende de casillas
	
	method mover(nuevaPos) {
		position = game.at(nuevaPos.x(), nuevaPos.y())
		puedeMoverse = false
	}
	
	method puedeLlegar(rangoNecesarios) = rangoNecesarios <= rangoDeAccion && puedeMoverse
	
	method combatir(enemigo) {
		var danio = (self.nivelAtaque() + self.buffAtaque() - enemigo.nivelDefensa() - enemigo.buffDefensa()).limitBetween(0,10).randomUpTo(10).truncate(0)
		enemigo.recibirDanio(danio) 
		self.puedeAtacar(false)
	}
	
	method recibirDanio(danio) {vida -= danio}
		
	method chequearMuerte() {if(self.vida() < 1) self.morir()}
		
	method morir() {escenario.twilightZone(self)}
}
																				