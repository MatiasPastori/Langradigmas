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
		"Piensalo: si no tuviese cooldown, sería fácil, ¿verdad?"
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
	const inicioNivelJ1comandante = [
		"Un clan está unido por el acero, no por la sangre.",
		"Los que gobiernan mediante el miedo sólo conservan el poder si a sus súbditos les falta valor.",
		"Ataquen, ¡ATAQUEN!",
		"El Sol Eterno nos guía."
	]
	const inicioNivelJ2comandante = [
		"Nuestras unidades se ven mas atractivas, ¿verdad?",
		"Ataquen, ¡ATAQUEN!",
		"¿Creen que pueden con nosotros? ¿En serio?",
		"El juicio final está cerca."
	]	
	const inicioNivelJ1subordinados = [
		"¡A la batalla!",
		"¡Por nuestra nación!",
		"¡Por la luz!",
		"¡Marcha con dignidad!",
		"¡AAAAAAAAH!"
	]
	const inicioNivelJ2subordinados = [
		"Tu corazón... Su constante palpitar, ¡me da asco! Lo acallaré, como hice con el mío.",
		"¡Por la oscuridad!",
		"Esperé tanto tiempo este momento",
		"Conviértete a la oscuridad.",
		"ME PINTARÉ EL ROSTRO CON VUESTRA SANGRE."
	]
	const inicioTurnoJ1 = [
		"¡Un trabajo excelente! Emm, ¿puedo escaparme ya?",
		"La muerte se acerca...",
		"La oscuridad se acabará.",
		"Buscaré a mis enemigos... ¡Y pobre de aquellos que se me opongan!"
	]
	const inicioTurnoJ2 = [
		"El asesinato nunca pasa de moda.",
		"Si he de morir, os llevaré a todos conmigo, ¡MI DESTINO ES MIO!",
		"La clemencia es para los débiles...",
		"Me vendría bien un corazón... Digamos... ¿el tuyo?"
	]
	const victoriaJ1 = [
		"Por fin, ha pagado por las atrocidades cometidas contra mi pueblo.",
		"victoria, ¡VICTORIA!",
		"Podré volver a mi pueblo, con mi familia.",
		"¡Jugaste... y perdiste!"
	]
	const victoriaJ2 = [
		"Fácil, tal y como lo esperaba.",
		"¿Y ahora qué héroe?",
		"El Infierno nos espera con la mesa servida.",
		"¡Jugaste... y perdiste!"
	]
 	const derrotaJ1 = [
		"La luz es vida; de ella todos provenimos y a ella todos regresamos",
		"¡Mi comandante!",
		"Y ahora... ¿qué será de nosotros?"
	]
	const derrotaJ2 = [
		"No es posible, ¡NO!",
		"No era tan fuerte al final.",
		"De todas maneras nos volveremos a ver en el Infierno."
	]
	const randomsJ1 = [
		"¿Hola? ¿Hay alguien ahí?",
		"Lo único que siempre he querido es estudiar.",
		"Mi familia me espera",
		"Hacer lo mismo una y otra vez y esperar diferentes resultados es una LOCURA...",
		"Tengo intención de vivir eternamente",
		"Me hubiese gustado hacer el otro juego."
	]
	const randomsJ2 = [
		"¿Hola? ¿Hay alguien ahí?",
		"Allí abajo no eran tan divertido.",
		"Los espíritus están inquietos.",
		"Pero buenas noticias amigos, me ha dejado moco... que no es poco.",
		"Me hubiese gustado hacer el otro juego.",
		"Alguien que me recuerde por qué me apunté para esto"
	]
	
	method msgInicioNivelJ1comandante() = inicioNivelJ1comandante.anyOne()
	method msgInicioNivelJ2comandante() = inicioNivelJ2comandante.anyOne()
	method msgInicioNivelJ1subordinados() = inicioNivelJ1subordinados.anyOne()
	method msgInicioNivelJ2subordinados() = inicioNivelJ2subordinados.anyOne()
	method msgInicioTurnoJ1() = inicioTurnoJ1.anyOne()
	method msgInicioTurnoJ2() = inicioTurnoJ2.anyOne()
	method msgVictoriaJ1() = victoriaJ1.anyOne()
	method msgVictoriaJ2() = victoriaJ2.anyOne()
	method msgderrotaJ1() = derrotaJ1.anyOne()
	method msgderrotaJ2() = derrotaJ2.anyOne()
	method msgRandomsJ1() = randomsJ1.anyOne()
	method msgRandomsJ2() = randomsJ2.anyOne()
	
}
