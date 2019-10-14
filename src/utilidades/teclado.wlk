import wollok.game.*
import inicio.*
import escenario.escenario.*
import escenario.tienda.*
import unidades.guerrero.*
import unidades.tirador.*
import unidades.caballeria.*
import turnos.*

import escenario.casillas.*
import cursor.*
import jugadores.*

object teclado {
	method setearTeclasMovimiento(cursor) {
		keyboard.up().onPressDo    { self.mover(arriba, cursor)}
		keyboard.down().onPressDo  { self.mover(abajo, cursor)}
		keyboard.left().onPressDo  { self.mover(izquierda, cursor)}
		keyboard.right().onPressDo { self.mover(derecha, cursor)}
	}
	method mover(direccion, cursor) { cursor.position(direccion.siguiente(cursor.position())) }
	method setearTeclasAccion(cursor) {
		keyboard.s().onPressDo { cursor.seleccionar() }	
		keyboard.a().onPressDo { cursor.atacar() }	
		keyboard.d().onPressDo { cursor.atacarEspecial() }
		
		keyboard.t().onPressDo { game.say(cursor,jugador1.getUnidades().size().toString()) }
	}
	method setearTeclasTienda() {
		keyboard.k().onPressDo {if(tienda.habilitada()) tienda.terminarCompra()}
		keyboard.y().onPressDo {if(tienda.habilitada()) tienda.comprar()}
		keyboard.n().onPressDo {if(tienda.habilitada()) tienda.vender()} 
		keyboard.num(1).onPressDo {
			if(tienda.habilitada()) {
				tienda.unidadAComprar(new Guerrero(position = game.at(1,1), image = "transparente.png", jugadorDuenio = tienda.jugadorActual(), tipo = "guerrero", comandante = tienda.jugadorActual().getUnidades().head(), rangoDeAccion = 50, nivelAtaque = 24, nivelDefensa = 20))
				tienda.getGuerreroJug().image("guerrero"+ tienda.jugadorActual().getId() + "iddle1.png")
				tienda.getTiradorJug().image("tirador"+ tienda.jugadorActual().getId() + "gris.png")
				tienda.getCaballeroJug().image("caballeria" + tienda.jugadorActual().getId() + "gris.png")
		}}
		keyboard.num(2).onPressDo {
			if(tienda.habilitada()) {
				tienda.unidadAComprar(new Tirador(position = game.at(2,2), image = "transparente.png", jugadorDuenio = tienda.jugadorActual(), tipo = "tirador", comandante = tienda.jugadorActual().getUnidades().head(), rangoDeAccion = 50, nivelAtaque = 24, nivelDefensa = 20))
				tienda.getGuerreroJug().image("guerrero"+ tienda.jugadorActual().getId() + "gris.png")
				tienda.getTiradorJug().image("tirador"+ tienda.jugadorActual().getId() + "iddle1.png")
				tienda.getCaballeroJug().image("caballeria" + tienda.jugadorActual().getId() + "gris.png")
			}
		}
		keyboard.num(3).onPressDo {
			if(tienda.habilitada()) {
				tienda.unidadAComprar(new Caballeria(position = game.at(3,3), image = "transparente.png", jugadorDuenio = tienda.jugadorActual(), tipo = "caballeria", comandante = tienda.jugadorActual().getUnidades().head(), rangoDeAccion = 50, nivelAtaque = 24, nivelDefensa = 20))
				tienda.getGuerreroJug().image("guerrero"+ tienda.jugadorActual().getId() + "gris.png")
				tienda.getTiradorJug().image("tirador"+ tienda.jugadorActual().getId() + "gris.png")
				tienda.getCaballeroJug().image("caballeria" + tienda.jugadorActual().getId() + "iddle1.png")
			}
		}
	}
	method setearTeclasTurno() {keyboard.enter().onPressDo { 
		if (turnoManager.habilitado()) {
			if(cursor.unidad() != null) {
				cursor.error("Tienes una unidad seleccionada!")
			}
			turnoManager.finalizarTurno()
		}
	}}
	method setearTeclaInicio() {keyboard.enter().onPressDo { 
		if (inicio.inicioHabilitado()) {
			inicio.inicioHabilitado(false)
			game.removeVisual(inicio.getInicioVisual())
			escenario.iniciar()	
		}
	}}
}

object izquierda { method siguiente(position) = position.left(1) }

object derecha { method siguiente(position) = position.right(1) }

object abajo { method siguiente(position) = position.down(1) }

object arriba { method siguiente(position) = position.up(1) }

