#Include buscarObjetoEnCelda.ahk


;no recurrente, ejecuta toda una compronacion cada ciclo
;Evalua el inventario y guarda cada resultado en su variables de estados
comprobarInv()
{
 	Global
	Local r := 0
	Local POR_LIMPIAR := 0
	Local CELDAS_LIMPIAR := []
	local POR_GUARDAR := 0
	local CELDAS_GUARDAR := []
	local POR_LLENAR := 0
	local CELDAS_LLENAR := [0,0] ;este arreglo nunca se usa, se coloca por precausion
	local POR_ENCANTAR := 0
	local CELDAS_ENCANTAR := []
	Local i := 0
	local j := 0
	local k := 0
	local contieneJollaSinEncantar := false
	local contieneJollaEncantada := false
	;El estado del inventario se caracterisa por tener las siguientes variables
	;POR LIMPIAR	, si existe almenos un objeto que no este permitido en el inventario. Lo permitido es RUNA COSMICA , JOLLAS SIN ENCANTAR Y JOLLAS ENCANTADAS
	;POR GUARDAR, si existe por lo menos una jolla permitida ya encantada
	;POR LLENAR, Si existe almenos un espacion vacio
	;POR ENCANTAR, Si existe almenos una jolla sin encantar.
	
	;Lo que busco son ESPACIOS VACIOS, OBJETOS NO PERMITIDOS, jolla permitida  encantada, jolla permitida sin encantar
	;Para saber si esta por limpiar recorro cada celda
	i = 1
	;28  celdas del inventario
	Loop, 28
	{
		
		;Reseteo las variables 
		contieneJollaSinEncantar := false
		contieneJollaEncantada := false
		;Evalua si la celda esta vacia
	
		
		
		r := BarraOpciones.inventory.celdaEstaVacia(BarraOpciones.inventory.celda[i])
		;MsgBox, % r
		if (r = 1)
		{
			;Tooltip, La celda %i% esta vacia.
			;Sleep, 2000
			;Tooltip
			;Sleep 200			
			;Esta celda esta vacia, entonces hay espacios que llenar
			;Cuando la celda esta vacia solo se hace lo siguiente
			POR_LLENAR := true
		
		}
		else if (r = 0)
		{
			;En caso de que la celda contenga algo
			;Evaluo si la celda contiene una jolla permitida sin encantar
			;Tooltip, La celda %i% esta llena.
			;Sleep, 2000
			;Tooltip
			;Sleep 200
			j = 1
			loop, % familiaJollasSinEncantar.length()
			{
				r := buscarObjetoEnCelda(BarraOpciones.inventory.celda[i], familiaJollasSinEncantar[j])
				;Si encuentro una de las jollas sin encantar  
				if (r = 1)
				{
					;Tooltip, La celda %i% esta por encantar.
					;Sleep, 2000
					;Tooltip
					;Sleep 200
					;Si encontre una jolla permitida sin encantar
					POR_ENCANTAR := true
					CELDAS_ENCANTAR.push(i)
					contieneJollaSinEncantar := true
					break ;detengo este bucle
				}
				else
				{
					;no encontre esta jolla sin encantar en esta celdaç
					;busco el siguiente tipo de jolla sin encantar
					j++
				}
			}
			
			if (contieneJollaSinEncantar)
			{
				;Ya termine con esta celda, debo dejar esto aqui, 
				;Continuar
			}
			else
			{
				;Tooltip, La celda %i% no tiene jolla sin encantar.
				;Sleep, 2000
				;Tooltip
				;Sleep 200
				;En caso de que no contenga una jolla sin encantar que este permitida
				;busco si contiene una jolla encantada que este permitida
				k = 1
				loop, % familiaJollasEncantadas.length()
				{
					r := buscarObjetoEnCelda(BarraOpciones.inventory.celda[i], familiaJollasEncantadas[k])
					if (r = 1)
					{
						;Tooltip, La celda %i% esta por guardar.
						;Sleep, 2000
						;Tooltip
						;Sleep 200
					
						;Si encontre una jolla encantada que esta permitida
						POR_GUARDAR := true
						CELDAS_GUARDAR.push(i)
						contieneJollaEncantada := true
						break ;detengo este bucle
					}
					else
					{
						;no encontre esta jolla sin encantar en esta celdaç
						;busco el siguiente tipo de jolla sin encantar
						k++
					}
				}
			
				if (contieneJollaEncantada)
				{
					;Esta celda contiene una jolla encantada y ya se hiso lo que se tenia que hace
					;Continuar
				
				}
				else
				{
					;La celda no contiene un jolla sin encantar
					;Evaluo si contiene una runa cosmica
					;Tooltip, La celda %i% no contiene jolla encantada.
					;Sleep, 2000
					;Tooltip
					;Sleep 200
					
					r := buscarObjetoEnCelda(BarraOpciones.inventory.celda[i], runaCosmicaId)
					if (r = 1)
					{
						;Tooltip, La celda %i% contiene una runa cosmica. Se bloqueara esta celda.
						;Sleep, 2000
						;Tooltip
						;Sleep 200
						;inventario.bloclCelda(i)
					}
					else
					{
						;Tooltip, La celda %i% contiene un objeto no permitido.
						;Sleep, 2000
						;Tooltip
						;Sleep 200
						;Tampoco contiene una runa cosmica 
						;Se que contiene algo, pero no es algo permitido
						POR_LIMPIAR := true
						CELDAS_LIMPIAR.push(i)
					
					}
				
				}
			
			
			}
		
		}
	
	
	
	i++
	
	
	}
	
	;POR LIMPIESA[ POR GUARDAR [ POR LLENAR [ POR ENCANTAR
	ESTADO_INV := [[POR_LIMPIAR, CELDAS_LIMPIAR], [POR_GUARDAR, CELDAS_GUARDAR], [POR_LLENAR, CELDAS_LLENAR], [POR_ENCANTAR, CELDAS_ENCANTAR]]
	tooltip, fin
	sleep 500
	tooltip
}


