//arboles binarios
//declarar
//crear | agregar
//recorrer: EnOrden | PreOrden | PostOrden
//buscar

program cosas;
const
	fin = 50;
type
//declaracion	
	rPersona = record
		nombre: string;
		dni: integer;
	end;
	
	
	aPersona = ^nodo2;
	
	nodo2 = record
		dato: rPersona;
		HI: aPersona;
		HD: aPersona;
	end;
	
	arbol = ^nodo;
	
	nodo = record
		dato: integer;
		HI: arbol;
		HD: arbol;
	end;
//agregar
procedure agregar(var a:arbol;n:integer);
begin
	if (a = nil) then //si no hay raiz/ esta vacio
	begin
		new(a);
		a^.dato:= n; a^.HI:= nil; a^.HD:= nil;
	end
	else
	if (n <= a^.dato) then// si uso (num < a^.dato) los valores 
		agregar(a^.HI, n)		//  identicos pasan al lado derecho
	else
		agregar(a^.HD, n);
end;

//cargar
procedure cargarArbol (var a:arbol);
var
	num: integer;
begin
	a:= nil;//inicializo
	read(num);
	while (num <> fin) do //agrego nums hasta que leo el 50
	begin
		agregar(a,num);
		read(num);
	end;
end;

//recorrer enOrden
//los valores se imprimen en orden ascendiente
procedure recorrerArEnOrden (a:arbol);
begin
	if (a <> nil) then
	begin
		recorrerArEnOrden(a^.HI);
		write('|',a^.dato);//accion deseada
		recorrerArEnOrden(a^.HD);
	end; 
end;

//recorrer preOrden
//los valores se imprimen en el orden en que se encontraron al construir el arbol
procedure recorrerArPreOrden (a:arbol);
begin
	if (a <> nil) then
	begin
		write('|',a^.dato);//accion deseada
		recorrerArPreOrden(a^.HI);
		recorrerArPreOrden(a^.HD);
	end; 
end;

//recorrer PostOrden
//los valores de las hojas se imprimen primero, 
//seguidos de los valores de sus padres, y así sucesivamente hasta llegar a la raíz
procedure recorrerArPostOrden (a:arbol);
begin
	if (a <> nil) then
	begin
		recorrerArPostOrden(a^.HI);
		recorrerArPostOrden(a^.HD);
		write('|',a^.dato);//accion deseada
	end; 
end;
//buscar (retorna true or false)
function buscarArbol(a:arbol;x:integer):boolean;
begin
	if (a = nil) then
		buscarArbol:= false
	else
	if (a^.dato = x) then
		buscarArbol:= true
	else
	if (x > a^.dato) then
		buscarArbol:= buscarArbol(a^.HD,x)
	else 
		buscarArbol:= buscarArbol(a^.HI,x);
end;
//buscar (retorna el nodo)
function buscarArbol(a:arbol;x:integer):arbol;
begin
	if (a = nil) then
		buscarArbol:= nil
	else
	if (a^.dato = x) then
		buscarArbol:= a
	else
	if (x > a^.dato) then
		buscarArbol:= buscarArbol(a^.HD,x)
	else 
		buscarArbol:= buscarArbol(a^.HI,x);
end;

var
	a:arbol;
	x:integer;
begin
	cargarArbol(a);
	writeln;write('en orden: ');
	recorrerArEnOrden(a);
	writeln;write('post orden: ');
	recorrerArPostOrden(a);
	writeln;write('pre orden: ');
	recorrerArPreOrden(a);
	x:= 22;
	if buscarArbol(a,x) then writeln('sfbhaf');
end.
