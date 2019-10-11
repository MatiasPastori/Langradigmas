import wollok.game.*
import escenario.escenario.*
import cursor.*
import utilidades.visuals.*
import utilidades.acciones.*
import jugadores.*
import turnos.*

// Superclase
class Unidad {
	const jugadorDuenio
	const rangoDeAccion
	var vida
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
		turnoManager.seMovio(self)
	}
	
	method puedeLlegar(rangoNecesario) = rangoNecesario <= rangoDeAccion && turnoManager.puedeMoverse(self)
	
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
		jugadorDuenio.getUnidades().remove(self)
		game.removeVisual(imagenVida)
		game.removeVisual(self)
	}
	
	method cambiarSprite(accion) {accion.cambiarSprite(self, tipo + self.idJugador())}
	
	method idJugador() = if (jugadorDuenio.equals(jugador1)) "J1" else "J2"
}

																				