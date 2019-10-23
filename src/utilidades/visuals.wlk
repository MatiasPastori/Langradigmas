import wollok.game.*

class Visual {
	var property image
	var property position
	
	method esSeleccionable() = false
	method esCasillaFija() = false
	method esObjetoGrande() = false
	method esAtacable() = false
}
// Se usa para instanciar algunas imágenes como los personajes que aparecen en la tienda
