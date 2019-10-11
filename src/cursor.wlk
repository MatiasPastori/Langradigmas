import wollok.game.*
import utilidades.distancia.*
import utilidades.visuals.*
import utilidades.estado.*
import utilidades.acciones.*
import jugadores.*
import unidades.unidad.*
import unidades.void.*
import turnos.*

object cursor {
	var property unidad = null
	var property position = game.center()
	var property image = turnoManager.getJugadorActual().cursorImage()
	var posicionesAtacables = []
	var property estado = estadoVacio

	method seleccionar() {
		estado.accion(self)
	}
	
	method atacar(){
		self.verificarLaUnidadPuedaAtacar()
		var unidadAtacada = self.unidadEn(position)
		unidad.combatir(unidadAtacada)
		unidadAtacada.combatir(unidad)
		unidad.cambiarSprite(deseleccion)
		turnoManager.yaAtaco(unidad)
		estado = estadoVacio
		unidad.image(unidad.getTipo() + unidad.idJugador() + "gris.png")
		self.descaptarEnemigosCercanos()
		unidad = null		
	}
	
	method verificarLaUnidadPuedaAtacar() {
		if ( unidad == null ) 
			self.error("No puedo hacer eso")
		if ( !posicionesAtacables.contains(position) || !turnoManager.puedeAtacar(unidad) )
			unidad.error("No puedo hacer eso")
	}
	
	method atacarEspecial() {}
	
	method captarEnemigosCercanos() {
		var posicionesCerca = [position.right(1),position.left(1),position.up(1),position.down(1)]
		posicionesAtacables = posicionesCerca.filter{pos => self.unidadEn(pos) != null}
		posicionesAtacables.forEach{pos => game.addVisual(new Visual(image="atacable.png", position = pos))}
	}
	
	method descaptarEnemigosCercanos() {
		var espadasDeAtaque = []
		posicionesAtacables.forEach({pos => espadasDeAtaque.add(game.getObjectsIn(pos).filter({objeto => objeto.image() == "atacable.png"}).head())})
		posicionesAtacables.clear()
		espadasDeAtaque.forEach({espada => game.removeVisual(espada)})
	}
	
	method mostrarRangoTransitable(){
		
	}
	
	method unidadEn(posicion) { 
		var lista = game.getObjectsIn(posicion).filter({objeto => objeto.esSeleccionable()})
		return if(lista.size() > 0) lista.head() else null
	}
	
	method esCasillaOcupable() = self.unidadEn(position) == null //Acá poner los limites del mapa tmb


	method esSeleccionable() = false
}

