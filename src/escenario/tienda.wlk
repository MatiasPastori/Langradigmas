import wollok.game.*
import utilidades.estadoTienda.*
import utilidades.visuals.*

object tienda {
	var property habilitada = true
	var property estado = jugador1Comprando
	var idUnidadCompra = 1
	var numJug = new Visual(position = game.at(27,10), image = "tienda_" + estado.idJugador() + ".png" )
	
	method getNumJug() = numJug
	method setIdUnidadCompra(num) {idUnidadCompra = num}
	
	method iniciar() {game.addVisual(numJug)}
	method comprar() {estado.comprar(idUnidadCompra)}
	method terminarCompra() = estado.terminarCompra()
}
