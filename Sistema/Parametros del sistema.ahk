;Lista todos los parametros principales que son requeridos en cada script
;Este documento existe para ahorrar tiempo en la creacion de nuevos scripts

IF NOT A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}


;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
;las configuraciones iniciales debes estar en un archovo aparte, son parte necesaria para el funcionamiento. config.ini
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability. ;averiguar por que acelera el clikc a instantaneo
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Mouse, Window ;todo esta relativo a la ventana.
CoordMode, Pixel, Window 
SetBatchLines -1 ;no afecta la velocidad del mouse
ListLines On ; despues sera OFF, caundo todo este listo

_DETENER := false ;una super global que esta en cada script
