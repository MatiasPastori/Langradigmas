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
		tienda.carritoDeCompras().forEach{unidad => 
			jugador1.comprar(unidad)
			jugador1.getUnidades().head().reclutar(unidad)
		}
	
		tienda.jugadorActual(jugador2)
		tienda.estado(jugador2Comprando)
		tienda.iniciar()
	}	
}

object jugador2Comprando {
	method terminarCompra() {
		tienda.carritoDeCompras().forEach{unidad => 
			jugador2.comprar(unidad)
			jugador2.getUnidades().head().reclutar(unidad)
		}
		
		tienda.imagenesTienda().forEach{imagen => game.removeVisual(imagen)}
		tienda.imagenesTienda().clear()
		tienda.jugadorActual(jugador1)
		tienda.idUnicoUnidad(3)
		tienda.estado(jugador1Comprando)
		tienda.habilitada(false)
		escenario.nivelActual().iniciar()
	}
}
