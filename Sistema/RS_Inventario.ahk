#Include Nucleo/RS_InterfaceInventario.ahk
;REQUERIMIENTOS DE LA VERSION GRATUITA

/*
El auto botado gratuito es una version inferior al Asistente de Inventario. A diferencia de este:
	-No tiene interface grafica.
	-Bota todo lo que hay en el inventario de forma indiscriminada.
	-No se puede configurar.
	-Usa el mismo patron de botado cada vez.
	-No se puede detener mientras se ejecuta (block Input)
	-Bota las 28 casillas, el usuario debe saberlo para darle buen uso
	
*/


/*
REQUERIMIENTOS DE LA VERSION PREMIUM
Contruir un inventario manejable con funciones para:
	botar todo.
	botar item por LPC()
	Click celda()
	primerItemClave()
	primerItem()
	ultimoItemClave()
	ultimoItem()
	agregarAItemsPorBotar()-->los items que se quieren botar
	agregarAItemsClave-->los items con los que se espera hacer algo.
	crearLPCCelda()
	usarItemEnItem()-->recive las celdas de cada item y el orden de primero->segundo
*/









class _Inventario extend Logica
{
	celdasOcupadas := 0 ;el numero de celdas con objetos
	estalLeno := false ;indica si esta lleno
	vacio := false ;inidca si esta vacio
	primeraCelda := 0 ;indica la primera celda que esta ocupada
	
	ultimaCelda := ;indica la ultima celda que esta ocupada
	listaPatron := [] ;una lista de todos los patrones de botar items
	celdaBloqueadas := [] ;una lista de las celdas bloqueadas
	celdaImportante := ;una lista de las celdas importantes, las importantes no se botan y son requeridas, hay error si no esta presente
	contextoVar := {nombre:,funcion:, valor:} ;un objeto que almacena las variables definidas por el usuario, usa la funcion para guardar el resultado en VALOR
	interface := {}
	celda := [] ;lista de todas las celdas

	__New()
	{
	
		this.interface := new _InterfaceInventario()
		loop, % this.interface.celda.length()
		{
			this.celda[A_index] := this.interface.celda[A_index] ;en lugar de crear una copia tipo celda := new celda(interface.celda, n)
		}
	
	}








	;Ordena que se actualisen las variables del inventario
	;Manda resultados que indican posibles errores, como la ausencia de una celda importante
	actualisar()
	{
		nuevasVar.actualisar() ;es informacion que es almacenada en esta variables
	
	}

	buscarObjeto()
	{}
	
	;indica si el inventario a cambiado
	aCambiado()
	{
		;si el estado actual es diferente al alterior. Para logralo se comparan todas las variables, incluso las variables DEL CONTEXTO
	
	
	}
	
	
	bloquearCelda(numCelda)
	{
		if (numCelda => 1 && numCelda <= 28)
		{
			if (!this.celda[numCelda].estaBloqueada)
			{
				this.celda[numCelda].estaBloqueada := true
			}
			else 
			{
				MsgBox, Advertencia. Esta celda ya esta bloqueada.
			}
		}
		else
		{
			MsgBox, Error Operativo. bloquearCelda() dice: No se puede bloquear la celda %numCelda%
			ExitApp
		}
	}
	
