import wollok.game.*
import escenario.tienda.*
import escenario.niveles.*
import escenario.escenario.*
import unidades.guerrero.*
import unidades.caballeria.*
import unidades.tirador.*
import jugadores.*

object jugador1Comprando {
	var unidad
	
	method idJugador() = jugador1.getId()
	
	method comprar(idUnidad) {
		self.unidadComprada(idUnidad)
		return jugador1.comprar(unidad)
	} 
	
	method unidadComprada(idUnidad) {
		if (idUnidad == 1) 
			unidad = new Guerrero(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		else if (idUnidad == 2) 
			unidad = new Tirador(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "tirador", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		else 			
			unidad = new Caballeria(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "caballeria", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
	}
	
	method terminarCompra() {
		tienda.getNumJug().image("tienda_" + jugador2Comprando.idJugador() + ".png")
		tienda.estado(jugador2Comprando)
	}	
}

object jugador2Comprando {
	var unidad
	
	method idJugador() = jugador2.getId()
	
	method comprar(idUnidad) {
		self.unidadComprada(idUnidad)
		return jugador2.comprar(unidad)
	} 
	
	method unidadComprada(idUnidad) {
		if (idUnidad == 1) 
			unidad = new Guerrero(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "guerrero", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		else if (idUnidad == 2) 
			unidad = new Tirador(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
		else 			
			unidad = new Caballeria(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "caballeria", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)
	}
	
	method terminarCompra() {
		game.removeVisual(tienda.getNumJug())
		escenario.nivelActual().iniciar()
		tienda.habilitada(false)
	}
}
