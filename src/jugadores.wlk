import unidad.*

object jugador1 {
	var unidades = []
	
	method cursorImage() = "cursorJ1.png"
	
	method getUnidades() = unidades
	
	method terminarTurno() {
		 
	}
	
	method comprar(unidad) = unidades.add(unidad)
	
}

object jugador2 {	
	var unidades = []
	
	method cursorImage() = "cursorJ2.png"
	
	method getUnidades() = unidades
	
	method terminarTurno(){
		
	}
	
	method comprar(unidad) = unidades.add(unidad)
}
