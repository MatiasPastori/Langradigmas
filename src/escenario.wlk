import wollok.game.*
import teclado.*
import niveles.*
import casillas.*
import cursor.*

// imports de testing que probablemente sean borrados
import comandante.*
import tirador.*
import unidad.*
import jugadores.*

object escenario {
	const height = 17
	const width = 31
	var nivelActual = nivel1

	method configurar() {
		// CONFIGURACIÓN DEL JUEGO
		game.title("Langradigmas")
		game.height(height)
		game.width(width)
		
		teclado.setearTeclasMovimiento(cursor)
		teclado.setearTeclasAccion(cursor)
			
		// Start Pruebas
		map_manager.generar_casillas()
		map_manager.generar_bordes()
		
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
		unSoldadoBueno.cambiarSprite(iddle)
		otroSoldadoBueno.cambiarSprite(iddle)
		comandanteMalo.cambiarSprite(iddle)
		unTiradorMalo.cambiarSprite(iddle)
		otroTiradorMalo.cambiarSprite(iddle)
		// End Pruebas
		
		
		
		game.addVisual(cursor)
	}
	method actualizarNivel() {
		nivelActual = nivelActual.siguiente()
	}
	method twilightZone(character) {
		character.position(game.at(100,100))
		game.at(100, 100).clear()
	}
}


