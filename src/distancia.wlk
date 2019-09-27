
// Da la distancia entre dos puntos evaluada en cantidad de movimientos que una 
// unidad necesita para llegar a la misma

class Distancia {
	var property position
	
	method distanciaA(posFinal) {
		var distX = posFinal.x() - position.x()
		var distY = posFinal.y() - position.y()
		return distX.abs() + distY.abs()
	}
}