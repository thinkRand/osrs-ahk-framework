#include Nucleo/RS_InterfaceClienteGlobal.ahk
#include funcComprobarInv.ahk
/*
cosmicRuneID := 10
safireRingID := 2
safireNecklaceID := 4
rignOfRecoilID := 3
gamesNecklaceID := 5
safireBraceletID := 6
braceletOfClayID := 7
safireAmuletID := 8
amuletOfMagicID := 9
*/

Global ESTADO_INV := []


Global familiaJollasSinEncantar := [2, 4, 6, 8]
;Global familiaJollasEncantadas := [idAmuleto, idBrasalete, idAnillo, IdNecklace] ;el ordende debe ser mas comun-menos comun->ring-necklace,bracelet,amulet
Global familiaJollasEncantadas := [3,5,7,9]

Global runaCosmicaId := 10

return 


ini:
m := ""
cargar_InterfaceGlobal()


if (!InterfaceGlobal.existe)
{
	return
}

cargar_BarraOpciones()



toolMsg("Prueba de estado de inventario...")

;MsgBox, % BarraOpciones.Inventory.celda.length()

comprobarInv()



toolMsg("Muestra de estado")

if(ESTADO_INV[1][1] = 1)
{
	toolMsg("El inventario esta por limpiar")
	;muestro las celdas por limpiar con loop
	loop, % ESTADO_INV[1][2].length()
	{
		m .= ESTADO_INV[1][2][A_index] . ", "
	}
	toolMsg(m)
}

if(ESTADO_INV[2][1] = 1)
{
	toolMsg("El inventario esta por guardar")
		;muestro las celdas por guardar
	loop, % ESTADO_INV[2][2].length()
	{
		m .= ESTADO_INV[2][2][A_index] . ", "
	}
	toolMsg(m)
}

if(ESTADO_INV[3][1] = 1)
{
	toolMsg("El inventario esta por llenar")
	;muestro las celdas por llenar
	loop, % ESTADO_INV[3][2].length()
	{
		m .= ESTADO_INV[3][2][A_index] . ", "
	}
	toolMsg(m)
}

if(ESTADO_INV[4][1] = 1)
{
	toolMsg("El inventario esta por encantar")
	;muestro las celdas por encantar
	loop, % ESTADO_INV[4][2].length()
	{
		m .= ESTADO_INV[4][2][A_index] . ", "
	}
	toolMsg(m)
}














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