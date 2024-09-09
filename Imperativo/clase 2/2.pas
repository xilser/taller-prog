program ej2;
const
	fin = 100;// aunque se repita, por si se cambia el min
	min = 100;
	max = 200;
type
	lEntero = ^nodo;
	
	nodo = record
		dato:integer;
		sig: lEntero;
	end;


procedure agregarAdelante(var l:lEntero; num:integer);
var
	nue: lEntero;
begin
	new(nue);
	nue^.dato:= num;
	nue^.sig:= l;
	l:= nue;
end;




procedure cargarListaRec(var l:lEntero);
var
	num: integer;
begin
	num:= random(max - min) + min;
	if (num <> fin) then
	begin
		//writeln('se agrega el num ',num); para verificar
		agregarAdelante(l,num);
		cargarListaRec(l);
	end;		
end;


procedure imprimirListaRec(l:lEntero);
begin
	if (l <> nil) then
	begin
		write('|',l^.dato);
		imprimirListaRec(l^.sig);
		//writeln(l^.dato); para imprimir en el orden inverso
	end;
end;


procedure imprimirListaRecInv(l:lEntero);
begin
	if (l <> nil) then
	begin
		imprimirListaRec(l^.sig);
		write('|',l^.dato);
	end;
end;


function buscarMinRec(l:lEntero;min:integer):integer;
begin
	if (l = nil) then// caso base
		buscarMinRec:= min
	else if (l^.dato < min) then
		buscarMinRec:= buscarMinRec(l^.sig,l^.dato)//sig + actualizo min
	else 
		buscarMinRec:= buscarMinRec(l^.sig,min);//sig
end;


procedure buscarMin(l:lEntero);
var
	min:integer;
begin
	min:= 9999;
	writeln;
	writeln('El min es: ',buscarMinRec(l,min));
end;


function buscarValorRec(l:lEntero;n:integer):boolean;
begin
	if(l = nil) then //caso base
		buscarValorRec:= false
	else if (l^.dato = n) then
		buscarValorRec:= true
	else buscarValorRec:= buscarValorRec(l^.sig,n);
end;


procedure buscarValor(l:lEntero);
var
	valor: integer;
begin
	writeln('dame num a buscar');
	readln(valor);
	if buscarValorRec(l, valor) then//e
		writeln('Se ha encontrado!')
	else writeln('No se ha encontrado');
end;


var
	l:lEntero;
begin
	randomize;
	cargarListaRec(l);	//a
	imprimirListaRec(l); //b
	writeln;
	imprimirListaRecInv(l);//c
	buscarMin(l);//d
	buscarValor(l);//e
end.
