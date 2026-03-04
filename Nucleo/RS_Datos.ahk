;puedo cambiar el nombre a RS_Colores
;lista de variables que contienen datos fijos acerca de runescape, seran tratadas como globales y constantes
;Se diferecian los obejtos del mundo con los ITEMS, un item puede tener una version de objeto en el mundo. Los objetos del mundo con arboles tiene madera que es un Item


_RSRoca := [{nombre:"Clay", color:"0x3D84AC", materialColor:"el color del material"},{nombre:"Iron", color:"0x141e39", materialColor:"0x111A32"}, {nombre:"cooper", color:"0x1D3552", materialColor:"0x26466B"}]
_RSGema := [{nombre:"", color:""},{nombre:"", color:""}]
_RSArbol := [{nombre:"Oak",color:"", colorMadera:""}]
_RSPez := [{nombre:"", materialColor:"", quemadoColor:""}]

/*
#########################################
#OBJETOS UNICOS
#########################################
*/
_RSClueGeode := {color:""}
_RSClueBottle := {color:""}
_RSClueNet := {color:""} 


/*
########################################
#ITEMS JOLLAS
# info para identificarlos en las celdas de bancos y inventario
########################################
*/

;Se supone que cada objeto esta definido de forma que pueda ser encontra en cualquier parte de un ainterface(banco e inventario)
			;si lo anterior no es posible habra que definir una forma para identificar dichos objetos de forma unica
			;puedo buscar atraves de una matris de colores, una imagen, o un asucecion de colores corta.
		;RING, NECKLACE, BRACELET, AMULET. cada item tiene una coleccion de indicadores que sirve para identificarlo de forma INFALIBLE
_RSSappireRing :=0
_RSSappireNecklace :=0
_RSSappireBracelet :=0
_RSSappireAmulet :=0


;Lista de items, segun su imagen en las celdas del banco, por supuesto son plantillas LPC
Global items := []
;las plantillas dicen donde buscar, y que debe haber hay
;la LPC puede tener colores que indican vacio, estos colores son tratados de forma diferente por el detector, los considera de la misma familia, cualquiera se considera iguales
;item[id] := {nombre:, plantillaLPC}
;;La plantilla debe indicar los lugares donde hay un color base, de la misma foram, quisas dejando una señal -1 , para indicar que en ese punto va un color base
items[1] := {nombre:"AmuletMould", plantillaLPC:[{x:6, y:16, color:"0x9899A6"}
,{x:9, y:16, color:"0x9899A6"}
,{x:12, y:16, color:"0x878795"}
,{x:15, y:16, color:"0x878795"}
,{x:18, y:16, color:"0x878795"}
,{x:21, y:16, color:"0x9899A6"}
,{x:24, y:16, color:"0x9899A6"}
,{x:27, y:16, color:"0x010000"} 
,{x:30, y:16, color:"0x333E48"}]}






items[2] := {nombre:"safireRing", plantillaLPC:[{x:6, y:16, color:"0x29353E"}
,{x:9, y:16, color:"0x010000"}
,{x:12, y:16, color:"0x055869"}
,{x:15, y:16, color:"0x010000"}
,{x:18, y:16, color:"0x010000"}
,{x:21, y:16, color:"0x0CAECF"}
,{x:24, y:16, color:"0x077187"}
,{x:27, y:16, color:"0x29353E"}
,{x:30, y:16, color:"0x29353E"}]}


items[3] := {nombre:"ringOfRecoil", plantillaLPC:[{x:6, y:16, color:"0x29353E"}
,{x:9, y:16, color:"0x07748B"}
,{x:12, y:16, color:"0x055869"}
,{x:15, y:16, color:"0x010000"}
,{x:18, y:16, color:"0x010000"}
,{x:21, y:16, color:"0x09849D"}
,{x:24, y:16, color:"0x29353E"}
,{x:27, y:16, color:"0x29353E"}
,{x:30, y:16, color:"0x29353E"}]}


