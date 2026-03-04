;carga todo lo necesario del sistema y prueba #include sistema
;puedo hacer un documento especial para hacer pruebas individuales de las partes

#Include Nucleo/RS_InterfaceClienteGlobal.ahk
#Include crearLPCSPELL.ahk
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
numCelda := 7

;recorre cada celda y se posa en el punto top, left y luego en el centro de la celda
Tooltip, Creando LPCSPELL de celda %numCelda%
sleep 2000
tooltip
clip := ""
loop, % InterfaceMagic.celda.length()
{
	clip := clip . "Spell " . A_index . "`n"
	LPC := crearLPCSpell(InterfaceMagic.celda[A_index])
	clip := clip . LPC . "`n`n"
	
}

ClipBoard .= clip
Tooltip, Fin
sleep 500
tooltip

return

a::
	Gosub ini
return


esc::
	exitapp
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