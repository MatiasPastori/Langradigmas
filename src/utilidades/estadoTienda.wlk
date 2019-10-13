import wollok.game.*
import escenario.tienda.*
import escenario.niveles.*
import escenario.escenario.*
import unidades.guerrero.*
import unidades.caballeria.*
import unidades.tirador.*
import jugadores.*

object jugador1Comprando {
	method terminarCompra() {
		tienda.carritoDeCompras().forEach{unidad => jugador1.comprar(unidad)}
		
		tienda.jugadorActual(jugador2)
		tienda.imagenesTienda().forEach{imagen => game.removeVisual(imagen)}
		tienda.iniciar()
		tienda.estado(jugador2Comprando)
	}	
}

object jugador2Comprando {
	method terminarCompra() {
		tienda.carritoDeCompras().forEach{unidad => jugador2.comprar(unidad)}
		
		tienda.imagenesTienda().forEach{imagen => game.removeVisual(imagen)}
		escenario.nivelActual().iniciar()
		tienda.habilitada(false)
	}
}
