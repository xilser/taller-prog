program resumen;
type
	str20= string[20];
	
	rPersona = record
		nombre:str20;
		apellido:str20;
		edad:integer;
		altura:real;
	end;
	
	tListaP= ^nodo;
	
	nodo=record
		dato: rPersona;
		sig: tListaP;
	end;	
	
procedure leerPersona (var rP:rPersona);
begin
	readln(rP.nombre);
	readln(rP.apellido);
	readln(rP.edad);
	readln(rP.altura);
end;

//recorrer 
//agregar adelante
//agregar al final
//insertar ordenado
//cargar elemento
//buscar (no ordenado/ordenado)
//eliminar elemento
//ordenar 

procedure recorrerLista(l:tListaP);
//Efecto: recorre la lista imprimiendo apellido y nombre
begin
	while(l <> nil) do
	begin
		writeln(l.dato.apellido,', ', l.dato.nombre);
		l:= l^.sig;
	end;
end;

procedure agregarAdelante(var l: tListaP; p:rPersona);
//Efecto: se añade p al comienzo de lista (para usarse en cargarElemento)
var
	nue: tListaP;
begin
	new(nue);		//creo nuevo dato
	nue^.dato:=p;	//le asigno el valor deseado
	nue^.sig:=l;	//lo pongo al principio de la lista
	l:=nue;			//actualizo el primero
end;

procedure agregarFinal(var L,ult:tListaP;p:rPersona);
//Efecto: se añade p al final de la lista (para usarse en cargarElemento)
var
	nue:tListaP;
begin
	new(nue);			//creo nuevo nodo (cambiar nue por nodo)
	nue^.dato:= p;			//asigno el elemento deseado
	nue^.sig:= nil;			//se convierte en el final de la lista
	if (L = nil) then 		//si está vacía
		L:= nue			//actualizo el inicio 
	else ult^.sig:= nil; 		//realizo enlace con el ultimo
	ult:=nue;			//actualizo el final (ult siempre termina apuntando al nodo nuevo)
end;

procedure insertarOrdenado(var l:tListaP; p:rPersona);
//Efecto: insertar persona en una lista ordenada por edad (ascendente)
//(para usarse en cargarElemento)
var
	nue: tListaP;
	act, ant: tListaP; //punteros auxiliares para recorrido
begin
	//creo el nodo a insertar
	new (nue);
	nue^.dato := p;
	act := l; //ubico act y ant al inicio de la lista
	ant := l;
	while( act <> nil)and(p.edad > act^.dato.edad)do
	//busco la pos para insertar el nodo creado
	begin
		ant := act;
		act:= act^.sig;
	end;
	//realizo los enlaces
	if (act = ant) then //al inicio o lista vacía
		l:= nue
	else ant^.sig:= nue; //al medio o al final
	nue^.sig:= act;
end;


procedure cargarElemento(var l:tListaP);
//Efecto: agrega un elemento en la lista (lugar a especificar) 
//hasta que se ingrese -1 como edad 
var
	p:rPersona;
	//ult:tListaP; (para agregarFinal)
begin
	//l:= nil; (para agregarFinal)
	leerPersona(p);
	while (p.edad <> -1) do
	begin
		//elegir entre 3:
		//agregarFinal(l,ult,p);
		//agregarAdelante(l,p);
		//insertarOrdenado(l,p);
		leerPersona(p);
	end;
end;

function buscarElemento(pri:tListaP; valor:integer):boolean;
//Efecto: busca en la tListaP: true si la edad de una persona = valor
var
	found:boolean;
begin
	found:=false;
	while (pri <> nil) and (not found) do //mientras no llege al final y no encuentre
		if (valor = pri^.dato.edad) then //si lo encuentro
			found:=true// bien
		else pri:=pri^.sig;//sino sigo
	buscarElemento:=found;
end;

function buscarOrdenado(pri:tListaP; valor:integer):boolean;
//Efecto: busca en una lista ordenada por edad tListaP: true si la edad 
//de una persona = valor
var
	found:boolean;
begin
	found:=false;
	while (pri <> nil) and (pri.dato.edad < valor) do
		pri:=pri^.sig;
	if (pri <> nil) and (pri.dato.edad = valor) then
		found:=true;
	buscarOrdenado:=found;
end;

procedure eliminarElemento (var L:tListaP;var exito:boolean; valor:str20);
// Efecto: busca un nombre en la lista y lo elimina
var
	ant, act: tListaP; //punteros auxiliares para recorrer
begin
	exito:= false;
	act:= L;//ubico al principio de la lista
	//busco comenzando por el primer elemento
 	// Si el elemento seguro existe no pregunto por (act <> nil)
	while (act <> nil) and (act^.dato.nombre <> valor) do 
	begin
		ant:= act;
		act:=act^.sig;
	end;
	if (act <> nil) then//encontre el valor
	begin
		exito:= true;
		if (act = L) then 	//si el dato es el primero en la lista
			L:= act^.sig 		//aputo al segundo
		else ant^.sig:=act^.sig;//no es el primero, apunto al sig
		dispose (act);			//elimino el dato
	end;
