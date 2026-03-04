#Include Nucleo/RS_InterfaceClienteGlobal.ahk
#Include RS_Banco.ahk
#Include funcLimpiar.ahk
#Include funcGuardar.ahk
#Include funcLlenar.ahk

Banco := 0
Global familiaJollasSinEncantar := [2, 4, 6, 8]
;Global familiaJollasEncantadas := [idAmuleto, idBrasalete, idAnillo, IdNecklace] ;el ordende debe ser mas comun-menos comun->ring-necklace,bracelet,amulet
Global familiaJollasEncantadas := [3,5,7,9]
Global CELDA_PARA_SACAR_JOLLAS := 0
Global runaCosmicaId := 10
return

ini:
	cargar_InterfaceGlobal()
	if (!interfaceGlobal.existe)
	{
		return
	}
	cargar_BarraOpciones()
	MouseMove, BarraOpciones.inventory.x, BarraOpciones.inventory.y
	
	InterfaceBanco := new _InterfaceBanco(InterfaceGlobal)
		MouseMove, InterfaceBanco.x, InterfaceBanco.y
	Banco := new _Banco(InterfaceBanco)
	MouseMove, Banco.Interface.botonWithdrawAll.area.x1, Banco.Interface.botonWithdrawAll.area.y1
return

limpiar:
tooMsg("Limpiar")
	limpiarInv()

return


guardar:
tooMsg("Guardar")
	guardarInv()
return

llenar:
tooMsg("Llenar")
llenarInv()
return

tooMsg(t)
{
	Tooltip, %t%
	sleep 2000
	Tooltip
	sleep 200

}


i::
	GoSub ini
return

a::
	GoSub limpiar
return

b::
	GoSub guardar
return

c::
	GoSub llenar
return 

esc::
	exitapp
return