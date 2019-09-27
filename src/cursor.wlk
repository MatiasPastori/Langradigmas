import wollok.game.*

object cursor {
	//var jugadorActual = jugador1 Recordar poner esto cuando se creen los object jugador
	//var hayAlgoSeleccionado = true
	var unidad = null
	var property position = game.center()

	method image() = "cursorGood.png"

	method seleccionar() {
		if (unidad == null) {
			unidad = self.agarrarUnidadDeLaPosicionActual()
		}else {
			unidad.mover(position)
			unidad = null
		}
	}
	
	method agarrarUnidadDeLaPosicionActual() { 
		var lista = game.getObjectsIn(self.position()).filter({objeto => objeto != self})
		return if(lista.size() > 0 && lista.head().esSeleccionable()) lista.head() else null
	}

	method atacar() {}
	
	method atacarEspecial() {}

	
}

object movimiento {

	method configurarFlechas(visual) {
		keyboard.up().onPressDo    { self.mover(arriba, visual)}
		keyboard.down().onPressDo  { self.mover(abajo, visual)}
		keyboard.left().onPressDo  { self.mover(izquierda, visual)}
		keyboard.right().onPressDo { self.mover(derecha, visual)}
	}

	method mover(direccion, cursor) {
		cursor.position(direccion.siguiente(cursor.position()))
	}

}

object izquierda {

	method siguiente(position) = position.left(1)

}

object derecha {

	method siguiente(position) = position.right(1)

}

object abajo {

	method siguiente(position) = position.down(1)

}

object arriba {

	method siguiente(position) = position.up(1)

}

