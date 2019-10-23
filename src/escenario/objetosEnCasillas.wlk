import wollok.game.*

class ObjetoCasilla {
	var property vidaObjeto = 10
	var property imagenVida = null
	const property nivelDefensa = 20
	var property tipo
	
	var property position
	method image() = tipo.image()
	
	method buffAtaqueQueOtorga() = tipo.buffAtaque()
	method buffDefensaQueOtorga() = tipo.buffDefensa()
	
	method esSeleccionable() = false
	method esCasillaFija() = false
	method esObjetoGrande() = tipo.esObjetoGrande()
	method esAtacable() = tipo.esAtacable() // Para futura implementación
	
	// Se piensa implementar un sistema de ataque a los objetos de casillas para obtener bonificaciones
	// Parte de esta lógica posiblemente pase a los objetos de abajo dependiendo del tipo
	method combatir(unidad) {}
	method recibirDanio(danio) {
		vidaObjeto -= danio
		self.imagenVida().image("vidaObj_" + vidaObjeto.toString() + ".png")
		self.chequearDestruccion()
	}
	method chequearDestruccion() {if(vidaObjeto < 1) self.destruir()}
	method destruir() = game.removeVisual(self)	
}

object torre {
	method image() = "casillaTorre.png"
	method esAtacable() = false
	method esObjetoGrande() = true
	method buffAtaque() = 0
	method buffDefensa() = 0
}

object murallaVertical {
	method image() = "casillaMurallaVer.png"
	method esAtacable() = false	
	method esObjetoGrande() = true
	method buffAtaque() = 0
	method buffDefensa() = 0
}

object murallaHorizontal {
	method image() = "casillaMurallaHor.png"
	method esAtacable() = false	
	method esObjetoGrande() = true
	method buffAtaque() = 0
	method buffDefensa() = 0
}