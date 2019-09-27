import wollok.game.*

object cursor {
	var hayAlgoSeleccionado = false
	var unidad = null

	var property position = game.center()

	method image() = "cursorGood.png"

	method seleccionar() {
		if (!hayAlgoSeleccionado) {
			var lista = game.getObjectsIn(self.position()).filter({objeto => objeto != self})
			unidad = self.agarrarUnidad(lista)
			if (unidad != null) hayAlgoSeleccionado = true
		}else if (unidad != null) {
			unidad.mover(position)
			hayAlgoSeleccionado = false
			unidad = null
		}
	}
	
	method agarrarUnidad(lista) = if(lista.size() > 0) lista.head() else null
}

object movimiento {

	method configurarFlechas(visual) {
		keyboard.up().onPressDo{ self.mover(arriba, visual)}
		keyboard.down().onPressDo{ self.mover(abajo, visual)}
		keyboard.left().onPressDo{ self.mover(izquierda, visual)}
		keyboard.right().onPressDo{ self.mover(derecha, visual)}
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

