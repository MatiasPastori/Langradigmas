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
	const unidadesPorJugador = 11
	var ganador
	var cantUnidadesMuertas = 0
	
	method getGanador() = ganador
	method getCantUnidadesMuertas() = cantUnidadesMuertas
	
	method generarNivel()
	method tienda() {
		var comandanteJ1 = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", rangoDeAccion = 50, rangoEspecial = 50,vida = 10, nivelAtaque = 28, nivelDefensa = 24 )
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
	// ver imagen en assets explicacion_seteo_unidades
		coordY = comandanteJ1.position().y() + 2
		primerPelotonUnidadesJ1.forEach{ unidad => 
			unidad.position(game.at(comandanteJ1.position().x(), coordY))
			coordY--
			if (coordY == comandanteJ1.position().y() ) { coordY-- }
		}
		coordY = comandanteJ1.position().y() + 1
		segundoPelotonUnidadesJ1.forEach{ unidad => 
			unidad.position(game.at(comandanteJ1.position().x()+1, coordY))
			coordY--
		}
		coordY = comandanteJ1.position().y() + 1
		tercerPelotonUnidadesJ1.forEach{ unidad => 
			unidad.position(game.at(comandanteJ1.position().x()-1, coordY))
			coordY--
		}

	// Pelotones J2
		coordY = comandanteJ2.position().y() + 2
		primerPelotonUnidadesJ2.forEach{ unidad => 
			unidad.position(game.at(comandanteJ2.position().x(), coordY))
			coordY--
			if (coordY == comandanteJ2.position().y() ) { coordY-- }
		}
		coordY = comandanteJ2.position().y() + 1
		segundoPelotonUnidadesJ2.forEach{ unidad => 
			unidad.position(game.at(comandanteJ2.position().x()+1, coordY))
			coordY--
		}
		coordY = comandanteJ2.position().y() + 1
		tercerPelotonUnidadesJ2.forEach{ unidad => 
			unidad.position(game.at(comandanteJ2.position().x()-1, coordY))
			coordY--
		}	
				
		jugador1.getUnidades().forEach{ unidad => 
			game.addVisual(unidad)
			game.addVisual(unidad.imagenVida())
			game.addVisual(unidad.imagenCD())
			unidad.cambiarSprite(iddle)
		}
		jugador2.getUnidades().forEach{ unidad => 
			game.addVisual(unidad)
			game.addVisual(unidad.imagenVida())
			game.addVisual(unidad.imagenCD())
			unidad.cambiarSprite(iddle)
		}
	}
	method terminarNivel(jGanador) {
		var victoria = new Visual(position=game.at(0,0), image="victoria_" + jGanador.getId() + ".png")
		ganador = jGanador
		game.addVisual(victoria)
		cantUnidadesMuertas = self.calcularUnidadesCaidas()
		game.schedule(2000, {
			game.allVisuals().filter{visual => !visual.esCasillaFija()}.forEach{ visual =>
				game.removeVisual(visual)
			}
			jugador1.getUnidades().clear()
			jugador2.getUnidades().clear()
			
			self.siguientePantalla()		
		} )
	}
	
	method siguientePantalla() {
		escenario.actualizarNivel()
		escenario.iniciarNivel()	
		return 0	
	}
	method calcularUnidadesCaidas() = 
		unidadesPorJugador - jugador1.getUnidades().size() + unidadesPorJugador - jugador2.getUnidades().size()
	
	method setearCasillasBase(internas, borde) {
		mapManager.getInternas().forEach{casilla => casilla.image(internas)}
		mapManager.getBordeLateral().forEach{
			casilla => casilla.image(internas)
		}	
		mapManager.getBordeCentral().forEach{
			casilla => casilla.image(borde)
		}			
	}
	method setearObjetos(posiciones, objetoImg) {
		posiciones.forEach{ pos =>
			var vida = new Visual(image="vidaObj_10.png", position=pos, esAtacable=true)
			var objeto = new Visual(image=objetoImg, position=pos, esAtacable=true, imagenVida=vida)
			game.addVisual(objeto)
			game.addVisual(vida)
		}
	}
	method setearCasillas(posiciones, objetoImg) { 
		posiciones.forEach{pos => 
			mapManager.accederAInterna(pos.x(),pos.y()).image(objetoImg)
		}
	}
}

