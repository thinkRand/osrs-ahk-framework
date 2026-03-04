;deberia hacer overlay de cada celda
setWorkingDir %A_scriptDir%

;carga todo lo necesario del sistema y prueba #include sistema

;puedo hacer un documento especial para hacer pruebas individuales de las partes

#Include Nucleo/RS_InterfaceClienteGlobal.ahk
#Include Nucleo/RS_Datos.ahk
#Include BuscarObjetoEnCelda.ahk
;include Sistema/Puntero.ahk
;creo la interface global 
return

ini:
cargar_InterfaceGlobal()
if (!InterfaceGlobal.existe)
{
	return
}

;#CARGO LAS INTERFACES A PROBAR
cargar_BarraOpciones()
InterfaceBanco:= new _InterfaceBanco(InterfaceGlobal )
InterfaceMagic := new _InterfaceMagic(InterfaceGlobal)

interfaceEnPrueba := BarraOpciones.inventory
numCelda := 2
idObjeto := 1

/*
Tooltip, Prueba de posicion...
Sleep 2000
Tooltip

WinGetPos, X, Y, , , A
Box_Draw(X + interfaceEnPrueba.x, Y + interfaceEnPrueba.y, interfaceEnPrueba.ancho, interfaceEnPrueba.alto)

sleep 5000

Tooltip, Prueba de hubicacion...
Sleep 2000
Tooltip

MouseMove, interfaceEnPrueba.x, interfaceEnPrueba.y, 20, 

sleep 2000

MouseMove, (interfaceEnPrueba.x-1) + interfaceEnPrueba.ancho, interfaceEnPrueba.y

Sleep 2000

MouseMove, interfaceEnPrueba.x, (interfaceEnPrueba.y-1) + interfaceEnPrueba.alto, 20

Sleep 2000

MouseMove, (interfaceEnPrueba.x-1) + interfaceEnPrueba.ancho, (interfaceEnPrueba.y-1) + interfaceEnPrueba.alto, 20

Sleep 2000


Box_Destroy()


sleep 2000




;recorre cada celda y se posa en el punto top, left y luego en el centro de la celda
Tooltip, Prueba de celdas...
Sleep 2000
Tooltip

*/
/*
loop, % interfaceEnPrueba.celda.length()
{
	;-1 porque voy a agregar el ancho y el alto
	bX := X + (interfaceEnPrueba.celda[A_index].area.x1)
	bY := Y + (interfaceEnPrueba.celda[A_index].area.y1)
	Box_Draw(bX, bY, interfaceEnPrueba.celda[A_index].ancho, interfaceEnPrueba.celda[A_index].alto)
}



loop, % interfaceEnPrueba.celda.length()
{
	MouseMove, interfaceEnPrueba.celda[A_index].area.x1, interfaceEnPrueba.celda[A_index].area.y1, 20
	Sleep 3000
	MouseMove, interfaceEnPrueba.celda[A_index].area.x2 ,interfaceEnPrueba.celda[A_index].area.y2, 20
	Sleep 3000
}

Box_Destroy()
*/

Tooltip, Prueba de reconocimiento de objeto %idObjeto%
Sleep 2000
Tooltip
;item 1 es la plantilla de body rune
;recive(celda, idObjeto, coloresBase)

rr := buscarObjetoEnCelda(interfaceEnPrueba.celda[numCelda], idObjeto)

if (rr = 1)
{
	Tooltip, Hay objeto %idObjeto% en %numCelda%
	Sleep 2000
	Tooltip
}

if (rr = 0)
{
	Tooltip, No hay objeto %idObjeto% en %numCelda%
	Sleep 2000
	Tooltip
}

if (rr = 2)
{
	Tooltip, Error con pixelGet. 
	Sleep 2000
	Tooltip
}


sleep 2000
Tooltip, Fin de pruebas...
Sleep 2000
Tooltip
	
return

a::
	Gosub ini
return

esc::
	exitapp
return




Box_Draw(X, Y, W, H) {
  ; No longer adding to the height since using only a single rectangle
  If(W < 0)
    X += W, W *= -1
  If(H < 0)
    Y += H, H *= -1
  Gui, New
  Gui,+E0x20 +ToolWindow -Caption +AlwaysOnTop +LastFound 
  ; Set window to 50% transparency
  WinSet,Transparent,128
  Gui,Color, 0xFF0000
  
  
 Gui, Show, % "x"X " y"Y " w" W " h" H " NA"
}

Box_Destroy()
{
  Gui, Destroy
}