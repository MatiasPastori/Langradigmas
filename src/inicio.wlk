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
		game.boardGround("tienda.png")
		
		teclado.setearTeclaInicio()
	}
	method mostrarInicio() {game.addVisual(inicio)}
	method getInicioVisual() = inicio
}