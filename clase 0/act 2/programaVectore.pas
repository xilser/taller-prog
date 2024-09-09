program vectorRandom;
const
	dimF = 50;
type
	vNums = array [1..dimF] of integer;
	
procedure rangoRandom(var a,b:integer);
begin
	writeln('dame rango a'); readln(a);
	writeln('dame rango b'); readln(b);
	//me fijo que esten bien, sino los intercambio
	if (a < b) then
	begin
		a:= a + b;
		b:= a - b;
		a:= a - b;
	end;
end;

procedure cargaVector (var v:vNums;var dimL:integer; a,b:integer);
var
	num :integer;
begin
	num:= random(a) + b;
	writeln('a= ',a,' b=',b);
	writeln('el num es: ',num);
	if (num <> 0) then
		dimL:= 0;
		
	while (num <> 0) and (dimL < dimF) do
	begin
		dimL:= dimL + 1;
		v[dimL]:= num;
		num:= random(a) + b;	
	end;
	
	if (num = 0) then
		writeln('OMG un 0, stop');
end;

procedure imprimirVector (v: vNums;dimL: integer);
var
	i: integer;
begin
	for i:=1 to dimL do
		writeln('El num en la pos ',i,' es: ',v[i]);
	// para inverso
	writeln('Al reves!');
	for i:= dimL downto 1 do
		writeln('El num en la pos ',i,' es: ',v[i]);
end;

var
	a,b,dimL:integer;
	v:vNums;
BEGIN
	randomize;
	rangoRandom(a,b);
	cargaVector(v,dimL,a,b);
	imprimirVector(v,dimL);
END.
{ACTIVIDAD 2: Crear un nuevo archivo ProgramaVectores.pas
a) Implemente un módulo CargarVector que cree un vector de enteros
con a lo sumo 50 valores aleatorios. Los valores, generados
aleatoriamente (entre un mínimo y máximo recibidos por parámetro),
deben ser almacenados en el vector en el mismo orden que se
generaron, hasta que se genere el cero.
b) Implemente un módulo ImprimirVector que reciba el vector generago
en a) e imprima todos los valores del vector en el mismo orden que
están almacenados. Qué cambiaría para imprimir en orden inverso?
c) Escriba el cuerpo principal que invoque a los módulos ya
implementados}
