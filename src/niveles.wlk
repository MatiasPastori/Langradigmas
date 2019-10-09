import casillas.*
import tienda.*

object nivel1 {
	
	method iniciar() {
		tienda.iniciar()
		self.setearCasillas()
	}
	
	method setearCasillas() {
		mapManager.getEjeX().forEach{
			ejeY => ejeY.forEach{
				casilla => casilla.image("casillaPasto.png")
			}
		}
		mapManager.getBorde().forEach{
			casilla => casilla.image("casillaMontana.png")
		}
	}
	
	method siguiente() = nivel2
}

object nivel2 {
	
	method iniciar() {
	
	}
	
	method siguiente() = nivel3
}

object nivel3 {
	
	method iniciar() {
		
	}
	
	method siguiente() = null
}