end;


var
	l: tListaP; p:rPersona;
begin
	agregarAdelante(l,p);
end.

//=======================================//
{*cargar valores
* recorridos [total / parcial (parcial seguro existe/ no se sabe)]
* agregar elementos al final
* insertar elementos
* borrar elementos
* busqueda de un elemento normal
* busqueda elemento en vector ordenado (binaria)
* ordenacion de los elementos }

program resumen;

const
	dimF = 100;
	
type
	vector = array [1..dimF] of integer;
//-------------------cargar--------------------------//
procedure cargar (var v:vector);
var
	i: integer;
begin
	for i=1 to dimF do
		read(v[i]);
end;
//-----------recorrido parcial----------------------//
//para con multiplo de 3, retorna la pos
function posicion (v :vector):integer;
var
	pos, resto:integer;
	seguir:boolean;
begin
	seguir:= true; pos :=1;
	while((pos<=dimF) and (seguir = true)) do
	begin
		resto:=datos[pos] mod 3; //multi
		if (resto = 0) then seguir = false
			else pos:= pos+1;
	end;
	if seguir = false then posicion:= pos
		else posicion := 1;
end;
//-----------agregar al final---------------//
//verificar si hay espacio
//incrementar la cantidad de elementos (dimL)
//agregar elemento
procedure agregarFinal (var v:vector;var dimL:integer; var: exito:boolean;valor:integer);
begin
	exito:=false;
	//verificar espcaio
	if dimL < dimF then 
	begin
		exito:= true;
		//inc dimL
		dimL:=dimL +1;
		//agregar elemento
		v [dimL]:= valor;
	end;
end;
//-----------insertar elemento en pos---------------//
//verificar si hay espacio
//verificar la pos
//mover todo
//agregar elemento
//incrementar la cantidad de elementos (dimL)
procedure insertarPos (var v:vector;var dimL:integer; var: exito:boolean;valor:integer; pos:integer);
var
	i:integer;
begin
	exito:=false;
	//verificar espcaio y la pos
	if (dimL < dimF) and ((pos>=1) and (pos<=dimL)) then 
	begin
		exito:= true;
		//mover todo
		for i:=dimL downto pos do
			v[i+1]:= v[i];
		//agregar espacio
		v[pos]:= valor;
		//inc dimL
		dimL:=dimL +1;
	end;
end;
//-----------borrar elemento en pos---------------//
//verificar la pos
//mover todo
//decrementar la cantidad de elementos (dimL)
procedure eliminarPos (var v:vector;var dimL:integer;var exito:boolean;pos:integer);
var
	i:integer;
begin
	exito:=false;
	if ((pos>=1) and (pos <=dimL)) then
	begin
		for i:= pos to (dimL-1) do
			v[i]:= v[i+1];
		exito = true;
		dimL:=dimL-1;
	end;
end;

//-----------buscar elemento---------------//
//verificar no pasarse y que no se haya encontrado
//verificar elemento
//devolver valor (si se encontro (boolean) la pos (int), etc.)
function buscarElemento (v:vector;valor:integer;dimL:integer):boolean;
var
	found:boolean;
	pos:integer;
begin
	found:=false;
	pos:=1;
	while ((pos<=dimL) and (not found)) do
	begin
		if (v[pos] = valor) then found:= true
			else pos:=pos+1;
	end;
	buscar:=found;
end;

//-----------busqueda binaria (vector ordenado)---------------//
function busquedaBinaria (v:vector; dimL:integer;valor:integer):boolean;
var
	F,M,L:integer;
begin
	F:= 1; L:= dimL; M:=(F+L)div 2;
	while ((F <= L) and (valor <> v[M])) do
	begin
		if (valor < v[M]) then 
			L:=M-1
		else
			F:=M+1;
		M:=(F+L) div 2;
	end;
	if ((F <= L) and (valor = v[M])) then busquedaBinaria:=true
		else busquedaBinaria:= false;
end;

//-----------orden seleccion---------------//
procedure ordenSeleccion (var v:vector;dimL:integer);
var
	i,j,pos,aux:integer;
begin
	for i:= 1 to dimL-1 do //-1 porque el ultimo no hace falta
	begin 
		//busca el minimo (v[p]) entre (v[i]..v[j])
		pos:= i;
		for j:= i+1 to dimL do
			if v[j] < v[pos] then pos:=j;
			
		//intercambia v[i] y v[p]
		aux:= v[pos];
		v[pos]:= v[i];
		v[i]:= aux;
	end;
end;

//-----------orden insercion ---------------//
procedure ordenInsercion(var v:vector; dimL:integer);
var
	i,j,actual:integer;
begin
	for i:= 2 to dimL do //desde el segundo elemento hasta el final
	begin
		actual:= v[i];//valor actual a ordenar
		j:= i-1;
		while (j > 0) and (v[j] > actual) do
		begin //busco la pos y muevo todo hacia la derecha hasta llegar
			v[j+1]:= v[j];
			j:= j-1;
		end;
	v[j+1]:= actual;//se posiciona
	end;
end;

//============================================//
