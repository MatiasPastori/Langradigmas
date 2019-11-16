import wollok.game.*
import utilidades.visuals.*

object pantallaCarga {
	const background = new Visual(image="pantallaCarga.png", position=game.at(0,0))
	
	method iniciarPantallaCarga() {
		game.addVisual(background)
	}
	method desactivarPantallaCarga() {	
		game.removeVisual(background)
	}
}
