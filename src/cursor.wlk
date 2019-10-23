import wollok.game.*
import utilidades.distancia.*
import utilidades.visuals.*
import estados.estadoSeleccionCursor.*
import estados.estadoEspecialCursor.*
import utilidades.acciones.*
import utilidades.comentarios.*
import unidades.unidad.*
import escenario.casillas.*
import jugadores.*
import turnos.*

object cursor {
	var property unidad = null
	var property position = game.center()
	var property image = turnoManager.getJugadorActual().cursorImage()
	var property objetosAtacables = []
	var rangoMarcadoPorUnidad = []
	var property estadoSeleccion = estadoVacio
	var property estadoEspecial = estadoNoEspecial

	method esSeleccionable() = false
	method esAtacable() = false
	method esCasillaFija() = false

	method seleccionar() {
		estadoSeleccion.accion(self)
	}
	
	method atacar(){
		self.verificarLaUnidadPuedaAtacar()
		var atacado = self.atacableEn(position)
		unidad.combatir(atacado)
		atacado.combatir(unidad)
		unidad.cambiarSprite(deseleccion)
		turnoManager.yaAtaco(unidad)
		estadoSeleccion = estadoVacio
		self.descaptarEnemigosCercanos()
		self.borrarRango()
		unidad = null		
	}
	
	method usarHabilidadEspecial() {
		self.verificarHabilidadEspecialDisponible()
		estadoEspecial.accion(self)
	}
	
	// Métodos para poner o borrar espadas sobre enemigos cercanos
	method captarEnemigosCercanos() {
		objetosAtacables = self.objetosAmenazantes(unidad.position())
		objetosAtacables.forEach{enemigo => game.addVisual(new Visual(image="atacable.png", position = enemigo.position()))}
	}
	method descaptarEnemigosCercanos() {
		var espadasDeAtaque = []
		objetosAtacables.forEach{
			enemigo => espadasDeAtaque.add(
				game.getObjectsIn(enemigo.position()).filter{obj => obj.image() == "atacable.png"}.head()
			)
		}
		objetosAtacables.clear()
		espadasDeAtaque.forEach{espada => game.removeVisual(espada)}
	}
	method objetosAmenazantes(posicion) {
		var posUnidad = posicion
		var posicionesCerca = [posUnidad.right(1),posUnidad.left(1),posUnidad.up(1),posUnidad.down(1)]
		var objetos = []
		posicionesCerca.filter{pos => self.hayEnemigoEn(pos) or self.hayObjetoRompibleEn(pos)}.forEach{
			pos =>
			objetos.add(self.unidadEn(pos))
			objetos.add(self.rompibleEn(pos))
		}
		return objetos.copyWithout(null)
	}
	method hayObjetoRompibleEn(pos) = self.rompibleEn(pos) != null
	method hayUnidadEn(pos) = self.unidadEn(pos) != null
	method hayAtacableEn(pos) = self.atacableEn(pos) != null
	method hayEnemigoEn(pos) = self.hayUnidadEn(pos) and !turnoManager.esDelJugadorActual(self.unidadEn(pos))
	method noHayEnemigosCerca() = objetosAtacables.isEmpty()
	
	method rompibleEn(pos) = self.getObjeto(game.getObjectsIn(pos).filter{objeto => objeto.esAtacable() and !objeto.esSeleccionable()})
	method unidadEn(pos) = self.getObjeto(game.getObjectsIn(pos).filter{objeto => objeto.esSeleccionable()})
	method atacableEn(pos) = self.getObjeto(game.getObjectsIn(pos).filter{objeto => objeto.esAtacable()})	
	method getObjeto(lista) = if(lista.size() > 0) lista.head() else null
	
	// Métodos para mostrar o borrar rangos de movimientos
	method mostrarRango(rango, marca){
		var casillasAMarcar = mapManager.getInternas().filter { 
			casilla =>
			distancia.distanciaEntre(casilla.position(), unidad.position()) <= rango
		}
		casillasAMarcar.forEach { casilla =>
			var visual = new Visual(image = marca, position = casilla.position())
			rangoMarcadoPorUnidad.add(visual)
			game.addVisual(visual)
		}
	}
	method borrarRango() = rangoMarcadoPorUnidad.forEach { visual => 
		game.removeVisual(visual)
		rangoMarcadoPorUnidad.remove(visual)
	}
	method enRangoEspecial() = !rangoMarcadoPorUnidad.filter{visual => visual.position() == self.position()}.isEmpty()
	
	// Otros
	method esCasillaOcupable(pos) = !self.hayAtacableEn(pos) and mapManager.estaEnInternas(pos)
	
	// Chequeo de errores
	method verificarLaUnidadPuedaAtacar() {
		if ( unidad == null ) 
			self.error(error.msgSinUnidadSeleccionada())
		if ( !turnoManager.puedeAtacar(unidad) or turnoManager.esDelJugadorActual(self.unidadEn(position)) or !self.hayAtacableEn(position) )
			unidad.error(error.msgAtaqueInvalido())
	}
	
	method verificarHabilidadEspecialDisponible() {
		if ( unidad == null ) 
			self.error(error.msgSinUnidadSeleccionada())
		if (!unidad.habilidadEspecialDisponible())
			unidad.error(error.msgEspecialEnCooldown())
	}
}

