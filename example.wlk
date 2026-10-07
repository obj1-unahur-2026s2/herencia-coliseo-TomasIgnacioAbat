class Arma {
  method poderDeAtaque()
}

class ArmaDeFilo inherits Arma{

  const filo        // Numero entre 0 y 1
  const longitud    // En Centimetros

  method filo() = filo

  method longitud() = longitud
  override method poderDeAtaque(){
    return filo * longitud
  }
}

class ArmaContundente inherits Arma{

  const peso

  method peso() = peso

  override method poderDeAtaque(){
    return peso
  }
}

class Armadura {
  method puntosDeArmadura(unLuchador)
}
class Casco inherits Armadura{

  override method puntosDeArmadura(unLuchador) = 10
}

class Escudo inherits Armadura{

  override method puntosDeArmadura(unLuchador) = 5 + (unLuchador.destreza() * 0.10)
}

class Gladiador {
  var vida = 100
  var arma

  method vida() = vida
  method cambiarArma(nuevaArma){
    arma = nuevaArma
  }
  method poderDeAtaque()
  method fuerza()
  method defensa()
  method recibirDanio(danio){
    vida =- danio
  }
  method curarse(vidaASumar){
    vida += vidaASumar
  }

  method atacar(unGladiador){
    unGladiador.recibirDanio(self.poderDeAtaque() - unGladiador.defensa())
  }

  method pelea(unGladiador){
    self.atacar(unGladiador)
    unGladiador.atacar(self)
  }
}

class Mirmillon inherits Gladiador{
  var armadura
  const fuerza
  const destreza = 15

  override method fuerza() = fuerza + destreza

  method cambiarArmadura(nuevaArmadura){
    armadura = nuevaArmadura
  }

  override method poderDeAtaque() = fuerza + arma.poderDeAtaque()

  override method defensa() = armadura.puntosDeArmadura(self) + destreza
}

class Dimachaerus inherits Gladiador{

  const armas = [arma]
  const fuerza = 10
  var destreza

  override method fuerza() = fuerza + destreza

  method recogerArma(nuevaArma){
    armas.add(nuevaArma)
  }

  override method poderDeAtaque() = fuerza + self.poderDeTodasLasArmas()

  method poderDeTodasLasArmas(){
    return armas.sum({a => a.poderDeAtaque()})
  }

  override method atacar(unGladiador){
    super(unGladiador)
    destreza += 1
  }

  override method defensa() = destreza / 2
}

class Grupo {

  var cantidadDePeleas      //Un numero
  const miembros = []

  method nombre()           //Un String

  method agregarGladiador(nuevoGladiador){
    miembros.add(nuevoGladiador)
  }

  method quitarGladiador(unGladiador){
    miembros.remove(unGladiador)
  }

  method pelea(otroGrupo){
    self.elMasFuerte().atacar(otroGrupo.elMasFuerte())
  }
  method elMasFuerte(){
    return miembros.filter({g => g.vida() > 0}).max({g => g.fuerza()})
  }
}