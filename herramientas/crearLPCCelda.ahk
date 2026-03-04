
;Puede ser util crear lpc de 3, de 6, y de 9.

;Necesito una foto de un banco full para notar mejores formas para crear LPC de las celdas de un banco
;Igual para los inventario
;recive las dimenciones de una celda y crea una LPC estandar que consiste en 9 puntos
;SI UNA LPC NO SE PUEDE CREAR EN HORIZONTAL PORQUE SA VACIO, ENTONVES SE PRUEVA EN VERTICAL
OLD_crearLPCCelda(celda)
{
	Global
	Local x := []
	Local y := []
	Local f := 0
	Local LPC := []
	Local xP := 0
	Local yP := 0
	Local cP:= ""
	Local cuenta := 0 
	;Divido el ancho en 4 partes, dos de 10% y dos de 40% en el orden 10-40-40-10 y lo mismo para el alto
	;3 columnas
	;Floor(celda.ancho * porcentaje[i])
	;En lugar de floor quisas deba usar upp
	x[1] := (celda.x-1) + Floor(celda.ancho * 0.10) ;10%
	x[2] := (celda.x-1) + Floor(celda.ancho * 0.40) ;40%
	x[3] := (celda.x-1) + Floor(celda.ancho * 0.80) ;80%
	;3 filas
	y[1] := (celda.y-1) + Floor(celda.alto * 0.10)
	y[2] := (celda.y-1) + Floor(celda.alto * 0.40)
	y[3] := (celda.y-1) + Floor(celda.alto * 0.80)
	
	;3 filas
	f := 1 ;fila 1
	cuenta := 1
	loop, 3
	{
		;3 columnas
		c := 1 ;columna 1
		loop, 3
		{
			pixelGetColor, cP, x[c], y[f]
			if (!ErrorLevel)
			{
				LPC[cuenta] := {x:x[c], y:y[f], color:cP}
				c++
				sleep 100 ;100ms por captura para que se tome su tiempo
			}
			else
			{
				;indica error al crear la LPC
				MsgBox, Error.
				return 0
			
			}
			cuenta++
		}
		f++
	}

	return LPC
}

;Transforma un LPC a texto y lo pone en el clipboard
;Funcion aparte que no se incluye en el sistema
LPCAClipBoard(LPC)
{
	cantidad := LPC.length()
		contenido := "LPC :=[" 
		
			;el acento asia atras es el scape sequence de autohotkey
			loop, % LPC.Length()
			{
				contenido := contenido . ",{x:" . LPC[A_index].x . " , y:" . LPC[A_index].y . " ,color:'" . LPC[A_index].color . "' }"
			}
		contenido := contenido . "]"
		
	clipboard := contenido
}

;esta version usa una plantilla fija para hayar los pares PUNTOS-COLOR de un objeto
crearLPCCelda_x(celda)
{
	Global
	;Toma una celda y escanea los 9 puntos de la linea x + 6 +9 +12 +15 +18 +21 +24 +27 +30.
	Local xRel := [6,9,12,15,18,21,24,27,30] ;relativo al eje x
	Local yRel := 16 ;+16 relativo al eje Y
	Local LPC := "["
	Local xC := ""
	;Tomo los puntos de la line X
		loop, % xRel.length()
		{
			;MouseMove, x, y, 10
			PixelGetColor, xC, celda.area.x1 + xRel[A_index], celda.area.y1 + yRel
			if (!ErrorLevel)
			{
				LPC := LPC . "`n,{x:" . xRel[A_index] . ", y:" . yRel . ", color:'" . xC . "'}"
			}
			else
			{
				MsgBox, Error fatal.
				return 0
			}
		}
		LPC .= "]"
		ClipBoard := LPC
	
}


crearLPCCelda_y(celda)
{
	Global
	;Toma una celda y escanea los 9 puntos de la linea x + 6 +9 +12 +15 +18 +21 +24 +27 +30.
	Local yRel := [6,9,12,15,18,21,24,27,30] ;relativo al eje x
	Local xRel := 16 ;+16 relativo al eje Y
	Local LPC := "["
	Local yC := ""
	;Tomo los puntos de la line X
		loop, % yRel.length()
		{
			;MouseMove, x, y, 10
			PixelGetColor, yC, celda.area.x1 + xRel, celda.area.y1 + yRel[A_index]
			if (!ErrorLevel)
			{
				LPC := LPC . "`n,{x:" . xRel . ", y:" . yRel[A_index] . ", color:'" . yC . "'}"
			}
			else
			{
				MsgBox, Error fatal.
				return 0
			}
		}
		LPC .= "]"
		ClipBoard := LPC
	
}


;usa una plantilla de LPC para crear la LPC de la celda actual
/*
plantillaALPC(plantilla, x1,y1,x2,y2)
{
	Global
	Local LPC := []
	loop, % plantilla.lenght()
	{
		LPC[A_index] := {x:plantilla[A_index].x + x1, y:plantilla[A_index].y + y1, color:plantilla[A_index].color}
	}
	return LPC
}
*/
