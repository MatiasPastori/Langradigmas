import wollok.game.*
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

		
		jugador1.getUnidades().head().position(game.at(2,8))
		jugador2.getUnidades().head().position(game.at(game.width()-3,8))

		
				
		jugador1.getUnidades().forEach{unidad => 
			game.addVisual(unidad)
			unidad.cambiarSprite(iddle)
		}
		jugador2.getUnidades().forEach{unidad => 
			game.addVisual(unidad)
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
