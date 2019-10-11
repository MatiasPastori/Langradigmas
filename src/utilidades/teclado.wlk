import wollok.game.*
import inicio.*
import escenario.escenario.*
import escenario.tienda.*
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
		keyboard.d().onPressDo { cursor.atacarEspecial() }
	}
	method setearTeclasTienda() {
		keyboard.k().onPressDo {if(tienda.habilitada()) tienda.terminarCompra()}
		keyboard.y().onPressDo {
			if(tienda.habilitada()) {

			} 
		}
		keyboard.n().onPressDo {
			if(tienda.habilitada()) {

			} 
		}
		keyboard.num(1).onPressDo {
			if(tienda.habilitada()) {

			} 
		}
		keyboard.num(2).onPressDo {
			if(tienda.habilitada()) {

			} 
		}
		keyboard.num(3).onPressDo {
			if(tienda.habilitada()) {

			} 
		}
	}
	method setearTeclasTurno() {keyboard.enter().onPressDo { 
		if (!tienda.habilitada())  
			turnoManager.finalizarTurno()
	}}
	method setearTeclaInicio() {keyboard.enter().onPressDo { 
		if (inicio.inicioHabilitado()) {
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

