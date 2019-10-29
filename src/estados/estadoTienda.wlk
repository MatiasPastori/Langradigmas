import wollok.game.*
import escenario.tienda.*
import escenario.niveles.*
import escenario.escenario.*
import unidades.guerrero.*
import unidades.caballeria.*
import unidades.tirador.*
import jugadores.*

/*
 	Maneja la lógica de la tienda cuando un jugador termina su compra dependiendo de quien es.
 	Para ver su uso ir a /escenario/tienda 
*/

object jugador1Comprando {
	method terminarCompra() {
		tienda.jugadorActual(jugador2)
		tienda.estado(jugador2Comprando)
		tienda.iniciar()
	}	
}

object jugador2Comprando {
	method terminarCompra() {
		tienda.imagenesTienda().forEach{imagen => game.removeVisual(imagen)}
		tienda.imagenesTienda().clear()
		tienda.jugadorActual(jugador1)
		tienda.idUnicoUnidad(3)
		tienda.estado(jugador1Comprando)
		tienda.habilitada(false)
		escenario.nivelActual().iniciar()
	}
}
