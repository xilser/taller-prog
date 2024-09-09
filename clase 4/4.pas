program jeje;
const
	fin = 0;
type
	ranDia = 1..30;
	ranMes = 1..12;
	rFecha = record
		dia:ranDia;
		mes:ranMes;
	end;
	
	rPrestamo = record
		isbn: integer;
		numSocio: integer;
		cantDias: integer;
		fecha:rFecha;
	end;
	
	aPrestamo = ^nodoArPrestamo;
	
	nodoArPrestamo = record
		dato: rPrestamo;
		hi:aPrestamo;
		hd:aPrestamo;
	end;
	
	rISBN = record
		numSocio: integer;
		cantDias: integer;
	end;
	
	//lista para cada nodo 
	lPrestamo = ^nodoPrestamo;
	
	nodoPrestamo = record
		dato: rISBN;
		sig: lPrestamo;
	end;
	
	rNodoISBN = record
		isbn: integer;
		lista: lPrestamo;
	end;
	
	aISBN = ^nodoISBN;
	
	nodoISBN = record
		dato: rNodoISBN;
		hi: aISBN;
		hd: aISBN;
	end;

procedure leerPrestamo(var p: rPrestamo);
begin
  writeln('Ingrese el ISBN del libro (0 para finalizar): ');
  readln(p.isbn);
  if (p.isbn <> fin) then
  begin
    writeln('Ingrese el número de socio: ');
    readln(p.numSocio);
    writeln('Ingrese la cantidad de días de préstamo: ');
    readln(p.cantDias);
    writeln('Ingrese el día del préstamo: ');
    readln(p.fecha.dia);
    writeln('Ingrese el mes del préstamo: ');
    readln(p.fecha.mes);
  end;
end;

procedure agregarArbolPrestamo(var a:aPrestamo;r:rPrestamo);
begin
	if (a = nil) then
	begin
		new(a);
		a^.dato:= r;
		a^.hi:= nil; a^.hd:= nil;
	end
	else
	if (r.isbn < a^.dato.isbn) then
		agregarArbolPrestamo(a^.hi,r)
	else
		agregarArbolPrestamo(a^.hd,r);
end;

procedure agregarAdelante(var l:lPrestamo; r:rPrestamo);
var
  nue: lPrestamo;
  nuevoPrestamo: rISBN;
begin
  new(nue);
  nuevoPrestamo.numSocio := r.numSocio;
  nuevoPrestamo.cantDias := r.cantDias;
  nue^.dato := nuevoPrestamo;
  nue^.sig := l;
  l := nue;
end;


procedure agregarArbolISBN(var a:aISBN;r:rPrestamo);
begin
	if (a = nil) then
	begin
		new(a);
		a^.dato.isbn:= r.isbn;
		a^.dato.lista:= nil;
		agregarAdelante(a^.dato.lista, r);
		a^.hi:= nil; a^.hd:= nil;
	end
	else
	if (r.isbn = a^.dato.isbn) then
		agregarAdelante(a^.dato.lista, r)
	else
	if (r.isbn < a^.dato.isbn) then
		agregarArbolISBN(a^.hi,r)
	else
		agregarArbolISBN(a^.hd,r);

end;


procedure crearArboles(var aP: aPrestamo; var aI: aISBN);
var
	r:rPrestamo;
begin
	leerPrestamo(r);
	while (r.isbn <> fin) do
	begin
		agregarArbolPrestamo(aP,r);
		agregarArbolISBN(aI,r);
		leerPrestamo(r);
	end;
end;


procedure imprimirListaPrestamos(l: lPrestamo);
begin
  while (l <> nil) do
  begin
    writeln('  Socio: ', l^.dato.numSocio, ' - Días: ', l^.dato.cantDias);
    l := l^.sig;
  end;
end;

procedure imprimirArbolPrestamos(a: aPrestamo);
begin
  if (a <> nil) then
  begin
    imprimirArbolPrestamos(a^.hi);
    writeln('Prestamo ISBN: ', a^.dato.isbn, ' - Socio: ', a^.dato.numSocio, ' - Días: ', a^.dato.cantDias, ' - Fecha: ', a^.dato.fecha.dia, '/', a^.dato.fecha.mes);
    imprimirArbolPrestamos(a^.hd);
  end;
end;

procedure imprimirArbolISBN(a: aISBN);
begin
  if (a <> nil) then
  begin
    imprimirArbolISBN(a^.hi);
    writeln('ISBN: ', a^.dato.isbn);
    writeln('Prestamos asociados:');
    imprimirListaPrestamos(a^.dato.lista);
    imprimirArbolISBN(a^.hd);
  end;
end;

var
	aPres: aPrestamo;
	aIS: aISBN;
begin
	crearArboles(aPres,aIS);
	writeln('Estructura de préstamos individuales:');
	imprimirArbolPrestamos(aPres);
  
	writeln('Estructura de ISBN con préstamos agrupados:');
	imprimirArbolISBN(aIS);
end.
