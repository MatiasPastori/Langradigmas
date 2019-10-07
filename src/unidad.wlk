import wollok.game.*
import escenario.*
import cursor.*
import jugadores.*

// Superclase
class Unidad {
	const rangoDeAccion
	var property vida // property just for testing, no queremos que le toquen sus cositas
	var property puedeAtacar = true
	var property puedeMoverse = true
	var tipo
	
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
	}
	
	method recibirDanio(danio) {vida -= danio}
		
	method chequearMuerte() {if(self.vida() < 1) self.morir()}
		
	method morir() {escenario.twilightZone(self)}
	
	method cambiarSprite(accion) {
		var jugador = "J1"
		if (jugador2.getUnidades().contains(self)) jugador = "J2"
		accion.cambiarSprite(self, tipo + jugador)
	}
}

object ataque {
	method cambiarSprite(unidad, id) {
		// todavia no existen ataque1 y ataque2, seran dos sprites de mov de la unidad simulando el ataque
		game.onTick(1000,"ataque1",{ 
			unidad.image(id + "ataque1.png")
			game.onTick(500,"ataque2", {unidad.image(id + "ataque2.png")
				game.removeTickEvent("ataque1")
				game.removeTickEvent("ataque2")
				unidad.image(id + "gris.png") // todavia no existe ...gris.png
			})
		})
	}	
}
object iddle {
	method cambiarSprite(unidad, id) {
		game.onTick(1000,"iddle1",{ 
			unidad.image(id + "iddle1.png")
			game.onTick(500,"iddle2", {unidad.image(id + "iddle2.png")
				game.removeTickEvent("iddle2")
			})
		})
	}	
}
object avance {
	method cambiarSprite(unidad, id) {
		// esto se implementara si se logra hacer que la unidad avance casillero por casillero hasta el destino
	}	
}

																				