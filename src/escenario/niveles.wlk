import wollok.game.*
import escenario.escenario.*
import escenario.casillas.*
import escenario.objetosEnCasillas.*
import escenario.tienda.*
import unidades.comandante.*
import utilidades.acciones.*
import utilidades.visuals.*
import utilidades.comentarios.*
import jugadores.*
import turnos.*
import cursor.*

// Clase abstracta, es utilizada por los objetos niveles
class Nivel {
	const tiendaImg = new Visual(position = game.at(0,0), image = "tienda.png")
	const unidadesPorJugador = 11
	var ganador
	var cantUnidadesMuertas = 0
	
	method getGanador() = ganador
	method getCantUnidadesMuertas() = cantUnidadesMuertas
	
	method generarNivel()
	method tienda() {
		var comandanteJ1 = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador1, tipo = "comandante", idUnico=1, rangoDeAccion = 3, rangoEspecial = 8, vida = 10, nivelAtaque = 28, nivelDefensa = 25)
		var comandanteJ2 = new Comandante(position = game.center(), image = "transparente.png", jugadorDuenio = jugador2, tipo = "comandante", idUnico=2,rangoDeAccion = 3, rangoEspecial = 8, vida = 10, nivelAtaque = 28, nivelDefensa = 25)
		
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
		turnoManager.setJugadorActual(jugador1)
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
		self.agregarUnidadesEnCampo(jugador1)
		self.agregarUnidadesEnCampo(jugador2)			
	}
	method agregarUnidadesEnCampo(jugador) {
		jugador.getUnidades().forEach{ unidad => 
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
		mapManager.getInternas().forEach{casilla => casilla.image(internas.anyOne())}
		mapManager.getBordeLateral().forEach{
			casilla => casilla.image(internas.anyOne())
		}	
		mapManager.getBordeCentral().forEach{
			casilla => casilla.image(borde)
		}			
	}
	method setearObjetosDeCasillas(posiciones, objeto) { 
		posiciones.forEach{pos => 
			var casilla = mapManager.accederAInterna(pos)
			casilla.objeto(new ObjetoCasilla(tipo=objeto, position=pos))
			game.addVisual(casilla.objeto())
		}
	}
}

object nivel1 inherits Nivel{	
	override method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel1_C.png")

		self.setearCasillasBase(["casillaPasto.png"],"casillaMontana.png")
		self.setearCasillas()
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
		var pisoCastillo = [game.at(0,11),game.at(1,11),game.at(2,11),game.at(3,11),game.at(4,11),game.at(5,11),game.at(0,10),game.at(1,10),game.at(2,10),game.at(3,10),game.at(4,10),game.at(5,10),game.at(0,9),game.at(1,9),game.at(2,9),game.at(3,9),game.at(4,9),game.at(5,9),game.at(6,9),game.at(0,8),game.at(1,8),game.at(2,8),game.at(3,8),game.at(4,8),game.at(5,8),game.at(6,8),game.at(0,7),game.at(1,7),game.at(2,7),game.at(3,7),game.at(4,7),game.at(5,7),game.at(6,7),game.at(0,6),game.at(1,6),game.at(2,6),game.at(3,6),game.at(4,6),game.at(5,6),game.at(0,5),game.at(1,5),game.at(2,5),game.at(3,5),game.at(4,5),game.at(5,5)]
		var casitas = [game.at(12,14),game.at(12,13),game.at(11,14),game.at(11,13),game.at(12,12),game.at(14,13),game.at(13,4),game.at(12,3),game.at(10,3),game.at(5,2)]
		var arbolitos = [game.at(13,13),game.at(18,4),game.at(27,13),game.at(26,13),game.at(24,11),game.at(23,6),game.at(23,5),game.at(25,4),game.at(12,4),game.at(17,9)]
		var montanias = [game.at(20,12),game.at(20,13),game.at(18,14),game.at(18,5),game.at(17,4),game.at(17,3),game.at(19,13)]		
		var borde1 = mapManager.accederABordes(0,4)
		var borde2 = mapManager.accederABordes(0,12)
		
		self.setearObjetosDeCasillas(posMurallasVer, murallaVertical)
		self.setearObjetosDeCasillas(posMurallasHor, murallaHorizontal)
		self.setearObjetosDeCasillas(posTorres, torre)
		self.setearObjetosDeCasillas(pisoCastillo, pisoRombo)
		self.setearObjetosDeCasillas(casitas, casas)
		self.setearObjetosDeCasillas(arbolitos, arboles)
		self.setearObjetosDeCasillas(montanias, montania)
		// Setear dos objetos en bordes, no puedo usar el método de arriba
		borde1.objeto(new ObjetoCasilla(tipo=murallaHorizontal, position=borde1.position()))
		borde2.objeto(new ObjetoCasilla(tipo=murallaHorizontal, position=borde2.position()))
		game.addVisual(borde1.objeto())
		game.addVisual(borde2.objeto())
	}
	
	method siguiente() = nivel2
}

object nivel2 inherits Nivel{	
	override method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel2_C.png")
		
