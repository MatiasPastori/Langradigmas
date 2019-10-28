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

/*
	Maneja las principales funcionalidades del juego (seleccionar una unidad, atacar con la unidad seleccionada,
	utilizar la habilidad especial de la unidad seleccionada).
	@unidad: unidad seleccionada por el jugador que posee el turno.
	@objetoAtacables: lista con objetos que pueden ser atacados por la unidad seleccionada.
	@rangoMarcadoPorUnidad: casillas definidas dado un rango en base a la posición de la unidad seleccionada.
	@estadoSeleccion: referencia al objeto que maneja la lógica de la selección de la unidad.
	@estadoEspecial: referencia al objeto que maneja la lógica de la utilización de la habilidad especial.
*/

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
	method esObjetoGrande() = false

	method seleccionar() {
		estadoSeleccion.accion(self)
	}
	
	method atacar(){
		self.verificarLaUnidadPuedaAtacar()
		var atacado = self.atacableEn(position)
		unidad.combatir(atacado,self.casillaEn(position))
		atacado.combatir(unidad,self.casillaEn(position))
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
	
	// Define que objetos pueden ser atacados por la unidad seleccionada en un rango de 1 casilla de distancia
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
	method hayCasillaFijaEn(pos) = self.casillaEn(pos) != null
	method hayEnemigoEn(pos) = self.hayUnidadEn(pos) and !turnoManager.esDelJugadorActual(self.unidadEn(pos))
	method hayObjetoGrandeEn(pos) = self.objetoGrandeEn(pos) != null
	method noHayEnemigosCerca() = objetosAtacables.isEmpty()
	
	// Devuelve el objeto que puede ser destruído en una posición dada. Null si no hay
	method rompibleEn(pos) = self.getObjeto({obj => obj.esAtacable() and !obj.esSeleccionable()}, pos)
	// Devuelve la unidad en una posición dada. Null si no hay
	method unidadEn(pos) = self.getObjeto({obj => obj.esSeleccionable()}, pos)
	// Devuelve la casilla en una posición dada. Null si no hay
	method casillaEn(pos) = self.getObjeto({obj => obj.esCasillaFija()}, pos)
	// Devuelve el objeto que puede ser atacado en una posición dada. Null si no hay
	method atacableEn(pos) = self.getObjeto({obj => obj.esAtacable()}, pos) 
	// Devuelve el objeto que no permite que una unidad ocupe una casilla en una posición dada. Null si no hay
	method objetoGrandeEn(pos) {
		var objetoDeCasilla = self.getObjeto({obj => obj.esCasillaFija()},pos).objeto()
		if (objetoDeCasilla != null) {
			if (objetoDeCasilla.esObjetoGrande()){
				return objetoDeCasilla
			} 
		}
		return null
	}
	// Dada una condición y una posición, devuelve el objeto que cumpla. Null si no hay
	method getObjeto(condicion,pos) { 
		var lista = game.getObjectsIn(pos).filter({obj => condicion.apply(obj)})
		return if(lista.size() > 0) lista.head() else null
	}
	
	// Métodos para mostrar o borrar rangos de movimientos
	// @marca: path de imagen png que se quiere mostrar en las casillas alcanzadas por el rango.
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
	// enRangoEspecial(): true si la posición del cursor se encuentra dentro del rango marcado para una unidad dada
	method enRangoEspecial() = !rangoMarcadoPorUnidad.filter{visual => visual.position() == self.position()}.isEmpty()
	
	// Otros
	method esCasillaOcupable(pos) = !self.hayAtacableEn(pos) and !self.hayObjetoGrandeEn(pos)
	
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

