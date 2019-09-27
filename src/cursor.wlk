import wollok.game.*

object cursor {
	//var jugadorActual = jugador1 Recordar poner esto cuando se creen los object jugador
	var hayAlgoSeleccionado = false
//	var unidad = null
	
	/////////////////////
	var objetoColisionado = null // PARTE DE LA SOLUC 2
	/////////////////////

	var property position = game.center()

	method image() = "cursorGood.png"

//	method seleccionar() {
//		if (!hayAlgoSeleccionado) {
//			var lista = game.getObjectsIn(self.position()).filter({objeto => objeto != self})
//			unidad = self.agarrarUnidad(lista)
//			if (unidad != null) hayAlgoSeleccionado = true
//		}else if (unidad != null) {
//			unidad.mover(position)
//			hayAlgoSeleccionado = false
//			unidad = null
//		}
//	}
//	
//	method agarrarUnidad(lista) = if(lista.size() > 0) lista.head() else null
	

	/////////////////////////////////////////////////////////////////////////
	// SOLUC 2	
	method setObjetoColisionado(algo) { objetoColisionado = algo }
	method hayAlgoColisionado() = objetoColisionado != null
	method colisionadoSeleccionable() = objetoColisionado.esSeleccionable()
				// Ver comandantes.wlk para ver la implementacion de esSeleccionable()	
	
	method seleccionar() {
		
		if (self.hayAlgoColisionado() && self.colisionadoSeleccionable()) {
			// Si hay algo colisionado y es seleccionable => lo muevo
			  // Quizas mas adelante se pase a llamar esMovible, puede que seleccionemos mas cosas que no sean movibles
			
			objetoColisionado.mover(position)
			// hayAlgoSeleccionado = true (quizas quiera guardar esto y sacarlo fuera del if)
			// Por si quiero hacer algo mas pero por ahora la implementacion es basica
		}
		// hayAlgoSeleccionado = false
	}
	//////////////////////////////////////////////////////////////////////////
	
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

