object error {
	const movimientoInvalido = [
		"Prudencia! hay enemigos por doquier",
		"¿En serio quieres que me mueva allí?",
		"No creo que sea una buena idea",
		"¿Acaso me consideras desechable?"
	]
	const ataqueInvalido = [
		"No puedo hacer eso",
		"¿Te parece apropiado hacer el ridículo en medio de una guerra?",
		"No tengo tiempo para juegos."
	]
	const sinUnidadSeleccionada = [
		"Primero debería seleccionar una unidad.",
		"No he seleccionado a nadie."
	]
	const conUnidadSeleccionada = [
		"Tienes una unidad seleccionada",
		"Pss, creo que estoy agarrando a alguien"
	]
	const especialEnCooldown = [
		"¡Aún no es el momento!",
		"No puedo aún, ¿Podrías tranquilizarte?",
		"¿Quién programo mi habilidad especial? ¡LE PUSO COOLDOWN!",
		"Yep, sigo con cooldown.",
		"Piensalo: si no tuviese cooldown, sería fácil ¿verdad?"
	]
	const carritoVacio = [
		"No puedes vender unidades que todavía no compraste.",
		"Comienza comprando unidades antes de venderlas.",
		"¿Intentas venderme aire? ¡compra algo!"
	]
	const carritoLleno = [
		"¡Tu carrito está lleno! no puedes comprar mas de ",
		"No puedes comprar mas de ",
		"Por persona sólo ",
		"Por mas que seas el mas débil de los jugadores, sólo llevarás "
	]
	const seleccionarDespuesComprar = [
		"Es simple: primero selecciona una unidad, luego la compras.",
		"¿Qué dice la primer línea de las instrucciones de abajo?"
	]
	const carritoSinLlenar = [
		"Todavía puedes comprar mas unidades",
		"Es obligatorio comprar mas unidades",
		"¿En serio vas a comenzar con desventaja? ¡compra mas unidades!",
		"Es una orden: ve y compra mas unidades",
		"No voy a dejar que te vayas si no terminas de comprar todas tus unidades",
		"Es peligroso salir sin un ejército completo",
		"¡Te harán trizas! termina de comprar"
	]
	
	method msgmovimientoInvalido() = movimientoInvalido.anyOne()
	method msgAtaqueInvalido() = ataqueInvalido.anyOne()
	method msgSinUnidadSeleccionada() = sinUnidadSeleccionada.anyOne()
	method msgConUnidadSeleccionada() = conUnidadSeleccionada.anyOne()
	method msgEspecialEnCooldown() = especialEnCooldown.anyOne()
	method msgCarritoVacio() = carritoVacio.anyOne()
	method msgCarritoLleno(cantidadMax) = carritoLleno.anyOne() + cantidadMax.toString() + " unidades"
	method msgSeleccionarDespuesComprar() = seleccionarDespuesComprar.anyOne()
	method msgCarritoSinLlenar() = carritoSinLlenar.anyOne()
}

object comentario {
	
	
}
