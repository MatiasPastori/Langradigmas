import wollok.game.*
import escenario.escenario.*
import cursor.*
import jugadores.*
import utilidades.visuals.*

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

object iddle {
	method cambiarSprite(unidad, id_xjug) {
		unidad.imagenVida().position(game.at(unidad.position().x(), unidad.position().y()))
		game.onTick(1000,"iddle1",{ 
			unidad.image(id_xjug + "iddle1.png")
			game.onTick(500,"iddle2", {unidad.image(id_xjug + "iddle2.png")
				game.removeTickEvent("iddle2")
			})
		})
	}	
}
object seleccion {
	method cambiarSprite(unidad, id_xjug) {
		game.removeTickEvent("iddle1")
		game.removeTickEvent("iddle2")
		unidad.imagenVida().image("transparente.png")
		unidad.image("transparente.png")
		cursor.image(id_xjug + "Hold.png") 
	}
}
object deseleccion {
	method cambiarSprite(unidad, id_xjug) {
		if (unidad.getVida() > 0 ) {
			unidad.cambiarSprite(iddle)
			unidad.imagenVida().image(unidad.getVida().toString() + ".png")			
		}
		cursor.image(cursor.jugadorActual().cursorImage())
	}
}
object ataque {
	method cambiarSprite(unidad, id_xjug) {
		if (unidad.getVida() > 0) {unidad.imagenVida().image(unidad.getVida().toString() + ".png")}
		
		//unidad.image(id_jug + "gris.png") // todavia no existe ...gris.png
		// todavia no existen ataque1 y ataque2, seran dos sprites de mov de la unidad simulando el ataque
		// comento el codigo porque me interesa que se le cambie el sprite de vida despues de atacar
//		game.onTick(1000,"ataque1",{ 
//			unidad.image(id_jug + "ataque1.png")
//			game.onTick(500,"ataque2", {unidad.image(id_jug + "ataque2.png")
//				game.removeTickEvent("ataque1") // quiero que se ejecuten una vez cada uno pero separados por X segs
//				game.removeTickEvent("ataque2") //  y despues se borran
//			})
//		})
	}	
}

																				