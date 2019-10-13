import wollok.game.*
import utilidades.estadoTienda.*
import utilidades.visuals.*
import jugadores.*

object tienda {
	var unidadAComprar
	var idUnidadCompra = 1
	var cantComprada = 0
	const maxUnidadesPorJugador = 10
	const property imagenesTienda = []
	var property estado = jugador1Comprando
	var property jugadorActual = jugador1
	var property habilitada = true
	var numJug = new Visual(position = game.at(27,10), image = "tienda_" + jugadorActual.getId() + ".png")
	var cantDisp1erDigito = new Visual(position = game.at(7,13), image = "tienda_" + "num1.png") 
	var cantDisp2doDigito = new Visual(position = game.at(8,13), image = "tienda_" + "num0.png") 
	var compradosUnidad1 = new Visual(position = game.at(10,10), image = "tienda_" + "num0.png") 
	var compradosUnidad2 = new Visual(position = game.at(10,8), image = "tienda_" + "num0.png") 
	var compradosUnidad3 = new Visual(position = game.at(10,6), image = "tienda_" + "num0.png") 
	var comandanteJug = new Visual(position = game.at(25,13), image = "comandante" + jugadorActual.getId() + "iddle1.png")
	var guerreroJug = new Visual(position = game.at(5,10), image = "guerrero" + jugadorActual.getId() + "iddle1.png")
	var tiradorJug = new Visual(position = game.at(5,8), image = "tirador" + jugadorActual.getId() + "gris.png")
	var caballeroJug = new Visual(position = game.at(5,6), image = "caballeria" + jugadorActual.getId() + "gris.png")
	
	method getNumJug() = numJug
	method getcantDisp1erDigito() = cantDisp1erDigito
	method getcantDisp2doDigito() = cantDisp2doDigito
	method getcantcompradosUnidad1() = compradosUnidad1
	method getcantcompradosUnidad2() = compradosUnidad2
	method getcantcompradosUnidad3() = compradosUnidad3
	method getComandanteJug() = comandanteJug
	method getGuerreroJug() = guerreroJug
	method getTiradorJug() = tiradorJug
	method getCaballeroJug() = caballeroJug
	method setIdUnidadCompra(num) {idUnidadCompra = num}
	method setUnidad(unidad) {unidadAComprar = unidad}
	
	method iniciar() {
		self.agregarVisuales()
	}
	method agregarVisuales() {
		imagenesTienda.add(cantDisp1erDigito)
		imagenesTienda.add(cantDisp2doDigito)
		imagenesTienda.add(compradosUnidad1)
		imagenesTienda.add(compradosUnidad2)
		imagenesTienda.add(compradosUnidad3)
		imagenesTienda.add(comandanteJug)
		imagenesTienda.add(guerreroJug)
		imagenesTienda.add(tiradorJug)
		imagenesTienda.add(caballeroJug)
		imagenesTienda.forEach{imagen => game.addVisual(imagen)}
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
