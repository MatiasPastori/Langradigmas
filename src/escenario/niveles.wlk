import wollok.game.*
import escenario.casillas.*
import escenario.tienda.*
import unidades.comandante.*
import unidades.tirador.*
import unidades.guerrero.*
import unidades.caballeria.*
import unidades.unidad.*
import utilidades.acciones.*
import utilidades.visuals.*
import jugadores.*
import turnos.*
import cursor.*

object nivel1 {	
	var tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	
	method generarNivel() {
		self.setearCasillas()
		game.schedule(2000, {self.tienda()})
	}
	method tienda() {
		var comandanteBueno = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", rangoDeAccion = 50, vida = 10, nivelAtaque = 28, nivelDefensa =24 )
		var comandanteMalo = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "comandante", rangoDeAccion = 2, vida = 10, nivelAtaque = 24, nivelDefensa = 30)
		
		game.addVisual(tiendaImg)
		
		jugador1.comprar(comandanteBueno)
		jugador2.comprar(comandanteMalo)
		tienda.habilitada(true)
		tienda.iniciar()
	}
	method iniciar() {
		game.removeVisual(tiendaImg)
		
		
		// Start Pruebas		
		var comandanteBueno = new Comandante(position = game.at(1,8), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", rangoDeAccion = 50, vida = 10, nivelAtaque = 28, nivelDefensa =24 )
		game.addVisual(comandanteBueno)	
		var soldadoBueno1 = new Guerrero(position = game.at(2,9), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(soldadoBueno1)
		var tiradorBueno = new Tirador(position = game.at(2,7), image = "transparente.png", jugadorDuenio = jugador1, tipo = "tirador", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(tiradorBueno)
		var caballeroBueno = new Caballeria(position = game.at(3,9), image = "transparente.png", jugadorDuenio = jugador1, tipo = "caballeria", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(caballeroBueno)
		var soldadoBueno4 = new Guerrero(position = game.at(3,7), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(soldadoBueno4)
		var comandanteMalo = new Comandante(position = game.at(game.width()-2,8), image = "transparente.png", jugadorDuenio = jugador2, tipo = "comandante", rangoDeAccion = 2, vida = 10, nivelAtaque = 24, nivelDefensa = 30)
		game.addVisual(comandanteMalo)	
		var tiradorMalo1 = new Tirador(position = game.at(game.width()-3,9), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(tiradorMalo1)		
		var guerreroMalo = new Guerrero(position = game.at(game.width()-3,7), image = "transparente.png", jugadorDuenio = jugador2, tipo = "guerrero", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(guerreroMalo)		
		var caballeroMalo = new Caballeria(position = game.at(game.width()-4,9), image = "transparente.png", jugadorDuenio = jugador2, tipo = "caballeria", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(caballeroMalo)		
		var tiradorMalo4 = new Tirador(position = game.at(game.width()-4,7), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(tiradorMalo4)	
		
		jugador1.comprar(comandanteBueno)
		jugador1.comprar(soldadoBueno1)
		jugador1.comprar(tiradorBueno)
		jugador1.comprar(caballeroBueno)
		jugador1.comprar(soldadoBueno4)
		jugador2.comprar(comandanteMalo)
		jugador2.comprar(tiradorMalo1)
		jugador2.comprar(guerreroMalo)
		jugador2.comprar(caballeroMalo)
		jugador2.comprar(tiradorMalo4)
		
		comandanteBueno.cambiarSprite(iddle)
		game.addVisual(comandanteBueno.imagenVida())
		soldadoBueno1.cambiarSprite(iddle)
		game.addVisual(soldadoBueno1.imagenVida())
		tiradorBueno.cambiarSprite(iddle)
		game.addVisual(tiradorBueno.imagenVida())
		caballeroBueno.cambiarSprite(iddle)
		game.addVisual(caballeroBueno.imagenVida())
		soldadoBueno4.cambiarSprite(iddle)
		game.addVisual(soldadoBueno4.imagenVida())
		comandanteMalo.cambiarSprite(iddle)
		game.addVisual(comandanteMalo.imagenVida())
		tiradorMalo1.cambiarSprite(iddle)
		game.addVisual(tiradorMalo1.imagenVida())
		guerreroMalo.cambiarSprite(iddle)
		game.addVisual(guerreroMalo.imagenVida())
		caballeroMalo.cambiarSprite(iddle)
		game.addVisual(caballeroMalo.imagenVida())
		tiradorMalo4.cambiarSprite(iddle)
		game.addVisual(tiradorMalo4.imagenVida())
		// End Pruebas
		
		game.addVisual(cursor)
		turnoManager.iniciarTurno()
	}
	
	method setearCasillas() {
		mapManager.getEjeX().forEach{
			ejeY => ejeY.forEach{
				casilla => casilla.image("casillaPasto.png")
			}
		}
		mapManager.getBorde().forEach{
			casilla => casilla.image("casillaMontana.png")
		}
	}
	
	method siguiente() = nivel2
}

object nivel2 {
	var tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	
	method generarNivel() {
		self.setearCasillas()
		game.schedule(2000, {self.tienda()})
	}	
	
	method tienda() {

	}
	
	method iniciar() {
	
	}
	
	method setearCasillas() {

	}
	
	method siguiente() = nivel3
}

object nivel3 {
	var tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	
	method generarNivel() {
		self.setearCasillas()
		game.schedule(2000, {self.tienda()})
	}	
		
	method tienda() {

	}
	method iniciar() {
		
	}
	
	method setearCasillas() {

	}
	
	method siguiente() = null
}
