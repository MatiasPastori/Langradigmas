import wollok.game.*
import escenario.casillas.*
import escenario.tienda.*
import unidades.comandante.*
import unidades.tirador.*
import unidades.unidad.*
import utilidades.acciones.*
import jugadores.*
import turnos.*
import cursor.*

object nivel1 {
	
	method tienda() {
		var comandanteBueno = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", rangoDeAccion = 50, vida = 10, nivelAtaque = 28, nivelDefensa =24 )
		var comandanteMalo = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "comandante", rangoDeAccion = 2, vida = 10, nivelAtaque = 24, nivelDefensa = 30)
		jugador1.comprar(comandanteBueno)
		jugador2.comprar(comandanteMalo)
		tienda.habilitada(true)
		tienda.iniciar()
	}
	method iniciar() {
		self.setearCasillas()

		
		
		// Start Pruebas		
		var comandanteBueno = new Comandante(position = game.at(1,8), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", rangoDeAccion = 50, vida = 10, nivelAtaque = 28, nivelDefensa =24 )
		game.addVisual(comandanteBueno)	
		var soldadoBueno1 = new Tirador(position = game.at(2,9), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(soldadoBueno1)
		var soldadoBueno2 = new Tirador(position = game.at(2,7), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(soldadoBueno2)
		var soldadoBueno3 = new Tirador(position = game.at(3,9), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(soldadoBueno3)
		var soldadoBueno4 = new Tirador(position = game.at(3,7), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = comandanteBueno, rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		game.addVisual(soldadoBueno4)
		var comandanteMalo = new Comandante(position = game.at(game.width()-2,8), image = "transparente.png", jugadorDuenio = jugador2, tipo = "comandante", rangoDeAccion = 2, vida = 10, nivelAtaque = 24, nivelDefensa = 30)
		game.addVisual(comandanteMalo)	
		var tiradorMalo1 = new Tirador(position = game.at(game.width()-3,9), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(tiradorMalo1)		
		var tiradorMalo2 = new Tirador(position = game.at(game.width()-3,7), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(tiradorMalo2)		
		var tiradorMalo3 = new Tirador(position = game.at(game.width()-4,9), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(tiradorMalo3)		
		var tiradorMalo4 = new Tirador(position = game.at(game.width()-4,7), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 27, nivelDefensa = 12)
		game.addVisual(tiradorMalo4)	
		
		jugador1.comprar(comandanteBueno)
		jugador1.comprar(soldadoBueno1)
		jugador1.comprar(soldadoBueno2)
		jugador1.comprar(soldadoBueno3)
		jugador1.comprar(soldadoBueno4)
		jugador2.comprar(comandanteMalo)
		jugador2.comprar(tiradorMalo1)
		jugador2.comprar(tiradorMalo2)
		jugador2.comprar(tiradorMalo3)
		jugador2.comprar(tiradorMalo4)
		
		comandanteBueno.cambiarSprite(iddle)
		game.addVisual(comandanteBueno.imagenVida())
		soldadoBueno1.cambiarSprite(iddle)
		game.addVisual(soldadoBueno1.imagenVida())
		soldadoBueno2.cambiarSprite(iddle)
		game.addVisual(soldadoBueno2.imagenVida())
		soldadoBueno3.cambiarSprite(iddle)
		game.addVisual(soldadoBueno3.imagenVida())
		soldadoBueno4.cambiarSprite(iddle)
		game.addVisual(soldadoBueno4.imagenVida())
		comandanteMalo.cambiarSprite(iddle)
		game.addVisual(comandanteMalo.imagenVida())
		tiradorMalo1.cambiarSprite(iddle)
		game.addVisual(tiradorMalo1.imagenVida())
		tiradorMalo2.cambiarSprite(iddle)
		game.addVisual(tiradorMalo2.imagenVida())
		tiradorMalo3.cambiarSprite(iddle)
		game.addVisual(tiradorMalo3.imagenVida())
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
	
	method iniciar() {
	
	}
	
	method setearCasillas() {

	}
	
	method siguiente() = nivel3
}

object nivel3 {
	
	method iniciar() {
		
	}
	
	method setearCasillas() {

	}
	
	method siguiente() = null
}
