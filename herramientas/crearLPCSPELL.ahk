

crearLPCSpell(celda)
{
	Global
	;Los spell tienen un ancho y un alto de 24
	;Los spell no se usan tan frecuentemente como la busque da objetos y los spell se puede parecer los unos a los otros si no se escoge con sabiduria
	;Para los spell se necesita una LPC mas poderasa, una que trace una cruz en vertical y horizontal y que se junten en el medio, es decir 48 colores por spell CUANTOOO!!!?
	;comparar 48 colores y se hace muy rapido asi que sigue siendo comveniente
	Local xRel := 11 ;relativo al eje x
	Local yRel := 11 ;relativo al eje Y
	Local LPC := "["
	Local xC := ""
	Local yC := ""
	Local i := 0
	Local j := 0
	;Tomo los puntos de la line X
		
		
			j := 1
			loop, % celda.alto
			{
		
				;MouseMove, x, y, 10
				PixelGetColor, yC, celda.area.x1 + xRel, celda.area.y1 + j
				
				if (!ErrorLevel)
				{
					LPC := LPC . "`n,{x:" . xRel . ", y:" . j . ", color:'" . yC . "'}"
				}
				else
				{
					MsgBox, Error fatal.
					return 0
				}
				j++
			}
		
		
		loop, % celda.ancho
		{
			;MouseMove, x, y, 10
			PixelGetColor, xC, celda.area.x1 + A_index, celda.area.y1 + yRel
			
			if (!ErrorLevel)
			{
				LPC := LPC . "`n,{x:" . A_index . ", y:" . yRel . ", color:'" . xC . "'}"
			}
			else
			{
				MsgBox, Error fatal.
				return 0
			}
		}
		
		
		LPC .= "]"
		;ClipBoard := LPC
		return LPC
	
}