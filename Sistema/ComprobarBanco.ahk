#Include BuscarObjetoEnCelda.ahk





;Comprueba el estado del banco y coloca ese estado en la global
;Comprobar incluye revisar todas las celdas del banco y listar todas las que coincida con la busqueda
comprobarBanco()
{
	Global 
	Local r := 0
	Local lista := [] ;Para guardar las celdas con coincidencias.(jollas no encantadas)
	
	;recorro todas las celdas del banco. La cantidad de celdas varia segun el alto de la ventana, pero esto es manejado por la interface banco
	loop, % Banco.celda.length()
	{
		
		
		;Tooltip, Verificando celda %A_index%
		;Sleep 2000
		;Tooltip
		;sleep 200
		;antes de verificar una celda me tengo que  asegurar que no esta vacia, eso agilisa las busquedas.
		r := Banco.celda[A_index].estaVacia()
		if (r = 0)
		{
			;verifica que esta celda tiene una jolla permitida. 1 si es una jolla permitida, 0 si no lo es
			r := verificaCelda(Banco.celda[A_index])
			if (r  = 1)
			{
				;Agrego la pos de esta celda a la lista de celdas con jollas
				Tooltip, Hay jollas por encantar en celda %A_index%
				sleep 2000
				Tooltip
				sleep 200
				lista.push(A_index)
				
			}
			else
			{
				;Como esta celda no contiene una coincidencia no la agrego
				;continua
			}
		}
		else
		{
			;Tooltip, La celda %A_index% esta vacia
			;sleep 2000
			;Tooltip
			;sleep 200
		}
	
	}
	
	;AL terminar la busqueda compruebo que obtube
	
	;Si encontre alguna celda con jollas permitidas
	if (lista.length() > 0)
	{
		Tooltip, Jollas ok.
		Sleep 1000
		Tooltip
		sleep 200
		ESTADO_BANCO := [1,lista]
	}
	else
	{
		;No encontre jollas permitidas en las celdas del banco que fueron evaluadas
		Tooltip, No hay jollas en el banco.
		Sleep 1000
		Tooltip
		sleep 200
		ESTADO_BANCO := [0,[]]
	}
				
}




;verifica que una celda tiene una jolla permitida y no encantada. 1 si es una jolla permitida, 0 si no lo es
;La siguiente funcion no es recurrente
;Las jollas permitidas y no encantadas estan en la global familiaJollasSinEncantar
;puede llamarce buscarFamiliaJollas()
verificaCelda(celda)
{
	Global
	Local r := 0
	;familiaJollas := [idAmult, idBrcl, idRing, idNeck]
	
	loop, % familiaJollasSinEncantar.length()
	{
		;busca un objeto, usando su id
		;no se deben buscar objetos en celdas que esten vacias.	
		r := buscarObjetoEnCelda(celda, familiaJollasSinEncantar[A_index])
		if (r = 1)
		{
			return 1
		}
		else
		{
			;continua
		}
	}
	;si no encontre una coincidencia
	return 0
}















;La siguiente funcion escoge una celda que contenga jollas de las celdas que arrojo la comprobacion del banco
;Utilisa la verificacion de celda para escoger la primera que contenga una jolla permitida.
;SI no encuentra ninguna jolla en tonces arroja un erro indicando que no hay jollas en los lugares que habian y que es necsario otra comprobacion del banco
;la CELDA_PARA_SACAR_JOLLAS es la primera que se encuentre entre las que fueron ya encontradass
;ESTADO_BANCO[2] contiene los numeros de las celdas con jollas, no contiene las areas de las celdas Banco.celda contiene el area de una celda
escogerCeldaConJollas()
{
	Global
				;Escojo de que celda sacare jollas. Sera la primera que contenga alguna jolla, en el orden en que fueron encontradas.
				Local celdaEscojida := 0
				Local result := 0
				loop, % ESTADO_BANCO[2].length()
				{			
					;verifico que hay jollas en esta celda
					Tooltip, % "eval celda " ESTADO_BANCO[2][A_index]
					sleep 2000
					Tooltip
					sleep 200
					result := verificaCelda(Banco.celda[ESTADO_BANCO[2][A_index]])
					;Si esta celda aun contiene jolla
					if (result = 1)
					{
						celdaEscojida := ESTADO_BANCO[2][A_index]
						break
					}
					else if (result = 0)
					{
						;esta celda ya no tiene la jolla que se supone tenia. Puedo buscar en la siguiente celda o mandar a comprobar todo el banco
						;continua
					}
				}
				
				;si encontre una celda con jollas entre las celdas capturadas anteriormente.
				if (celdaEscojida != 0)
				{
					Tooltip, La celda con jollas es %celdaEscojida%
					Sleep 2000
					Tooltip
					sleep 200
					CELDA_PARA_SACAR_JOLLAS := celdaEscojida
					;1 indica que encontre jolla
					return 1
				}
				else if (celdaEscojida = 0)
				{
					;Ninguna de las celdas anteriores contiene una JOLLA. Debo pasar a RE-comprobar el banco.
					Tooltip, No hay jollas donde habian.
					Sleep 1000.
					Tooltip
					;comprobarBanco()
					;0 indica que no encontre jolla
					return 0
				}
		
}
