;usa una plantilla de LPC para crear la LPC de la celda actual

plantillaALPC(plantilla, x1,y1,x2,y2)
{
	Global
	Local LPC := []
	loop, % plantilla.length()
	{
		LPC[A_index] := {x:plantilla[A_index].x + x1, y:plantilla[A_index].y + y1, color:plantilla[A_index].color}
	}
	return LPC
}

