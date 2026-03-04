;Sigo con el mismo peo de separar los datos de la logica. 
;DATOS, ESTRUCTURA POR UN LADO, CON CONTROL Y MANEJO DE DATOS, LOGICA DE OPERACIONES POR OTRO LADO.


;#INTERFACE BANCO#
;Incluye los datos de la estructura grafica de un banco, sus limites y sus componentes.

class _InterfaceBanco
{
	ID := 0
	nombre := ""
	interfacePadreID := 0
	x := 0
	y := 0		
    ancho := 0
    largo := 0
    margenInternoIzq := 0
    margenInternoArr := 0
    coloresBase := [] ;es tambien el colorBase de todas las celdas, Estan en orden de mas frecuente a menos frecuente
    celda := []
	Monitor := {} ;espero que sea una referencia al monitor global, y que no sea una copia
	LPC := [] ;lista punto colo del banco
	botonWithdrawAll := {} ;el area y lpc de este boton
	botonCerrar := {} ;
	botonDepositarInv := {}
	plantillaLPCCelda := {} ;la lpc de una celda vacia, con esto puedo saber si una celda esta vacia/llena
    ;ventanaPadre
    ;creo que tambien le voy a tener que pasar el monitor global
	;CELDAS_BLOQUEADAS := [] , puede servir para celdas llenas de marcas rojas, en principio es inutil por ser tan especifico, es algo que el usu puede manejar con facilidad
    __New(ByRef InterfaceGlobal)
    {
		Global
		;En caso de que la interface global no exista no se puede iniciar el banco
		this.ID := 5
		this.nombre := "Banco"
		this.base := InterfaceGlobal ;el obejto interface global, debe ser creado con antelacion
		this.interfacePadreID := InterfaceGlobal.ID
		;las posiciones de la ventana Inventory son relativas a la InterfaceGlobal, la ventana SunAwtFrame2
		;Coordenadas del banco
		Local GlobalXMin = 765 ;el tamanio minimo de la ventana
		Local GlobalXMax = 1330 ;el tamanio maximo de la ventana
		Local xIniMin = 31 ;el punto xIni del banco cuando la ventana esta al minimo
		Local xIniMax = 313 ;el punto xIni del banco cuando la ventana esta al Maximo
		;InterfaceGlobal.ancho - GlobalXMin +1, el +1 indica que la posicion GlobalXMin no se considera, es decir que se cuenta desde 766 en adelante
		;al minio son globalx + 31 y al maximo son globalx + 31 + 282 y no se cuentan los decimales
        this.x := InterfaceGlobal.x + xIniMin + Floor(((InterfaceGlobal.ancho - GlobalXMin)/2))
        this.y := InterfaceGlobal.y + 2 ;1 solo si el tamaño de interface comiensa desde 1, porque si comiensa des 0 es +2
		this.ancho := 488 ;desde la posicion 0 hasta la final son 488 pixeles
		;El alto varia segun lo alto de la ventana pero el banco siempre comiensa en Global + 2 y termina en Global.Alto - 167
		this.alto :=  InterfaceGlobal.alto -167 - 1 
		this.margenInternoIzq := 45 ;o 57-12 porque no estoy seguro
        this.margenInternoArr := 73
		this.coloresBase := ["0x344049", "0x333E48", "0x323D46"] ;ordenados por frecuencia de aparicion, para saber si una celda esta vacia
		this.Monitor := InterfaceGlobal.Monitor ; &MonitorGlobal?
		;las posiciones en la LPC son relativas a la celda, pero la LPC final debe estar hubicada con relacion a la ventana
		;Los colores posibles en las celdas de banco cuando estan vacias crean una lista de colores base, cualquiera de esos colores es un color vacio, que sirve para identificar una celda vacia.
		
	
		;como la posicion de los puntos depende del tamanio de la venta tal y como el propio banco sera mas intuitivo indicar los puntos relativos al banco
		;La siguiente relacion entre puntos y colores es demaciado espesifica, y por tanto es propensa a fallas en cuanto una posicion no coincida, para identificar el Banco con mayor tolerancia a fallas
		;es mejor usar una coleccion de los colores del borde para buscarlos luego.
		Local pc1 := {x:this.x + 2, y:this.y + 72,color:"0x101212"}
		Local pc2 := {x:this.x + 327, y:this.y + 1,color:"0x1A1C1C"}
		Local pc3 := {x:this.x + 484,y:this.y + 134,color:"0x222525"}
		Local pc4 := {x:this.x + 2, y:this.y + 276,color:"0x101212"}
		Local pc5 := {x:this.x + 484, y:this.y + 305,color:"0x222525"}
		this.LPC := [pc1,pc2,pc3,pc4,pc5]
		Local caracteristicasCelda := {ancho:36, alto:32 ,margenArriba:4, margenIzquierdo:12}
		
        ;comienso a ubicar cada celda
		Local acumuladoX := (this.x - 1) + this.margenInternoIzq + caracteristicasCelda.margenIzquierdo
		Local acumuladoY := (this.y - 1) + this.margenInternoArr + caracteristicasCelda.margenArriba
		Local x1 := 0
		Local y1 := 0
		Local x2 := 0
		Local y2 := 0
		Local count := 1
		;7 filas
		loop, 7
		{	
			y1 := acumuladoY + 1
			y2 := acumuladoY + caracteristicasCelda.alto
			;8 columnas
			loop, 8
			{
					
				x1 := acumuladoX + 1
				x2 := acumuladoX + caracteristicasCelda.ancho
				;debo crear la LPC de esta celda, que?
				;En realidad las celdas no tienen LPC, las lpc son de objetos
				;Si sigo esta logica entonces puedo definir un OBJETO VACIO, que es la union en orden clualquiera de los colores base, entonces una celda solo necesita conocer su OBJETO VACIO, o mejor dicho
				;La coleccion de colores base
				;LPCCelda := plantillaALPC(this.plantillaLPCCelda, x1,y1,x2,y2)
				;Quisas sea mas combeniente crear una clase Celda
				this.celda[count] := {x:x1, y:y1, area:{x1:x1, y1:y1, x2:x2, y2:y2}, ancho:caracteristicasCelda.ancho, alto:caracteristicasCelda.alto, coloresBase: this.coloresBase} ;LPC:LPCCelda
				
				;Acumulo la celda
				acumuladoX := acumuladoX + caracteristicasCelda.ancho + caracteristicasCelda.margenIzquierdo
				
				;se puede decir que acumuladoX es igual a X2 en este punto
				count++
			}
			acumuladoX := (this.x - 1) + this.margenInternoIzq + caracteristicasCelda.margenIzquierdo
			acumuladoY := acumuladoY + caracteristicasCelda.alto + caracteristicasCelda.margenArriba
			;y1 := y2 + caracteristicasCelda.margenArriba
			;y1 := y2
			;x1 := this.x + this.margenInternoIzq
		}
		
		
		;#inicio los botones especiales
		
		this.botonWithdrawAll := new this._botonWithdrawAll(this)
		this.botonCerrar := new this._botonCerrar(this)
		this.botonDepositarInv := new this._botonDepositarInv(this)
		
		

    }
	
