#Include Sistema/Puntero.ahk






;Logica de operacion con la interface Magic

;Clase para definir las formas de logica, que????
class Logica 
{


}



;se puede hacer class _Magic extends InterfaceMagic, para que tenga relacion directa
;Una creacion automatica de un objeto que borra su clase, _InterfaceMagic := new InterfaceMagic, libera el espacio de la clase pero la clase ya no existe, sirve para objetos unicos.
;Hacer de la interface una cested class dentro de magic puede ser mas coherente que cualquier otra cosa
;Vaciar la clase base para borrar los metodos puede aumentar el rendimiento al ahorrar memoria
;Extend es hijo


;Extends logica
class _Magic
{
	SPELL_ACTUAL := 0 ;guarda cual espell fue activado y espera que se use
	HAY_SPEEL_EN_USO := 0 ;indica si actualmente hay un spell en cola de uso
	spell := [] ;lista de spell, no contiene area ni nada
	interface := {} ;referencia a la interface magic
	;Selecciona un objetivo para un spell de una lista de objetivos posibles
	;Mejor que use un spell en un objetivo dado
	;No es recurrente. Debe ser protegida con condicionales
	Monitor := {} ;referencia al monitor global
	__New(ByRef Interface)
	{
		Global
		;la interface magic debe ser una subclase de esta 
		this.interface := Interface
		this.Monitor := Interface.Monitor
		;por cada celda creo un spell que lo referencia, este agrega unos metos y puede que otras cosa mas adelante
		loop, % interface.celda.length()
		{
			this.spell[A_index] := new this._Spell(this, A_index)
		}
	}
	
	
	
	
	;#METODOS

	;recurrente que forza la apertura de magic.Derivada de la funcion ACTIVAR()
	activar()
	{}
	
	usarSpellEn(area)
	{
		 ;Solo si tengo un espell en mano
	 	if (HAY_SPEEL_EN_USO)
		{
			;algunos spell cambian la interface automaticamente cuando son usados, ese comportamiento se tendra que maneja en otra parte
			clickA(area)
			HAY_SPEEL_EN_USO := false
			SPELL_ACTUAL := 0
			return 1
		}
		else
		{	
			;0 indica que no hay un spell en uso actualmente
			MsgBox, No hay un spell seleccionado.
			return 0
		}
	}
	;da click de forma incondicional
	clickSpell(n)
	{
		clickA(this.interface.celda[n].area)
	}
	;Selecciona un spell por su posicion
	;0 si no hay runas, 1 si el poder se selecciono, 2 si la ventana no esta activa
	;no es recurrente, debe ser protegida con condicionales para evitar que seleccione un spell repetidas veces
	;devuelve 1 si todo sale bien, 0 en caso de que no se tengan runas para castear el spell, esto debe ocacionar una salida forsosa del script
	selecSpell(n)
	{
		;Solo si la ventana magic esta visible
		if (this.estaVisible())
		{
			;si el spell esta activo, esto es de logica
			;si n es igual a 1 siempre se usa el spell.Si se escoge un spell teleprot no se QUEDA SPELL EN MANO. ES AUNTO USABLE
			if(n != 1)
			{
				if (this.spell[n].estaActivo())
				{
					;el area y esas cosas son datos
					clickA(this.interface.celda[n].area)
					SPELL_ACTUAL := n
					HAY_SPEEL_EN_USO := true
					return 1 ;indica que todo salio bien
				}
				else
				{	
					;0 indica que no hay suficientes runas
					MsgBox, No tienes suficientes runas para usar este spell.
					ExitApp
					;return 0
				}
			}
			else
			{
				clickA(this.Interface.celda[n].area)
			}			
		}
		else 
		{
			;2 indica que la ventana no esta activa
			return 2
		}
	}

	;Compruba si la ventana magic esta abierta. Nunca debe ser recurrente.
	estaVisible()
	{
		Global
		Local r := 0 ;el resultado
		
		r := this.interface.Monitor.comparaLPC(this.Interface.listaPC)
		return r
		;tambien puede hacer return Monitor.comparaLPC(this.Interface.listaPC)
	}

	

	;cada spell tiene unos colores inactivos y otros activos
	;Tiene referencias a las celdas de la interface
	class _Spell
	{
		;revisa la celda para ver si esta activo el spell
		Sn := 0 ;Spell number, el numero de celda o la posicion
		padre := {} ;referencia al padre
		
		_New(ByRef p, sn)
		{
			this.padre := p
			this.Sn := sn
		}
		
		estaActivo()
		{
			Global
			Local r = 0 ;el resultado de la operacion
			;Si la ventana magic esta visible, no se si deba incluir esta comprobacion, deberia limitarme a usar este codigo solo en casos en que la ventana esta abierta
			if (this.padre.estaVisible())
			{
				;reviso si la LPC coincide, si no coincice se consifera ACTIVO, porque la LPC que se usa es la inactiva, aunque puede que este mal posicionado tambien
				;devuelve 1 si coinciden y 0 si no coinciden
				r := this.padre.Monitor.comparaLPC(this.padre.Interface.celda[Sn].LPC)
				;retorna 0 si no coincide, y si no coincide se considera que esta activo
				return !r ;	
			}
			else
			{
				;2 indica que la ventana no esta visible
				return 2		
			}
		}
	}

	
	;Lista de todos los spell que estan activos
	;la presumo inservible
	;espellActivo()
	

} ;fin de class principal

