
;PROBAR TODOS LOS METODOS DE BANCO
setWorkingDir %A_scriptDir%

#include Nucleo/RS_InterfaceClienteGlobal.ahk
#Include BuscarObjetoEnCelda.ahk
#Include RS_Banco.ahk
return


ini:
	cargar_InterfaceGlobal()
	if (!interfaceGlobal.existe)
	{
		return
	}
	
	InterfaceBanco := new _InterfaceBanco(InterfaceGlobal)
	Banco := new _Banco(InterfaceBanco)
	
	
	r := Banco.estaVisible()
	
	if (r = 1)
	{
		Tooltip, El banco esta visible...
		sleep 2000
		Tooltip
		Sleep 200
	
	}
	else if (r = 0)
	{
		Tooltip, El banco no esta visible...
		sleep 2000
		Tooltip
		Sleep 200
	
	}
	else if(r = 2)
	{
		Tooltip, LPC vacia.
		sleep 2000
		Tooltip
		Sleep 200

	}
	else
	{
		MsgBox, Error al detectar si esta visible %r%
	}
	
	
	Tooltip, Prueba activarBotonWitdrawAll.
	sleep 2000
	Tooltip
	Sleep 200
	
	Banco.activarBotonWitdrawAll()
	
	Tooltip, Prueba boton cerrar.
	sleep 2000
	Tooltip
	Sleep 200
	
	
	;Banco.cerrar()
	
	Tooltip, Prueba boton depositar
	sleep 2000
	Tooltip
	Sleep 200
	
	Banco.clickDepositarInv()
	
	Tooltip, Prueba de cada celda.
	sleep 2000
	Tooltip
	Sleep 200
	
		;recorro cada celda indicando si esta vacia
	loop,%  Banco.celda.length()
	{
		MouseMove, Banco.celda[A_index].x, Banco.celda[A_index].y, 20
		MouseMove, Banco.Interface.celda[A_index].x, Banco.Interface.celda[A_index].y, 20
		Sleep 500
		r := Banco.celda[A_index].estaVacia()
		if (r = 1)
		{
			Tooltip, Esta vacia.
			Sleep 500
			Tooltip
			sleep 100
		}
		else if ( r = 0)
		{
		
			Tooltip, Esta llena.
			Sleep 500
			Tooltip
			sleep 100
			idObjeto := 1
			rr := buscarObjetoEnCelda(Banco.celda[A_index], idObjeto)

			if (rr = 1)
			{
				Tooltip, Hay objeto %idObjeto% en %A_index%
				Sleep 2000
				Tooltip
			}

			if (rr = 0)
			{
				Tooltip, No hay objeto %idObjeto% en %A_index%
				Sleep 2000
				Tooltip
			}

			if (rr = 2)
			{
				Tooltip, Error con pixelGet. 
				Sleep 2000
				Tooltip
			}
		}
		else
		{
			Tooltip, Celda esta vacia error.
			Sleep 1000
			Tooltip
			Sleep 100
		
		}
	
	}
	
	

	
	
	
	
	
	
	
	;ABRIR ES UN CASO ESPECIAL.
return



a::
	GoSub ini
return

esc::
	exitapp
return