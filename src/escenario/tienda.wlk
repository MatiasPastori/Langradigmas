import wollok.game.*
import utilidades.estadoTienda.*
import utilidades.visuals.*
import unidades.guerrero.*
import jugadores.*

object tienda {
	var property habilitada = false
	var property estado = jugador1Comprando
	var property jugadorActual = jugador1
	
	const maxUnidadesPorJugador = 10
	var cantComprada = 0
	var property unidadAComprar
	const property carritoDeCompras = []
	
	const property imagenesTienda = []
	var numJug
	var cantDisp1erDigito
	var cantDisp2doDigito
	var contadorGuerrerosComprados
	var contadorTiradoresComprados
	var contadorCaballeriaComprada
	var comandanteJugImg
	var guerreroJugImg
	var tiradorJugImg
	var caballeroJugImg
	
	method getNumJug() = numJug
	method getcantDisp1erDigito() = cantDisp1erDigito
	method getcantDisp2doDigito() = cantDisp2doDigito
	method getcantcompradosUnidadGuerrero() = contadorGuerrerosComprados
	method getcantcompradosUnidadTirador() = contadorTiradoresComprados
	method getcantcompradosUnidadCaballeria() = contadorCaballeriaComprada
	method getComandanteJug() = comandanteJugImg
	method getGuerreroJug() = guerreroJugImg
	method getTiradorJug() = tiradorJugImg
	method getCaballeroJug() = caballeroJugImg
	
	method iniciar() {
		self.restablecerTienda()
		self.agregarVisuales()
	}
	method restablecerTienda() {
		imagenesTienda.forEach{imagen => game.removeVisual(imagen)}
		imagenesTienda.clear()
		carritoDeCompras.clear()
		
		unidadAComprar = new Guerrero(position = game.at(1,1), image = "transparente.png", jugadorDuenio = jugadorActual, tipo = "guerrero", comandante = jugadorActual.getUnidades().head(), rangoDeAccion = 50, nivelAtaque = 24, nivelDefensa = 20)
		numJug = new Visual(position = game.at(27,10), image = "tienda_" + jugadorActual.getId() + ".png")
		cantDisp1erDigito = new Visual(position = game.at(7,13), image = "tienda_num1.png") 
		cantDisp2doDigito = new Visual(position = game.at(8,13), image = "tienda_num0.png") 
		contadorGuerrerosComprados = new Visual(position = game.at(10,10), image = "tienda_num0.png") 
		contadorTiradoresComprados = new Visual(position = game.at(10,8), image = "tienda_num0.png") 
		contadorCaballeriaComprada = new Visual(position = game.at(10,6), image = "tienda_num0.png") 
	 	comandanteJugImg = new Visual(position = game.at(25,13), image = "comandante" + jugadorActual.getId() + "iddle1.png")
	 	guerreroJugImg = new Visual(position = game.at(5,10), image = "guerrero" + jugadorActual.getId() + "iddle1.png")
	 	tiradorJugImg = new Visual(position = game.at(5,8), image = "tirador" + jugadorActual.getId() + "gris.png")
		caballeroJugImg = new Visual(position = game.at(5,6), image = "caballeria" + jugadorActual.getId() + "gris.png")	
	}
	method agregarVisuales() {
		imagenesTienda.add(numJug)
		imagenesTienda.add(cantDisp1erDigito)
		imagenesTienda.add(cantDisp2doDigito)
		imagenesTienda.add(contadorGuerrerosComprados)
		imagenesTienda.add(contadorTiradoresComprados)
		imagenesTienda.add(contadorCaballeriaComprada)
		imagenesTienda.add(comandanteJugImg)
		imagenesTienda.add(guerreroJugImg)
		imagenesTienda.add(tiradorJugImg)
		imagenesTienda.add(caballeroJugImg)
		imagenesTienda.forEach{imagen => game.addVisual(imagen)}
	}
	
	method comprar() {
		self.verificarCantidadUnidadesCompradas()
		self.verificarQueHayaUnidadSeleccionada()
		carritoDeCompras.add(unidadAComprar)
		cantComprada++
		self.actualizarContadoresPorUnidad()
		self.actualizarContadorDisponibles()
		self.todosAGris()
		unidadAComprar = null
	} 	
	method vender() { 
		self.verificarQueHayaUnidadesCompradas()
		carritoDeCompras.remove(carritoDeCompras.last())
		cantComprada--
		self.actualizarContadoresPorUnidad()
		self.actualizarContadorDisponibles()
	}
	
	method terminarCompra() { 
		cantComprada = 0
		estado.terminarCompra()
	}
		
	method actualizarContadorDisponibles() {
		if(cantComprada == 0) {
			cantDisp1erDigito.image("tienda_num1.png")
			cantDisp2doDigito.image("tienda_num0.png")
		} else {
			cantDisp1erDigito.image("tienda_num0.png")
			cantDisp2doDigito.image("tienda_num" + (10-cantComprada).toString() + ".png")		
		}
	}
	method actualizarContadoresPorUnidad() {
		var guerrerosComprados = carritoDeCompras.count{unidad => unidad.getTipo() == "guerrero"}
		var tiradoresComprados = carritoDeCompras.count{unidad => unidad.getTipo() == "tirador"}
		var caballeriaComprados = carritoDeCompras.count{unidad => unidad.getTipo() == "caballeria"}
		
		contadorGuerrerosComprados.image("tienda_num" + guerrerosComprados.toString() + ".png")
		contadorTiradoresComprados.image("tienda_num" + tiradoresComprados.toString() + ".png")
		contadorCaballeriaComprada.image("tienda_num" + caballeriaComprados.toString() + ".png")
	} 
	
	method todosAGris() {
		guerreroJugImg.image("guerrero" + jugadorActual.getId() + "gris.png")
		tiradorJugImg.image("tirador" + jugadorActual.getId() + "gris.png")
		caballeroJugImg.image("caballeria" + jugadorActual.getId() + "gris.png")
	}
	
	method verificarCantidadUnidadesCompradas() {
		if (cantComprada == maxUnidadesPorJugador)
			self.error("No puedes comprar mas de " + maxUnidadesPorJugador.toString() + " unidades")
	}
	method verificarQueHayaUnidadSeleccionada() {
		if (unidadAComprar == null) 
			self.error("Debes seleccionar una unidad para comprar!") 
	}
	method verificarQueHayaUnidadesCompradas() {
		if (cantComprada == 0)
			self.error("No puedes vender unidades que todavía no compraste")
	}
}
