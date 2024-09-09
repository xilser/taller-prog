program listas;


type
	lEntero = ^nodo;
	
	nodo = record
		dato: integer;
		sig: lEntero;
	end;


procedure agregarAdelante(var l:lEntero; n:integer);
var
	nue:lEntero;
begin
	new(nue);
	nue^.dato:= n;
	nue^.sig:= l;
	l:=nue;
end;


procedure cargarLista(var l:lEntero);
var
	num:integer;
	
begin
	num:= random(50)+100;
	while (num <> 120) do
	begin
		agregarAdelante(l,num);
		num:= random(50)+100;
	end;
end;


procedure imprimirLista(l:lEntero);
begin
	while (l<> nil) do
	begin
		writeln('num: ',l^.dato);
		l:=l^.sig;
	end;
end;


function buscarElemento (l:lEntero; n:integer):boolean;
var
	found:boolean;
begin
	found:= false;
	while (l<>nil) and (found = false) do
	begin
		if (l^.dato = n) then 
			found:= true
		else l:= l^.sig;
	end;
	buscarElemento := found;
end;


var
	num:integer;
	l:lEntero;
BEGIN
	randomize;
	cargarLista(l);
	imprimirLista(l);
	writeln('dame num para buscar: ');readln(num);
	if buscarElemento(l,num) then
		writeln('Se ha encontrado!')
	else
		writeln('pues no esta');
END.


{ACTIVIDAD 3: Crear un archivo ProgramaListas.pas
a) Implemente un módulo CargarLista que cree una lista de enteros y le
agregue valores aleatorios entre el 100 y 150, hasta que se genere el
120.
b) Implemente un módulo ImprimirLista que reciba una lista generada en
a) e imprima todos los valores de la lista en el mismo orden que están
almacenados.
c) Implemente un módulo BuscarElemento que reciba la lista generada
en a) y un valor entero y retorne true si el valor se encuentra en la lista
y false en caso contrario.
d) Invocar desde el programa principal a los módulos implementados
para crear una lista, mostrar todos sus elementos y determinar si un
valor leído por teclado se encuentra o no en la lista.}
