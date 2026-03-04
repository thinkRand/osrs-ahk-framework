
;Un indicador es una piesa de informacion para leer, es un punto en la pantalla, y lo que se espera que indique es el color del pixel que hay en ese punto
;Esa informacin sirve para detectar cambios de estado de graficos o para indicar el estado actual de un grafico.

;los monitores vigilan los indicadores para tranformar lo que ven en informacion
;hya un monitor universal o hay un monitor para cada Area.

;A un monitor hai que decirle que vigilar
;Los indicadores solo se deben leer
;Los monitores leen los indicadores para hacer cosas
;tambien puedo crear un objeto monitor global que recive todo de forma global, y es usado por cada sub interface para conocer informacion de estado.
;Se usan las funciones de Monitor para definir logica de Monitoreo, como las relacionadas con restreo de pixeles
;Dentro del sistema cada interface esta posicionada de forma relativa a la interface global, y el monitor se encarga de traducir esas coordenadas para que sean relativas a la ventana
;Por que crear un objeto para saber el color de un punto si con pixel get colo basta para eso
class _Monitor
{
	Static cuentaIndicadores := 0
	indicadores := []
	Static cuentaAreas := 0
	areas := []
	;todas las interfaces y lo demas se hubica relativo a la ventana global de runelite, algunas interfaces necesitan las cpprdenadas de la inerface global para determinar su posicion relatva a la entna runelite.
	
	;No necesita nada para operar
	_New()
	{
	
	}
	class _Indicador
	{
		ID := 0
		x := 0
		y := 0
		__New(x, y, ID)
		{
			this.x := x
			this.y := y
			this.ID := ID
		}
	}
	
	hola()
	{
		MsgBox, Monitor dice hola...
	}

	agregarIndicador(x, y)
	{
		this.cuentaIndicadores++
		;la x e y son relativas a la interdaceGlobal SunAwtFrame2, pero deben ser relativas a la ventana, por eso le sumo la pos de SunAwtFrame2
		;Debo guarada cada cosa en posicion relativa a la interface Global, o relativa a la ventana. Cuando se busca se deben proporcionar coordenadas relativas a la ventana, y para cada interface es mas logico asignarle una posicion relativa a la interdaceGlobal
		nuevoIndicador := new this._Indicador(x  , y , this.cuentaIndicadores)
		this.indicadores[this.cuentaIndicadores] := nuevoIndicador
		return this.cuentaIndicadores
	}
	
	colorActualIndicador(indicadorID)
	{
		;la pos del indicador esta expresada de forma relativa a la ventana, asi que pixel get color funcionara correctamente
		;Tooltip, % "indicador id = " indicadorID
		;sleep 500
		;MouseMove, this.indicadores[indicadorID].x, this.indicadores[indicadorID].y
		PixelGetColor colorActual, this.indicadores[indicadorID].x, this.indicadores[indicadorID].y
		return colorActual
	}
	
	colorActualEn( x, y)
	{
		Global
		PixelGetColor colorActual, x, y
		return colorActual
	}
	
	;Compara o comprueba, aprueba o verifica, esta bien o esta mal, el nombre no lo decido aun
	;seria de gran ayuda agregar un criterio opcional para aceptar 80% de coincidencia como una ocurrecia
	comparaLPC(LPC)
	{
		Global
		Local cA := "" ;color actual
		if(LPC.length()>0)
		{
			loop, % LPC.length()
			{
				;Tooltip, LPC: evaluando punto %A_index% ...
				;Sleep 1000
				;Tooltip
				;recupero el color actual en el punto
				PixelGetColor cA, LPC[A_index].x, LPC[A_index].y
				if (!ErrorLevel)
				{
					if (cA = LPC[A_index].color)
					{
						;continua porque hay que comprobar los demsa puntos
					}
					else 
					{
						;Un punto no coincide, 0 indica que no esta visible
						return 0
					}
					;Si llego hasta aqui significa que todos los puntos coincidieron
					
				}
				else
				{
					;En caso de error puedo ignorarlo ya que su ocurrencia es baja y no afecta lo siguiente
				}
				
			}
			return 1
		}
		else
		{
			;2 indica que la LPC no contiene nada, 
			MsgBox, LPC no contiene nada. No se puede continuar.
			;En un caso como este se debe salir del sistema
			return 2
		}
		
	}
	
	estaColorEnArea(bArea, bColor)
	{
		Global
		;primero se tiene que comprobar que la variable area y color contienen valores validos
		;la variable color puede ser un arreglo o una cadena unico que indica un color
		;toda area creada tiene coordenadas relativas a la ventana, significa que puedo usar las funciones normalmente
		Local cX, cY
		if isObject(bArea)
		{
			if bColor is xdigit
			{
				PixelSearch, cX, cY, bArea.x1 ,bArea.y1, bArea.x2, bArea.y2, bColor,,fast
				if(!ErrorLevel)
				{
					return 1
				}
				else
				{
					return 0
				}
			}
			else
			{
				
				MsgBox Error en funcion estaColorEnArea(). El color no es valido.
				return -1
			}
		}
		else
		{
			MsgBox Error en funcion estaColorEnArea(). El area no es valida.
			return -1
		
		}
	}
	
	;actualizar(); lee cada indicador y guarda esa informacion en la variable que se aya designado para eso. Deben ser referencias a variables ocntenidas en los objetos que esperan saber esa informacion
	;con un arrglo varList puedo saber que variables van con cada indicador, y en esas variables solo indicare el color en ese indicador al de ejecutar actualisar(), asi que mientras mas seguido se ejecute
	;la funcion actualisar se contara con la informacion mas precicisa a tiempo real

}
