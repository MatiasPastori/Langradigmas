import wollok.game.*
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
		keyboard.k().onPressDo { 
			if(tienda.habilitada()) {
				escenario.nivelActual().iniciar()
				tienda.habilitada(false)
			} 
		}
	}
	method setearTeclasTurno() {
		keyboard.enter().onPressDo { turnoManager.finalizarTurno() }	
	}
}

object izquierda { method siguiente(position) = position.left(1) }

object derecha { method siguiente(position) = position.right(1) }

object abajo { method siguiente(position) = position.down(1) }

object arriba { method siguiente(position) = position.up(1) }

