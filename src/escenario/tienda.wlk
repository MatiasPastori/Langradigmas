import wollok.game.*
import estados.estadoTienda.*
import utilidades.visuals.*
import utilidades.comentarios.*
import unidades.guerrero.*
import unidades.tirador.*
import unidades.caballeria.*
import jugadores.*

object tienda {
	var property habilitada = false
	var property estado = jugador1Comprando
	var property jugadorActual = jugador1
	
	const maxUnidadesPorJugador = 10
	var cantComprada = 0
	var property unidadReservada
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
	method getCantComprada() = cantComprada
	
	method iniciar() {
		self.restablecerTienda()
		self.agregarVisuales()
	}
	method restablecerTienda() {
		imagenesTienda.forEach{imagen => game.removeVisual(imagen)}
		imagenesTienda.clear()
		carritoDeCompras.clear()
		
		numJug = new Visual(position = game.at(27,10), image = "tienda_" + jugadorActual.getId() + ".png")
		cantDisp1erDigito = new Visual(position = game.at(7,13), image = "tienda_num1.png") 
		cantDisp2doDigito = new Visual(position = game.at(8,13), image = "tienda_num0.png") 
		contadorGuerrerosComprados = new Visual(position = game.at(10,10), image = "tienda_num0.png") 
		contadorTiradoresComprados = new Visual(position = game.at(10,8), image = "tienda_num0.png") 
		contadorCaballeriaComprada = new Visual(position = game.at(10,6), image = "tienda_num0.png") 
	 	comandanteJugImg = new Visual(position = game.at(25,13), image = "comandante" + jugadorActual.getId() + "iddle1.png")
		guerreroJugImg = new Visual(position = game.at(5,10), image = "transparente.png")
		tiradorJugImg = new Visual(position = game.at(5,8), image = "transparente.png")
		caballeroJugImg = new Visual(position = game.at(5,6), image = "transparente.png")	
		
		self.reservar(guerrero)
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
		carritoDeCompras.add(unidadReservada.tomarUna())
		cantComprada++
		self.actualizarContadoresPorUnidad()
		self.actualizarContadorDisponibles()
	} 	
	method reservar(tipo) {tipo.reservarUnidad()}
	
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
		
	// Contadores
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

	// Errores
	method verificarCantidadUnidadesCompradas() {
		if (cantComprada == maxUnidadesPorJugador) 
			self.error(error.msgCarritoLleno(maxUnidadesPorJugador))
	}
	method verificarQueHayaUnidadSeleccionada() {
		if (unidadReservada == null) 
			self.error(error.msgSeleccionarDespuesComprar()) 
	}
	method verificarQueHayaUnidadesCompradas() {
		if (cantComprada == 0)
			self.error(error.msgCarritoVacio())
	}
}

object guerrero {
	method reservarUnidad() {
		tienda.getGuerreroJug().image("guerrero"+ tienda.jugadorActual().getId() + "iddle1.png")
		tienda.getTiradorJug().image("tirador"+ tienda.jugadorActual().getId() + "gris.png")
		tienda.getCaballeroJug().image("caballeria" + tienda.jugadorActual().getId() + "gris.png")
		tienda.unidadReservada(self)
	}
	method tomarUna() = new Guerrero(position = game.at(1,1), image = "transparente.png", jugadorDuenio = tienda.jugadorActual(), tipo = "guerrero", comandante = tienda.jugadorActual().getUnidades().head(), rangoDeAccion = 3, rangoEspecial = 1,nivelAtaque = 24, nivelDefensa = 20)
}
object tirador {
	method reservarUnidad() {
		tienda.getGuerreroJug().image("guerrero"+ tienda.jugadorActual().getId() + "gris.png")
		tienda.getTiradorJug().image("tirador"+ tienda.jugadorActual().getId() + "iddle1.png")
		tienda.getCaballeroJug().image("caballeria" + tienda.jugadorActual().getId() + "gris.png")	
		tienda.unidadReservada(self)
	}
	method tomarUna() = new Tirador(position = game.at(2,2), image = "transparente.png", jugadorDuenio = tienda.jugadorActual(), tipo = "tirador", comandante = tienda.jugadorActual().getUnidades().head(), rangoDeAccion = 4, rangoEspecial = 2,nivelAtaque = 24, nivelDefensa = 20)
}
object caballeria {
	method reservarUnidad() {
		tienda.getGuerreroJug().image("guerrero"+ tienda.jugadorActual().getId() + "gris.png")
		tienda.getTiradorJug().image("tirador"+ tienda.jugadorActual().getId() + "gris.png")
		tienda.getCaballeroJug().image("caballeria" + tienda.jugadorActual().getId() + "iddle1.png")	
		tienda.unidadReservada(self)
	}
	method tomarUna() = new Caballeria(position = game.at(3,3), image = "transparente.png", jugadorDuenio = tienda.jugadorActual(), tipo = "caballeria", comandante = tienda.jugadorActual().getUnidades().head(), rangoDeAccion = 5, rangoEspecial = 1,nivelAtaque = 24, nivelDefensa = 20) 
}
