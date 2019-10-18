import wollok.game.*
import utilidades.distancia.*
import utilidades.visuals.*
import utilidades.estadoSeleccionCursor.*
import utilidades.estadoEspecialCursor.*
import utilidades.acciones.*
import utilidades.comentarios.*
import jugadores.*
import unidades.unidad.*
import unidades.void.*
import turnos.*

object cursor {
	var property unidad = null
	var property position = game.center()
	var property image = turnoManager.getJugadorActual().cursorImage()
	var posicionesAtacables = []
	var property estadoSeleccion = estadoVacio
	var property estadoEspecial = estadoNoEspecial

	method seleccionar() {
		estadoSeleccion.accion(self)
	}
	
	method atacar(){
		self.verificarLaUnidadPuedaAtacar()
		var unidadAtacada = self.unidadEn(position)
		unidad.combatir(unidadAtacada)
		unidadAtacada.combatir(unidad)
		unidad.cambiarSprite(deseleccion)
		turnoManager.yaAtaco(unidad)
		estadoSeleccion = estadoVacio
		//unidad.image(unidad.getTipo() + unidad.idJugador() + "gris.png")
		self.descaptarEnemigosCercanos()
		unidad = null		
	}
	
	method usarHabilidadEspecial() {
		self.verificarHabilidadEspecialDisponible()
		estadoEspecial.accion(self)
	}
	method captarEnemigosCercanos(dist) {
		var posicionesCerca = [position.right(dist),position.left(dist),position.up(dist),position.down(dist)]
		posicionesAtacables = posicionesCerca.filter{pos => 
			self.unidadEn(pos) != null and !turnoManager.esDelJugadorActual(self.unidadEn(pos))
		}
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
	
	// Chequeo de errores
	method verificarLaUnidadPuedaAtacar() {
		if ( unidad == null ) 
			self.error(error.msgSinUnidadSeleccionada())
		if ( !posicionesAtacables.contains(position) || !turnoManager.puedeAtacar(unidad) )
			unidad.error(error.msgAtaqueInvalido())
	}
	
	method verificarHabilidadEspecialDisponible() {
		if (!unidad.habilidadEspecialDisponible())
			unidad.error(error.msgEspecialEnCooldown())
	}
}

