;Creo la clase y defino el objeto, o defino directamente el objeto, sin valores de posicion establecidos
;Despues se agregaran esto valores
;NO, no manejo esa logica aqui, aqui solo defino las partes, las estructura, los datos y sus mecanismos de acceso
;La interface global es SunAwtCanvas2 en caso de que se use RuneLite.
class _InterfaceGlobal
{
	;Monitor := {}
	__New(x, y, width, heigth, padre)
	{
		Global
		;posicion relativa a su padre, en este caso el padre de esta inteface es la ventana de runelite, esa pos es muy importante porque ayudara a conocer la pos de todas las demas 
		ID := 1
		this.nombre := "interfaceGlobal"
		this.x := x
		this.y := y
		this.ancho := width
		this.alto := heigth
		this.interfacePadreID := padre ;-->la hwnd de la ventana, runeLite en caso de runelite
		;this.Monitor := new _Monitor()-->El monitor debe ser un objeto global
		this.existe := true	
	}
}




;Las interfaces son una categoria, es decir que define estas caracteristicas basicas para las interfaces
;Como no le estoy dando uso a esta interface entonces la voy a suspender
/*
class _InterfaceCliente
{
        ID := 0 ;para que la maquina la identifique con facilidad
		interfacePadreID := 0 ;0 es el screen
        nombre := "" ;para yo identificarla con facilidad
        x:= 0 ;pos x
        y := 0 ;pos y
        ancho := 0 ;el width
        largo := 0 ;el heigh
		existe := false
       ; interfacesHijo ;lista de todas las interfaces que contiene
	   contenido := [] ;lista del contenido, son objetos. desde celdas a pequeñas interfaces con funciones propias etc sidePanel{celda1:, celda2:} MiniMpa{health{}}}
}
*/