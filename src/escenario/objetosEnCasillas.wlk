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
	method combatir(unidad,cursor) {}
	method recibirDanio(danio) {
		vidaObjeto -= danio
		self.imagenVida().image("vidaObj_" + vidaObjeto.toString() + ".png")
		self.chequearDestruccion()
	}
	method chequearDestruccion() {if(vidaObjeto < 1) self.destruir()}
	method destruir() = game.removeVisual(self)	
}

class Muralla {
	method esAtacable() = false
	method esObjetoGrande() = true
	method buffAtaque() = 0
	method buffDefensa() = 0
}
class Rio {
	method esAtacable() = false	
	method esObjetoGrande() = false
	method buffAtaque() = -3
	method buffDefensa() = -3
}
class Casa {
	method esAtacable() = false	
	method esObjetoGrande() = false
	method buffAtaque() = -1
	method buffDefensa() = 3	
}

object torre inherits Muralla{
	method image() = "casillaTorre.png"
}

object murallaVertical inherits Muralla{
	method image() = "casillaMurallaVer.png"
}

object murallaHorizontal inherits Muralla{
	method image() = "casillaMurallaHor.png"
}

object rioVertical inherits Rio{
	method image() = "casillaRioVer.png"
}

object rioHorizontal inherits Rio{
	method image() = "casillaRioHor.png"
}

object rioUnion inherits Rio{
	method image() = "casillaRioUnion.png"
}

object rioGiro1 inherits Rio{
	method image() = "casillaRioGiro1.png"
}

object rioGiro3 inherits Rio{
	method image() = "casillaRioGiro3.png"
}

object casas inherits Casa{
	method image() = "casillaCasitas.png"
}

object casas2 inherits Casa{
	method image() = "casillaCasitas2.png"
}

object arboles {
	method image() = "casillaArboles.png"
	method esAtacable() = false	
	method esObjetoGrande() = false
	method buffAtaque() = 5
	method buffDefensa() = -1
}