;NO SE DETECTA
items[4] := {nombre:"safireNecklace", plantillaLPC:[{x:16, y:6, color:"0x010000"}
,{x:16, y:9, color:"0x29353E"}
,{x:16, y:12, color:"0x29353E"}
,{x:16, y:15, color:"0x29353E"}
,{x:16, y:18, color:"0x370303"}
,{x:16, y:21, color:"0x840A07"}
,{x:16, y:24, color:"0x0CAECF"}
,{x:16, y:27, color:"0x29353E"}
,{x:16, y:30, color:"0x29353E"}]}





items[5] := {nombre:"gamesNecklace", plantillaLPC:[{x:6, y:16, color:"0x29353E"}
,{x:9, y:16, color:"0x010000"}
,{x:12, y:16, color:"0x202030"}
,{x:15, y:16, color:"0x29353E"}
,{x:18, y:16, color:"0x29353E"}
,{x:21, y:16, color:"0x010000"}
,{x:24, y:16, color:"0x03404E"}
,{x:27, y:16, color:"0x202030"}
,{x:30, y:16, color:"0x29353E"}]}


items[6] := {nombre:"safireBracelet", plantillaLPC:[{x:6, y:16, color:"0x29353E"}
,{x:9, y:16, color:"0x0EC3E9"}
,{x:12, y:16, color:"0x0EC1E6"}
,{x:15, y:16, color:"0x0CB6D9"}
,{x:18, y:16, color:"0xA70E09"}
,{x:21, y:16, color:"0x010000"}
,{x:24, y:16, color:"0x29353E"}
,{x:27, y:16, color:"0x29353E"}
,{x:30, y:16, color:"0x29353E"}]}


items[7] := {nombre:"braceletOfClay", plantillaLPC:[{x:6, y:16, color:"0x29353E"}
,{x:9, y:16, color:"0x0CB9DC"}
,{x:12, y:16, color:"0x0EC1E6"}
,{x:15, y:16, color:"0x0EBEE2"}
,{x:18, y:16, color:"0x0ECCF3"}
,{x:21, y:16, color:"0x0CA0D2"}
,{x:24, y:16, color:"0x010000"}
,{x:27, y:16, color:"0x29353E"}
,{x:30, y:16, color:"0x29353E"}]}



items[8] := {nombre:"safireAmulet", plantillaLPC:[{x:16, y:6, color:"0x010000"}
,{x:16, y:9, color:"0x29353E"}
,{x:16, y:12, color:"0x29353E"}
,{x:16, y:15, color:"0x29353E"}
,{x:16, y:18, color:"0x056B6D"}
,{x:16, y:21, color:"0x7C0907"}
,{x:16, y:24, color:"0x0ABCBF"}
,{x:16, y:27, color:"0x29353E"}
,{x:16, y:30, color:"0x29353E"}]}



items[9] := {nombre:"amuletOfMagic", plantillaLPC:[{x:16, y:6, color:"0x010000"}
,{x:16, y:9, color:"0x29353E"}
,{x:16, y:12, color:"0x29353E"}
,{x:16, y:15, color:"0x29353E"}
,{x:16, y:18, color:"0x29353E"}
,{x:16, y:21, color:"0x71727E"}
,{x:16, y:24, color:"0x010000"}
,{x:16, y:27, color:"0x010000"}
,{x:16, y:30, color:"0x202030"}]}



items[10] := {nombre:"cosmicRune", plantillaLPC:[{x:6, y:16, color:"0x0CD3D6"}
,{x:9, y:16, color:"0x0CD3D6"}
,{x:12, y:16, color:"0x0CD3D6"}
,{x:15, y:16, color:"0x0CD3D6"}
,{x:18, y:16, color:"0x6A6A75"}
,{x:21, y:16, color:"0x0CD3D6"}
,{x:24, y:16, color:"0x797986"}
,{x:27, y:16, color:"0x8B8B9A"}
,{x:30, y:16, color:"0x202030"}]}


























		


