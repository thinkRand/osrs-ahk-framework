#include Sistema/Puntero.ahk

;REGLAS
;	-Solo debe estar activo un retraso a la ves.
;	-El retraso puede terminarce asi mismo solo en caso negativo. En los casos positivos debe ser terminado de forma externa.
	
	
;Debe dar click en el area de una interface que se le indica. Luego debe esperar a que esa interface este visible.;La funcion activar debe desviar el paso del flujo hasta que la ventana este visible, cuando este visible debe permitir el paso por del flujo al camino siguiente.
;Devuel 1 si la interface esta activa, 0 si no esta activa, 2 si se espero mucho tiempo 
	activar(areaClick, ventanaEstaVisible, espera, REINICIAR:=0)
	{
		Static clickRealisado := false
		Static r := 0 
		Static esperaActiva := false ;para indicar se se inicio una espera 
		
		;en caso de que halla que reiniciar
		if (REINICIAR)
		{
			;Compruebo si hay alguna variable de estado activa para reiniciarla
			if (esperaActiva)
			{
				reiniciarEspera() ;reinicia la funcion espera para que pueda ser utilisado de nuevo
				esperaActiva = false
			}
			
			if (clickRealisado)
			{
				clickRealisado = false
			}
			
		}
		else
		{
			;Si la ventana esta visible
			if (ventanaEstaVisible)
			{
				;Compruebo si hay alguna variable de estado activa para reiniciarla
				if (esperaActiva)
				{
					reiniciarEspera() ;reinicia la funcion espera para que pueda ser utilisado de nuevo
					esperaActiva = false
				}
				
				if (clickRealisado)
				{
					clickRealisado = false
				}
				
				return 1 ;indica que la ventana esta activa
			
			}
			else
			{
			
				;SI aun no he dado el click
				if (!clickRealisado)
				{
					;La siguiente funcion realisa el siguiente procedimiento: Mueve el mouse, espero, click
					clickA(areaClick)
					clickRealisado := true ;indico que ya di el primer click
				}
				else
				{
					
					;SI ya di el primer click lo que queda es esperar que la interface aparesca, en caso de que no aparesca debo mandar error
					;Espero tiene dos resultados, 1 para seguir esperando y 0 para tiempo terminado
					esperaActiva := true
					;Si hay que esperar mas tiempo
					if (espera(espera))
					{
						;Aun queda tiempo
						;Indico que la ventana no esta visible todavia
						return 0 ;si activar es 0 indica que la ventana no esta activa y hay que esperar mas.
					}
					else
					{
						;Tiempo limite alcansado
						esperaActiva = false
						clickRealisado = false
						reiniciarEspera() ;reinicia la funcion espera para que pueda ser utilisado de nuevo
						Return 2
					}
					
				
				}
			
			
			
			}
		}
	}
	
;reinicia activar incondicionalmente
reiniciarActivar()
{
	activar(0, 0, 0, 1)
}
	
	
;Que pasa si el relog interno de una pc falla?
;1 para aun queda tiempo y 0 para tiempo terminado
;espera no puede ser autonoma poque su resultado inplica que no conocera el futura a partir de ahy, pero puede saber lo que pasa despues dependiendo de su funcion hermana de reinicio.
;retraso va en milisegundos
;si el traso llega a cero esta funcion debe reiniciarce. Debido a que el retorno de esta funcion puede conducir dos casos ; uno positivo cuando es 1 y uno negativo cuando es 0. Entonces esta funcion conoce el caso
;cuando es 0, pero no conoce el caso positivo. Los casos positivos deben reiniciar la funcion, los negativos ocasionan que se reinicie asi misma. Tambien se puede usar reinicio cuando la funcion alcansa un 
;caso negativo, pero es mejor que lo haga sola, o quisas no, quisas no es tan claro!

;la funcion espera debe tener una condicion para terminarce, la condicion depende de una variables externa. algo como espera(retraso, var=true/false)--->(espera(3000, celda diferente a la anteriro)
espera(retraso, REINICIAR:= 0)
{
	Global
	Static ini := 0
	Static inicio := true ;determian si esta es la ejecucion inicial
	Local dif := 0
	;si hay que reiniciar las variables
	if (REINICIAR)
	{
		ini := 0
		inicio := true
	}
	else
	{
		;si es la primera ejecucion
		if (inicio)
		{	
			;capturo el tiempo actual que sera el inicial. En milisegundos
			ini := A_TickCount
			inicio := false
		}
		else
		{
			;Como no es la ejecucion inicial solo veo cuanto tiempo a pasado
			;calculo la diferencia de milisegundos
			;resto el tiempo inicial de el tiempo actual para que la diferencia sea positiva
			dif := A_TickCount - ini
			;si ha pasado mas tiempo del retraso o se acabo el tiempo 
			if (actual >= retraso)
			{
				;0 indica que se acabo el tiempo
				return 0
			}
			else
			{
				;1 indica que aun queda tiempo
				return 1
			}
		
		}
	}
}

reiniciarEspera()
{
	Global
	;Ejecuto la funcion para reiniciar la espera para que pueda volver a ser utilisada
	espera(0, 1)
}

;Espera un tiempo designado hasta que la llave indique que debe terminar
esperaHasta(espera, llave)
{
	Global
	Static ini := 0
	Static inicio := true ;determian si esta es la ejecucion inicial
	Local dif := 0
	;MsgBox, espera hasta recive llave = %llave%
	if (llave = 1)
	{
		;reinicio las variables
			ini := 0
			inicio := true
	
		;1 significa continuar
		return 1
	
	
	
	}
	else if (llave = 0)
	{
		;si es la primera ejecucion
		if (inicio)
		{	
			;capturo el tiempo actual que sera el inicial. En milisegundos
			ini := A_TickCount
			inicio := false
		}
		else
		{
			;Como no es la ejecucion inicial solo veo cuanto tiempo a pasado
			;calculo la diferencia de milisegundos
			;resto el tiempo inicial de el tiempo actual para que la diferencia sea positiva
			dif := A_TickCount - ini
			;si ha pasado mas tiempo del retraso o se acabo el tiempo 
			if (dif >= espera)
			{
				;0 indica que se acabo el tiempo
				ini := 0
				inicio := true
				return 0
			}
			else
			{
				;2 significa continuar esperando
				return 2
			}
		
		}
	
	
	
	
	
	
	}
	else
	{
		MsgBox, Error fatal. Espera() no puede recivir llaves diferentes de 0 y 1.
		Exitapp
	}



}


/*


activarCuando() o activarDespues()
{}
r := esperaHasta(3000, BarraOpciones.opcion[4].estaActiva()&&BarraOpciones.inventory.estaVisible())
		if (r = 1)
		{
			;puedo continuar
			msg("El inventario esta abierto")
		}
		else if (r = 2)
		{
			;hay que esperar
			msg("Esperando inv...")
		}
		else if (r = 0)
		{
			;Se acabo el tiempo prudente, intento abrir el inv
			clickA(BarraOpciones.opcion[4].area)
			;No quiero hacer mas click apartir de aqu. Si no habre mado erro inv no responde
		}
		
		
*/