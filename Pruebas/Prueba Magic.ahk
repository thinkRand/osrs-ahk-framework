
;PROBAR TODOS LOS METODOS DE MAGIC

#include RS_Magic.ahk
#Include Nucleo/RS_InterfaceClienteGlobal.ahk
return


ini:
	cargar_InterfaceGlobal()
	if (!interfaceGlobal.existe)
	{
		return
	}
	
	InterfaceMagic := new _InterfaceMagic(InterfaceGlobal)
	Magic := new _Magic(InterfaceMagic)
	;Area donde lansar el spell de prueba
	area := {x1:InterfaceGlobal.x + 300, y1:InterfaceGlobal.y + 300, x2:InterfaceGlobal.x + 320, y2:InterfaceGlobal.y + 320}
	spellNum := 7 ;el spell de prueba
	r := 0 ;el return
	;solo se prueba la funcion estaVisible()
	/*
	MouseMove, Magic.Interface.x, Magic.Interface.y, 20
	sleep 2000
	
	;MouseMove, InterfaceMagic.x, InterfaceMagic.y, 20
	
	if (Magic.estaVisible() = 1)
	{
		Tooltip, Magic esta visible...
		Sleep 2000
		Tooltip
	}
	else if (Magic.estaVisible() = 0)
	{
		Tooltip, Magic no esta visible...
		Sleep 2000
		Tooltip
	}
	else if (Magic.estaVisible() = 2)
	{
	
		MsgBox, LPC esta vacia.
	}
	else
	{
		MsgBox, esta Visible no responde
	}
	
	Tooltip, Prueba usarSpell %spellNum% ...
	Sleep 2000
	Tooltip
	Sleep 100
	
	r := Magic.usarSpellEn(area)
	
	
	
	Tooltip, Prueba selecSpell %spellNum% ...
	Sleep 2000
	Tooltip
	Sleep 100
	r := Magic.selecSpell(n)
	
	Tooltip, Return = %r%
	Sleep 2000
	Tooltip
	Sleep 100
	
	if(Magic.spell[spellNum].estaActivo() = 1)
	{
		Tooltip, Spell %spellNum% esta activo.
		Sleep 2000
		Tooltip
		Sleep 100
	}
	else
	{
		Tooltip, Spell %spellNum% no esta activo.
		Sleep 2000
		Tooltip
		Sleep 100
	
	}
	*/
	
	
	;Magic.clickSpell(7)
	Tooltip, % Magic.spell.length()
	sleep 2000
	
	loop, % Magic.spell.length()
	{
		MouseMove, Magic.interface.celda[A_index].area.x1, Magic.interface.celda[A_index].area.y1,20
		sleep 2000
		MouseMove, Magic.interface.celda[A_index].area.x2, Magic.interface.celda[A_index].area.y2, 20
		sleep 2000

	}
	
	Tooltip, Fin
	Sleep 1000
	Tooltip
	
return



a::
	GoSub ini
return

esc::
	exitapp
return