;#Include Nucleo/RS_InterfaceGlobal.ahk --> aqui no se debe inicialisar nada, esto solo es datos y su estrucutr con sus controles, y gestiones
#Include Nucleo/RS_SidePanel.ahk
;La interface inventario no se puede hubicar correctamente si no se tiene la interface global, por eso es necesario crear principalmente la interface Global
;La interface global debe ser un centro, un nucleo, una estructura de informacion que se lee. Entonces las demas interfaces estan en comunicacion con la interface Global, leyendo su estructura de datos
;para su uso. En este caso puede ser combeniente que la interface global tenga relacion con las demas con extends, de esa manera las anteriores podran acceder a la informacion de primera mano
;Lo que necesito es un modo para que la informacion que se cambie en la interface global este disponible directamente para todas las demas, es decir, solo puede haber un objeto interfaceGlobal, al que 
;se le puede cambiar sus coordenadas y las nuevas coordenadas estan disponibles en todas partes ya que cada interface subordinada tiene una referencia a la variables de la interfaces global, mas
;y no una copia, referencia a una variable dentro de un objeto???, quisas pueda resolver esto creando unas super globales para contener esta informacion, en caso de que no puede hacer referencias a variables
;dentro de un objeto.
;Quiero lograr una actualisacion en cascada

;La interface siempre debe proporcionar informacion actualisada sobre su posicion. El unico factor dinamico en ese calculo es la interface global. Por tanto cada ves que se solicite una posicion
;se debe contar con la informacion de la interface global. Es decir, cada ves que se accede a una posicion de la interface inventario , esa posicion debe ser calculada en base a la posicion de la inteface global

;Que es mejor:
	;mantener una actualisasion cada ves que requiera una posicion
	;Actualisar todo y mantener un acceso a esa informacion
	
;Creo que es mas combeniente crear una funcion para actualisar todo, una ves que se note un cambio. en lugar de mantener un calculo cada ves que una variables se solicite

class _InterfaceInventario
{
	ID := 0
	nombre := ""
	opcionID := 0
	x := 0
	y := 0		
	ancho := 0
	largo := 0
	margenInternoIzq := 0
	margenInternoArr := 0
	coloresBase := []
	celda := []
	Monitor := {} ;espero que sea una referencia al monitor global, y que no sea una copia
	;ventanaPadre
	;creo que tambien le voy a tener que pasar el monitor global
	;CELDAS_BLOQUEADAS := [] 
	;celdasBloqueadas := []--->Probablemente no necesite esto despues.
	;los parametro recividos se debe actualisar, la interface global no se recive de esta manera, o quisas si. La cosa es que siempre se debe saber de donde probiene la informacion debo priorisar la claridad.
	__New(ByRef interfaceGlobal)
	{
		Global
		;El objeto interface inventario tendra de base al objeto interface global
		base := InterfaceGlobal
		this.ID := 3
		this.nombre := "Inventario"
		this.opcionID := 4
		
		;Las posiciones de la ventana Inventory son relativas a la InterfaceGlobal, la ventana SunAwtFrame2
		this.x := (base.x + base.ancho - 204)  ;el problema con esto es que el valor se fija en el momento actual, no es dinamico. Tiene que ser dinamico. Cada variable debe tomar un valor de una ecpresion?
		this.y := (base.y + base.alto -311) 
		this.ancho := 204
		this.alto := 275
		this.margenInternoIzq := 13
		this.margenInternoArr := 11
		this.coloresBase := ["0x29353E", "0x2C3640","0x26323B","0x2D3840"]
		this.Monitor := MonitorGlobal ; &MonitorGlobal?
		this.celdasBloqueadas := [1, 2, 3] ;la casillas 1, 2 y la 3 estan bloqueadas, su contenido no sera botado, esto es una constante
		caracteristicasCelda := {ancho:32,alto:32 ,margenArriba:4, margenIzquierdo:10}
		
		;comienso a ubicar cada celda
		Local acumuladoX := (this.x - 1) + this.margenInternoIzq + caracteristicasCelda.margenIzquierdo
		Local acumuladoY := (this.y - 1) + this.margenInternoArr + caracteristicasCelda.margenArriba
		
		Local count := 1
		Local y1 := 0
		Local y2 := 0
		Local x1 := 0
		Local x2 := 0
		;7 filas
		loop, 7
		{
			y1 := acumuladoY + 1
			y2 := acumuladoY + caracteristicasCelda.alto
			;8 columnas
			loop, 4
			{
					
				x1 := acumuladoX + 1
				x2 := acumuladoX + caracteristicasCelda.ancho
					
				;this.celda[count] := {x:x1, y:y1, area:{x1:x1, y1:y1, x2:x2, y2:y2}, ancho:, alto:, indicadorID: }
				this.celda[cuenta] := new this._Celda(cuenta, x1, y1, x2, y2, this.Monitor.agregarIndicador(x1+16, y1+16))
				;Acumulo la celda
				acumuladoX := acumuladoX + caracteristicasCelda.ancho + caracteristicasCelda.margenIzquierdo
				
				;se puede decir que acumuladoX es igual a X2 en este punto
				count++
			}
			acumuladoX := (this.x - 1) + this.margenInternoIzq + caracteristicasCelda.margenIzquierdo
			acumuladoY := acumuladoY + caracteristicasCelda.alto + caracteristicasCelda.margenArriba
				
		}			
    } ;Fin de __NEW

/*
Las siguientes funciones forman parte de la idea de actualisacion FIABLE , esto sirve para que cada ves que la interface se le solicite alguna informacion esta este actualisada
	;Quisas la aproximacion mas optima o la mas clara sea usar los propiedades
	;cuando se haga interface.x se ejecuta la funcion return X dicha funcion esta declarada en las propiedades.

	;metodos ser y get de la variable x
	x
	{
		get
		{
			return (base.x + base.ancho - 204) 		
		}
	
	}
	
	y
	{
		get
		{
			;Si el ancho de la base llega a xxx minimo entonces la pos en y se reduce. en -XX
			return (base.y + base.alto -311)
		}
	}

*/
		
