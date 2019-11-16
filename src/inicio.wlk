import wollok.game.*
import utilidades.visuals.*
import utilidades.teclado.*
import cursor.*

import jugadores.* // import just for testing

/*
	Setea la configuración inicial. 
	@inicioHabilitado: true cuando comienza el juego, false al pasar la primer pantalla.
	@inicio: objeto de la clase Visual (ver utilidades/visuals.wlk) que contiene la imagen de inicio.
*/

object inicio {
	const height = 17
	const width = 31
	var property inicioHabilitado = true
	var inicio = new Visual(position = game.at(0,0), image = "inicio.png")
	
	method configurar() {
		// CONFIGURACIÓN DEL JUEGO	
		game.title("Langradigmas")
		game.height(height)
		game.width(width)
		
		teclado.setearTeclaInicio()
		
		keyboard.num(9).onPressDo { jugador1.getUnidades().head().recibirDanio(10) }
	}
	method mostrarInicio() = game.addVisual(inicio)
	method getInicioVisual() = inicio
}
