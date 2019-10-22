import wollok.game.*
import utilidades.visuals.*
import utilidades.acciones.*
import utilidades.distancia.*
import jugadores.*
import turnos.*

// Superclase
class Unidad {
	const jugadorDuenio
	const property rangoDeAccion
	const property rangoEspecial
	var vida = 10
	var tipo
	
	var property position
	var property image
	var property imagenVida = new Visual(image = "10.png", position = game.center())
	var property imagenCD = new Visual(image = "especial_ready.png", position = game.center())
	
	const property nivelAtaque
	const property nivelDefensa
	var property cooldown = 0
	
	method esSeleccionable() = true
	method esAtacable() = true
	method esCasillaFija() = false
	
	method buffAtaque() = 0 // depende de casillas
	method buffDefensa() = 0 // depende de casillas
	
	method getVida() = vida
	method getTipo() = tipo
	
	method habilidadEspecialDisponible() = cooldown == 0
	
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
	}
	
	method potencialDeDanio(enemigo) = self.nivelAtaque() + self.buffAtaque() - enemigo.nivelDefensa() - enemigo.buffDefensa()

	method recibirDanio(danio) {
		self.modificarVida(vida - danio)
		self.chequearMuerte()
	}
	
	method modificarVida(nuevaVida) {
		vida = nuevaVida
		self.imagenVida().image(self.getVida().toString() + ".png")
	}
		
	method chequearMuerte() {if(self.getVida() < 1) self.morir()}
		
	method morir() {
		jugadorDuenio.getUnidades().remove(self)
		game.removeVisual(imagenVida)
		game.removeVisual(imagenCD)
		game.removeVisual(self)
	}
	
	method codoACodo() {
		return distancia.distanciaEntre(position, jugadorDuenio.getUnidades().head().position()) == 1
	}
	method curar() { 
		if(self.codoACodo()) {
			self.modificarVida(10.min(vida + 3))
			self.imagenVida().image(self.getVida().toString() + ".png")
		}
	}
	
	
	method cambiarSprite(accion) {accion.cambiarSprite(self, tipo + self.idJugador())}
	
	method idJugador() = jugadorDuenio.getId()
}

																				