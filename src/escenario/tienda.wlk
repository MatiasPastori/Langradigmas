import wollok.game.*
import utilidades.estadoTienda.*
import utilidades.visuals.*

object tienda {
	var property habilitada = true
	const maxUnidadesPorJugador = 10
	var property estado = jugador1Comprando
	var idUnidadCompra = 1
	var numJug = new Visual(position = game.at(27,10), image = "tienda_" + estado.idJugador() + ".png" )
	var comandanteJug = new Visual(position = game.at(25,13), image = "comandante" + estado.idJugador() + "iddle1.png" )
	
	method getNumJug() = numJug
	method getComandanteJug() = comandanteJug
	method setIdUnidadCompra(num) {idUnidadCompra = num}
	
	method iniciar() {
		game.addVisual(numJug)
		game.addVisual(comandanteJug)
	}
	method comprar() {estado.comprar(idUnidadCompra)}
	method vender() = estado.vender()
	method terminarCompra() = estado.terminarCompra()
	
	method verificarCantidadUnidadesCompradas(cantComprada) {
		if (cantComprada == maxUnidadesPorJugador)
			self.error("No puedes comprar mas de " + maxUnidadesPorJugador.toString() + " unidades")
	} 
}
