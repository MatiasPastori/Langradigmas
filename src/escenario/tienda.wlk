import wollok.game.*
import estados.estadoTienda.*
import utilidades.visuals.*
import utilidades.comentarios.*
import utilidades.creadorDeUnidades.*
import unidades.guerrero.*
import unidades.tirador.*
import unidades.caballeria.*
import jugadores.*

/*
	Compra de unidades por jugador.
	@habilitada: indica si la tienda está abierta o no para comprar unidades
	@estado: ir a /estados/estadoTienda
	@jugadorActual: jugador comprando en la tienda
	@maxUnidadesPorJugador: cantidad máxima que un jugador puede comprar por nivel
	@cantComprada: cantidad de unidades que el jugador lleva comprada
	@idUnicoUnidad: se usa para setear animaciones (ver /utilidades/acciones). Comienza en 3 ya que el comandante del J1 es 1 y el del J2 es 2
	@tipoUnidadReservada: ver /utilidades/creadorDeUnidades
	@carritoDeCompras: unidades que el jugadorActual quiere comprar
	@imagenesTienda: lista de imagenes que se muestran en la tienda. Les da un feedback al jugador de qué está comprando, unidades compradas, etc
	@numJug: visual de número del jugador (1 J1, 2 J2)
	@cantDisp1erDigito: visual de la cantidad disponible a comprar (1er dígito)
	@cantDisp2doDigito: visual de la cantidad disponible a comprar (2do dígito)
	@contadorGuerrerosComprados: visual que indica la cantidad de guerreros comprados por el jugadorActual
	@contadorTiradoresComprados: visual que indica la cantidad de tiradores comprados por el jugadorActual
	@contadorCaballeriaComprada: visual que indica la cantidad de caballeros comprados por el jugadorActual
	@imagenComandanteDelJugador: visual del comandante del jugadorActual
	@imagenGuerreroAVender: visual de un guerrero del jugadorActual
	@imagenTiradorAVender: visual de un tirador del jugadorActual
	@imagenCaballeroAVender: visual de un caballero del jugadorActual
	
*/

object tienda {
	var property habilitada = false
	var property estado = jugador1Comprando
	var property jugadorActual = jugador1
	
	const maxUnidadesPorJugador = 10
	var cantComprada = 0
	var property idUnicoUnidad = 3
	var property tipoUnidadReservada
	const property carritoDeCompras = []
	
	const property imagenesTienda = []
	var numJug
	var cantDisp1erDigito
	var cantDisp2doDigito
	var contadorGuerrerosComprados
	var contadorTiradoresComprados
	var contadorCaballeriaComprada
	var imagenComandanteDelJugador
	var imagenGuerreroAVender
	var imagenTiradorAVender
	var imagenCaballeroAVender
	
	method getNumJug() = numJug
	method getcantDisp1erDigito() = cantDisp1erDigito
	method getcantDisp2doDigito() = cantDisp2doDigito
	method getcantcompradosUnidadGuerrero() = contadorGuerrerosComprados
	method getcantcompradosUnidadTirador() = contadorTiradoresComprados
	method getcantcompradosUnidadCaballeria() = contadorCaballeriaComprada
	method getComandanteJug() = imagenComandanteDelJugador
	method getGuerreroJug() = imagenGuerreroAVender
	method getTiradorJug() = imagenTiradorAVender
	method getCaballeroJug() = imagenCaballeroAVender
	method getCantComprada() = cantComprada
	
	method iniciar() {
		self.restablecerTienda()
		self.agregarVisuales()
	}
	
	// Pone a la tienda en un estado inicial reseteando las imágenes visuales
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
	 	imagenComandanteDelJugador = new Visual(position = game.at(25,13), image = "comandante" + jugadorActual.getId() + "iddle1.png")
		imagenGuerreroAVender = new Visual(position = game.at(5,10), image = "transparente.png")
		imagenTiradorAVender = new Visual(position = game.at(5,8), image = "transparente.png")
		imagenCaballeroAVender = new Visual(position = game.at(5,6), image = "transparente.png")	
		
		self.reservar(unGuerrero)
	}
	method agregarVisuales() {
		imagenesTienda.add(numJug)
		imagenesTienda.add(cantDisp1erDigito)
		imagenesTienda.add(cantDisp2doDigito)
		imagenesTienda.add(contadorGuerrerosComprados)
		imagenesTienda.add(contadorTiradoresComprados)
		imagenesTienda.add(contadorCaballeriaComprada)
		imagenesTienda.add(imagenComandanteDelJugador)
		imagenesTienda.add(imagenGuerreroAVender)
		imagenesTienda.add(imagenTiradorAVender)
		imagenesTienda.add(imagenCaballeroAVender)
		imagenesTienda.forEach{imagen => game.addVisual(imagen)}
	}
	
	method comprar() {
		var unidadAComprar
		self.verificarCantidadUnidadesCompradas()
		self.verificarQueHayaUnidadSeleccionada()
		unidadAComprar = creadorDeUnidades.crearSubordinado(jugadorActual, tipoUnidadReservada, idUnicoUnidad)
		carritoDeCompras.add(unidadAComprar)
		cantComprada++
		idUnicoUnidad++
		self.actualizarContadoresPorUnidad()
		self.actualizarContadorDisponibles()
	} 	
	
	// Este método se invoca cuando el jugador selecciona un tipo de unidad que luego va a comprar y le da un feedback visual de cuál seleccionó
	method reservar(tipoDeLaUnidad) {
		self.colorearAlSeleccionado(tipoDeLaUnidad)
		tipoUnidadReservada = tipoDeLaUnidad
	}
	method colorearAlSeleccionado(tipo) {
		var coloresPorUnidad = [] 
		// Esta lista tendrá siempre 3 strings. Dos "gris" y un "iddle1". (iddle1 representa la unidad a color, la seleccionada)
		// Las posiciones de la lista corresponden 0->guerrero 1->tirador 2->caballero
		// Se asigna el contenido de la pos de la lista a la unidad correspondiente y así se marca el seleccionado en color y los otros en gris
		coloresPorUnidad = tipo.coloresPorSeleccionado()
		imagenGuerreroAVender.image("guerrero"+ jugadorActual.getId() + coloresPorUnidad.get(0) +".png")
		imagenTiradorAVender.image("tirador"+ jugadorActual.getId() + coloresPorUnidad.get(1) + ".png")
		imagenCaballeroAVender.image("caballeria" + jugadorActual.getId() + coloresPorUnidad.get(2) + ".png")		
	}
	
	method vender() { 
		self.verificarQueHayaUnidadesCompradas()
		carritoDeCompras.remove(carritoDeCompras.last())
		cantComprada--
		idUnicoUnidad--
		self.actualizarContadoresPorUnidad()
		self.actualizarContadorDisponibles()
	}
	
	method terminarCompra() { 
		cantComprada = 0
		carritoDeCompras.forEach{unidad => 
			jugadorActual.comprar(unidad)
			jugadorActual.getUnidades().head().reclutar(unidad)
		}
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
		if (tipoUnidadReservada == null) 
			self.error(error.msgSeleccionarDespuesComprar()) 
	}
	method verificarQueHayaUnidadesCompradas() {
		if (cantComprada == 0)
			self.error(error.msgCarritoVacio())
	}
}
