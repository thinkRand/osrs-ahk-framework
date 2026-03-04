
class _InterfaceMagia
{
	ID := 0
	nombre := ""
	opcionID := 0 ;la id de la opcion en la barra de opciones.
	interfacePadreID := 0
	x := 0
	y := 0		
    ancho := 0
    largo := 0
    margenInternoIzq := 0
    margenInternoArr := 0
    coloresBase := [] ;
    celda := []
	LPC := []

	 __New(ByRef InterfaceGlobal)
        {
			Global
			this.base := InterfaceGlobal
			this.ID := 4
			this.nombre := "Magia"
			this.opcionID := 7
			this.interfacePadreID := InterfaceGlobal.ID
			
			;las posiciones de la ventana de Magic son relativas a la InterfaceGlobal, la ventana SunAwtFrame2
            this.x := InterfaceGlobal.x + InterfaceGlobal.ancho - 204 
            this.y := InterfaceGlobal.y + InterfaceGlobal.alto -311 
			this.ancho := 204
			this.alto := 275
			this.margenInternoIzq := 10
        	this.margenInternoArr := 7
			this.coloresBase := ["0x26323B"]
		
			
			;El color esta en formato BGR porque asi lo da pixel get color y pixel search recive BGR
			;tengo que sumar la pos de la ventana
			Local pc1 := {x:InterfaceGlobal.ancho - 201 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 299, color:"0x36484F"}
			Local pc2 := {x:InterfaceGlobal.ancho - 201 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 187, color:"0x405057"}
			Local pc3 := {x:InterfaceGlobal.ancho - 202 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 59, color:"0x36484F"}
			Local pc4 := {x:InterfaceGlobal.ancho - 5 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 292, color:"0x36484F"}
			Local pc5 := {x:InterfaceGlobal.ancho - 4 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 168, color:"0x405057"}
			Local pc6 := {x:InterfaceGlobal.ancho - 5 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 59, color:"0x36484F"}
			this.LPC := [pc1, pc2, pc3, pc4, pc5, pc6]
            ;comienso a ubicar cada celda
			Local x1 := this.x + this.margenInternoIzq
			Local y1 := this.y + this.margenInternoArr
            Local caracteristicasCelda := {ancho:24,alto:24 ,margenArriba:0, margenIzquierdo:2}
            Local count := 1
			;10 filas
			loop, 10
			{	
				y1 := y1 + caracteristicasCelda.margenArriba
				y2 := y1 + caracteristicasCelda.alto
				;7 columnas
				loop, 7
				{
					
					x1 := x1 + caracteristicasCelda.margenIzquierdo
					x2 := x1 + caracteristicasCelda.ancho
					;indicadorID: this.Monitor.agregarIndicador(x1+16, y1+16) queda para el objeto Magic
					this.celda[count] := {x:x1, y:y1, area:{x1:x1, y1:y1, x2:x2, y2:y2}, ancho:caracteristicasCelda.ancho, alto:caracteristicasCelda.alto}
					x1 := x2
					count++
				}
				y1 := y2
				x1 := this.x + this.margenInternoIzq
			}	
		}


} ;fin de class










;################################################################
;abajo lo que estaba definicio dentro dle documento interfaceGlobal


;# INTERFACE MAGIC#
;Interface Magic, incluye solo la definicion de la interface (conjunto de datos estructurados): Propiedades y relaciones. La logica se debe definir con un manejador.
class _InterfaceMagic
{
	ID := 0
	nombre := ""
	opcionID := 0 ;la id de la opcion en la barra de opciones.
	interfacePadreID := 0
	x := 0
	y := 0		
    ancho := 0
    largo := 0
    margenInternoIzq := 0
    margenInternoArr := 0
    colorBase := "" ;
    celda := []
	Monitor := {}
	;Lista Punto-Color, para comprobar que la interface esta visible. Es una lista de los pares de punto y su color
	listaPC := []

	 __New(ByRef InterfaceGlobal)
        {
			Global
			this.ID := 4
			this.nombre := "Magia"
			this.opcionID := 7
			this.interfacePadreID := InterfaceGlobal.ID
			this.Monitor := InterfaceGlobal.Monitor
			;las posiciones de la ventana de Magic son relativas a la InterfaceGlobal, la ventana SunAwtFrame2
            this.x := InterfaceGlobal.ancho - 204 + InterfaceGlobal.x
            this.y := InterfaceGlobal.alto -311 + InterfaceGlobal.y
			this.ancho := 204
			this.alto := 275
			this.margenInternoIzq := 10
        	this.margenInternoArr := 7
			this.colorBase := "0x26323B"
		
			
			;El color esta en formato BGR porque asi lo da pixel get color y pixel search recive BGR
			;tengo que sumar la pos de la ventana
			pc1 := {x:InterfaceGlobal.ancho - 201 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 299, color:"0x36484F"}
			pc2 := {x:InterfaceGlobal.ancho - 201 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 187, color:"0x405057"}
			pc3 := {x:InterfaceGlobal.ancho - 202 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 59, color:"0x36484F"}
			pc4 := {x:InterfaceGlobal.ancho - 5 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 292, color:"0x36484F"}
			pc5 := {x:InterfaceGlobal.ancho - 4 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 168, color:"0x405057"}
			pc6 := {x:InterfaceGlobal.ancho - 5 + InterfaceGlobal.x, y: (InterfaceGlobal.y + InterfaceGlobal.alto) - 59, color:"0x36484F"}
			this.listaPC := [pc1, pc2, pc3, pc4, pc5, pc6]
			caracteristicasCelda := {ancho:24,alto:24 ,margenArriba:0, margenIzquierdo:2}
            ;comienso a ubicar cada celda
			Local acumuladoX := (this.x - 1) + this.margenInternoIzq + caracteristicasCelda.margenIzquierdo
			Local acumuladoY := (this.y - 1) + this.margenInternoArr + caracteristicasCelda.margenArriba
			
			count := 1
			;10 filas
			loop, 10
			{	
				y1 := acumuladoY + 1
				y2 := acumuladoY + caracteristicasCelda.alto
				;7 columnas
				loop, 7
				{
						
					x1 := acumuladoX + 1
					x2 := acumuladoX + caracteristicasCelda.ancho
					;debo crear la LPC de esta celda
					LPCCelda := plantillaALPC(this.plantillaLPCCelda, x1,y1,x2,y2)
					this.celda[count] := {x:x1, y:y1, area:{x1:x1, y1:y1, x2:x2, y2:y2}, ancho:caracteristicasCelda.ancho, alto:caracteristicasCelda.alto, LPC:_LPCSpellStandard[count]} ;LPC:_LPCSpellStandard[]
					
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
		}


} ;fin de class
