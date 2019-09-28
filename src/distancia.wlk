
// Da la distancia entre dos posiciones evaluada en cantidad de movimientos que una unidad 
// necesita para ir de una a otra en valor absoluto

class Distancia {
	var property position
	
	method distanciaA(posFinal) {
		var distX = posFinal.x() - position.x()
		var distY = posFinal.y() - position.y()
		return distX.abs() + distY.abs()
	}
}