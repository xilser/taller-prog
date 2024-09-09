program listasOrdenadas;
type
	lEntero = ^nodo;
	
	nodo = record
		dato: integer;
		sig: lEntero;
	end;


procedure insertarOrdenado(var l:lEntero;n:integer);
var
	nue,ant,act:lEntero;//nodo y auxiliares
begin
	new(nue);
	nue^.dato:= n;
	act:=l;
	ant:=l;
	while (act <> nil) and (n > act^.dato) do
	begin
		ant:= act;
		act:= act^.sig;
	end;
	//realizo los enlaces
	if (act = ant) then //inicio o lista vacia
		l:= nue
	else ant^.sig:= nue;//medio o final
	nue^.sig:= act;
end;


procedure cargarListaOrdenada(var l:lEntero);
var
	num:integer;
	
begin
	num:= random(50)+100;
	while (num <> 120) do
	begin
		insertarOrdenado(l,num);
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


function buscarElementoOrdenado(l:lEntero;n:integer):boolean;
var
	found:boolean;
begin
	found:= false;
	while (l <> nil) and (n > l^.dato) do
		l:= l^.sig;
	if (l <> nil) and (l^.dato = n) then
		found:= true;
	buscarElementoOrdenado:= found;
end;


var
	l:lEntero;
	n:integer;
BEGIN
	randomize;
	cargarListaOrdenada(l);
	imprimirLista(l);
	writeln('dame num para buscar: ');readln(n);
	if buscarElementoOrdenado(l,n) then
		writeln('Se ha encontrado!')
	else
		writeln('pues no esta');
END.


{ACTIVIDAD 4: Crear un archivo ProgramaListasOrdenadas.pas
a) Implemente un módulo CargarListaOrdenada que cree una lista de
enteros y le agregue valores aleatorios entre el 100 y 150, hasta que se
genere el 120. Los valores dentro de la lista deben quedar ordenados
de menor a mayor.
b) Reutilice el módulo ImprimirLista que reciba una lista generada en a) e
imprima todos los valores de la lista en el mismo orden que están
almacenados.
c) Implemente un módulo BuscarElementoOrdenado que reciba la lista
generada en a) y un valor entero y retorne true si el valor se encuentra
en la lista y false en caso contrario.
d) Invocar desde el programa principal a los módulos implementados
para crear una lista ordenada, mostrar todos sus elementos y
determinar si un valor leído por teclado se encuentra o no en la lista}
