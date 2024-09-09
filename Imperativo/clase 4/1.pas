{a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por código de producto. De cada producto deben quedar almacenados su código, la cantidad total de unidades vendidas y el monto total. De cada venta se cargan código de venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las ventas finaliza cuando se lee el código de venta 0.
b. Imprimir el contenido del árbol ordenado por código de producto.
c. Retornar el menor código de producto.
d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro.
e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos valores recibidos (sin incluir) como parámetros.


}
Program ImperativoClase4;


type 
	venta = record
		codigoVenta: integer;
		codigoProducto: integer;
		cantUnidades: integer;
		precioUnitario: real;
	end;
	
	
	productoVendido = record
		codigo: integer;
		cantTotalUnidades: integer;
		montoTotal: real;
	end;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato: productoVendido;
		HI: arbol;
		HD: arbol;
	end;
     
procedure ModuloA (var a: arbol);
{ Almacene los productos vendidos en una estructura eficiente para la búsqueda por código de producto. De cada producto deben quedar almacenados la cantidad total 
de unidades vendidas y el monto total. }


  Procedure CargarVenta (var v: venta);
  begin
    v.codigoVenta:= random (51) * 100;
    If (v.codigoVenta <> 0)
    then begin
           v.codigoProducto:= random (100) + 1;
           v.cantUnidades:= random(15) + 1;
           v.precioUnitario:= (100 + random (100))/2;
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: venta);
  var p: productoVendido;
     
     Procedure ArmarProducto (var p: productoVendido; v: venta);
     begin
       p.codigo:= v.codigoProducto;
       p.cantTotalUnidades:= v.cantUnidades;
       p.montoTotal:= v.cantUnidades * v.precioUnitario;
     end;
  
  Begin
    if (a = nil) 
    then begin
           new(a);
           ArmarProducto (p, elem);
           a^.dato:= p; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.codigoProducto = a^.dato.codigo)
         then begin
                a^.dato.cantTotalUnidades:= a^.dato.cantTotalUnidades + elem.cantUnidades;
                a^.dato.montoTotal:= a^.dato.montoTotal + (elem.cantUnidades * elem.precioUnitario);
              end
         else if (elem.codigoProducto < a^.dato.codigo) 
              then InsertarElemento(a^.HI, elem)
              else InsertarElemento(a^.HD, elem); 
  End;


var unaVenta: venta;  
Begin
 writeln;
 writeln ('----- Ingreso de ventas y armado de arbol de productos ----->');
 writeln;
 a:= nil;
 CargarVenta (unaVenta);
 while (unaVenta.codigoVenta <> 0) do
  begin
   InsertarElemento (a, unaVenta);
   CargarVenta (unaVenta);
  end;
 writeln;
 writeln ('-----------------------------------------------');
 writeln;
end;


procedure ModuloB (a: arbol);
{ Imprima el contenido del árbol ordenado por código de producto.}
  procedure ImprimirArbol (a: arbol);
  begin
    if (a <> nil)
    then begin
          if (a^.HI <> nil) then ImprimirArbol (a^.HI);
          writeln ('Codigo producto |', a^.dato.codigo, '| cantidad: ', a^.dato.cantTotalUnidades, ' monto total: ', a^.dato.montoTotal:2:2,'$');
          if (a^.HD <> nil) then ImprimirArbol (a^.HD);
         end;
  end;


begin
  writeln;
  writeln ('----- Modulo B ----->');
  writeln;
  if ( a = nil) then writeln ('Arbol vacio')
                else ImprimirArbol (a);
  writeln;
  writeln ('-----------------------------------------------');
  writeln;
end;


procedure ModuloC (a: arbol);
{Retornar el menor código de producto.}


  function ObtenerMinimo (a: arbol): integer;
  begin
    if (a = nil) 
    then ObtenerMinimo:= 9999
    else if (a^.HI = nil) then ObtenerMinimo:= a^.dato.codigo
                          else ObtenerMinimo:= ObtenerMinimo (a^.HI)
  end;
   
var menorCodigo: integer;
begin
  writeln;
  writeln ('----- Modulo C ----->');
  writeln;
  write ('Menor codigo de producto: ');
  writeln;
  menorCodigo:= ObtenerMinimo (a);
  if (menorCodigo = 9999) 
  then writeln ('Arbol vacio')
  else begin
         writeln;
         writeln ('El codigo menor es ', menorCodigo); 
         writeln;
       end;
  writeln;
  writeln ('-----------------------------------------------');
  writeln;
end;


procedure ModuloD (a: arbol);
{ Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro }
  
	function CantidadDeCodigosMenores (a: arbol; valor: integer): integer;
	begin
		if (a = nil) then
			CantidadDeCodigosMenores:= 0
		else
		if (a^.dato.codigo < valor) then
			CantidadDeCodigosMenores:= 1 + CantidadDeCodigosMenores(a^.HI, valor) + CantidadDeCodigosMenores (a^.HD, valor)
		else
			CantidadDeCodigosMenores := CantidadDeCodigosMenores(a^.HI, valor);	// solo buscamos en el izquierdo (por orden)
	end;
var
	cant,valor: integer;
begin
	writeln;writeln ('----- Modulo D ----->');writeln;
	write ('Ingresar un codigo: ');
	readln (valor);
	cant := CantidadDeCodigosMenores(a, valor);
	writeln;writeln ('La cantidad de codigos menores al codigo ', valor, ' es: ', cant);	writeln;
	writeln ('-----------------------------------------------');writeln;
end;
   


procedure ModuloE (a: arbol);
{ Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de producto y retorne el monto total entre todos los códigos de productos 
comprendidos entre los dos valores recibidos (sin incluir). }
	function ObtenerMontoTotalEntreDosCodigos (a: arbol; cod1, cod2: integer): real;
	begin
	{ COMPLETAR }
		if (a = nil) then
			ObtenerMontoTotalEntreDosCodigos:= 0
		else
		if (a^.dato.codigo > cod1) and (a^.dato.codigo < cod2) then
			ObtenerMontoTotalEntreDosCodigos:= a^.dato.montoTotal + ObtenerMontoTotalEntreDosCodigos(a^.HI, cod1,cod2) + ObtenerMontoTotalEntreDosCodigos(a^.HD,cod1,cod2)
		else
		if (a^.dato.codigo <= cod1) then
			ObtenerMontoTotalEntreDosCodigos:= ObtenerMontoTotalEntreDosCodigos(a^.HD, cod1,cod2)
		else
			ObtenerMontoTotalEntreDosCodigos:= ObtenerMontoTotalEntreDosCodigos(a^.HI, cod1,cod2)


	end;


var
	cod1,cod2:integer;
	total:real;
begin
	write('Ingrese cod 1: ');read(cod1);
	write('Ingrese cod 2: ');read(cod2);
	//cod 1 siempre menor
	cod1:= cod1 + cod2;
	cod2:= cod1 - cod2;
	cod1:= cod1 - cod2;
	
	total:= ObtenerMontoTotalEntreDosCodigos(a,cod1,cod2);
	 if (total = 0) then 
		writeln ('No hay codigos entre ', cod1, ' y ', cod2)
		else 
		begin
         writeln;
         writeln;write('El monto total entre (',cod1,',',cod2,') es: ',total:0:2); 
         writeln;
       end;
end;

var 
  a: arbol;
begin
  randomize;
  ModuloA (a);
  ModuloB (a);
  ModuloC (a);
  ModuloD (a);
  ModuloE (a);  
end.
