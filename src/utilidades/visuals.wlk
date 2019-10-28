import wollok.game.*

/*
 	Se utiliza para instanciar objetos cuyo único propósito es visual y no deben interactuar con el juego.
*/

class Visual {
	var property image
	var property position
	
	method esSeleccionable() = false
	method esCasillaFija() = false
	method esObjetoGrande() = false
	method esAtacable() = false
}