		self.setearCasillasBase(["casillaPiedritas.png"],"casillaBosqueDenso.png")
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
		var posRioVertical = [game.at(17,1),game.at(17,2),game.at(17,3),game.at(15,5),game.at(15,6),game.at(15,7),game.at(15,8),game.at(15,9),game.at(15,10),game.at(15,11),game.at(13,13),game.at(13,14),game.at(13,15)]
		var posRioHorizontal = [game.at(16,4),game.at(14,12)]
		var posGiro1 = [game.at(17,4),game.at(15,12)]
		var posGiro3 = [game.at(15,4),game.at(13,12)]
		var posMurallasH = [game.at(11,3),game.at(13,5),game.at(14,5),game.at(15,5),game.at(16,5),game.at(17,5),game.at(19,3),game.at(11,1),game.at(12,1),game.at(13,1),game.at(14,1),game.at(15,1),game.at(16,1),game.at(17,1),game.at(18,1),game.at(19,1)]
		var posMurallasV = [game.at(12,4),game.at(18,4),game.at(20,2),game.at(10,2)]
		var posTorres = [game.at(10,1),game.at(10,3),game.at(12,5),game.at(12,3),game.at(18,5),game.at(18,3),game.at(20,3),game.at(20,1)]
		var casitas = [game.at(5,3),game.at(7,2),game.at(7,3)]
		var casitas2 = [game.at(23,3),game.at(23,2),game.at(24,5)]
		var arbolillos = [game.at(4,13),game.at(5,13),game.at(8,11),game.at(6,13),game.at(7,13),game.at(7,12),game.at(6,12),game.at(7,11),game.at(6,11),game.at(18,13),game.at(19,14),game.at(22,12),game.at(20,14),game.at(21,14),game.at(21,13),game.at(20,13),game.at(21,12),game.at(20,12),game.at(24,3),game.at(23,4),game.at(7,4),game.at(6,3)]
		
		self.setearObjetosDeCasillas(posRioVertical, rioVertical)
		self.setearObjetosDeCasillas(posRioHorizontal, rioHorizontal)
		self.setearObjetosDeCasillas(posGiro1, rioGiro1)
		self.setearObjetosDeCasillas(posGiro3, rioGiro3)
		self.setearObjetosDeCasillas(posMurallasH, murallaHorizontal)
		self.setearObjetosDeCasillas(posMurallasV, murallaVertical)
		self.setearObjetosDeCasillas(posTorres, torre)
		self.setearObjetosDeCasillas(casitas, casas)
		self.setearObjetosDeCasillas(casitas2, casas2)
		self.setearObjetosDeCasillas(arbolillos, arboles)
	}
	
	method siguiente() = nivel3
}

object nivel3 inherits Nivel{	
	override method generarNivel() {
		var nivelImg = new Visual(position = game.at(0,0), image = "nivel3_C.png")
		var internas = ["casillaArenaTurbia.png","casillaArenaTurbia2.png","casillaArenaTurbia3.png","casillaArenaTurbia4.png"]
		
		self.setearCasillasBase(internas,"casillaMontana2.png")
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
		var posMurallasHor = [game.at(game.width()-2,4),game.at(game.width()-3,4),game.at(game.width()-4,4),game.at(game.width()-5,4),game.at(game.width()-6,4),game.at(game.width()-2,12),game.at(game.width()-3,12),game.at(game.width()-4,12),game.at(game.width()-5,12),game.at(game.width()-6,12)]
		var posMurallasVer = [game.at(game.width()-7,5),game.at(game.width()-7,11)]
		var posTorres = [game.at(game.width()-7,4),game.at(game.width()-7,6),game.at(game.width()-7,12),game.at(game.width()-7,10)]
		var pisoCastillo = [game.at(25,11),game.at(30,11),game.at(29,11),game.at(28,11),game.at(27,11),game.at(26,11),game.at(25,10),game.at(30,10),game.at(29,10),game.at(28,10),game.at(27,10),game.at(26,10),game.at(24,9),game.at(30,9),game.at(29,9),game.at(28,9),game.at(27,9),game.at(26,9),game.at(25,9),game.at(24,8),game.at(30,8),game.at(29,8),game.at(28,8),game.at(27,8),game.at(26,8),game.at(25,8),game.at(24,7),game.at(30,7),game.at(29,7),game.at(28,7),game.at(27,7),game.at(26,7),game.at(25,7),game.at(25,6),game.at(30,6),game.at(29,6),game.at(28,6),game.at(27,6),game.at(26,6),game.at(25,5),game.at(30,5),game.at(29,5),game.at(28,5),game.at(27,5),game.at(26,5)]
		var casitas = [game.at(19,14),game.at(19,13),game.at(20,14),game.at(20,13),game.at(19,12),game.at(17,13),game.at(18,4),game.at(19,3),game.at(21,3),game.at(26,2)]
		var arbolitos = [game.at(18,13),game.at(13,4),game.at(4,13),game.at(5,13),game.at(7,11),game.at(8,6),game.at(8,5),game.at(6,4),game.at(19,4),game.at(14,9)]
		var montanias = [game.at(11,12),game.at(11,13),game.at(13,14),game.at(13,5),game.at(14,4),game.at(14,3),game.at(12,13)]
		var borde1 = mapManager.accederABordes(game.width()-1,4)
		var borde2 = mapManager.accederABordes(game.width()-1,12)
				
		self.setearObjetosDeCasillas(posMurallasVer, murallaVertical2)
		self.setearObjetosDeCasillas(posMurallasHor, murallaHorizontal2)
		self.setearObjetosDeCasillas(posTorres, torre2)
		self.setearObjetosDeCasillas(pisoCastillo, pisoPiedraRoja)
		self.setearObjetosDeCasillas(casitas, casas2)
		self.setearObjetosDeCasillas(arbolitos, arboles2)
		self.setearObjetosDeCasillas(montanias, montania2)
		// Setear dos objetos en bordes, no puedo usar el método de arriba
		borde1.objeto(new ObjetoCasilla(tipo=murallaHorizontal2, position=borde1.position()))
		borde2.objeto(new ObjetoCasilla(tipo=murallaHorizontal2, position=borde2.position()))
		game.addVisual(borde1.objeto())
		game.addVisual(borde2.objeto())
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
