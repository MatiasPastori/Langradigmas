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
	method mover(direccion, cursor) { cursor.position(direccion.siguiente(cursor.position())) }
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

object izquierda { method siguiente(position) = position.left(1) }

object derecha { method siguiente(position) = position.right(1) }

object abajo { method siguiente(position) = position.down(1) }

object arriba { method siguiente(position) = position.up(1) }

