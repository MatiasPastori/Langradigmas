
/*
	Da la distancia entre dos posiciones evaluada en cantidad de movimientos que una unidad 
	necesita para ir de una a otra en valor absoluto.
*/

object distancia {
	method diferenciaEntre(x1,x2) = (x1 - x2)
	
	method distanciaEntre(posInicial, posFinal) = 
		self.diferenciaEntre(posInicial.x(),posFinal.x()).abs() + self.diferenciaEntre(posInicial.y(),posFinal.y()).abs()		
}