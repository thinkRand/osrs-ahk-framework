#Include funcActivar.ahk
#include RS_Banco.ahk
#Include Sistema/Puntero.ahk
#Include ComprobarInv.ahk



;recurrente
;Guarda todas las jollas que son resultado de encantar 
;orden de los estados del inventario POR LIMPIESA[ POR GUARDAR [ POR LLENAR [ POR ENCANTAR
;################GUARDAR######################

guardarInv() 
{
	Global
	;EL ESTADO ACTUAL DEL INVENTARIO DEBE SER DIFERENTE AL ANTERIRO. no siempre es asi, el inventario se puede quedar trabado en estado por llenar.
	Static ultimaCeldaClick = 0
	Local r := 0
	;Me aseguro de activar el boton de sacar todo en el banco
	r := activar(Banco.Interface.botonWithdrawAll.area, Banco.Interface.botonWithdrawAll.estaActivo(), 3000)
	if (r := 1)
	{
		;Le doy click a la primera celda con un objeto por guardar. Como es recurrente debo evitar que de click a la misma celda en cada ciclo 
		;Como no quiero dar click en el mismo lugar dos veces tengo que recordar la ultima celda donde hise click, para no darle otra ves
		comprobarInv() ;en este momento el estado del inventario puede ser igual al anterior, en caso de que halla sido muy rapido
		
		;si ya no hay que guardar
		if (ESTADO_INV[2][1] = 0)
		{
			;Reseteo esta variabel para que no cause problemas en la siguiente orden de GUARDAR
			Tooltip, ya no hay que guardar.
			sleep 2000
			Tooltip
			sleep 200
			ultimaCeldaClick = 0
		}
		else
		{
			;si el caso actual no es igual al caso anterior
			if ( ESTADO_INV[2][2][1] != ultimaCeldaClick)
			{
				clickA(BarraOpciones.inventory.celda[ESTADO_INV[2][2][1]].area)
				ultimaCeldaLimpiada := ESTADO_INV[2][2][1]	
			}
		}
		
		;Lo que estaba en la primera celda por limpiar ya no debe estar, despues de comprobar el inventario nuevamente esta celda ya no debe estar listada.
		;La siguiente celda sera otra en caso de que aun quede algo por limpiar.
		
	}
	else if(r = 2)
	{
			;2 significa mucho tiempo esperando
			MsgBox, El boton withdraw all no responde.
			return 0.
	}
	else if(r = 0)
	{
			;significa que hay que esperar.
			;continuar
		
	}
	
}


;################LIMPIAR######################

 ;recurrente, realisa las partes en cada ciclo
 ;orden de los estados del inventario POR LIMPIESA[ POR GUARDAR [ POR LLENAR [ POR ENCANTAR
 ;La limpiesa solo se puede ejecutar una ves en cada instancia del script. Se supone que una ves que todo se arregle nunca debe ponerse en esta para limpiar nuevamente.
 ;quisas deba comprobar que el banco esta abierto
limpiarInv()
{
	Global
	Local r := 0
	Static ultimaCeldaLimpiada := 0
	Local r := 
	;Me aseguro de activar el boton de sacar todo en el banco
	MsgBox, % Banco.Interface.botonWithdrawAll.estaActivo()
	r := activar(Banco.Interface.botonWithdrawAll.area, Banco.Interface.botonWithdrawAll.estaActivo(), 3000)
	if (r = 1)
	{
		;reiniciarActivar() ;para los casos en que se activo
		;Le doy click a la primera celda con un objeto por limpiar. Como es recurrente debo evitar que de click en cada ciclo 
		;Como no quiero dar click en el mismo lugar dos veces tengo que recordar la ultima celda donde hise click, para no darle otra ves
		;si la primera celda por limpiar es diferente a la ultima celda que limpie
		comprobarInv()
		
		;si ya no hay que limpiar
		if(ESTADO_INV[1][1] = 0)
		{
			ultimaCeldaLimpiada := 0
		Tooltip, ya no hay que limpiar.
			sleep 2000
			Tooltip
			sleep 200
		}
		else
		{
			if ( ESTADO_INV[1][2][1] != ultimaCeldaLimpiada)
			{
				clickA(BarraOpciones.inventory.celda[ESTADO_INV[1][2][1]].area)
				;Lo que estaba en la primera celda por limpiar ya no debe estar, despues de comprobar el inventario nuevamente esta celda ya no debe estar listada.
				;La siguiente celda sera otra en caso de que aun quede algo por limpiar.
				ultimaCeldaLimpiada := ESTADO_INV[1][2][1]	
			}
			else
			{
				;En caso de que el caso actual sea igual al anterior
				
				;Si esto se repite mucho puede significa un laggeo, eso debe resolverse por fuera.
			
			}
		
			
		}
		
	}
	else if (r = 2)
	{

		MsgBox, El boton withdraw all no responde.
		return 0.
	}
	else if(r = 0)
	{
			;0 signidfica que hay que esperar y que el boton no esta activo.
	}
	
}





;################LLENAR######################

;orden de los estados del inventario POR LIMPIESA[ POR GUARDAR [ POR LLENAR [ POR ENCANTAR
;recurrente
llenarInv() 
{
	Global
	;Si el boton de sacar todos esta activo
	Static ultimaCeldaClick := 0
	Static retraso := 0
	Local r := 0 
	
	;Me aseguro de que el boton withdraw all esta activado
	r := activar(Banco.Interface.botonWithdrawAll.area, Banco.Interface.botonWithdrawAll.estaActivo(), 3000)
	if(r = 1)
	{
		;Si no hay celda para sacar jollas
		if (CELDA_PARA_SACAR_JOLLAS != 0)
		{
			comprobarInv()
			;si ya no hay que llenar
			if (ESTADO_INV[3][1] = 0)
			{
			Tooltip, ya no hay que llenar.
			sleep 2000
			Tooltip
			sleep 200
					ultimaCeldaClick = 0 
			}
			else
			{
				;en caso de que todavia halla que llenar
				
				;si el caso actual es diferente al caso anterior
				if (CELDA_PARA_SACAR_JOLLAS != ultimaCeldaClick)
				{		
					clickA(Banco.celda[CELDA_PARA_SACAR_JOLLAS].area)
					ultimaCeldaClick := CELDA_PARA_SACAR_JOLLAS
				}
				else
				{
					;En caso de que el  actual sea igual al anterior
				
					;Si esto se repite mucho puede significa un laggeo, eso debe resolverse por fuera.
					;Esperar que reaccione
				}
					
				
			
			
			}
		
		
			
		}
		else
		{
			MsgBox, Error operativo. La celda para sacar jollas no se conoce
			return 0		
		}
		
	}
	else if (r = 2)
	{
		
		;2 significa mucho tiempo esperando
		MsgBox, El boton withdraw all no responde.
		return 0.
	}
	else if(r = 0)
	{
			;0 significa que el boton no esta activo, hay que esperar.
			;continuar
		
	}
	
	



}

;################ENCANTAR######################
;recurrente
;La siguiente funcion se ejecuta de forma recurrente
;Devuelve 1 para indicar que puedo hacer el ciclo, 0 en caso contrario
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

;esta funcion tiene memoria del pasado, ademas considera un estado pasado a su primera ejecucion, este es que esta funcion solo se ejecuta cuando existen jollas en el inventario por encantar, si no dara error desconocido, o quesas solo diga que no hay jollas por encantar
encantarInv() 
{
	Global
	;recivo una global llamada NUM_CELDA_ENCANTAMIENTO
	Static inv = false ;puede indentificarse como "hay encantamiento en mano y debe usarse en INV"
	Static primerCiclo = true
	Static ultimo := false ;para indicar si esta es la ultima jolla
	Local r := 0 ;resultados
	Static FinalInv := false ;para indicar el caso final en que se esta en el inventario y no queda nada por encantar
	;En principio para encantar debo empesar de algun lado, ya sea de la ventana Magic o Inventory
		;Por lo general empiesa desde el inventario
	;Si alguna ventana esta activa puedo continuar, sino no debo abrir la de magic
	
	;Si este es el primer ciclo
	if (primerCiclo)
	{
		Tooltip, Es primer ciclo.
		Sleep 2000
		Tooltip
		Sleep 200
	
	
		;Debo saber si tengo el inventario o la magia abierta
		;Debe haber una diferencia en detectar el inventario o la magic. POR EL SIDE_PANEL NO SE PUEDE
		if(BarraOpciones.opcion[4].estaActiva() = 1)
		{
			;Si la ventana inventario esta activa entonces activo la de magia
			;Siempre que activar dispare un caso positivo o negativo se reinicia asi misma, pero si nunca se dispara un caso positivo o negativo esta no se reinicia. Se debe usar cuidande de reiniciarla.
			r := activar(BarraOpciones.opcion[7].area, BarraOpciones.opcion[7].estaActiva(), 3000)
			
			if(r = 1)
			{
				;la ventana de magic fue activada
				primerCiclo := false
				inv := false
				return 1 ;indica que el ciclo termino positivo
			
			}
			else if(r = 2)
			{
				MsgBox, Error. La ventana magic no habre.
				;reiniarActivar()
				return 0 ;indica que el cilco termino negativo
			}
			else if(r = 0)
			{
				;hay que esperar y no esta activa
				return 1
			}
			
			
		}
		else if (BarraOpciones.opcion[7].estaActiva() = 1)
		{
			;continua
			reiniciarActivar() ;reinicia activar incondicionalmente, solo en caso de que activar se halla usado antes
			;no hago Inv = treu porque todavia no es momento del inv
			primerCiclo := false
			inv := false ;todavia no es momento del inventario
		}
		else
		{
			;Si ninguna de las dos ventanas esta visible debo activar la de magia
			r := activar(BarraOpciones.opcion[7].area, BarraOpciones.opcion[7].estaActiva(), 3000)
			
			if(r = 1)
			{
				;la ventana de magic fue activada
				primerCiclo := false
				inv := false
				return 1 ;indica que el ciclo termino positivo
			
			}
			else if(r = 2)
			{
				MsgBox, Error. La ventana magic no habre.
				return 0 ;indica que el cilco termino negativo
			}
			else if(r = 0)
			{
				;hay que esperar y no esta activa
				return 1
			}
			inv := false ;no es momento de usar el inv, es momento de la magic
		}
	}
	else
	{
		Tooltip, No es primer ciclo.
		Sleep 2000
		Tooltip
		Sleep 200
	
	
		;Si es momento del inv
		if (inv)
		{
			Tooltip, Es momento de Inventory.
			Sleep 2000
			Tooltip
			Sleep 200
			;No compruebo si la opcion 4 esta activa. Eso ya se resolvio
			;MOMENTO MORI...
			;Despues de escoger un spell se activa la opcion de inventario automaticamente, pero no a super velocidad, la funcion inv.Visible no ayuda en este caso ya que solo detecta al SIDE_PANEL
			;DEPRECATED: BarraOpciones.inventory.estaVisible()
			
			
			if (BarraOpciones.opcion[4].estaActiva() = 1)
			{
				reiniciarEspera() ;reinicia la espera incondicionalmente, para los casos en que inicie una espera.
				reiniciarActivar() ;reinicia activar incondicionalmente, para los casos en que activar se halla usado antes
				Tooltip, Corriendo comprobacion...
				Sleep 2000
				Tooltip
				Sleep 200
				comprobarInv() ;la comprobacion debe suceder antes de hacer click para evitar errores de deteccion de estado. Si el estado cambia mas lento de lo que se detecta se percibira como que 
				;no cambio en el siguiente ciclo, probocando errores.
				
				;Si el estado del inventario indica cuantas jollas quedan por encantar puedo saber cuando no ir por un spell
				;SI hay mas de una jolla
				if (ESTADO_INV[4][2].length() > 1)
				{
					;Click en la primera celda por encantar
					Tooltip, Hay mas de una celda por encantar...
					Sleep 2000
					Tooltip
					Sleep 200
					ClickA(BarraOpciones.inventory.celda[ESTADO_INV[4][2][1]].area)
					inv := false
					;si el inventario no esta por encantar
				}
				else if (ESTADO_INV[4][2].length() = 1)
				{
					Tooltip, Quesa una celda por encantar...
					Sleep 2000
					Tooltip
					Sleep 200
					;Click en la unica celda por encantar
					ClickA(BarraOpciones.inventory.celda[ESTADO_INV[4][2][1]].area)
					;Ahora se abrira sola la ventana de magic
					inv := false ; termino en magic, pero me devuelvo a inv para la comprobacion final.
					;Indico que este fue la ultima jolla por encantar, solo debo esperar que la ventana reaccione
					ultimo := true
					;Ya le di click a la unica celda que quedaba, debo esperar a que el estado del inventario reconosca que ya no esta por encantar
					
					;como el inventario ya no esta por encantar el siguiente ciclo no ejecutara la funcion ENCANTAR
				
				}
				else if (ESTADO_INV[4][2].length() = 0)
				{
					Tooltip, No hay jollas por encantar.
					Sleep 1000
					Tooltip
					;a partir de aqui ya se reconoce que el inventario ya no esta por encantar, la siguiente ejecucion sera por un nuevo ciclo
					ultimo := false
					inv := false
					primerCiclo = true
					FinalInv := false
				}
				
				
			}
			else
			{
			
				;Si inventario no esta abierto se puede deber a dos cosas, error de conexion o termine de encantar y estoy pegado en Magic.
				
				if(FinalInv)
				{
				
					;Si estoy pegado en Magic habro el inventario
					;ERROR CON LAS ACTIVAVIONES, ME ESTA APARECIENDO EL MSJ 2 CIEMPRE QUE VENGO DE MAGIC. Y LO PEOR ES QUE NO HACE CLICK, LO QUE ME INDICA QUE UNA
					;ACTIVACION ANTERIOR NO CE CERRO.
					r := activar(BarraOpciones.opcion[4].area, BarraOpciones.opcion[4].estaActiva(), 3000)
					
					if(r = 1)
					{
						;la ventana de inv fue activada
						return 1 ;indica que el ciclo termino positivo
					
					}
					else if(r = 2)
					{
						MsgBox, Error. La ventana inv no habre.
						return 0 ;indica que el cilco termino negativo
					}
					else if(r = 0)
					{
						;hay que esperar y no esta activa
						return 1
					}
				
				
				
				}
				else
				{
				
					;inicio una espera, pero no una activacion
					r := espera(3000)
					if (r = 1)
					{
						;continuar esperando
					
					}
					else if(r := 0)
					{
						;se acabo el tiempo
						MsgBox, Error. La ventana Inventory no esta visible.
						return 0 ;indica 	que el ciclo termina en estado negativo.
					}
				}
			}
		
		
		}
		else
		{
			Tooltip, Es momento de Magic.
			Sleep 2000
			Tooltip
			Sleep 200
			;Si el side panel esta abierto, no compruebo si la opcion 7 esta activa porque eso ya se debe haber solucionado..
			;SI LA OPCION ESTA ACTIVA SE CONSIDERA QUE EL SIDE_PANEL TAMBIEN LO ESTA.
			if (BarraOpciones.opcion[7].estaActiva() = 1)
			{
				reiniciarEspera() ;reinicia espera() incondicionalmente. Sirve para los casos en que se activo una espera.
				;Mientras no halla encantado la ultima jolla sigo seleccionando el espell
				if (!ultimo)
				{
					;la global NUM_CELDA_ENCANTAMIENTO tiene la posicion de la celda con el encantamiento a usare
					;si no se tiene suficientes runas la siguiente funcion avisa de ese caso y cierra el script con exitApp
						Tooltip, selec spell...
						Sleep 2000
						Tooltip
						Sleep 200
						Magic.selecSpell(NUM_CELDA_ENCANTAMIENTO)
						inv = true
						Tooltip, spell listo. ya es momento de inv...
						Sleep 2000
						Tooltip
						Sleep 200
				}
				else
				{
					;En caso de que ya encante la ultima jolla no sigo seleccionando el spell de encantamiento y regreso al inventario para hacer la comprobacion final
					;si enbargo se debe forzar la apertura del inventario en este punto.
					;Termino en Magic porque cuando se encanta la ultima jolla automaticamente termino en Magic., pero devo volver a inv
					FinalInv = true ;da la orden para abri el inventario para hacer la comprobacion final
					inv := true ;indico que se ejecute la parte de inv, esa parte maneja el caso FinalInv
				}
			}
			else
			{
				;inicio una espera, pero no una activacion
				r := espera(3000)
				if (r = 1)
				{
					;continuar esperando
				
				}
				else if(r := 0)
				{
					;se acabo el tiempo
					MsgBox, Error. La ventana Magic no esta visible.
					return 0 ;indica 	que el ciclo termina en estado negativo.
				}
		
			}
		
		
		}
	
	}
	
}


 