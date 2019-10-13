import wollok.game.*
import escenario.tienda.*
import escenario.niveles.*
import escenario.escenario.*
import unidades.guerrero.*
import unidades.caballeria.*
import unidades.tirador.*
import jugadores.*

object jugador1Comprando {
	// Lo dejo acá porque quizás las unidades tengan stats diferentes según el jugador
	method unidadComprada(idUnidad) {
		if (idUnidad == 1) 
			tienda.setUnidad(new Guerrero(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "guerrero", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)) 
		else if (idUnidad == 2) 
			tienda.setUnidad(new Tirador(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "tirador", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20))
		else 			
			tienda.setUnidad(new Caballeria(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "caballeria", comandante = jugador1.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20))
	}	
	method terminarCompra() {
		tienda.jugadorActual(jugador2)
		tienda.getNumJug().image("tienda_" + tienda.jugadorActual().getId() + ".png")
		tienda.getComandanteJug().image("comandante" + tienda.jugadorActual().getId() + "iddle1.png")
		tienda.getGuerreroJug().image("guerrero" + tienda.jugadorActual().getId() + "iddle1.png")
		tienda.getTiradorJug().image("tirador" + tienda.jugadorActual().getId() + "gris.png")
		tienda.getCaballeroJug().image("caballeria" + tienda.jugadorActual().getId() + "gris.png")
		tienda.estado(jugador2Comprando)
		tienda.setIdUnidadCompra(1)
	}	
}

object jugador2Comprando {
	method unidadComprada(idUnidad) {
		if (idUnidad == 1) 
			tienda.setUnidad(new Guerrero(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "guerrero", comandante = jugador2.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20)) 
		else if (idUnidad == 2) 
			tienda.setUnidad(new Tirador(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "tirador", comandante = jugador2.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20))
		else 			
			tienda.setUnidad(new Caballeria(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "caballeria", comandante = jugador2.getUnidades().head(), rangoDeAccion = 50, vida = 10, nivelAtaque = 24, nivelDefensa = 20))
	}
	method terminarCompra() {
		tienda.imagenesTienda().forEach{imagen => game.removeVisual(imagen)}
		escenario.nivelActual().iniciar()
		tienda.habilitada(false)
	}
}
