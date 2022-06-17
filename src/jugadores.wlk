import wollok.game.*


class JugadorGenerico{
	
	const nombre
	const property image= if(nacionalidad== argentino) {"generico_arg.png"} else {"brasilero_gen.png"}
	var property position
	const nacionalidad
	
	/*method chequeoDePosiciones(){
		game.whenCollideDo()
	}
	
	method pasarPelota(){
		 if(.collideDo())
		 pelota.serPateadaPor(self)
	}
	
	method gritarGol(){
		if(pelota.position()== || pelota.position()==){
			game.say(jugador, "Gooooooooooool")
		}
	}*/
	
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


object messi{
	const property image = "messi_colo.png"
	var property position = game.center().right(1)
	
	method patearPelota(){
		 
	}
}

object neymar{
	const property image = "neymar.png"
	var property position = game.center().left(1)
	
	method patearPelota(){
		 
	}
	
}

object pelota{
	const property image= "pelota.png"
	var property position= game.center()
	
	method serPateadaPor(jugador){
		if(jugador.nacionalidad() == argentino){ //PREGUNTAR ESTOOOOOOOOOO
		 self.position().rigth(2)
		 } else {
		 self.position().left(2)
		 }
	}

}

object argentino{}
object brasilero{}