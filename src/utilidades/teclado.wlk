import wollok.game.*
import escenario.escenario.*
import escenario.tienda.*

import escenario.casillas.*

object teclado {
	method setearTeclasMovimiento(visual) {
		keyboard.up().onPressDo    { self.mover(arriba, visual)}
		keyboard.down().onPressDo  { self.mover(abajo, visual)}
		keyboard.left().onPressDo  { self.mover(izquierda, visual)}
		keyboard.right().onPressDo { self.mover(derecha, visual)}
	}
	method mover(direccion, cursor) { cursor.position(direccion.siguiente(cursor.position())) }
	method setearTeclasAccion(cursor) {
		keyboard.s().onPressDo { cursor.seleccionar() }	
		keyboard.a().onPressDo { cursor.atacar() }	
		keyboard.d().onPressDo { cursor.atacarEspecial() }
		
		keyboard.t().onPressDo { game.say(mapManager.access(2, 3), "hola") }
		keyboard.y().onPressDo { game.say(mapManager.accessBorde(0, 0), "hola") }
	}
	method setearTeclasTienda() {
		keyboard.k().onPressDo { 
			if(tienda.habilitada()) {
				escenario.nivelActual().iniciar()
				tienda.habilitada(false)
			} 
		}
	}
}

object izquierda { method siguiente(position) = position.left(1) }

object derecha { method siguiente(position) = position.right(1) }

object abajo { method siguiente(position) = position.down(1) }

object arriba { method siguiente(position) = position.up(1) }
