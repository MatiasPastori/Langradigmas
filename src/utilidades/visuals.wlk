import wollok.game.*

class Visual {
	var property vidaObjeto = 0
	
	var property image
	var property position
	
	var property esAtacable = false	
	
	method esSeleccionable() = false

	method combatir() {} // para ser polimórfico con las unidades que usan combatir para romper el objeto de la casilla
	method recibirDanio(danio) {
		vidaObjeto -= danio
		self.chequearDestruccion()
	}
	method chequearDestruccion() {if(vidaObjeto < 1) self.destruir()}
	method destruir() = game.removeVisual(self)
}
