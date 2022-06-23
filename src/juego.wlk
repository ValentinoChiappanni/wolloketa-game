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
	
	const property messi = new JugadorPrincipal (position=game.at(9,6), image="messi_colo.png")
	const property neymar = new JugadorPrincipal (position=game.at(7,6), image="neymar.png")
	
	var jugadorActivo = messi
	
	const arcoBra = new Arco(position=game.at(0,5), nacionalidad= brasilero)
	const arcoBra2 = new Arco(position=game.at(0,6), nacionalidad= brasilero)
	
	const arcoArg = new Arco(position=game.at(16,5), nacionalidad= argentino)
	const arcoArg2 = new Arco(position=game.at(16,6), nacionalidad= argentino)
	
	const arcos = [arcoBra, arcoBra2, arcoArg, arcoArg2]
	
	method configuraciones(){
		game.height(12)
		game.width(17)
		game.title("Mundialito 2022")
		game.boardGround("ground.png")
		
		const hinchada = game.sound("AudioFondo.mp3")
	    hinchada.shouldLoop(true)
	    game.schedule(500, { hinchada.play()} )
	    
		self.iniciarJuego()
	
	}
	
	method crearJugador(nombre, position, nacionalidad){
		return new JugadorGenerico(nombre= nombre, position= position, nacionalidad= nacionalidad)
	}
	
	method iniciarJuego(){
		game.addVisual(arcoBra)
		game.addVisual(arcoArg)
		game.addVisual(arcoBra2)
		game.addVisual(arcoArg2)
		game.addVisual(messi)
		game.addVisual(neymar)
		game.addVisual(pelota)
		seleccionArgentina.forEach({x=>game.addVisualCharacter(x)})
		seleccionBrasil.forEach({x=>game.addVisualCharacter(x)})
		game.addVisual(arquero1)
		game.addVisual(arquero2)
		
		//Metodo movimiento
		game.onTick(1000, "el meneaito", { => 
			arquero1.moverseOpuesto()
			arquero2.moverseOpuesto()
		})
		
		keyboard.w().onPressDo { jugadorActivo.moverUnoArriba() }
		keyboard.s().onPressDo { jugadorActivo.moverUnoAbajo() }
		keyboard.a().onPressDo { jugadorActivo.moverUnoIzquierda() }
		keyboard.d().onPressDo { jugadorActivo.moverUnoDerecha() }
		keyboard.space().onPressDo { jugadorActivo.patearPelota() }
		
		//Cambiar jugador
		keyboard.j().onPressDo { if (jugadorActivo == messi){jugadorActivo = neymar}else{jugadorActivo=messi} }
		
		// Cambiar esto
		game.whenCollideDo(pelota, { jugador => if(jugador == messi or jugador == neymar)
												{pelota.serLlevadaPor(jugador)}
												if(seleccionBrasil.contains(jugador) || seleccionArgentina.contains(jugador)) 
												{ jugador.pasarPelotaAJugadorEstrella() }
		})
		
		// Gol -- Falta game.clear()
		
		game.onCollideDo(pelota, { algo => if(arcos.contains(algo)) {pelota.entrarAlArco(algo) }})
										   
		}

	}
