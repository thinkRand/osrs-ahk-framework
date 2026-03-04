
;como saber si un objeto se formo con exito?, y como saber si exiten todas sus propiedades en un objeto?.
;Lo que pasa es que necesito hacer comprobaciones de los objetos que voy a usar para crear otros a la ves que necesito comprobar que un objeto se formo con todas sus variables y metodos

;LAS POSICIONES DE LAS OPCIONES TIENE QUE SER VERIFICADAS
class _InterfaceBarraOpciones 
{
	ID := 0
	nombre := ""
	interfacePadreID := ""
	x := 0
	y := 0
	opcion := []
	existe := false ;para indicar si se creo esta interface
	coloresOpcionActiva := {} ;lista de colores de un opcion activa
	coloresOpcionInactiva := {} ;lista de colores de una opcin inactiva, puede que no sea necesaria si se tien la lista de colores activos
	__New(ByRef InterfaceGlobal)
	{
		Global
		;dependiendo del tamanio disponible en interfaceGlobalContenedora variara la posicion de la barra
		base := InterfaceGlobal
		this.ID := 2
		this.interfacePadreID := InterfaceGlobal.ID
		this.nombre := "BarraOpciones"
		;la posicion debe ser relativa a la ventana, para conocerla tambien necesito la pos de la interfaGlobal
		this.x := InterfaceGlobal.x + InterfaceGlobal.ancho - 429 
		this.y := InterfaceGlobal.y + InterfaceGlobal.alto - 36 
		this.existe := true ;deberia esperar al final
		
		Local caracteristicasOpciones := {alto:36, ancho:33}
		this.alto := caracteristicasOpciones.alto
		this.ancho := ((caracteristicasOpciones.ancho * 13 )-1)
		;opcionList := {4:_InventarioNormal}
		

		;defino las propiedades de cada opcion individualmente, solo en caso de que sea diferente en algunas opciones
		;pi son las pociciones relativas de los indicadores para cada opcion
		Local pi := []
		pi[1] := [16, 4]
		pi[2] := [25, 14]
		pi[3] := [4, 4]
		pi[4] := [4, 4]
		pi[5] := [ 4, 16]
		pi[6] := [5, 5]
		pi[7] := [5,5]
		pi[8] := [4,4]
		pi[9] := [26,8]
		pi[10] := [5, 9]
		pi[11] := [5,10]
		pi[12] := [ 5, 16]
		pi[13] := [12, 3]
		
		;ci son los colores activo y base, que se esperan en los indicadores de cada opcion, en BGR
		;El algoritmo para detectar si una opcion esta activa debe cambiar,
		;Con saber si ahy una variante de color activo dentro del area de una opcion es suficiente para saber si esta activa. Y es menos propenso a fallas.
		Local cI := []
		cI[1] := ["0x5A6A74","0x192264"]
		cI[2] := ["0x41494D","0x10153C"]
		
		cI[3] := ["0x627481","0x1B246B"]
		cI[4] := ["0x627481","0x1B246B"]
		cI[5] := ["0x5E717C","0x1B246B"]
		cI[6] := ["0x697C8A","0x1D2671"]
		
		cI[7] := ["0x697C8A","0x1D2671"]
		cI[8] := ["0x627481","0x1B246B"]
		cI[9] := ["0x3B454A","0x10153C"]
		
		cI[10] := ["0x697C8A","0x1D2671"]
		cI[11] := ["0x697C8A","0x1D2671"]
		cI[12] := ["0x5A6A74","0x192264"]
		cI[13] := ["0x5F7381","0x1B246B"]
		
		;Defino pos, area y color de cada opcion, ;son en total 13 opciones en la barra de opciones.
		;Tambien defino pos de cada indicador.
		Local x1 := this.x
		Local y1 := this.y
		Local y2 := (y1 - 1 )+ caracteristicasOpciones.alto)
		Local x2 := 0
		
