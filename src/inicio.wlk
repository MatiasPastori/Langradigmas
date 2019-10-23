import wollok.game.*
import utilidades.visuals.*
import utilidades.teclado.*
import cursor.*

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
		
		keyboard.num(9).onPressDo { game.say(cursor,cursor.casillaEn(cursor.position()).position().toString()) }
		
		teclado.setearTeclaInicio()
	}
	method mostrarInicio() = game.addVisual(inicio)
	method getInicioVisual() = inicio
}
