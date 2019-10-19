
// Da la distancia entre dos posiciones evaluada en cantidad de movimientos que una unidad 
// necesita para ir de una a otra en valor absoluto

object distancia {
	method distanciaEntre(posInicial, posFinal) {
		var distX = posFinal.x() - posInicial.x()
		var distY = posFinal.y() - posInicial.y()
		return distX.abs() + distY.abs()
	}
}