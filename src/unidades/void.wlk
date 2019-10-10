object void {
	var property position
	var property image
	var property imagenVida 
	var property nivelAtaque
	var property nivelDefensa
	
	method puedeAtacar() = false
	method puedeAtacar(x) {}
	method puedeMoverse() = false
	method puedeMoverse(x) {}
 	method esSeleccionable() = false
	method buffAtaque() {}
	method buffDefensa() {}	
	method getVida() {}
	method mover(nuevaPos) {}
	method puedeLlegar(rangoNecesario) {}
	method combatir(enemigo) {}
	method recibirDanio(danio) {}
	method chequearMuerte() {}
	method morir() {}
	method cambiarSprite(accion) {} 
	method buffAtaquePorComandanteCerca() {} 
	method buffDefensaPorComandanteCerca() {} 
	method buff(bloque) {} 
	method serReclutado(unComandante) {} 
}
