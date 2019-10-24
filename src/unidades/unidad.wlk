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
	var idUnico
	
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
	method esObjetoGrande() = false
	
	method buffAtaque(casilla) = self.buffCasilla(casilla, {objeto => objeto.buffAtaqueQueOtorga()})
	method buffDefensa(casilla) = self.buffCasilla(casilla, {objeto => objeto.buffDefensaQueOtorga()})
	
	method buffCasilla(casilla, bloque) {
		if (casilla.objeto() != null) {
			return bloque.apply(casilla.objeto())
		}
		return 0
	} 
	
	method getVida() = vida
	method getTipo() = tipo
	method getIdUnico() = idUnico
	
	method habilidadEspecialDisponible() = cooldown == 0
	
	method mover(nuevaPos) {
		position = game.at(nuevaPos.x(), nuevaPos.y())
		imagenVida.position(game.at(nuevaPos.x(), nuevaPos.y()))
		turnoManager.seMovio(self)
	}
	
	method puedeLlegar(rangoNecesario) = rangoNecesario <= rangoDeAccion && turnoManager.puedeMoverse(self)
	
	method combatir(enemigo, casilla) {
		var danioBruto = self.potencialDeDanio(enemigo, casilla).limitBetween(0,10)
		var danioNeto = danioBruto.randomUpTo(10).truncate(0)
		enemigo.recibirDanio(danioNeto)
	}
	
	method potencialDeDanio(enemigo, casilla) = self.nivelAtaque() + self.buffAtaque(casilla) - enemigo.nivelDefensa() - enemigo.buffDefensa(casilla)

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

																				