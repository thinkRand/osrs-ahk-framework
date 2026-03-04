
;Inica si la opcion dada esta activa
estaActiva()
		{
			Global
			Local colorEnIndicador := ""
			;Como pixel get color  actua segun las coordendas de la ventana, el monitor conoce las coordenadas de la ventana y traduce las coordenadas relativas a la interfaceGlobal a relativas a la ventana.
			;debo asegurarme de conocer al objeto monitor de la clase superior a esta
			;Tooltip, % "En funcion esta activa. Monitor tiene xG = " this.Monitor.xG
			;sleep 5000
			;las variables no debe tener nombre parecidos a variables Globales, o debe restringirse a que todo aqui es local
			
			colorEnIndicador := this.Monitor.colorActualIndicador(this.indicadorID)
			;tooltip, % c
			;sleep 1000
			if (colorEnIndicador  = this.colorBase)
			{
				return false
			}
			else if(colorEnIndicador = this.colorActivo)
			{
				return true
			}
			else
			{
				;Tooltip, % "c = " c "colorBase = " this.colorBase "colorActivo = " this.colorActivo
				;sleep 1000
				;el color no se reconoce
				 ;return -1
				;PARA SOPORTAR LOS ERRORES VOY A INDICAR TRUE, para continuar pese  a la diferencia de color
				return true
			}
		}
		
		
		
		
		
		
	;BarraOpciones.opcionActiva(), lee los indicadores de cada opcion en busca de la opcion activa y retorna el Num de la Opcion
	opcionActiva()
		{
			Global
			Local resultado
			;Se que son exactamente 13 opciones, ni mas ni menos, y cuento con ello.Solo una esta activa a la vez
			loop, 13
			{
				resultado := this.opcion[A_index].estaActiva()
				if (resultado = true)
				{
					return, A_index
					;Tooltip, % "Op " A_index " = " BarraOpciones.opcion[A_index].estaActiva()
				}
				
			}
			;en caso de que ninguna opcion tenga un valor true devuelvo 0
			return 0
			
		}