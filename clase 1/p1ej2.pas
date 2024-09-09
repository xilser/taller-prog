program p1ej2;
const
	dimF = 300;
	fin = -1;
type
	
	rOficina = record
		codigo: integer;
		dni: integer;
		valor: real;
	end;
	
	vOficina = array [1..dimF] of rOficina;
	
procedure leerOficina (var r:rOficina);
begin
	writeln('dame codigo (fin ',fin,')');readln(r.codigo);
	if r.codigo <> fin then
	begin
        WriteLn('dni: '); readLn(r.dni);
        WriteLn('valor: '); readLn(r.valor);
	end;
end;

procedure agregarFinal (var v:vOficina; r:rOficina;var dimL:integer);
begin
	dimL:= dimL+1;
	v[dimL]:= r;
end;
	
procedure generarOficina(var v:vOficina;var dimL:integer);
var
	r:rOficina;
begin
	dimL:= 0;
	leerOficina(r);
	while (dimL < dimF) and (r.codigo <> fin) do
	begin
		agregarFinal(v,r,dimL);
		leerOficina(r);
	end;
end;

procedure ordenSeleccion (var v:vOficina;dimL:integer);
var
	i,j,pos:integer;
	aux:rOficina;
begin
	for i:= 1 to dimL-1 do //-1 porque el ultimo no hace falta
	begin 
		//busca el minimo (v[pos]) entre (v[i]..v[n])
		pos:= i;
		for j:= i+1 to dimL do
			if v[j].codigo < v[pos].codigo then 
				pos:=j;
			
		//intercambia v[i] y v[p]
		aux:= v[pos];
		v[pos]:= v[i];
		v[i]:= aux;
	end;
end;

procedure ordenInsercion(var v:vOficina; dimL:integer);
var
	i,j:integer;
	actual:rOficina;
begin
	for i:= 2 to dimL do //desde el segundo elemento hasta el final
	begin
		actual:= v[i];//valor actual a ordenar
		j:= i-1;
		while (j > 0) and (v[j].codigo > actual.codigo) do
		begin //busco la pos y muevo todo hacia la derecha hasta llegar
			v[j+1]:= v[j];
			j:= j-1;
		end;
	v[j+1]:= actual;//se posiciona
	end;
end;

procedure ImprimirVector(v:vOficina;dimL:integer);
var
    i:integer;
begin
    for i:=1 to dimL do
    begin
		writeln('---------------------');
        WriteLn('Codigo: ',v[i].codigo);
        WriteLn('Dni: ',v[i].dni);
        WriteLn('Valor: ',v[i].valor:0:2);
    end;
end;

var
	v: vOficina;
	dimL: integer;
begin
	generarOficina(v,dimL);
	//ordenSeleccion(v,dimL);
	ordenInsercion(v,dimL);
	imprimirVector(v,dimL);
end.

{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}
