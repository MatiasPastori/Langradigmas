import wollok.game.*

class Comandante {
	const rangoDeAccion = 50
	var vida = 10
	var puedeMoverse = true // Recordar hacer puedeMoverse = true al finalizar CADA TURNO
	var puedeAtacar = true  // Recordar hacer puedeAtacar = true al finalizar CADA TURNO
	
	var buffAtaque
	var buffDefensa
	var nivelAtaque
	var nivelDefensa
	
	var property position
	var property image
	
	method esSeleccionable() = true
	
	method mover(new_position) {
		position = game.at(new_position.x(),new_position.y())
		puedeMoverse = false
		
//		var n_p_x = (new_position.x() - position.x()).limitBetween(-movimientos, movimientos)
//		var n_p_y = (new_position.y() - position.y()).limitBetween(-movimientos, movimientos)
//
//		position = game.at(position.x() + n_p_x, position.y() + n_p_y)
	}
	
	method combatir(enemigo){
		var danio 
				if((self.nivelAtaque() - enemigo.nivelAtaque())>1 && (self.nivelDefensa() - enemigo.nivelDefensa())>1){
					danio = 6.randomUpTo(10).truncate(0)
				}else if((self.nivelAtaque() - enemigo.nivelAtaque())<1 && (self.nivelDefensa() - enemigo.nivelDefensa())>1){
					danio = 1.randomUpTo(3).truncate(0)
				}else if((self.nivelAtaque() - enemigo.nivelAtaque())>1 && (self.nivelDefensa() - enemigo.nivelDefensa())<1){
					danio = (self.nivelAtaque() - enemigo.nivelDefensa()).abs().randomUpTo(4).truncate(0)
				}else{ danio = 0.randomUpTo(2).truncate(0)}
				enemigo.vida(-danio) 
				enemigo.combatir(self)
		}
	
	method nivelAtaque() = nivelAtaque
	
	method nivelDefensa() = nivelDefensa 
	
	method buffDeAtaque() = buffAtaque
	method buffDeDefensa() = buffDefensa
	
	method puedeLlegar(movimientosNecesarios) = movimientosNecesarios <= rangoDeAccion && puedeMoverse
}