	actualisarPosiciones()
	{
		;Borro los datos anteriores
		this.x := 0
		this.y := 0
		celda := []
	
		;Reactualisar la posicion de esta interface
		this.x := (base.x + base.ancho - 204) 
		this.y := (base.y + base.alto -311)
		
		;Actualiso la posicion de las celdas
		caracteristicasCelda := {ancho:32, alto:32, margenArriba:4, margenIzquierdo:10}
		Local acumuladoX := (this.x - 1) + this.margenInternoIzq + caracteristicasCelda.margenIzquierdo
		Local acumuladoY := (this.y - 1) + this.margenInternoArr + caracteristicasCelda.margenArriba
		
		Local count := 1
		Local y1 := 0
		Local y2 := 0
		Local x1 := 0
		Local x2 := 0
		;7 filas
		loop, 7
		{
			y1 := acumuladoY + 1
			y2 := acumuladoY + caracteristicasCelda.alto
			;8 columnas
			loop, 4
			{
					
				x1 := acumuladoX + 1
				x2 := acumuladoX + caracteristicasCelda.ancho
					
				;this.celda[count] := {x:x1, y:y1, area:{x1:x1, y1:y1, x2:x2, y2:y2}, ancho:, alto:, indicadorID: }
				this.celda[cuenta] := new this._Celda(cuenta, x1, y1, x2, y2, this.Monitor.agregarIndicador(x1+16, y1+16))
				;Acumulo la celda
				acumuladoX := acumuladoX + caracteristicasCelda.ancho + caracteristicasCelda.margenIzquierdo
				
				;se puede decir que acumuladoX es igual a X2 en este punto
				count++
			}
			acumuladoX := (this.x - 1) + this.margenInternoIzq + caracteristicasCelda.margenIzquierdo
			acumuladoY := acumuladoY + caracteristicasCelda.alto + caracteristicasCelda.margenArriba
				
		}
	
	}


	;Cuando se acceda a una posicion de la celda esta depende de cual posicion; de el side panel? o de la interface global?	
	class _Celda
	{
		x := 0
		y := 0
		area := {}
		ancho := 0
		alto := 0
		n := 0 ;su numero en la lista de celdas
		estaBloqueada := false
		indicadorID := 0
		__New(n, x1, y1, x2, y2, indicadorID)
		{
			Global
			this.n := n
			this.x := x1
			this.y := y1
			this.area := {x1:x1, y1:y1, x2:x2, y2:y2}
			this.ancho := 32 ;el ancho de cada celda es 32 fijo
			this.alto := 32 ;el alto de cada celda es 32 fijo
			this.estaBloqueada := false ;ninguna celda recien creada esta bloqueada
			this.indicadorID := indicadorID
		}
			
	} ;fin de clase interna
	
} ;Fin de clase