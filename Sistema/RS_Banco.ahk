#Include Sistema/Puntero.ahk
#Include Nucleo/RS_InterfaceBanco.ahk
#Include Sistema/GestionTiempo.ahk






;BANCO DEBE TENER UNA CLASE CELDA que referencia a la celda y agrega el metodo estaVacia()

;Para crear un objeto banco que maneje las cosas, la logica no debe contener datos solo manejarlos.
class _Banco
{

	
	datosApertura := 0 ;incluye el area donde abrir el banco y informacion sobre la forma de abirilo
	celda := [] ;referencia a todas las celdas de la interface
	;botonWithdrawAll := {} ;un area y un metodo esta activo
	Monitor := {}
	Interface := {}
	
	__New(Byref Interface)
	{
		Global
		this.Monitor := MonitorGlobal
		this.Interface := Interface
	
		loop,% Interface.celda.length()
		{
			this.celda[A_index] := new this._celda(Interface.celda[A_index], this.Monitor)
		}
	
	}
	
	;area, un lClick/Rclick, 
	agregarDatosApertura(area, opcion)
	{
		Global
		;El area es el area, pero la opcion es 1 para indicar que se da L click , o 2 para R click
		this.datosApertura := {area:area, opcion:opcion}
	}
	
	

	;abre el banco si no lo esta. SOLO SE PUEDE USAR SI EL AREA HA SIDO DEFINIDA
	abrir()
	{
		if (this.datosApertura != 0)
		{
			;Si la opcion es uno significa que el banc=o se abre con L click
			if (this.datosApertura.opcion = 1 )
			{
				clickA(this.datosApertura.area)
				return 1
			}
			else if(this.datosApertura.opcion = 2)
			{
				;en caso de que el banco se abra con R click hay que seleccionar la opcion 2
				;la siguiente funcion incluye reaccion, movimiento
				punteroA(this.datosApertura.areas)
				;la siguiente funcion incluye, reaccion, movimiento retraso y click				
				selecOpcionMenu(2)
				return 1
			}
			else
			{
				MsgBox, Erro irresoluble en la definicion del banco.
				return 0
			
			}
			
			
			
			return 1
		}
		else
		{
			MsgBox, No se ha definido el area del banquero, cofre o taquilla. No se puede continuar.
			return 0
		
		}
	
		;abrir depende del area donde esta el cofre, banquero o taquilla.
		;depende de las opciones de apertura de banco
		;Un click, si alguiente tiene menu entry swap
		;segundo click, la opcion para abrir el banco se hubica en la pocicion 3 del menu pop-up, 
			;la opcion se puede hubicar en diferentes posiciones dependiendo de:
				;si es cofre.
				;si es baquero
				;si es mostrador o taquilla.
	}
	
	
	;Cierra el banco si este esta abierto, para la prueba no comprobara si el banco esta abierto
	cerrar()
	{
		Global
		;if this.estaVisible()
		;{
		clickA(this.Interface.botonCerrar.area)
		;}
		;else
		;{
		;	MsgBox, El banco no esta abierto.
		;}
	}
	
	;si no esta activo lo activa
	activarBotonWitdrawAll()
	{
		Global
		Local r
		
		
		
		;lo siguiente no deberia ser asi, que funcione no quiere decir que este bien 
		
		r := this.Interface.botonWithdrawAll.estaActivo()
		if (r = 0)
		{
			clickA(this.Interface.botonWithdrawAll.area)
		}	
	}
	
	clickDepositarInv()
	{
		Global
		clickA(this.Interface.botonDepositarInv.area)
	}
	
	
	
	
	;compruba si esta visible
	estaVisible()
	{
		Global
		Local r
		;this.Monitor.hola()
		r := this.Monitor.comparaLPC(this.Interface.LPC)
		;Si la LPC coincide entonces el banco esta visible
		return r
	}
	
	;Crea un areferencia a cada celda, de modo que no se haga una copia de datos. Luego agrega la funcion de logica, estaVacia()
	;En este momento no me concentrare en hacerlo de la MEJOR MANERA, solo QUE FUNCIONE.
	;por eso elijo hacer una vil copia de los datos y hacer de la clase _celda una ENVOLTURA o wrapper de la celda de la interface
	class _celda
	{
		;todos los datos de la interface celda deben ser pasados por referencia no una copia
		x := 0 
		y := 0
		area := {}
		ancho := 0
		alto := 0
		LPC := []
		Monitor := {} ;una referencia al monitor
		__New(ByRef IntCelda, ByRef Monitor)
		{
			;Segun lo que ley las referencias pasadas a esta funcion no son referencias realmente. No se referencia variables de objetos, "Interface.celda" no se referencia, solo "Interface" se puede
			this.x := intCelda.x
			this.y := intCelda.y
			this.area := intCelda.area
			this.ancho := intCelda.ancho
			this.alto := intCelda.alto
			this.LPC := intCelda.LPC
		}
		
		;indica si la celda a la cual referencia esta vacio o no
		estaVacia()
		{
			Global
			Local r := 0
			;Por eficiencia los colores base solo deben ser los del banco
			Local coloresBase := ["0x29353E", "0x2C3640","0x26323B","0x2D3840","0x344049", "0x333E48", "0x323D46"]
			Local y := 16 ;+16 relativo al eje y de la celda
			Local cA := ""
			Local esBase := false
			;Local j := 0
			;recorre el eje x en busca de cualquier color que no se base
			
			;si coinciden entonces la celda esta vacia
			loop, % this.ancho
			{
				;comienso en celda.x
				PixelGetColor, cA, (this.x - 1) + A_index, this.y + y
				
				if (!ErrorLevel)
				{
					j := 1
					esBase := false
					loop, % coloresBase.length()
					{
						if (cA = coloresBase[j])
						{
							;el color es BASE, continuar
							esBase := true
							break
							
						}
						j++
					}
					if (esBase)
					{
					
					}
					else
					{
						return 0
					}
					
					
				}
				else
				{
					;hubo error pero para continuar apesar de ello, lo dejare pasar
				
				}
			
			}
			;si llego aqui entonces todos los colores son base, la celda esta vacia
			return 1
		}
	
	}
	

} ;fin de clase principal



/*METODO DE BOTON WITHDRAW ALL
estaActivo()
		{
			Global
			Local cA := ""
			cA := this.Monitor.colorActualIndicador(this.indicadorID)
			
			if (cA != this.colorIndicadorBase)
			{
				;el color base es el inactivo, si es diferente se considera activo
				
				return 1
			}
			else
			{
				return 0
			}
		}
		
		
*/