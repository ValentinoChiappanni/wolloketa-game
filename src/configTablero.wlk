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
	const arquero1= new Arquero(nombre= "Willy", position= game.at(15,5), nacionalidad= argentino)
	const arquero2= new Arquero(nombre= "Pele", position= game.at(1,6), nacionalidad= brasilero)
	
	method configuraciones(){
		game.height(12)
		game.width(17)
		game.title("Mundialhaksjaks 2022")
		game.boardGround("ground.png")
		game.addVisualCharacter(messi)
		game.addVisualCharacter(neymar)
		game.addVisual(pelota)
		seleccionArgentina.forEach({x=>game.addVisualCharacter(x)})
		seleccionBrasil.forEach({x=>game.addVisualCharacter(x)})
		game.addVisual(arquero1)
		game.addVisual(arquero2)
	}
	
	method iniciar(){
		game.onTick(2000, "el meneaito", { => arquero1.movete()})
	 	game.onTick(2000, "el meneaito", { => arquero2.movete()})
	}
	
	method crearJugador(nombre, position, nacionalidad){
		return new JugadorGenerico(nombre= nombre, position= position, nacionalidad= nacionalidad)
	}
	
}

	
