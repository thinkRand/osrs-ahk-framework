/*
Aqui debe ir la coleccion de funciones para iniciar las interfaces y ademas para manejarlas

*/


cargar_todo()
{}

cargar_Magic()
cargar_Inventario()
cargar_Banco()
cargar_Plegaria()
cargar_Equipo()



cargar_BarraOpciones()
{
	Global
	if (InterfaceGlobal.existe)
	{
		BarraOpciones := new _MenuBarraOpciones(InterfaceGlobal)
		return 1
	}
	else
	{
		MsgBox, No se puede continuar porque la InterfaceGlobal no esta definido.
		return 0 ;indica un error
	}
} ;fin de funciones


cargar_Magic()
{
	Global
	if (InterfaceGlobal.existe)
	{
		InterfaceMagic := new _InterfaceMagic(InterfaceGlobal)
		;como hago que una clase sepa lo que esta fuera de ella, me refiero las variables
		Magic := New _Magic(InterfaceMagic)
	}
	else
	{
		MsgBox, No se puede continuar porque la InterfaceGlobal no esta definida.
		return 0 ;indica un error
	}

}





;crea un objeto global llamado InterfaceGlobal, es parte de interface, porque es parte de su logica
;devuelve 1 en caso de que la interface se cargue con exito, 0 en caso contrario
cargar_InterfaceGlobal()
{
	Global
	cargarEntorno()
	if EXISTE_ENTORNO
	{
			
				;defino las acciones a tomar para el caso de cada cliente
				;el 100% de los casos NOMBRE_PROCESO_EN_USO es un tipo de cliente valido
				switch (NOMBRE_PROCESO_EN_USO)
				{
					case "RuneLite.exe":
						;Detecto la posicion de la frame conocida como SunAwtCanvas2,la misma esta dentro de la ventana de runelite SunAwtFrame
						Local Control := 0
						Local X, Y, anchoControl, altoControl
						ControlGet, Control, Hwnd, , SunAwtCanvas2, ahk_id %VENTANA_EN_USO%
						;en caso de que no detecte o no consiga la interface que busco debo mandar un error.Se puede usar ErrorLevel, se pone en 0 en caso de todo bien y en 1 en caso de que aya error
						if (Control)
						{
						
							ControlGetPos, X, Y, anchoControl, altoControl, , ahk_id %Control%
							;esto crea la global InterfaceGlobal
							InterfaceGlobal := new _InterfaceGlobalContenedora(X, Y, anchoControl, altoControl, Control)
							return 1
						}
						else
						{
							MsgBox, Error en la creacion de los componentes. No se pudo encontrar la interface que contiene el cliente runescape.
							return 0
						}
						
						
						
						
						
						
										
					case "OSbuddy.exe":
					return
					case "OldSchool.exe":
					return
					default:
					return 0
				}
	}
	else
	{
		MsgBox El entorno no se ha definido. No se puede continuar
		return 0
	}
} ;fin de funcion

