import wollok.game.*


class JugadorGenerico{
	
	const nombre
	const property image= if(nacionalidad== argentino) {"generico_arg.png"} else {"brasilero_gen.png"}
	var property position
	const nacionalidad
	method pasarPelotaAJugadorEstrella(jugador){
		pelota.position(jugador.position())
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
	var property ultimoMovimiento = 1
	var property estaLlevandoLaPelota = false
	
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
	
	method llevar(objeto){
		objeto.serLlevadaPor(self)
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
}



object messi1{
	const property image = "messi_colo.png"
	var property position = game.center().right(1)
	var property ultimoMovimiento = 1
	var property estaLlevandoLaPelota = false
	
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
	
	method llevar(objeto){
		objeto.serLlevadaPor(self)
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
}

object neymar1{
	const property image = "neymar.png"
	var property position = game.center().left(1)
	
	method patearPelota(){
		 pelota.serPateadaPor(self)
	}
	
	method llevar(objeto){
		objeto.serLlevadaPor(self)
	}
	method moverUnoArriba(){
		self.position(self.position().up(1))
	}
	method moverUnoAbajo(){
		self.position(self.position().down(1))
	}
	method moverUnoDerecha(){
		self.position(self.position().right(1))
	}
	method moverUnoIzquierda(){
		self.position(self.position().left(1))
	}
	
}

object pelota{
	const property image= "pelota.png"
	var property position= game.center()
	
	method serPateadaPor(jugador){
		if (jugador.ultimoMovimiento() == 1){
			position = jugador.position().up(2)
		}else if (jugador.ultimoMovimiento() == 2){
			position = jugador.position().down(2)
		}else if (jugador.ultimoMovimiento() == 3){
			position = jugador.position().right(2)
		}else if (jugador.ultimoMovimiento() == 4){
			position = jugador.position().left(2)
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

}

object argentino{}
object brasilero{}