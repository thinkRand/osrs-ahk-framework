#include Nucleo/RS_InterfaceClienteGlobal.ahk
#Include RS_Banco.ahk
#Include funcComprobarBanco.ahk
#Include funcEscogerCeldaConJollas.ahk



familiaJollasSinEncantar := [2, 4, 6, 8]

ESTADO_BANCO := []
return 


b::
toolMsg("Escoger celda...")
escogerCeldaConJollas()
return

ini:
	cargar_InterfaceGlobal()
	if (!interfaceGlobal.existe)
	{
		return
	}
	
	InterfaceBanco := new _InterfaceBanco(InterfaceGlobal)
	Banco := new _Banco(InterfaceBanco)
	
	comprobarBanco()
	
	
return





toolMsg(text)
{
	Tooltip, %text% 
	Sleep 2000
	Tooltip
	sleep 200
}


a::
	GoSub ini
return


esc::
	exitapp
return

