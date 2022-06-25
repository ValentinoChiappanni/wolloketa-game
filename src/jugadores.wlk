import wollok.game.*
import juego.*

class JugadorGenerico{
	
	const property image= if(nacionalidad== argentino) {"generico_arg.png"} else {"generico_bra.png"}
	var property position
	const property nacionalidad
	method pasar(pelota){
		if(nacionalidad == argentino)
		pelota.position(juego.messi().position())
		if(nacionalidad == brasilero)
		pelota.position(juego.neymar().position())
	}
	
	method realizarAccionCon(pelota){
		self.pasar(pelota)
	}
	
}

class Arquero inherits JugadorGenerico{
	const posicionActual = position
	override method image()= if(nacionalidad== argentino) {"arqueroArg.png"} else {"arqueroBra.png"}
	
	method 	moverseOpuesto(){
		if(position.y()==posicionActual.y())
			self.position(self.position().down(1))
		else{
			self.position(self.position().up(1))
		}
		
	}
	
	method atajar(pelota){
		pelota.position(game.at(9.randomUpTo(15).truncate(0), 4.randomUpTo(8).truncate(0)))
	}
	
	override method realizarAccionCon(pelota){
		self.atajar(pelota)
	}
}

class JugadorPrincipal {
	const property image
	var property position
	var property nacionalidad
	var property ultimoMovimiento = 1
	var property estaLlevandoLaPelota = false
	//var property esElActivo = true
	var property arcoRival = if(nacionalidad == argentino) {juego.arcoBra()} else if(nacionalidad == brasilero) {juego.arcoArg()}
	var property previousPosition = position
	
	/*method seVaHaciaElGol() {
		const otroPosicion = arcoRival.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else -1
		// evitamos que se posicionen fuera del tablero
		newX = newX.max(0).min(game.width() - 1)
		newY = newY.max(0).min(game.height() - 1)
		previousPosition = position
		position = game.at(newX, newY)	
		pelota.serLlevadaPor(self)
	}*/
	
	method realizarAccionCon(pelota){
		pelota.serLlevadaPor(self)
	}
	
	method patearPelota(){
		if (self.tieneLaPelota()){
			pelota.serPateadaPor(self)
		}
	}
	
	method tieneLaPelota(){
		return estaLlevandoLaPelota && self.hayPelotaAlrededor()
	}
	
	method hayPelotaAlrededor(){
		return (position.x() - pelota.position().x()).abs() == 1 or (position.y() - pelota.position().y()).abs() == 1
	}
	
	method moverUnoArriba(){
		self.position(self.position().up(1))
		ultimoMovimiento = 1
	}
	method moverUnoAbajo(){
		self.position(self.position().down(1))
		ultimoMovimiento = 2
	}
	method moverUnoDerecha(){
		self.position(self.position().right(1))
		ultimoMovimiento = 3
	}
	method moverUnoIzquierda(){
		self.position(self.position().left(1))
		ultimoMovimiento = 4
	}
	
	method gritarGol() {
		game.say(self, "GOOOOL!")
	}
}


object pelota{
	const property image= "pelota.png"
	var property position= game.center()
	
	method serPateadaPor(jugador){
		if (jugador.ultimoMovimiento() == 1){
			position = jugador.position().up(4)
		}else if (jugador.ultimoMovimiento() == 2){
			position = jugador.position().down(4)
		}else if (jugador.ultimoMovimiento() == 3){
			position = jugador.position().right(4)
		}else if (jugador.ultimoMovimiento() == 4){
			position = jugador.position().left(4)
		}
	}
	
	method serLlevadaPor(jugador){
		jugador.estaLlevandoLaPelota(true)
		if (jugador.ultimoMovimiento() == 1){
			position = jugador.position().up(1)
		}else if (jugador.ultimoMovimiento() == 2){
			position = jugador.position().down(1)
		}else if (jugador.ultimoMovimiento() == 3){
			position = jugador.position().right(1)
		}else if (jugador.ultimoMovimiento() == 4){
			position = jugador.position().left(1)
		}
	}
	
	method entrarAlArco(arco) {
		if(arco.nacionalidad() == brasilero) {
		juego.messi().gritarGol()
		juego.marcadorBra().agregarGol()}
		else if(arco.nacionalidad() == argentino) {
		juego.neymar().gritarGol()
		juego.marcadorArg().agregarGol()}
	}

}

object argentino{}
object brasilero{}

class Arco{
	const property position
	const property nacionalidad
	
	
	method realizarAccionCon(pelota){
		pelota.entrarAlArco(self)
	}
}

class MarcadorDeGoles{
	var property cantidadDeGoles=0
	const property position
	const property nacionalidad
	
	method image(){ 
		var img
	
		//"goles" + cantidadDeGoles + ".png"
		if(cantidadDeGoles== 0){
			img= "goles0.png"
		} else if(cantidadDeGoles== 1){
			img= "goles1.png"
		} else if(cantidadDeGoles== 2){
			img= "goles2.png"
		} else if(cantidadDeGoles== 3){
			img= "goles3.png"
		} else if(cantidadDeGoles== 4){
			img= "goles4.png"
		} else if(cantidadDeGoles== 5){
			img= "goles5.png"
			//game.boardGround(self.imagenDelCampeon())
			//const champion = game.sound("light-rain.mp3")
			//champion.shouldLoop(true)
			//game.schedule(500, {champion.play()})
			//game.start()
		} return img
	
	}
	
	method agregarGol(){
		cantidadDeGoles++
	}
	
	/*method asignarImagen(){
		game.ground(imagen)
	}*/
	
	method imagenDelCampeon(){
		if(nacionalidad==argentino){
			return "messiCampeon.png"
		} else{
			return "neymarCampeon.png"
		}
	}
}

/*object marcadorGoles {
	const property position= game.at(16,16)
	method image(){
		if(cantidadGoles== 0){
			image= "0goles.png"
		} else if(cantidadGoles== 1){
			image= "1gol.png"
		} else if(cantidadGoles== 2){
			image= "2goles.png"
		} else if(cantidadGoles== 3){
			image= "3goles.png"
		} else if(cantidadGoles== 4){
			image= "4goles.png"
		} else if(cantidadGoles== 5){
			image= "5goles.png"
			game.backGround(campeon.imagenDelCampeon())
			const champion = game.sound("light-rain.mp3")
			champion.shouldLoop(true)
			game.schedule(500, {champion.play()})
			game.start()
		}
	}*/
