import wollok.game.*
import escenario.escenario.*
import cursor.*
import jugadores.*
import utilidades.visuals.*
import utilidades.acciones.*

// Superclase
class Unidad {
	const rangoDeAccion
	var vida
	var property puedeAtacar = true
	var property puedeMoverse = true
	var tipo
	
	var property position
	var property image
	var property imagenVida = new Visual(image = "10.png", position = game.center())
	
	const property nivelAtaque
	const property nivelDefensa
	
	method esSeleccionable() = true
	
	method buffAtaque() = 0 // depende de casillas
	method buffDefensa() = 0 // depende de casillas
	
	method getVida() = vida
	
	method mover(nuevaPos) {
		position = game.at(nuevaPos.x(), nuevaPos.y())
		imagenVida.position(game.at(nuevaPos.x(), nuevaPos.y()))
		puedeMoverse = false
	}
	
	method puedeLlegar(rangoNecesario) = rangoNecesario <= rangoDeAccion && puedeMoverse
	
	method combatir(enemigo) {
		var danioBruto = self.potencialDeDanio(enemigo).limitBetween(0,10)
		var danioNeto = danioBruto.randomUpTo(10).truncate(0)
		enemigo.recibirDanio(danioNeto)
		self.imagenVida().image(self.getVida().toString() + ".png")
	}
	
	method potencialDeDanio(enemigo) = self.nivelAtaque() + self.buffAtaque() - enemigo.nivelDefensa() - enemigo.buffDefensa()

	method recibirDanio(danio) {
		vida -= danio
		self.chequearMuerte()

	}
		
	method chequearMuerte() {if(self.getVida() < 1) self.morir()}
		
	method morir() {
		game.removeVisual(imagenVida)
		game.removeVisual(self)
	}
	
	method cambiarSprite(accion) {accion.cambiarSprite(self, tipo + self.idJugador())}
	
	method idJugador() = if (jugador1.getUnidades().contains(self)) "J1" else "J2"
}

																				