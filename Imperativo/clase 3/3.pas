program aiuda;
const
	fin = 0;
type
	ranDia = 1..30;
	ranMes =1..12;
	ranAno =1900..3000;
	
	rFecha = record
		dia: ranDia;
		mes: ranMes;
		ano: ranAno;
	end;


	rFinal = record
		codMateria: integer;
		fecha:rFecha;
		nota:real;
	end;
	
	lFinal = ^nodo;
	nodo = record
		dato: rFinal;
		sig: lFinal;
	end;
	
	rAlumno = record//nodo de arbol
		legajo:integer;
		lista:lFinal;
	end;
	
	aAlumno = ^nodoArbol;
	
	nodoArbol = record
		dato: rAlumno;
		hi: aAlumno;
		hd:aAlumno;
	end;


procedure leerAlumno(var rF:rFinal;var rA:rAlumno);
var
	rFec: rFecha;
	num: integer;
	numR:real;
begin
	num:= random(100 + 1) ;//legajo entre 0 y 100 para que sea mas probable
	rA.legajo:= num;
	if (rA.legajo <> fin) then
	begin
		num:= random(20) + 1;//materia del 1 al 20
		rF.codMateria:= num;
		numR:= random * 9 + 1;//numero real entre 1 y 10 
		rF.nota:= numR;
		num:= random(30 - 1 + 1) + 1;
		rFec.dia:= num;
		num:= random(12 - 1 + 1) + 1;
		rFec.mes:= num;
		num:= random(4000 - 2000 +1) + 2000;
		rFec.ano:= num;
		rF.fecha:= rFec;
	end;
end;


procedure agregarAdelante(var l:lFinal;r:rFinal);
var
	nue:lFinal;
begin
	new(nue);
	nue^.dato:= r;
	nue^.sig:= l;
	l:= nue;
end;


procedure agregarArbol (var a:aAlumno; rF:rFinal; rA:rAlumno);
begin
	if (a = nil) then
	begin
		new(a);
		a^.dato:= rA;
		a^.dato.lista:= nil;
		agregarAdelante(a^.dato.lista,rF);
		a^.hi:= nil; a^.hd:= nil;
	end
	else
	if (rA.legajo = a^.dato.legajo) then //mismo legajo, sumo a la lisa de finales
		agregarAdelante(a^.dato.lista,rF)
	else
	if (rA.legajo < a^.dato.legajo) then//si es menor, hijo izq
		agregarArbol(a^.hi,rF,rA)
	else								//es mayor, hd
		agregarArbol(a^.hd,rF,rA);
end;


procedure cargarArbol(var a:aAlumno);
var
	rF:rFinal;
	rA:rAlumno;
begin
	a:= nil;
	leerAlumno(rF,rA);//random porque no da escribir
	while (rA.legajo <> fin) do
	begin
		agregarArbol(a,rF,rA);
		leerAlumno(rF,rA);
	end;
end;


procedure imprimirLista(l:lFinal);
begin
	while (l <> nil) do
	begin
		writeln;
		write('> cod materia: ',l^.dato.codMateria);
		write(' Fecha: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.ano);
		write(' Nota: ',l^.dato.nota:0:2);
		l:=l^.sig;
	end;
end;

procedure imprimirArbolLista(a:aAlumno);
begin
	if (a <> nil) then
	begin
		imprimirArbolLista(a^.hi);
		writeln;writeln;
		write('|legajo: ',a^.dato.legajo);write(' ---Lista de finales-- ');
		imprimirLista(a^.dato.lista);
		imprimirArbolLista(a^.hd);
	end;
end;

function legajoImpar(a:aAlumno):integer;
begin
	if (a = nil) then
		legajoImpar:= 0
	else
	begin
		if ((a^.dato.legajo mod 2) <> 0) then
		  legajoImpar := 1
		else
		  legajoImpar := 0;
		  
		legajoImpar := legajoImpar + legajoImpar(a^.hi) + legajoImpar(a^.hd);
	end;
end;

function contarFinales(l: lFinal):integer;
var
	cant: integer;
begin
	cant:= 0;
	while (l <> nil) do
	begin
		if (l^.dato.nota >= 4) then
			cant:= cant+1;
		l:= l^.sig;
	end;
	contarFinales:= cant;
end;

procedure informar (a:aAlumno);
begin
	if (a <> nil) then
	begin
		writeln;
		informar(a^.hi);
		write('el alumno con legajo |',a^.dato.legajo,'| apobo ',contarFinales(a^.dato.lista),' finales');
		writeln();
		informar(a^.hd);
	end;
end;


var
	a:aAlumno;
begin
	randomize;
	cargarArbol(a);
	imprimirArbolLista(a);
	writeln;writeln(' la cant de alumnos con legajo impar son: ',legajoImpar(a));
	informar(a);
	
end.
