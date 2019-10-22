import wollok.game.*
import utilidades.visuals.*

class Casilla {
	var property position
	var property image = "transparente.png"
	
	var property objeto = null
	var property esAtacable = false
	
	method esSeleccionable() = false
	method esCasillaFija() = true
	method ponerObjetoVacio() { objeto = new Visual(position = game.center(), image="transparente.png") }
}

object mapManager {
	const ancho = game.width()
    const alto = game.height()
	var internas = []
	var bordeLateral = []
	var bordeCentral = []
	
	method getBorde() = bordeLateral + bordeCentral
	method getBordeLateral() = bordeLateral
	method getBordeCentral() = bordeCentral
	method getInternas() = internas
	
	method generarCasillas() {
		var eje_x = [] // casillas internas
		(ancho-2).times({ 
			i =>
			var eje_y = []
			(alto-2).times({ 
				j =>
				var casilla = new Casilla(position = game.at(i, j))
				game.addVisual(casilla)
				eje_y.add(casilla)
			})
			eje_x.add(eje_y)
		})
		internas = eje_x.flatten()
	}
	method accederAInterna(_x, _y) = internas.find{casilla => casilla.position() == game.at(_x,_y)}
	method estaEnInternas(posicionCursor) = !internas.filter{myPos => myPos.position() == posicionCursor}.isEmpty()

	method generarBordes() {
		var posCasillasLaterales = []
		var posCasillasCentrales = []
			(0 .. ancho-1).forEach{ i => posCasillasCentrales.add(new Position(x=i, y=0)) } // borde abajo
			(0 .. ancho-1).forEach{ i => posCasillasCentrales.add(new Position(x=i, y=alto-1)) } // borde arriba
			(1 .. alto-2).forEach{ i => posCasillasLaterales.add(new Position(x=0, y=i)) } // borde izquierdo
			(1 .. alto-2).forEach{ i => posCasillasLaterales.add(new Position(x=ancho-1, y=i)) } // borde derecho
			
			posCasillasLaterales.forEach { posicion => 
				var casilla = new Casilla(position = posicion)
				game.addVisual(casilla)
				bordeLateral.add(casilla)	
			}
			posCasillasCentrales.forEach { posicion => 
				var casilla = new Casilla(position = posicion)
				game.addVisual(casilla)
				bordeCentral.add(casilla)	
			}
		}
	method accederABordes(_x,_y) = self.getBorde().find{casilla => casilla.position() == game.at(_x,_y)}	
}




