	class _botonWithdrawAll
	{
		;el area relativa a la ventana o a la ventana banco. Puedo hacerlo de ambas forma.
		x := 0
		y := 0
		ancho := 0
		alto := 0
		area := {}
		indicadorID := 0 ;el objeto guarda una id del indicador que se le crear con el objeto monitor
		xIn := 0
		yIn := 0
		colorIndicadorBase := "" ;el color base en la posicion del indicador
		Monitor := {} ;
		;Para saber si esta activo
		__New(ByRef banco)
		{
			Global
			;el ancho y el alto ya incluyen las posiciones iniciales x1, y las finales x2. Luego tendre que quitarlas
			this.ancho := 25
			this.alto := 22
			
			;su area se hubica relativa al banco
			Local bancoX2 := (banco.x - 1) + banco.ancho
			Local bancoY2 := (banco.y - 1) + banco.alto
			;calculo las coordenadas finales del baton
			Local x2 := bancoX2 - 158
			Local y2 := bancoY2 - 5  ;6 ES EL MARGEN, .-1 para llegar a la la y2
			;calculo las coordenadas iniciales del boton
			this.x := x2 - (this.ancho - 1) ;el primer pixel en x 
			this.y := y2 - (this.alto - 1) 	;el primer pixel en y
			
			this.area := {x1:this.x, y1: this.y, x2:x2, y2:y2}
			;Las coordenadas del indicador del boton, estas son relativas al boton
			;Las coordenadas del indicador son datos que debe formar parte del objeto
			this.xIn := this.x + 20 ;desde la posicion inicial se recorren 20 pixeles hasta el indicador
			this.yIn := this.y + 11 ;dese la posicion inicial etc etc
			;this.Monitor := banco.Monitor
			this.indicadorID := 0 ;el indicador se agrega despues, por el momento es desconocidos
			this.colorIndicadorBase := "0x4D5252" ;en lugar de revisar el color de un punto deberia buscar un color activo en el area del boton, es menos propenso a fallas.
		}
		
	} ;fin de sub-case

	class _botonCerrar
	{
		
		x := 0
		y := 0
		ancho := 0
		alto := 0
		area := {}
		;Para saber si esta activo
		__New(ByRef banco)
		{
			Global
			this.ancho := 26
			this.alto :=  23
			;su area se hubica relativa al banco
			Local x2 := ((banco.x-1) + banco.ancho) -  3
			this.x :=  x2 - 25 ;el primer pixel en x 
			this.y := banco.y + 6	;el primer pixel en y
			
			this.area := {x1:this.x, y1:this.y, x2:x2, y2:(this.y-1) + this.alto}
		}
	} ;fin de sub-case

	class _botonDepositarInv
	{
		;el area relativa a la ventana o a la ventana banco. Puedo hacerlo de ambas formas
		x := 0
		y := 0
		ancho := 0
		alto := 0
		area := {}
		;Para saber si esta activo
		__New(ByRef banco)
		{
			Global
			this.ancho := 36
			this.alto :=  36
			;su area se hubica relativa al banco
			;-78
			Local x2 := ((banco.x - 1) + banco.ancho) - 43
			Local y2 := ((banco.y - 1) + banco.alto) - 6
			this.x := x2 - (this.ancho - 1 ) ;el primer pixel en x 
			this.y := y2 - (this.alto - 1) ;el primer pixel en y
			
			this.area := {x1:this.x, y1: this.y, x2:x2,y2:y2}
		}
	} ;fin de sub-case

	
} ;fin de clase principal