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
InterfaceBanco:= new _InterfaceBanco(InterfaceGlobal )
numCelda := 3
idObjeto := 1

/*
Tooltip, Prueba de posicion...
Sleep 2000
Tooltip

WinGetPos, X, Y, , , A
Box_Draw(X + InterfaceBanco.x, Y + InterfaceBanco.y, InterfaceBanco.ancho, InterfaceBanco.alto, guiNombre := "vacio")

sleep 5000

Tooltip, Prueba de hubicacion...
Sleep 2000
Tooltip

MouseMove, InterfaceBanco.x, InterfaceBanco.y, 20, 

sleep 2000

MouseMove, (InterfaceBanco.x-1) + InterfaceBanco.ancho, InterfaceBanco.y

Sleep 2000

MouseMove, InterfaceBanco.x, (InterfaceBanco.y-1) + InterfaceBanco.alto, 20

Sleep 2000

MouseMove, (InterfaceBanco.x-1) + InterfaceBanco.ancho, (InterfaceBanco.y-1) + InterfaceBanco.alto, 20

Sleep 2000


Box_Destroy()


sleep 2000

Tooltip, Prueba de visibilidad...
sleep 2000
tooltip

;recorre cada punto de la lista y verifica el color
loop, % InterfaceBanco.LPC.length()
{
	MouseMove, InterfaceBanco.LPC[A_index].x, InterfaceBanco.LPC[A_index].y, 20
	
	pixelGetColor, cA, InterfaceBanco.LPC[A_index].x, InterfaceBanco.LPC[A_index].y
	
	if (cA = InterfaceBanco.LPC[A_index].color)
	{
		Tooltip, % "Son iguales  [" cA "] <->[ " InterfaceBanco.LPC[A_index].color "]" 
	}
	else 
	{
		Tooltip, % "No son iguales [" cA "]<->[" InterfaceBanco.LPC[A_index].color "]"
	}
	
	Sleep 2000
	Tooltip
	
}


;recorre cada celda y se posa en el punto top, left y luego en el centro de la celda
tooltip, Prueba de celdas...
sleep 2000
tooltip
;voy a probar las 9 primeras celdas
loop, % 9
{
	MouseMove, InterfaceBanco.celda[A_index].x, InterfaceBanco.celda[A_index].y, 20
	Sleep 2000
	MouseMove, InterfaceBanco.celda[A_index].area.x2 ,InterfaceBanco.celda[A_index].area.y2, 20
	Sleep 2000
}

*/

/*
Tooltip, Prueba de botones especiales...
Sleep 2000
Tooltip

	MouseMove, InterfaceBanco.botonWithdrawAll.area.x1,  InterfaceBanco.botonWithdrawAll.area.y1, 20
	sleep 1000
	Tooltip, wAll
	Sleep 1000
	Tooltip
	sleep 200
	Tooltip, El color activo del boton debe ser 0x4d5252
	sleep 1000
	Tooltip, % "Esta activo = " InterfaceBanco.botonWithdrawAll.estaActivo()
	sleep 1000
	
	MouseMove, InterfaceBanco.botonWithdrawAll.area.x2,  InterfaceBanco.botonWithdrawAll.area.y2, 20
	Sleep 3000
	
	MouseMove, InterfaceBanco.botonCerrar.area.x1, InterfaceBanco.botonCerrar.area.y1, 20
	sleep 1000
	Tooltip, cerrar
	Sleep 5000
	Tooltip
	MouseMove, InterfaceBanco.botonCerrar.area.x2, InterfaceBanco.botonCerrar.area.y2, 20
	sleep 3000
	MouseMove, InterfaceBanco.botonDepositarInv.area.x1, InterfaceBanco.botonDepositarInv.area.y1, 20
	sleep 1000
	Tooltip, depoInv
	Sleep 5000
	Tooltip
	MouseMove, InterfaceBanco.botonDepositarInv.area.x2, InterfaceBanco.botonDepositarInv.area.y2, 20
	Sleep 3000

*/


;item 1 es la plantilla de body rune
;recive(celda, idObjeto, coloresBase)
;objeto 1=body rune, 2=Shrimps, 3=Ashes

Tooltip, Prueba de reconocimiento de objeto %idObjeto% ...
Sleep 2000
Tooltip
rr := buscarObjetoEnCelda(InterfaceBanco.celda[numCelda], idObjeto)

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




Box_Draw(X, Y, W, H, guiNombre := "") {
  ; No longer adding to the height since using only a single rectangle
  If(W < 0)
    X += W, W *= -1
  If(H < 0)
    Y += H, H *= -1
  Gui, guiNombre:New
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