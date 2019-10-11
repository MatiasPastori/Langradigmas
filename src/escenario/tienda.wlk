import wollok.game.*
import utilidades.estadoTienda.*
import utilidades.visuals.*

object tienda {
	var property habilitada = true
	var property estado = jugador1Comprando
	var idUnidadCompra = 1
	var numJug = new Visual(position = game.at(27,10), image = "tienda_" + estado.idJugador() + ".png" )
	
	method getNumJug() = numJug
	
	method iniciar() {
		game.addVisual(numJug)
	}
	method terminarCompra() = estado.terminarCompra()
}
