#include Nucleo/RS_Datos.ahk

;Se buscan objetos en celdas de bancos o de inventario. No se buscan objetos en areas completas (por ahora) porque es mas dificil

;Recive la celda y un arreglo con las id de los objetos a buscar. de 1 a infinito. 
;retorna la idItem del priemer objeto que encontro en la celda. 0 si no consigue alguno de los items dados.
;las lista de colores base de la celda sirve para reconocer los colores de la plantilla de un objeto que son referencia a un color del fondo de la celda.

;La ocurrecia de un objeto es demaciado estricara, con una aprobacion del 80% se puede decir que un objeto esta contenido en la celda.
buscarObjetoEnCelda(ByRef celda, idItem)
{
	
	Global
		Local cA := "" ;color actual
		Local esBase := false ;
		Local j := 1 ;indice
		Local pc := 0 ;indice punto-color
		;Una lista de los colores base del inventario y banco-primero estan los del inventario.
		Local coloresBase := ["0x29353E", "0x2C3640","0x26323B","0x2D3840","0x344049", "0x333E48", "0x323D46"]
		;;la LPC puede tener colores que indican vacio, estos colores son tratados de forma diferente por el detector, los considera de la misma familia, cualquiera se considItemera iguales
			;MsgBox, estoy aqui...
			;La plantilla debe indicar los lugares donde hay un color base, de la misma foram, quisas dejando una señal -1 , para indicar que en ese punto va un color base
			pc := 1
			;ToolTip, evaluando...
			;	Sleep 2000
			;	ToolTip
			;	Sleep 100
			loop, % items[idItem].plantillaLPC.length()
			{
				
				;recupero el color actual en el punto, sumo la plantilla a la pos de la celda para hallar los puntos correctos
				PixelGetColor cA, celda.area.x1 + items[idItem].plantillaLPC[pc].x, celda.area.y1 + items[idItem].plantillaLPC[pc].y
				
				if (!ErrorLevel)
				{
					;el color tiene que ser igual al de la plantilla
					if (cA = items[idItem].plantillaLPC[pc].color)
					{
						;continua porque hay que comprobar los demsa puntos
						;ToolTip, Coincide...
						;Sleep 2000
						;ToolTip
						;Sleep 100
					}
					else 
					{
						;El color no coincide, pero algunos colores pueden corresponder a la base, si el color corresponde a la base, se deja pasar por esta ocasion
						;Compruba que el color no es un color de base
						j := 1
						loop, % coloresBase.length()
						{
							esBase := false
							if(cA = coloresBase[j])
							{
								;Este color es un color base, si no coincide con el actual puede significar que el objeto esta en la celda solo que este color es diferente en el fondo de la celda
								;Para efectos de busqueda estos colores se consideran iguales
								esBase := true
								break
								;Continua con el siguiente color
							}
							j++
						}
						;si el color es un color base
						if (esBase)
						{
							;continua pero result que si todos los colores son base entonces esta es una celda vacia
							;el color J es un color base, pero acasa en esta posicion va un colo base?
							;si aqui no va un color base entonces no coincidio un pixel.
							;Si en esta posicion de la plantilla se reconoce que va un color base, no hay peo
							;ToolTip, Es Base...
							;Sleep 2000
							;ToolTip
							;Sleep 100
							
							;Si la plantilla dice que no deberia haber un color base entonces error, este objeto no coincide
							j := 1
							loop, % coloresBase.length()
							{
								esBase := false
								;Si la plantilla indica que debe haber un color base
								if(coloresBase[j] = items[idItem].plantillaLPC[pc].color)
								{
									;Este color es un color base, si no coincide con el actual puede significar que el objeto esta en la celda solo que este color es diferente en el fondo de la celda
									;Para efectos de busqueda estos colores se consideran iguales
									esBase := true
									break
									;Continua con el siguiente color
								}
								j++
							}
							
							;Si el color en la plantilla es un color base entonces esta bien que el color actual tambien lo sea
							if (esBase)
							{
								;continua
								;ToolTip, Base aprobado...
								;Sleep 2000
								;ToolTip
								;Sleep 100
								
							}
							else
							{
								;La plantilla indico que no debe haber un color base en esta posicion
								;ToolTip, Base negado...
								;Sleep 2000
								;ToolTip
								;Sleep 100
								return 0
							}
							
							
							
						}
						else
						{
							;Un punto no coincide, este no es el objeto
							;ToolTip, No coincide...
							;Sleep 2000
							;ToolTip
							;Sleep 100
							return 0
						}
					
						
					}
					pc++
				}
				else
				{
					;indica erro durante operacion
					return 2
				}
			}
			;Si llego hasta aqui significa que todos los puntos coincidieron
			return 1
}

;busca en cada celda del inventario uno o varios objetos y devuelve las coincidencias
;recive un arreglo con las id de los objetos a buscar
;0 indica no hay coincidencias, -1 indica error, de otro modo se retorna lo lla mencionado
buscarObjetoEnInventario(Ids)
{
	Global
	;conoce la global de inventario asi que por hay no hay problem
	;busca en cada una de las 28 celdas del inventario las coincidencias con las ids y
	;devuelve un arreglo indicando que objeto se allo en cada celda.
	;una celda sin objeto allado significa que no contiene uno de los objetos buscados, no significa que la
	;celda este vacia
	;basicamente devuelve que objeto hallo y donde

}

;similar a la anterior pero buca en las casillas del banco, las que esten visibles.
buscarObjetoEnBanco()
{
;busco en cada celda del banco una coincidencia y registro las coincidencias.
;el lloop debe recorre las celdas del banco que este visibles. para saberlo puedo hacer
		;bank.ancho/casillas.ancho * banco.alto/celda.alto. impresiso pero es una aproximacion a la cantidad de celdas visibles.
		;o quisas deba buscar hasta que me tope con un pixel por fuera de la ventana del banco.
}

;crea objeto
;revisa una celda y toma varios colores para crear una coleccion de indicadores. Esto sirve para definir objetos
;tambien puede llamarce creaItem
creaMatrisIndicadores()
{
	Global

}



