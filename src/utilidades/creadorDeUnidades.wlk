import wollok.game.*
import unidades.comandante.*
import unidades.tirador.*
import unidades.guerrero.*
import unidades.caballeria.*

/*
	Encapsula la creación de unidades. Estos objetos se utilizan en escenario/tienda.wlk.
	creadorDeUnidades: crea comandantes y subordinados con un duenio y en caso de los subordinados, con un tipo. 
	unGuerrero: crea el tipo de subordinado "guerrero".
	unTirador: crea el tipo de subordinado "tirador".
	unaCaballeria: crea el tipo de subordinado "caballeria".
	* 
	method coloresPorSeleccionado(): retorna una lista con el siguiente orden [guerrero,tirador,caballeria]. El nombre
		de la unidad seleccionada se reemplazará por "iddle1" mientras que los restantes por "gris".
		Para ver su implementación ir a escenario/tienda.wlk.
*/

object creadorDeUnidades {
	
	method crearComandante(duenio, unId) {
		return new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = duenio, tipo = "comandante", idUnico = unId, rangoDeAccion = 3, rangoEspecial = 8, vida = 10, nivelAtaque = 28, nivelDefensa = 25)
	}
	
	method crearSubordinado(duenio, tipo, unId) {
		return tipo.crearUno(duenio,unId)
	}
	
}

object unGuerrero {
	method crearUno(duenio, unId) {
		return new Guerrero(position = game.at(1,1), image = "transparente.png", jugadorDuenio = duenio, tipo = "guerrero", idUnico=unId,comandante = duenio.getUnidades().head(), rangoDeAccion = 3, rangoEspecial = 1,nivelAtaque = 24, nivelDefensa = 20)
	}
	
	method coloresPorSeleccionado() = ["iddle1","gris","gris"]
	
}
object unTirador {
	method crearUno(duenio, unId) {
		return new Tirador(position = game.at(2,2), image = "transparente.png", jugadorDuenio = duenio, tipo = "tirador", idUnico = unId, comandante = duenio.getUnidades().head(), rangoDeAccion = 4, rangoEspecial = 2,nivelAtaque = 22, nivelDefensa = 18)
	}
	method coloresPorSeleccionado() = ["gris","iddle1","gris"]
	
}
object unaCaballeria {
	method crearUno(duenio, unId) {
		return new Caballeria(position = game.at(3,3), image = "transparente.png", jugadorDuenio = duenio, tipo = "caballeria", idUnico = unId, comandante = duenio.getUnidades().head(), rangoDeAccion = 5, rangoEspecial = 1,nivelAtaque = 25, nivelDefensa = 17)
	}	
	method coloresPorSeleccionado() = ["gris","gris","iddle1"] 
}