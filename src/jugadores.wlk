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
	
	method vender() = unidades.remove(unidades.last())
	
	method siguiente() = jugador2	
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
	
	method vender() = unidades.remove(unidades.last())
	
	method siguiente() = jugador1
}
