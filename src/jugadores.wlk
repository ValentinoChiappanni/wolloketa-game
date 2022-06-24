import wollok.game.*
import juego.*


class JugadorGenerico{
	
	const nombre
	const property image= if(nacionalidad== argentino) {"generico_arg.png"} else {"generico_bra.png"}
	var property position
	const property nacionalidad
	method pasarPelotaAJugadorEstrella(){
		if(nacionalidad == argentino)
		pelota.position(juego.messi().position())
		if(nacionalidad == brasilero)
		pelota.position(juego.neymar().position())
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
	
	method seVaHaciaElGol() {
		const otroPosicion = arcoRival.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else -1
		// evitamos que se posicionen fuera del tablero
		newX = newX.max(0).min(game.width() - 1)
		newY = newY.max(0).min(game.height() - 1)
		previousPosition = position
		position = game.at(newX, newY)	
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
		juego.messi().gritarGol() }
		else if(arco.nacionalidad() == argentino) {
		juego.neymar().gritarGol() }
	}

}

object argentino{}
object brasilero{}

class Arco{
	const property position
	const property nacionalidad
}