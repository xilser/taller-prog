{1.- Implementar un programa que invoque a los siguientes m�dulos.
a. Un m�dulo recursivo que retorne un vector de a lo sumo 15 n�meros enteros �random� mayores a 10 y menores a 155 (incluidos ambos). La carga finaliza con 
el valor 20.
b. Un m�dulo no recursivo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un m�dulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un m�dulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores pares contenidos en el vector.
e. Un m�dulo recursivo que reciba el vector generado en a) y devuelva el m�ximo valor del vector.
f. Un m�dulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si dicho valor se encuentra en el vector o falso en caso contrario.
g. Un m�dulo que reciba el vector generado en a) e imprima, para cada n�mero contenido en el vector, sus d�gitos en el orden en que aparecen en el n�mero. 
Debe implementarse un m�dulo recursivo que reciba el n�mero e imprima lo pedido. Ejemplo si se lee el valor 142, se debe imprimir 1  4  2
}


Program Clase2MI;


const 
	dimF = 15;
    min = 10;
    max = 155;
    
type
	vector = array [1..dimF] of integer;
    


procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
var 
	valor: integer;
begin
	valor:= random(max - min + 1) + min;
		
	if ((valor <> 20 ) and (dimL < dimF)) then 
	begin
		dimL:= dimL + 1;
		v[dimL]:= valor;
		CargarVectorRecursivo (v, dimL);
	end;
end;


procedure CargarVector (var v: vector; var dimL: integer); 
begin
  dimL:= 0;
  CargarVectorRecursivo (v, dimL);
end;
 
procedure ImprimirVector (v: vector; dimL: integer);
var
   i: integer;
begin
     for i:= 1 to dimL do
         write ('----');
     writeln;
     write (' ');
     for i:= 1 to dimL do begin
        write(v[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimL do
         write ('----');
     writeln;
     writeln;
End;     


procedure ImprimirVectorRecursivo(v: vector; dimL: integer);
begin
  if (dimL > 0) then
  begin
    ImprimirVectorRecursivo(v, dimL - 1);
    writeln('El numero en la posicion ', dimL, ' es: ', v[dimL]);
  end;
end;


function par(n: integer):boolean;
begin
	if (n mod 2) = 0 then
		par:= true
	else par:= false;
end;


function SumarRecursivo (v: vector; dimL: integer): integer;
Begin
	if (dimL = 0) then
		SumarRecursivo:=0	//caso base: vector vacio
	else if par(v[dimL]) then 
		SumarRecursivo:= SumarRecursivo (v, dimL - 1) + v[dimL]// caso recursivo: dimL <> 0
	else SumarRecursivo:= SumarRecursivo (v, dimL - 1);
end; 
   
function Sumar (v: vector; dimL: integer): integer;  
begin
	Sumar:= SumarRecursivo (v, dimL);
end;


function maximoS(n, max: integer): integer;
begin
  if n > max then
    maximoS:= n
  else
    maximoS:= max;
end;


function maximoRecursivo(v: vector; dimL: integer): integer;
begin
	if dimL = 0 then //caso base, fin del vector
		maximoRecursivo:= -9999//num cualquiera bajo
	else
		maximoRecursivo:= maximoS(v[dimL], maximoRecursivo(v, dimL - 1));
end;


function ObtenerMaximo (v: vector; dimL: integer): integer;
begin	
	ObtenerMaximo:= maximoRecursivo(v,dimL);
end;


function buscarRec(v: vector; dimL, valor: integer): boolean;
begin
	if dimL = 0 then
		buscarRec := false //caso base
	else if v[dimL] = valor then
		buscarRec := true  
	else
		buscarRec := buscarRec(v, dimL - 1, valor); 
end;


function BuscarValor (v: vector; dimL, valor: integer): boolean;
begin
	BuscarValor := buscarRec(v, dimL, valor);
end;


procedure ImprimirDigitosRec(num: integer);
begin
	if (num > 0) then
	begin
		ImprimirDigitosRec(num div 10);
		write(num mod 10, ' ');
	end;
end;


procedure ImprimirDigitos(v: vector; dimL: integer);
var
	i: integer;
begin
	for i := 1 to dimL do
	begin
		ImprimirDigitosRec(v[i]);
		writeln;
	end;
end;


var 
	dimL, suma, maximo, valor: integer; 
    v: vector;
    encontre: boolean;
Begin 
	randomize;
	CargarVector (v, dimL);
	
	if (dimL = 0) then 
		writeln ('--- Vector sin elementos ---')
	else begin
		ImprimirVector (v, dimL);
	  	ImprimirVectorRecursivo (v, dimL);
	  	
	  	suma:= Sumar(v, dimL);
	  	writeln('La suma de los valores pares del vector es ', suma);
	  	
	  	maximo:= ObtenerMaximo(v, dimL);
		writeln('El maximo del vector es ', maximo); 
		
		write ('Ingrese un valor a buscar: ');
		read (valor);
		encontre:= BuscarValor(v, dimL, valor);
		if (encontre) then 
			writeln('El ', valor, ' esta en el vector')
        else writeln('El ', valor, ' no esta en el vector');
              
		ImprimirDigitos (v, dimL); 
	end;
end.
