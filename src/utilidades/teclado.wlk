import wollok.game.*
import inicio.*
import escenario.escenario.*
import escenario.tienda.*
import utilidades.comentarios.*
import utilidades.creadorDeUnidades.*
import turnos.*

import escenario.casillas.*
import cursor.*
import jugadores.*

object teclado {
	method setearTeclasMovimiento(cursor) {
		keyboard.up().onPressDo    { self.mover(arriba, cursor)}
		keyboard.down().onPressDo  { self.mover(abajo, cursor)}
		keyboard.left().onPressDo  { self.mover(izquierda, cursor)}
		keyboard.right().onPressDo { self.mover(derecha, cursor)}
	}
	//method mover(direccion, cursor) { cursor.position(cursor,direccion.siguiente(cursor.position())) }
	method mover(direccion, cursor) { direccion.siguiente(cursor) }
	method setearTeclasAccion(cursor) {
		keyboard.s().onPressDo { cursor.seleccionar() }	
		keyboard.a().onPressDo { cursor.atacar() }	
		keyboard.d().onPressDo { cursor.usarHabilidadEspecial() }
	}
	method setearTeclasTienda() {
		keyboard.t().onPressDo {
			if(tienda.habilitada()) {
				if (tienda.getCantComprada() != 10) {
					self.error(error.msgCarritoSinLlenar())
				}
				tienda.terminarCompra()
			}
		}
		keyboard.q().onPressDo {if(tienda.habilitada()) tienda.comprar()}
		keyboard.e().onPressDo {if(tienda.habilitada()) tienda.vender()} 
		keyboard.num(1).onPressDo {if(tienda.habilitada()) tienda.reservar(unGuerrero)}
		keyboard.num(2).onPressDo {if(tienda.habilitada()) tienda.reservar(unTirador)}
		keyboard.num(3).onPressDo {if(tienda.habilitada()) tienda.reservar(unaCaballeria)}
	}
	method setearTeclasTurno() {keyboard.enter().onPressDo { 
		if (turnoManager.habilitado()) {
			if(cursor.unidad() != null) {
				cursor.unidad().error(error.msgConUnidadSeleccionada())
			}
			turnoManager.finalizarTurno()
		}
	}}
	method setearTeclaInicio() {keyboard.enter().onPressDo { 
		if (inicio.inicioHabilitado()) {
			//game.sound("mainMenu.mp3")
			inicio.inicioHabilitado(false)
			game.removeVisual(inicio.getInicioVisual())
			escenario.iniciar()	
		}
	}}
}

object izquierda { 
	method siguiente(cursor) {
		if (cursor.position().left(1).x() != 0)
			cursor.position(cursor.position().left(1))
	}
}

object derecha { 
	method siguiente(cursor) {
		if (cursor.position().right(1).x() != game.width()-1)
			cursor.position(cursor.position().right(1))
	}
}

object abajo { 
	method siguiente(cursor) {
		if (cursor.position().down(1).y() != 0)
			cursor.position(cursor.position().down(1))
	}
}

object arriba { 
	method siguiente(cursor) {
		if (cursor.position().up(1).y() != game.height()-1)
			cursor.position(cursor.position().up(1))
	}
}

