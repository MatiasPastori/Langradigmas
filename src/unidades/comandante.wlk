import unidad.*
import subordinado.*

class Comandante inherits Unidad {
	const property subordinados = []
	
	method buffAtaqueQueOtorga() = 0
	method buffDefensaQueOtorga() = 0
	
	method reclutar(subordinado) = subordinados.add(subordinado)	

}