object nivel1 inherits Nivel{	
	override method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel1_C.png")
		var posTorresRompibles = [game.at(23,1),game.at(23,7),game.at(23,9),game.at(23,15)]
		var posMurallasRompibles = [game.at(23,2),game.at(23,3),game.at(23,4),game.at(23,5),game.at(23,6),game.at(23,8),game.at(23,10),game.at(23,11),game.at(23,12),game.at(23,13),game.at(23,14)]
		
		self.setearCasillasBase("casillaPasto.png","casillaMontana.png")
		self.setearCasillas()
		self.setearObjetos(posTorresRompibles, "casillaTorreMadera.png")
		self.setearObjetos(posMurallasRompibles, "casillaMurallaMaderaVer.png")
		game.schedule(500, {
			game.addVisual(nivelImg)
		})
		game.schedule(650, {nivelImg.image("nivel1_B.png")})
		game.schedule(800, {nivelImg.image("nivel1_A.png")})
		game.schedule(2000, {
			game.removeVisual(nivelImg)
			self.tienda()
		})
	}
	
	method setearCasillas() {
		var posMurallasHor = [game.at(1,4),game.at(2,4),game.at(3,4),game.at(4,4),game.at(5,4),game.at(1,12),game.at(2,12),game.at(3,12),game.at(4,12),game.at(5,12)]
		var posMurallasVer = [game.at(6,5),game.at(6,11)]
		var posTorres = [game.at(6,4),game.at(6,6),game.at(6,12),game.at(6,10)]
		
		self.setearCasillas(posMurallasVer, "casillaMurallaVer.png")
		self.setearCasillas(posMurallasHor, "casillaMurallaHor.png")
		self.setearCasillas(posTorres, "casillaTorre.png")
		mapManager.accederABordes(0,4).image("casillaMurallaHor.png")
		mapManager.accederABordes(0,12).image("casillaMurallaHor.png")
	}
	
	method siguiente() = nivel2
}

object nivel2 inherits Nivel{	
	override method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel2_C.png")
		
		self.setearCasillasBase("casillaPasto.png","casillaTorre.png")
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


	}
	
	method siguiente() = nivel3
}

object nivel3 inherits Nivel{	
	override method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel3_C.png")
		
		self.setearCasillasBase("casillaTorre.png","casillaTorre.png")
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

	}

	override method siguientePantalla() {
		var pantallaFinal = new Visual(position=game.at(0,0),image="transparente.png")
		var cantUnidadesCaidasD1 = new Visual(position=game.at(24,8),image="transparente.png")
		var cantUnidadesCaidasD2 = new Visual(position=game.at(25,8),image="transparente.png")
		var ganadoresId = [ ganador, nivel1.getGanador(), nivel2.getGanador() ]
		var cantJ1Victorias = ganadoresId.filter{ganador => ganador.getId() == "J1"}.size()
		var cantJ2Victorias = ganadoresId.filter{ganador => ganador.getId() == "J2"}.size()
		var cantidadMuertos = cantUnidadesMuertas + nivel1.getCantUnidadesMuertas() + nivel2.getCantUnidadesMuertas()
		var digito1UnidadesMuertas = cantidadMuertos.div(10).toString()
		var digito2UnidadesMuertas = (cantidadMuertos % 10).toString()
				
		if(cantJ1Victorias > cantJ2Victorias) {pantallaFinal.image("langradigmas_gana.png")}
		else {pantallaFinal.image("duloc_gana.png")}
		
		cantUnidadesCaidasD1.image("caidas_" + digito1UnidadesMuertas + ".png")
		cantUnidadesCaidasD2.image("caidas_" + digito2UnidadesMuertas + ".png")
			
		game.addVisual(pantallaFinal)
		game.addVisual(cantUnidadesCaidasD1)
		game.addVisual(cantUnidadesCaidasD2)
		
		return 0
	}
	
	method siguiente() = null
}
