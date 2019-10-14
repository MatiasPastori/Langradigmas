import wollok.game.*
import escenario.escenario.*
import escenario.casillas.*
import escenario.tienda.*
import unidades.comandante.*
import unidades.tirador.*
import unidades.guerrero.*
import unidades.caballeria.*
import unidades.unidad.*
import utilidades.acciones.*
import utilidades.visuals.*
import jugadores.*
import turnos.*
import cursor.*

object nivel1 {	
	var tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	
	method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel1_C.png")
		
		self.setearCasillas()
		game.schedule(500, {game.addVisual(nivelImg)})
		game.schedule(650, {nivelImg.image("nivel1_B.png")})
		game.schedule(800, {nivelImg.image("nivel1_A.png")})
		game.schedule(2000, {
			game.removeVisual(nivelImg)
			self.tienda()
		})
	}
	method tienda() {
		var comandanteBueno = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", rangoDeAccion = 50, vida = 10, nivelAtaque = 28, nivelDefensa =24 )
		var comandanteMalo = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "comandante", rangoDeAccion = 2, vida = 10, nivelAtaque = 24, nivelDefensa = 30)
		
		game.addVisual(tiendaImg)
		
		jugador1.comprar(comandanteBueno)
		jugador2.comprar(comandanteMalo)
		tienda.habilitada(true)
		tienda.iniciar()
	}
	method iniciar() {
		game.removeVisual(tiendaImg)
		
		self.posicionarUnidades()
		
		game.addVisual(cursor)
		turnoManager.habilitado(true)
		turnoManager.iniciarTurno()
	}
	method terminarNivel() {
		//TODO
		turnoManager.habilitado(false)
		escenario.actualizarNivel()
	}
	
	method posicionarUnidades() {	
		const comandanteJ1 = jugador1.getUnidades().head()
		const comandanteJ2 = jugador2.getUnidades().head()
		const primerPelotonUnidadesJ1 = jugador1.getUnidades().subList(1,4)
		const primerPelotonUnidadesJ2 = jugador2.getUnidades().subList(1,4)
		const segundoPelotonUnidadesJ1 = jugador1.getUnidades().subList(5,7)
		const segundoPelotonUnidadesJ2 = jugador2.getUnidades().subList(5,7)
		const tercerPelotonUnidadesJ1 = jugador1.getUnidades().subList(8,10)
		const tercerPelotonUnidadesJ2 = jugador2.getUnidades().subList(8,10)
		var _y

		comandanteJ1.position(game.at(2,8))
		comandanteJ2.position(game.at(game.width()-3,8))

	// Pelotones J1	
		_y = comandanteJ1.position().y() + 2
		primerPelotonUnidadesJ1.forEach{
			unidad =>
			unidad.position(game.at(comandanteJ1.position().x(), _y))
			_y--
			if (_y == comandanteJ1.position().y() ) { _y-- }
		}
		_y = comandanteJ1.position().y() + 1
		segundoPelotonUnidadesJ1.forEach{
			unidad =>
			unidad.position(game.at(comandanteJ1.position().x()+1, _y))
			_y--
		}
		_y = comandanteJ1.position().y() + 1
		tercerPelotonUnidadesJ1.forEach{
			unidad =>
			unidad.position(game.at(comandanteJ1.position().x()-1, _y))
			_y--
		}

	// Pelotones J2
		_y = comandanteJ2.position().y() + 2
		primerPelotonUnidadesJ2.forEach{
			unidad =>
			unidad.position(game.at(comandanteJ2.position().x(), _y))
			_y--
			if (_y == comandanteJ2.position().y() ) { _y-- }
		}
		_y = comandanteJ2.position().y() + 1
		segundoPelotonUnidadesJ2.forEach{
			unidad =>
			unidad.position(game.at(comandanteJ2.position().x()+1, _y))
			_y--
		}
		_y = comandanteJ2.position().y() + 1
		tercerPelotonUnidadesJ2.forEach{
			unidad =>
			unidad.position(game.at(comandanteJ2.position().x()-1, _y))
			_y--
		}	
				
		jugador1.getUnidades().forEach{unidad => 
			game.addVisual(unidad)
			game.addVisual(unidad.imagenVida())
			unidad.cambiarSprite(iddle)
		}
		jugador2.getUnidades().forEach{unidad => 
			game.addVisual(unidad)
			game.addVisual(unidad.imagenVida())
			unidad.cambiarSprite(iddle)
		}
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
	var tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	
	method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel2_C.png")
		
		self.setearCasillas()
		game.schedule(500, {game.addVisual(nivelImg)})
		game.schedule(650, {nivelImg.image("nivel2_B.png")})
		game.schedule(800, {nivelImg.image("nivel2_A.png")})
		game.schedule(2000, {
			game.removeVisual(nivelImg)
			self.tienda()
		})
	}	
	
	method tienda() {
		game.addVisual(tiendaImg)
	}
	
	method iniciar() {
		game.removeVisual(tiendaImg)
		// TODO
		
		game.addVisual(cursor)
		turnoManager.iniciarTurno()
	}
	
	method terminarNivel() {
		//TODO
		turnoManager.habilitado(false)
		escenario.actualizarNivel()
	}
	
	method setearCasillas() {

	}
	
	method siguiente() = nivel3
}

object nivel3 {
	var tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	
	method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel3_C.png")
		
		self.setearCasillas()
		game.schedule(500, {game.addVisual(nivelImg)})
		game.schedule(650, {nivelImg.image("nivel3_B.png")})
		game.schedule(800, {nivelImg.image("nivel3_A.png")})
		game.schedule(2000, {
			game.removeVisual(nivelImg)
			self.tienda()
		})
	}	
		
	method tienda() {
		game.removeVisual(tiendaImg)
	}
	method iniciar() {
		game.addVisual(tiendaImg)
		
		// TODO
		
		game.addVisual(cursor)
		turnoManager.iniciarTurno()
	}
	
	method terminarNivel() {
		//TODO
		turnoManager.habilitado(false)
		escenario.actualizarNivel()
	}
	
	method setearCasillas() {

	}
	
	method siguiente() = null
}