		;Probar las posiciones con un loop, indicando top left y botton right
		loop, 13
		{
			x2 := (x1 - 1) + caracteristicasOpciones.ancho 
			;la pos del indicador varia para cada opcion
			;la pos de cada opcion esta ecpresada en coordenadas relativas a la interfaceGlobal, pero deben estar expresadas segun la Ventana, para esto debo sumar la pos de la interfaceGlobal
			this.opcion[A_index] := new this._opcion(x1 , y1 , x2, y2, (x1 + pi[A_index][1]), (y1 + pi[A_index][2]), cI[A_index][1], cI[A_index][2])
			x1 := x2 + 1 
		}
	}
	

	

	

	;devo buscar que la memoria no se gaste si no se va a usar esto. Todo de iniciar vacio
	class _opcion
	{
		
		x := 0
		y := 0
		area := {}
		colorActivo := ""
		colorBase := ""
		indicadorID := 0
		xIn := 0 ;coordenada x del indicador
		yIn := 0 ; coordenada y del indicador
		
		;son varias opciones, como puedo definir una poscion estatica para cada una. Quierio hacerlo porque no me parece logico pasarle la posicion a cada opcion, o quisas si es mas logico! tengo que pensarlo mas, per tal como esta funciona
		__New(x1, y1, x2, y2, xIn, yIn, colorActivo, colorBase)
		{
			;la posicion de cada opcion depende inicialmente de la posicion de la barra de opciones. Puedo suprimir la entrada de esa informacion
			this.x := x1
			this.y := y1
			this.area := {x1:x1, y1:y1, x2:x2, y2:y2}				
			;Las coordenadas de lso indicadores deverian ser relativas a su posicion pero son relativas a la ventana. Quisas deba corregir eso
			this.xIn := xIn 
			this.yIn := yIn
			this.colorActivo := colorActivo
			this.colorBase := colorBase
			
		}
		
		;busca si esta opcion esta activa, puedo hacerlo con un rastre en el area o con una lectura de indicador, eligo lo segundo porque es mas rapido
		
		
	}


	;actualisa las posiciones segun las posiciones actuales del la interface global. la BASE de esta clase
	actualisarPosiciones()
	{
		Global
		;Borro los datos anteriores para evitar errores de quien sabe que
		this.x := 0
		this.y := 0
		this.opcion := []
		;Actualisa la posicion de todos los componentes usando la interface global alojada en en la BASE es esta clase
		this.x := base.x + base.ancho - 429
		this.y := base.y + base.alto - 36 
		
		
		;defino las propiedades de cada opcion individualmente, solo en caso de que sea diferente en algunas opciones
		;pi son las pociciones relativas de los indicadores para cada opcion
		Local pi := []
		pi[1] := [16, 4]
		pi[2] := [25, 14]
		pi[3] := [4, 4]
		pi[4] := [4, 4]
		pi[5] := [ 4, 16]
		pi[6] := [5, 5]
		pi[7] := [5,5]
		pi[8] := [4,4]
		pi[9] := [26,8]
		pi[10] := [5, 9]
		pi[11] := [5,10]
		pi[12] := [ 5, 16]
		pi[13] := [12, 3]
		
		;ci son los colores activo y base, que se esperan en los indicadores de cada opcion, en BGR
		;El algoritmo para detectar si una opcion esta activa debe cambiar,
		;Con saber si ahy una variante de color activo dentro del area de una opcion es suficiente para saber si esta activa. Y es menos propenso a fallas.
		Local cI := []
		cI[1] := ["0x5A6A74","0x192264"]
		cI[2] := ["0x41494D","0x10153C"]
		
		cI[3] := ["0x627481","0x1B246B"]
		cI[4] := ["0x627481","0x1B246B"]
		cI[5] := ["0x5E717C","0x1B246B"]
		cI[6] := ["0x697C8A","0x1D2671"]
		
		cI[7] := ["0x697C8A","0x1D2671"]
		cI[8] := ["0x627481","0x1B246B"]
		cI[9] := ["0x3B454A","0x10153C"]
		
		cI[10] := ["0x697C8A","0x1D2671"]
		cI[11] := ["0x697C8A","0x1D2671"]
		cI[12] := ["0x5A6A74","0x192264"]
		cI[13] := ["0x5F7381","0x1B246B"]
		
		;Defino pos, area y color de cada opcion, ;son en total 13 opciones en la barra de opciones.
		;Tambien defino pos de cada indicador.
		Local x1 := this.x
		Local y1 := this.y
		Local y2 := (y1 - 1 )+ caracteristicasOpciones.alto)
		Local x2 := 0
		
		;Probar las posiciones con un loop, indicando top left y botton right
		loop, 13
		{
			x2 := (x1 - 1) + caracteristicasOpciones.ancho 
			;la pos del indicador varia para cada opcion
			;la pos de cada opcion esta ecpresada en coordenadas relativas a la interfaceGlobal, pero deben estar expresadas segun la Ventana, para esto debo sumar la pos de la interfaceGlobal
			this.opcion[A_index] := new this._opcion(x1 , y1 , x2, y2, (x1 + pi[A_index][1]), (y1 + pi[A_index][2]), cI[A_index][1], cI[A_index][2])
			x1 := x2 + 1 
		}
		
		
	
	}
	
	

	
} ;fin de clase principal

