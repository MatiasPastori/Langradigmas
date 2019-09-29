import wollok.game.*
import escenario.*
import cursor.*
import distancia.*

class Arquero {
	const comandante
	const rangoDeAccion = 50
	var puedeMoverse = true // Recordar hacer puedeMoverse = true al finalizar CADA TURNO
	var property vida = 10
	
	const nivelAtaque = 22
	const nivelDefensa = 14
	
	var property position
	var property image
	
	method esSeleccionable() = true
	
	method mover(new_position) {
		position = game.at(new_position.x(), new_position.y())
		puedeMoverse = false
	}
	
	method combatir(enemigo) {
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
		// Aca va la logica del combate. El resultado afecta tanto al atacante como al atacado
		// Ambos pueden morir / ambos pueden ser dañados
		// Tambien se calcula el daño que hara con respecto a las bonificaciones de terreno, etc
	
	method puedeLlegar(movimientosNecesarios) = movimientosNecesarios <= rangoDeAccion && puedeMoverse

	method bufoPorCercaniaDeAtaque() {
		var distanciaAlComandante = new Distancia(position =self.position() )
		if(distanciaAlComandante.distanciaA(comandante.position())<3){
			return comandante.buffDeAtaque()
		}else return 0
	}
	method bufoPorCercaniaDeDefensa() {
		var distanciaAlComandante = new Distancia(position =self.position() )
		if(distanciaAlComandante.distanciaA(comandante.position())<3){
			return comandante.buffDeDefensa()
		}else return 0
	}
	
	
	method nivelAtaque() = nivelAtaque + self.bufoPorCercaniaDeAtaque()
	
	method nivelDefensa() = nivelDefensa + self.bufoPorCercaniaDeDefensa()

}
																				