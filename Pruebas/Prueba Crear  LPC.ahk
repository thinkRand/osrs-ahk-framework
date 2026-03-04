#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include crearLPCCelda.ahk
#include Nucleo/RS_InterfaceClienteGlobal.ahk
return


ini:
cargar_InterfaceGlobal()
if (!InterfaceGlobal.existe)
{
	return
}

cargar_BarraOpciones()
InterfaceBanco:= new _InterfaceBanco(InterfaceGlobal)
InterfaceMagic := new _InterfaceMagic(InterfaceGlobal)

InterfaceEnPrueba := BarraOpciones.inventory


numCelda := 1
Tooltip, se crea LPC de celda %numCelda%
crearLPCCelda_y(InterfaceEnPrueba.celda[numCelda])
sleep 1000

Tooltip, LPC a clipboard...
sleep 1000
Tooltip

;datosCelda(InterfaceEnPrueba.celda[numCelda])
Tooltip, Fin
Sleep 500
Tooltip
return

;necesito la posicion de la celda para hallar las posiciones relativas a la celda

/*
datosCelda(celda)
{

	clipboard := "x1=" . celda.area.x1 . "  y1=" . celda.area.y1 . "  x2=" . celda.area.x2 . "  y2=" . celda.area.y2

}
*/







a::
	GoSub ini
return

esc::
	ExitApp
return
