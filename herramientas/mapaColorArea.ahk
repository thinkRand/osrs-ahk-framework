


;de un area dada lista todos los colores

;scanArea()
;scanPixelArea()

;como maximo se inspeccionan cuadros de 800x800
crearListaColores(area)
{
	Global
	Local desdeX := 0
	Local hastaX := 0
	Local desdeY := 0
	Local hastaY := 0
	Local errores := 0
	Local lista := []
	Local filaY := 0
	Local columna := 0
	;se recorre de arriba a abajo y de izquierda a derecha
	desdeX := area.x1
	hastaX := area.x2
	desdeY := area.y1
	hastaY := area.y2
	;el loop debe acabar cuando llegue hasta hastaX y hastaY con un BREAK
	;FILAS
	filaY := desdeY
	loop, 800
	{
		
		;COLUMNAS
		columnaX := desdeX
		loop, 800
		{
			PixelGetColor, cXY , columnaX, filaY
			if (!ErrorLevel)
			{
				lista.push(cXY)
				columnaX++
				;si la coor x es la ultima 
				if (columnaX >= hastaX)
				{
					;detengo la busqueda en x
					break
				}
			}
			else
			{
				;se contiua sin agregar a la lista 
				errores++
				columnaX++
				;si la coor x es la ultima 
				if (columnaX >= hastaX)
				{
					;detengo la busqueda en x
					break
				}
			}
			
		
		}
		;cuado termine todas las columnas bajo a la otra fila
		filaY++
		if (filaY >= hastaY)
		{
			;detengo la busqueda en x
			break
		}
	
	}
	
	MsgBox, % "el primero color fue " lista[1]
	return lista

}

;Una lista puede ser de dos dimenciones o de una dimencion
;Debe recorrer todos los caminos,;
;Creo que se puede resolver con el objeto ENUMERATOR, y se pondria while enum[unico[color, grupo]]
listaColoresAClipBoard(lista)
{
	Global
	Local contenido := "lista := ["
	
	;averigua cuantas dimenciones tiene una lista
	;lista[1]  no debe ser un arreglo, debe ser un valor, pero encaso de que sea un arreglo como lo detecto, isArray??
	
	loop, % lista.length()
	{
		contenido .= lista[A_index] . "`n,"
	}
	contenido .= "]"
	
	ClipBoard := contenido
}

;lo hago especifico para salir de este peo rapidamente
listaColorGrupoAClipboard(lista)
{
	Global
	Local contenido := "lista := ["
	;la lista esta compuesta por posiciones que contiene pares de color, grupo
	MsgBox,% "la cantidad de pares recividos es " lista.length()
	;recorro la cantidad de pares
	loop,% lista.length()
	{
		;de este par tomo la informacion color, grupo
		contenido .= "`n" . lista[A_index][1] . "," . lista[A_index][2]
	}
	
	contenido .= "]"
	
	ClipBoard := contenido
}

;toma una lista y la agrupa por cantidad.
listaAgrupar(lista)
{
	Global
	Local Unicos := [] ;Es un arreglo de pares ;para que sea mas rapido la lista de unicos debe contener el color mas frecuente de primer lugar
	Local noEsta := true
	Local indexUn := 0
	Local indexLis := 0
	
	
	indexLis := 1
	loop,% lista.length()
	{
		noEsta := true ;indica que este color no esta en la lista de unicos, 
		indexUn := 1
		;recorro la cantidad de pares [color, grupo]
		loop, % Unicos.length()
		{
			;si el color en lista ya esta en unicos
			if (lista[indexLis] = Unicos[indexUn][1])
			{
				;el color ya se encuentra y por tanto
				noEsta := false
				break
			}
			else
			{
				indexUn++
			}
			
		}
		
		;si el color no esta en Unicos 
		if (noEsta)
		{
			;Lo agrego a unicos
			Unicos.push([lista[indexLis], 1])
		}
		else if (!noEsta)
		{
			;en caso de que el color si esta en unicos
			;aumento su grupo
			Unicos[indexUn][2]++
		}
		
		indexLis++
	}
	MsgBox,% "la cantidad de pares es " Unicos.length()	
	MsgBox, % "El primer grupo es " Unicos[1][1] "," Unicos[1][2] 
	return Unicos

}