	;reversion de bloquearCelda()
	abrirCelda(numCelda)
	{
		if (numCelda => 1 && numCelda <= 28)
		{
			if (this.celda[numCelda].estaBloqueada)
			{
				this.celda[numCelda].estaBloqueada := false
			}
			else 
			{
				MsgBox, Advertencia. Esta celda ya esta abierta.
			}
		}
		else
		{
			MsgBox, Error Operativo. abrirCelda() dice: No se puede abrir la celda %numCelda%
			ExitApp
		}
		
	}


	





















} ;fin de clase principal




























	celdaEstaVacia(celda)
	{
		Global
	
		;color base es el color base del inventario, y por consiguiente tambien de todas las celdas
		;saber si una celda esta vacia no es combeniente hacerlo con el pixel del medio
		;plantillaALPC(celda, plantilla)
		Local LPC_CELDA_VACIA := []
		LPC_CELDA_VACIA := [{x:celda.x + 16, y:celda.y + 6, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 9, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 12, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 15, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 18, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 21, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 24, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 27, color:"0x29353E"}
		,{x:celda.x +16, y:celda.y + 30, color:"0x29353E"}]
		
				if (this.Monitor.comparaLPC(LPC_CELDA_VACIA))
				{
					;Si la lpc coincide significa que esta vacia
					return 1
					;si una casillas esta llena debo saber que contiene, esto lo are despues porque puede perjudicar el rendimiento, y no es necesario ahora mismo
				}
				else
				{
					;si el indicador no cambio entonces esta celda esta vacia
					return 0
				}
	}
	
	
	;Antes era actualisar, pero no planeo ocupar tanto procesamiento en actualisarlo a cada rato.Devuel un verdadero o falso
	estaLLeno()
	{
		Global
		;Local TODAS_LAS_CELDAS_PERMITIDAS_LLENAS := true
		Local estaBloqueada := false
		Local CELDAS_LLENAS := [] ;contraparte de cada celda para indicar cuales estan llenas
		Local i := 1
		;esta verga siempre es 28, pa que conio lo hago asi?
		loop, % this.celda.length()
		{
			estaBloqueada := false	
			;Busco si la celda i esta bloqueada
			loop, % this.CELDAS_BLOQUEADAS.length()
			{
				if (this.CELDAS_BLOQUEADAS[A_index] = i)
				{
					estaBloqueada := true
					;MsgBox, celda %i% esta bloqueada
					break
				}
			}
			
			if !estaBloqueada
			{
				;color base es el color base del inventario, y por consiguiente tambien de todas las celdas
				if (this.Monitor.colorActualIndicador(this.celda[i].indicadorID) != this.colorBase)
				{
					;si el indicador cambio significa que esta casilla esta llena
					CELDAS_LLENAS[i] := true 
					;si una casillas esta llena debo saber que contiene, esto lo are despues porque puede perjudicar el rendimiento, y no es necesario ahora mismo
				}
				else
				{
					;si el indicador no cambio entonces esta celda esta vacia
					;MsgBox, celda %i% esta vacia
					;sleep 2000
					CELDAS_LLENAS[i] := false
					;como existe una casilla permitida que esta vacia, entonces TODAS_LAS_CASILLAS_LLENAS es falso
					;TODAS_LAS_CELDAS_PERMITIDAS_LLENAS := false
					;MsgBox, todas las celdas permitidas llenas falso
					return false ;hay una celda permitida que no esta llena
					
				}
				
			}
			else
			{
				;en caso de que este bloquada igual compruebo si esta llena
				;El codigo que sigue es redundate he innecesario, se puede hacer CELDAS_LLENAS[I] := TRUE Y LISTO!
				/*
				if (this.Monitor.colorActualIndicador(this.celda[i].indicadorID) != this.colorBase)
				{
					;si esta llena y bloqueada la anoto en celdsa llenas, igual las celdas bloqueadas siempre tienen que estar en modo llenas
					;punteroA(INVENTARIO_NORMAL.celda[i].area)
					;MsgBox, celda %i% esta llena
					
					;sleep 2000
					;si el indicador cambio significa que esta casilla esta llena
					CELDAS_LLENAS[i] := true 
					;si una casillas esta llena debo saber que contiene, esto lo are despues porque puede perjudicar el rendimiento, y no es necesario ahora mismo
					
				}
				else
				{
					;si la celda esta vacia pero esta bloqueada la marco como una casilla llena, porque estas celdas no se cuentan, nunca se botaran
					;punteroA(INVENTARIO_NORMAL.celda[i].area)
					;si el indicador no cambio entonces esta celda esta vacio
					;MsgBox, celda %i% esta vacia
					;sleep 2000
					CELDAS_LLENAS[i] := true
				}
				*/
				CELDAS_LLENAS[i] := true ;esta celda esta bloqueada y no importa que contenga, no se botara, se marca como llena para efectos de comprobar si todas las casillas estan llenas
	
	
			}
	
			i++
	
		}
		;recorri todas las celdas y no halle una que no este llena
		return true ;todas las casillas permitidas llenas
		

	
	
	
	
	} ;fin de funcion
		
		
		
	
		
		
		
		
        ;_actualizar()
        ;_botarItemSiguiente()
        ;_bloquearCelda(i,j,k)
		;_botarItem(i, j)