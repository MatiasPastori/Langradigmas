import wollok.game.*
import utilidades.estadoTienda.*
import utilidades.visuals.*
import jugadores.*

object tienda {
	var unidadAComprar
	var idUnidadCompra = 1
	var cantComprada = 0
	const maxUnidadesPorJugador = 10
	var property estado = jugador1Comprando
	var property jugadorActual = jugador1
	var property habilitada = true
	var numJug = new Visual(position = game.at(27,10), image = "tienda_" + jugadorActual.getId() + ".png")
	var comandanteJug = new Visual(position = game.at(25,13), image = "comandante" + jugadorActual.getId() + "iddle1.png")
	var guerreroJug = new Visual(position = game.at(5,10), image = "guerrero" + jugadorActual.getId() + "iddle1.png")
	var tiradorJug = new Visual(position = game.at(5,8), image = "tirador" + jugadorActual.getId() + "gris.png")
	var caballeroJug = new Visual(position = game.at(5,6), image = "caballeria" + jugadorActual.getId() + "gris.png")
	
	method getNumJug() = numJug
	method getComandanteJug() = comandanteJug
	method getGuerreroJug() = guerreroJug
	method getTiradorJug() = tiradorJug
	method getCaballeroJug() = caballeroJug
	method setIdUnidadCompra(num) {idUnidadCompra = num}
	method setUnidad(unidad) {unidadAComprar = unidad}
	
	method iniciar() {
		game.addVisual(numJug)
		game.addVisual(comandanteJug)
		game.addVisual(guerreroJug)
		game.addVisual(tiradorJug)
		game.addVisual(caballeroJug)
	}
	method comprar() {
		self.verificarCantidadUnidadesCompradas()
		estado.unidadComprada(idUnidadCompra)
		jugadorActual.comprar(unidadAComprar)
		cantComprada++
	} 	
	method vender() { 
		jugadorActual.vender()
		cantComprada--
	}
	method terminarCompra() { 
		cantComprada = 0
		estado.terminarCompra()
	}
	method verificarCantidadUnidadesCompradas() {
		if (cantComprada == maxUnidadesPorJugador)
			self.error("No puedes comprar mas de " + maxUnidadesPorJugador.toString() + " unidades")
	} 
}
