;PARA ENCANTAR NECESITO ALGUNAS GLOBALES
	;ESTADO_INV
	;NUM_CELDA_ENCANTAMIENTO
	
;ESTADO_INV := [[POR_LIMPIAR, CELDAS_LIMPIAR], [POR_GUARDAR, CELDAS_GUARDAR], [POR_LLENAR, CELDAS_LLENAR], [POR_ENCANTAR, CELDAS_ENCANTAR]]
;ESTADO_INV := [[1,0], [1,], [1,0], [1,0]]
#Include RS_Magic.ahk
#Include funcEncantar.ahk
#Include funcActivar.ahk
#Include Nucleo/RS_InterfaceClienteGlobal.ahk

SendMode, Event
SetDefaultMouseSpeed, 15
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

Global familiaJollasSinEncantar := [2, 4, 6, 8]
;Global familiaJollasEncantadas := [idAmuleto, idBrasalete, idAnillo, IdNecklace] ;el ordende debe ser mas comun-menos comun->ring-necklace,bracelet,amulet
Global familiaJollasEncantadas := [3, 5, 7, 9]
Global ESTADO_INV := []
Global runaCosmicaId := 10
Global NUM_CELDA_ENCANTAMIENTO := 6 ;level 1 enchant
return

;el estado del inventario se debe comprobar
s::
cargar_InterfaceGlobal()
if (!InterfaceGlobal.existe)
{
	return
}

cargar_BarraOpciones()
cargar_Magic()

toolMsg("Comprobacion inicial de inventario")
comprobarInv()
return

a::
toolMsg("Encantar")
	encantarInv()
return



esc::
	exitapp
return



toolMsg(text)
{
	Tooltip, %text% 
	Sleep 2000
	Tooltip
	sleep 200
}


