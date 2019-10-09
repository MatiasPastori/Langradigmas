import wollok.game.*
import escenario.casillas.*
import escenario.tienda.*
import unidades.comandante.*
import unidades.tirador.*
import unidades.unidad.*
import jugadores.*

object nivel1 {
	
	method iniciar() {
		self.setearCasillas()
		
		// Start Pruebas
		
		var comandanteBueno = new Comandante(position = game.at(1,8), image = "transparente.png", tipo = "comandante", rangoDeAccion = 2, vida = 10, nivelAtaque = 20, nivelDefensa = 20)
		game.addVisual(comandanteBueno)	
		var unSoldadoBueno = new Tirador(position = game.at(2,9), image = "transparente.png", tipo = "soldado", comandante = comandanteBueno, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(unSoldadoBueno)
		var otroSoldadoBueno = new Tirador(position = game.at(2,7), image = "transparente.png", tipo = "soldado", comandante = comandanteBueno, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(otroSoldadoBueno)
		var comandanteMalo = new Comandante(position = game.at(game.width()-2,8), image = "transparente.png", tipo = "comandante", rangoDeAccion = 2, vida = 10, nivelAtaque = 20, nivelDefensa = 20)
		game.addVisual(comandanteMalo)	
		var unTiradorMalo = new Tirador(position = game.at(game.width()-3,9), image = "transparente.png", tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(unTiradorMalo)		
		var otroTiradorMalo = new Tirador(position = game.at(game.width()-3,7), image = "transparente.png", tipo = "tirador", comandante = comandanteMalo, rangoDeAccion = 4, vida = 10, nivelAtaque = 10, nivelDefensa = 10)
		game.addVisual(otroTiradorMalo)		
		
		jugador1.comprar(comandanteBueno)
		jugador1.comprar(unSoldadoBueno)
		jugador1.comprar(otroSoldadoBueno)
		jugador2.comprar(comandanteMalo)
		jugador2.comprar(unTiradorMalo)
		jugador2.comprar(otroTiradorMalo)
		
		comandanteBueno.cambiarSprite(iddle)
		game.addVisual(comandanteBueno.imagenVida())
		unSoldadoBueno.cambiarSprite(iddle)
		game.addVisual(unSoldadoBueno.imagenVida())
		otroSoldadoBueno.cambiarSprite(iddle)
		game.addVisual(otroSoldadoBueno.imagenVida())
		comandanteMalo.cambiarSprite(iddle)
		game.addVisual(comandanteMalo.imagenVida())
		unTiradorMalo.cambiarSprite(iddle)
		game.addVisual(unTiradorMalo.imagenVida())
		otroTiradorMalo.cambiarSprite(iddle)
		game.addVisual(otroTiradorMalo.imagenVida())
		// End Pruebas
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
