import unidades.unidad.*

object jugador1 {
	var unidades = []
	var id = "J1"
	
	method cursorImage() = "cursorJ1.png"
	
	method getUnidades() = unidades
	method getId() = id
	
	method terminarTurno() {
		 
	}
	
	method comprar(unidad) = unidades.add(unidad)
	
	method siguiente() = jugador2	
	
	method curarUnidades() { unidades.forEach({unidad => unidad.curar()})}
}

object jugador2 {	
	var unidades = []
	var id = "J2"
	
	method cursorImage() = "cursorJ2.png"
	
	method getUnidades() = unidades
	method getId() = id
	
	method terminarTurno(){
		
	}
	
	method comprar(unidad) = unidades.add(unidad)
	
	method siguiente() = jugador1
	
	method curarUnidades() { unidades.forEach({unidad => unidad.curar()})}
}
