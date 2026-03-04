;carga todo lo necesario del sistema y prueba #include sistema
;puedo hacer un documento especial para hacer pruebas individuales de las partes

#Include Nucleo/RS_InterfaceClienteGlobal.ahk
#Include comparaLPCSPELL.ahk

coordMode Window

;include Sistema/Puntero.ahk
;creo la interface global 
return

ini:
cargar_InterfaceGlobal()

if (!InterfaceGlobal.existe)
{
	return

}

InterfaceMagic := new _InterfaceMagic(InterfaceGlobal)
num = 7
/*
Tooltip, Prueba de posicion...
Sleep 2000
Tooltip

;pos de la ventana activa
WinGetPos, X, Y, , , A

;box draw debe tener las coordenadas de la ventana actual y la interfaceGlobal
Box_Draw(X + InterfaceMagic.x,Y +InterfaceMagic.y, InterfaceMagic.ancho, InterfaceMagic.alto)

Sleep 4000
MouseMove, InterfaceMagic.x, InterfaceMagic.y, 20


sleep 5000
Box_Destroy()










tooltip, prueba de visibilidad...
sleep 2000
tooltip

;recorre cada punto de la lista y verifica el color
loop, % InterfaceMagic.listaPC.length()
{
	;tooltip, % InterfaceMagic.listaPC[A_index].x
	;Sleep 1000
	MouseMove, InterfaceMagic.listaPC[A_index].x, InterfaceMagic.listaPC[A_index].y, 20
	
	pixelGetColor, cA, InterfaceMagic.listaPC[A_index].x, InterfaceMagic.listaPC[A_index].y
	
	if (cA = InterfaceMagic.listaPC[A_index].color)
	{
		Tooltip,% "Son iguales " cA "<->" InterfaceMagic.listaPC[A_index].color "--actual<->esperado"
	}
	else 
	{
		Tooltip,% "No son iguales " cA "<->" InterfaceMagic.listaPC[A_index].color
	}
	
	Sleep 2000
	Tooltip
	
}

;recorre cada celda y se posa en el punto top, left y luego en el centro de la celda
tooltip, prueba de celdas...
sleep 2000
tooltip

loop, % interfaceMagic.celda.length()
{
	;-1 porque voy a agregar el ancho y el alto
	bX := X + (interfaceMagic.celda[A_index].area.x1)
	bY := Y + (interfaceMagic.celda[A_index].area.y1)
	;se inicio en la pos x1,y1, desde hay se empiesa a agregar el ancho, por lo que ancho termina en x2,y2, creando la celda perfectamente
	Box_Draw(bX, bY, interfaceMagic.celda[A_index].ancho, interfaceMagic.celda[A_index].alto)
}


loop, % InterfaceMagic.celda.length()
{
	MouseMove, InterfaceMagic.celda[A_index].area.x1, InterfaceMagic.celda[A_index].area.y1, 20
	Sleep 3000
	MouseMove, InterfaceMagic.celda[A_index].area.x2, InterfaceMagic.celda[A_index].area.y2, 20,
	Sleep 3000
}
*/
loop, % InterfaceMagic.celda.length()
{
kk := comparaLPCSPELL(InterfaceMagic.celda[A_index])

if (kk)
{
	Tooltip, Coincide
	Sleep 1000
	Tooltip
	Sleep 500
}
else
{
	Tooltip, No coincide
	Sleep 1000
	Tooltip
	Sleep 500
}
}

return

a::
	Gosub ini
return


esc::
	exitapp
return

r::
	reload
return

;para pruebas posteriores
;Magic := _Magic(InterfaceMagic)

/*
cargar_BarraOpciones()
Tooltip, prueba de visibilidad...
Sleep 2000
Tooltip



Sleep 2000

Tooltip, Esta visible = % Magic.estaVisible()
Sleep 2000
		
;Activo la opcion 7
MouseMove, BarraOpciones.opcion[7].area.x + 2, BarraOpciones.opcion[7].area.y + 2
Sleep 300
Click


Tooltip, Esta visible = % Magic.estaVisible()
Sleep 2000

Tooltip, prueba de celdas...
Sleep 2000
Tooltip

;spell.estaActivo()
loop,% Magic.spell.length()
{
	MouseMove, Magic.Interface.celda[A_index].x+5, Magic.Interface.celda[A_index].+6
	sleep 1000
}

tooltip, pruba de seleccion y uso de spell...
Sleep 2000
Tooltip

tooltip, usar spell 6, encantamiento de safiro..
Sleep 2000
Tooltip
areap := {x1:300, y:456, x2:433, y2: 457}


Tooltip, % Magic.usarSpellEn(p)
sleep 1000

tooltip, % selecSpell(6)
sleep 1000

Tooltip, % Magic.usarSpellEn(p)
sleep 1000






*/


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