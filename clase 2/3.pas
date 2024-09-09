program ej3;
const
	min= 300;
	max= 1550;
	dimF= 20;
type
	ranEnteros = 1..dimF;
	vEntero = array [ranEnteros] of integer;
	
procedure cargarVectorRec(var v:vEntero;var dimL:integer);
var
	n:integer;
begin
	n:= random(max - min + 1) + min;
	if (dimL < dimF) then
	begin
		dimL:= dimL+1;
		v[dimL]:= n;
		cargarVectorRec(v,dimL);
	end;
end;
	
procedure cargarVector (var v:vEntero; var dimL:integer);
begin
	dimL:= 0;
	cargarVectorRec(v,dimL);
end;
	
procedure imprimirVector(v:vEntero;dimL: integer);
var
	i:integer;
begin
	for i:= 1 to dimL do
		write('|',v[i]);
end;


procedure ordenarVectorInsercion(var v:vEntero;dimL:integer);
var
	i,j:integer;
	actual:integer;//depende del tipo de dato
begin
	for i:= 2 to dimL do
	begin
		actual:= v[i];
		j:= i-1;
		while (j > 0) and (v[j] > actual) do
		begin
			v[j+1]:= v[j];
			j:= j-1;
		end;
		v[j+1]:= actual;//se inserta
	end;
end;

procedure imprimirVectorRec(v:vEntero;dimL:integer);
begin
	if (dimL > 0) then
	begin
		imprimirVectorRec(v,dimL-1);
		write('|',dimL,'. ',v[dimL]);
	end;
end;

Procedure busquedaDicotomica (v: vEntero; ini,fin: ranEnteros; dato:integer; var pos: integer);
var
	m: ranEnteros;
begin
	ini:= 1; m:= (ini + fin) div 2; pos:= -1;
	while ((ini <= fin) and (v[m] <> dato)) do
	begin
		if (v[m] > dato) then
			fin:= m - 1
		else 
			ini:= m + 1;
		m:= (ini + fin) div 2;
	end;
	if ((ini < fin) and (v[m] = dato)) then
		pos:= m;
end;


var
	v: vEntero;
	dimL,dato,pos: integer;
	ini,fin:ranEnteros;
begin
	randomize;
	cargarVector(v,dimL);
	imprimirVector(v,dimL); //para verificar
	ordenarVectorInsercion(v,dimL);
	writeln;
	imprimirVectorRec(v,dimL);//para verificar
	writeln;writeln('dame num a buscar: ');readln(dato); fin:= dimL;
	busquedaDicotomica(v,ini,fin,dato,pos);
	if (pos <> -1) then 
		writeln('el num se encuentra en la pos: ',pos)
	else 
		writeln('no existe pa');
end.
