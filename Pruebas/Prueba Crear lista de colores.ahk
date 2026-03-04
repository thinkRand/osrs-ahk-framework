#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode windows


#Include listaColores.ahk
#Include Sistema/NuevaGestionArea.ahk

ini_GestionArea()
return



;LA PRUEBA CONSISTE EN :
;marcar una rea de la pantalla y a esta area se le scanearan los pixles creando la lista de pixeles.
;luego esa lista de pieles sera colocado en el clicpBoard



ini:



if(	AREAS_DEFINIDAS_POR_USUARIO.length()>0)
{
	lc := crearListaColores(AREAS_DEFINIDAS_POR_USUARIO[1])
}
sleep 2000


tooltip, Agrupar lista...
Sleep 2000
tooltip
lc := listaAgrupar(lc)
sleep 200

tooltip, Lista agrupada a clicpBoard...
Sleep 2000
tooltip

listaColorGrupoAClipboard(lc)


tooltip, todo listo. Bye.
Sleep 1000
tooltip
return


a::
	defineArea()
return

i::
	GoSub ini
return

esc::
	ExitApp
return
