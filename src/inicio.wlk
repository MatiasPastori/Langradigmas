import wollok.game.*
import utilidades.visuals.*
import utilidades.teclado.*

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
	}
	method mostrarInicio() {
		game.addVisual(inicio)
		keyboard.enter().onPressDo{	game.sound("mainMenu.mp3")}
	}
	method getInicioVisual() = inicio
}
