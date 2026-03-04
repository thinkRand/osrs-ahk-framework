#Include Sistema/GestionTiempo.ahk
SetDefaultMouseSpeed, 15
;SetMouseDelay, retrasoClick()
;quesas deba crear las fucniones que vi en los post: click rando area, click punto, mover random are, click rando etc,. Quisas deba cambiar le nombre de la funcion para hacerlo mas claro con su cometidoy su funcionamiento
;Global MOUSE_VELOCIDAD := 15
;La pregunta es: LA VELOCIDAD DEL MAUSE DEBE SER CONSTANTE O DEBO ADAPTARLA A LA SITUACION, Mientras mas lejos mas rapido y mas impresiso, Mientras mas cerca debe ser mas lento y mas preciso.
;tengo que medir el tiempo que tarda esta funcion en desplazarce desde cualquier posicion hasta el area elegida, la velocidad de desplasamiento debe obedecer un comportamiento `parecido al humano.

;La siguiente funcion no conoce el FUTURO, significa que no agregar un delay al final. 
;Sin embargo si conoce el pasado por lo que agrega un delay al principio, este corresponde al tiempo en reaccionar para comensar a mover el mouse
;MOUSE MOVE USA QUUVIC bezier, y es detectable.
punteroA(area, foco := 0)
{	
	Global
	Local xl := 0
	Local yl := 0
	
	Random, xl, area.x1 + foco, area.x2 - foco
	Random, yl, area.y1 + foco, area.y2 - foco
	;el senmode solo puede ser evetn para que la velicidad no sea instantanea
	retrasoReaccion() ;el tiempo que transcurre entre decidir mover el mouse y el primer movimiento del mouse. Eso incluye, tomar decicion, mover manos, y e tiempo que tarda la señal en llegar, luego el primero moc
	MouseMove, %xl%, %yl%
}

;click es solo el proceso de empujar hacia abajo y soltar hasta estar disponible para empujar nuevamente, esta funcion es algo mas, incluye 4 pasos, reaccion-movimiento-reaccion-click
clickA(area, foco := 0, n := 1)
{	
	Global
	Local x := 0
	Local y := 0
	;MsgBox % "legue a punteroA con area =" area[1][1]
	Random, x, area.x1 + foco, area.x2 - foco
	Random, y, area.y1 + foco, area.y2 - foco
	;MsgBox % "mover a punto x = " x " y= " y
	retrasoReaccion() ;antes de empesar un movimiento. Se nota un cambio. Eso es reaccion()
	MouseMove, x, y
	retrasoClick() ;;Tiempo  promedio entre, despues de mover el puntero, y  hacer click, ya comprobado
	Click, n
}


arastraA(area1, area2)
{
	;para mover algo del area1 al area2

}

;quisas arrastras sea mejor opcion
intercambiar()
{}

;puedo poner opcion para velocidad del mouse, esta debe ser rapida, como 10
selecOpcionMenu(n)
{
	Global
	Local centro := {x:, y:}
	Local opcion := []
	Local x := 0
	Local y := 0
	;No compruebo si hay un meno visible, pero puedo hacerlo ya que siempre se enpiesa en la posicion de un borde que tiene un color constante.
	;Listo las posiciones relativas de cada opcion, x esta en un rango permitido entre -33-centro-+33
	
	;una forma de comprobar si hay un menu abierto es desplasar el click hai abajo hasta que encuentre un color base de uno de estos menus, asi sabra si hay uno activo o no.
	opcion:= [{x1: -22, y1:20, x2: 33, y2:34}
	,{x1:-22 , y1:35, x2:88 , y2:49}
	,{x1:-22 , y1:50, x2:88 , y2:64}
	,{x1:-22 , y1:65, x2:88 , y2:79}
	,{x1:-22 , y1:80, x2:88 , y2:94}
	,{x1:-22 , y1:95, x2:88 , y2:109}
	,{x1:-22 , y1:110, x2:88 , y2:124}
	,{x1:-22 , y1:125, x2:88 , y2:139}
	,{x1:-22 , y1:140, x2:88 , y2:154}
	,{x1:-22 , y1:155, x2:88 , y2:169}
	,{x1:-22 , y1:170, x2:88 , y2:184}
	,{x1:-22 , y1:185, x2:88 , y2:199}]
	
	;la posicion actual es el centro
	Local cx := 0
	Local cy := 0
	MouseGetPos, cx, cy, , ,
	centro.x := cx
	centro.y := cy
	;randomiso el punto donde se hara click
	Random, x, opcion[n].x1, opcion[n].x2
	Random, y, opcion[n].y1, opcion[n].y2
	;se debe hacer reaccion, movimiento, retraso, click. Todo lo anterior lo hace clickA
	retrasoReaccion()
	;tambien puede ser MouseMove, centro.x + x, centro.y + y donde x= random, 0, 88 if x<55 x*-1 igual para Y
	MouseMove, x, y , 15, rel
	retrasoClick()
	click
	
	;despues de seleccionar una opcion se supone que el menu desaparece, se puede comprobar si el menu desaparece, pero eso es algo que puede no ser necesario.
}