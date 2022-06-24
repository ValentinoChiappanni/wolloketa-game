import wollok.game.*
import jugadores.*

object juego{
	const jugadorArg1= self.crearJugador("Arg1", game.at(10,2), argentino)
	const jugadorArg2= self.crearJugador("Arg2", game.at(10,9), argentino)
	const jugadorArg3= self.crearJugador("Arg3", game.at(12,6), argentino)
	const jugadorBra1= self.crearJugador("Bra1", game.at(6,2), brasilero)
	const jugadorBra2= self.crearJugador("Bra2", game.at(6,9), brasilero)
	const jugadorBra3= self.crearJugador("Bra3", game.at(4,6), brasilero)
	const seleccionArgentina= [jugadorArg1, jugadorArg2,jugadorArg3]
	const seleccionBrasil= [ jugadorBra1,  jugadorBra2,  jugadorBra3]
	
	const arquero1= new Arquero(nombre= "Willy", position= game.at(15,6), nacionalidad= argentino)
	const arquero2= new Arquero(nombre= "Pele", position= game.at(1,6), nacionalidad= brasilero)
	
	const property arcoBra = new Arco(position=game.at(0,5), nacionalidad= brasilero)
	const arcoBra2 = new Arco(position=game.at(0,6), nacionalidad= brasilero)
	
	const property arcoArg = new Arco(position=game.at(16,5), nacionalidad= argentino)
	const arcoArg2 = new Arco(position=game.at(16,6), nacionalidad= argentino)
	
	const arcos = [arcoBra, arcoBra2, arcoArg, arcoArg2]
	
	const property messi = new JugadorPrincipal (position=game.at(9,6), image="messi_colo.png", nacionalidad = argentino)
	const property neymar = new JugadorPrincipal (position=game.at(7,6), image="neymar.png", nacionalidad = brasilero)
	
	var jugadorActivo = messi
	var jugadorAutom = neymar
	
	
	
	method crearJugador(nombre, position, nacionalidad){
		return new JugadorGenerico(nombre= nombre, position= position, nacionalidad= nacionalidad)
	}
	method esGenerico(jugador) = seleccionBrasil.contains(jugador) || seleccionArgentina.contains(jugador)
	method esPrincipal(jugador) = jugador == messi || jugador == neymar
	
 	method configuraciones(){
		//Tablero
		game.height(12)
		game.width(17)
		game.title("Mundialito 2022")
		game.boardGround("ground.png")
		
		//Sonido
		const hinchada = game.sound("AudioFondo.mp3")
	    hinchada.shouldLoop(true)
	    keyboard.plusKey().onPressDo({hinchada.volume(1)})
		keyboard.minusKey().onPressDo({hinchada.volume(0.5)})
		keyboard.slash().onPressDo({hinchada.volume(0)})
	    game.schedule(500, { hinchada.play()} )
	    
	    //Agregar visuales y demás
		self.iniciarJuego()
	
	}
	
	method iniciarJuego(){
		//Visuales
		game.addVisual(arcoBra)
		game.addVisual(arcoArg)
		game.addVisual(arcoBra2)
		game.addVisual(arcoArg2)
		game.addVisual(messi)
		game.addVisual(neymar)
		game.addVisual(pelota)
		seleccionArgentina.forEach({x=>game.addVisual(x)})
		seleccionBrasil.forEach({x=>game.addVisual(x)})
		game.addVisual(arquero1)
		game.addVisual(arquero2)
		
		// Gol -- Falta game.clear()
		
		game.onCollideDo(pelota, { algo => if(arcos.contains(algo)) {pelota.entrarAlArco(algo) }})
		
		//Movimiento arqueros
		game.onTick(1000, "el meneaito", { => 
			arquero1.moverseOpuesto()
			arquero2.moverseOpuesto()
		})
		
		//Movimiento jugador activo
		keyboard.w().onPressDo { jugadorActivo.moverUnoArriba() }
		keyboard.s().onPressDo { jugadorActivo.moverUnoAbajo() }
		keyboard.a().onPressDo { jugadorActivo.moverUnoIzquierda() }
		keyboard.d().onPressDo { jugadorActivo.moverUnoDerecha() }
		keyboard.space().onPressDo { jugadorActivo.patearPelota() }
		
		//Cambiar jugador
		keyboard.j().onPressDo { if (jugadorActivo == messi){
									jugadorActivo = neymar
									jugadorAutom = messi
									//neymar.esElActivo(true)
									//messi.esElActivo(false)
								}else {
									jugadorActivo=messi
									jugadorAutom = neymar
									//messi.esElActivo(true)
									//neymar.esElActivo(false)
								}
		}
		
		game.whenCollideDo(pelota, { jugador => if(self.esPrincipal(jugador)) {pelota.serLlevadaPor(jugador)}
												if(self.esGenerico(jugador)) { jugador.pasarPelotaAJugadorEstrella() }
		})
		
		game.onTick(1000, "movimiento", {if(jugadorAutom.tieneLaPelota()) jugadorAutom.seVaHaciaElGol()})
	}

}
