

;Si la celda 1 coincide significa que esta activa, en cambio si las otras coinciden significa que no estan activas.
;puedo poner la opocion PREFECT, para coincidencias perfectas y  85%, para aprobar en caso de un alto porcentaje de coincidencia
comparaLPCSPELL(celda)
{
	Global
	Local cA := "" ;color Actual
	
	loop, % celda.LPC.length()
	{
		PixelGetColor, cA, celda.x + celda.LPC[A_index].x, celda.y + celda.LPC[A_index].y
		MouseMove, celda.x + celda.LPC[A_index].x, celda.y + celda.LPC[A_index].y, 20
		if(cA = celda.LPC[A_index].color) 
		{
			;este colo coincide, continuar
			;Tooltip, Coincide
			;Sleep 1000
			;Tooltip
			;Sleep 500
		}
		else
		{
			;este color no coincide
			;Tooltip, No coincide %cA%
			;Sleep 1000
			;Tooltip
			;Sleep 500
			return 0
		
		}
	}
	;si todo sale bien debo llegar hasta aqui
	return 1
}