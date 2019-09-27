class Distancia {
	var property position
	
	method distanciaA(posFinal) {
		var distX = posFinal.x() - position.x()
		var distY = posFinal.y() - position.y()
		return distX.abs() + distY.abs()
	}
}