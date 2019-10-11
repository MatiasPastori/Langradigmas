import wollok.game.*
import escenario.tienda.*
import escenario.niveles.*
import escenario.escenario.*
import unidades.guerrero.*
import unidades.caballeria.*
import unidades.tirador.*
import jugadores.*

object jugador1Comprando {
	
	method idJugador() = jugador1.getId()
	
	method unidadComprada(idUnidad) {
		if (idUnidad == 1)
			return new Guerrero()
		if (idUnidad == 2)
			return new Tirador()
		return new Caballeria()
	}
	
	method terminarCompra() {
		tienda.getNumJug().image("tienda_" + jugador2Comprando.idJugador() + ".png")
		tienda.estado(jugador2Comprando)
	}	
}

object jugador2Comprando {
	
	method idJugador() = jugador2.getId()
	
	method unidadComprada(idUnidad) {
		if (idUnidad == 1)
			return new Guerrero()
		if (idUnidad == 2)
			return new Tirador()
		return new Caballeria()
	}
	
	method terminarCompra() {
		game.removeVisual(tienda.getNumJug())
		escenario.nivelActual().iniciar()
		tienda.habilitada(false)
	}
}
