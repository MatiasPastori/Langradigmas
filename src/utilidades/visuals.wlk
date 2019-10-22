import wollok.game.*

class Visual {
	var property vidaObjeto = 10
	var property imagenVida = null
	const property nivelDefensa = 20
	const property buffDefensa = 0
	
	var property image
	var property position
	
	var property esAtacable = false	
	
	method esSeleccionable() = false
	
	method combatir(unidad) {} // para ser polimórfico con las unidades que usan combatir para romper el objeto de la casilla
	method recibirDanio(danio) {
		vidaObjeto -= danio
		self.imagenVida().image("vidaObj_" + vidaObjeto.toString() + ".png")
		self.chequearDestruccion()
	}
	method chequearDestruccion() {if(vidaObjeto < 1) self.destruir()}
	method destruir() = game.removeVisual(self)
}
