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
import utilidades.comentarios.*
import jugadores.*
import turnos.*
import cursor.*

class Nivel {
	const tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	
	method generarNivel()
	method tienda() {
		var comandanteJ1 = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", rangoDeAccion = 3, rangoEspecial = 8,vida = 10, nivelAtaque = 28, nivelDefensa = 24 )
		var comandanteJ2 = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "comandante", rangoDeAccion = 3, rangoEspecial = 8,vida = 10, nivelAtaque = 28, nivelDefensa = 24)
		
		game.addVisual(tiendaImg)
		jugador1.getUnidades().clear()
		jugador2.getUnidades().clear()
		jugador1.comprar(comandanteJ1)
		jugador2.comprar(comandanteJ2)
		tienda.habilitada(true)
		tienda.iniciar()
	}
	method iniciar() {
		var comandanteJ1 = jugador1.getUnidades().head()
		var comandanteJ2 = jugador2.getUnidades().head()
		var subordinadosJ1 = jugador1.getUnidades().subList(1,10)
		var subordinadosJ2 = jugador2.getUnidades().subList(1,10)
		
		game.removeVisual(tiendaImg)
		
		self.posicionarUnidades()
		game.schedule(2000, {
			game.say(subordinadosJ1.anyOne(), comentario.msgInicioNivelJ1subordinados())
			game.say(subordinadosJ1.anyOne(), comentario.msgInicioNivelJ1subordinados())
			game.say(subordinadosJ2.anyOne(), comentario.msgInicioNivelJ2subordinados())
			game.say(subordinadosJ2.anyOne(), comentario.msgInicioNivelJ2subordinados())				
		})
			
		game.addVisual(cursor)
		turnoManager.habilitado(true)
		turnoManager.iniciarTurno()
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
		var coordY

		comandanteJ1.position(game.at(2,8))
		comandanteJ2.position(game.at(game.width()-3,8))

	// Pelotones J1	 - Logica fea pero funcional
	// Agrega los pelotones de unidades alrededor del comandante correspondiente
		coordY = comandanteJ1.position().y() + 2
		primerPelotonUnidadesJ1.forEach{
			unidad => unidad.position(game.at(comandanteJ1.position().x(), coordY))
			coordY--
			if (coordY == comandanteJ1.position().y() ) { coordY-- }
		}
		coordY = comandanteJ1.position().y() + 1
		segundoPelotonUnidadesJ1.forEach{
			unidad => unidad.position(game.at(comandanteJ1.position().x()+1, coordY))
			coordY--
		}
		coordY = comandanteJ1.position().y() + 1
		tercerPelotonUnidadesJ1.forEach{
			unidad => unidad.position(game.at(comandanteJ1.position().x()-1, coordY))
			coordY--
		}

	// Pelotones J2
		coordY = comandanteJ2.position().y() + 2
		primerPelotonUnidadesJ2.forEach{
			unidad => unidad.position(game.at(comandanteJ2.position().x(), coordY))
			coordY--
			if (coordY == comandanteJ2.position().y() ) { coordY-- }
		}
		coordY = comandanteJ2.position().y() + 1
		segundoPelotonUnidadesJ2.forEach{
			unidad => unidad.position(game.at(comandanteJ2.position().x()+1, coordY))
			coordY--
		}
		coordY = comandanteJ2.position().y() + 1
		tercerPelotonUnidadesJ2.forEach{
			unidad => unidad.position(game.at(comandanteJ2.position().x()-1, coordY))
			coordY--
		}	
				
		jugador1.getUnidades().forEach{unidad => 
			game.addVisual(unidad)
			game.addVisual(unidad.imagenVida())
			game.addVisual(unidad.imagenCD())
			unidad.cambiarSprite(iddle)
		}
		jugador2.getUnidades().forEach{unidad => 
			game.addVisual(unidad)
			game.addVisual(unidad.imagenVida())
			game.addVisual(unidad.imagenCD())
			unidad.cambiarSprite(iddle)
		}
	}
	method terminarNivel() {
		//TODO
		jugador1.getUnidades().clear()
		jugador2.getUnidades().clear()
		turnoManager.habilitado(false)
		escenario.actualizarNivel()
	}
}

object nivel1 inherits Nivel{	
	override method generarNivel() {
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
	
	method setearCasillas() {

		mapManager.getInternas().forEach{casilla => casilla.image("casillaPasto.png")}

		mapManager.getBorde().forEach{
			casilla => casilla.image("casillaMontana.png")
		}
	}
	
	method siguiente() = nivel2
}

object nivel2 inherits Nivel{	
	override method generarNivel() {
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
	
	method setearCasillas() {

		mapManager.getInternas().forEach{casilla => casilla.image("casillaPasto.png")}

		mapManager.getBorde().forEach{
			casilla => casilla.image("casillaMontana.png")
		}
	}
	
	method siguiente() = nivel3
}

object nivel3 inherits Nivel{	
	override method generarNivel() {
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
	
	method setearCasillas() {
		mapManager.getInternas().forEach{casilla => casilla.image("casillaPasto.png")}

		mapManager.getBorde().forEach{
			casilla => casilla.image("casillaMontana.png")
		}
	}
	
	
	method siguiente() = null
}
