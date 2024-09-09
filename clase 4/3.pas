program pastorino;
const
  fin = -1;
type
  rVenta = record
    codigo: integer;
    cantUnidadVendida: integer;
    precio: real;
  end;

  lVenta = ^nodoVenta;
  nodoVenta = record
    dato: rVenta;
    sig: lVenta;
  end;

  rProducto = record
    codigo: integer;
    cantVenta: integer;
    montoTotalVenta: real;
    venta: lVenta;
  end;

  aProducto = ^nodoProducto;
  nodoProducto = record
    dato: rProducto;
    hi: aProducto;
    hd: aProducto;
  end;

procedure leerVenta(var r: rVenta; codigoProducto: integer);
var
  num: integer;
  numR: real;
begin
  //codigo
  num:= random(100- -1 + 1) + -1;
  r.codigo := num;
  
  if (r.codigo <> fin) then
  begin
    // Cantidad de unidades vendidas
    num := random(50) + 1;
    r.cantUnidadVendida := num;

    // Precio
    numR := random * 800 + 1;
    r.precio := numR;
  end;
end;

procedure agregarVenta(var l: lVenta; r: rVenta);
var
  nue: lVenta;
begin
  new(nue);
  nue^.dato := r;
  nue^.sig := l;
  l := nue;
end;

procedure agregarProducto(var a: aProducto; rP: rProducto; rV: rVenta);
begin
  if (a = nil) then
  begin
    new(a); // No hay árbol, creo primer nodo
    a^.dato := rP; // Inserto el dato
    a^.dato.venta := nil; // Inicializo la lista de ventas
    agregarVenta(a^.dato.venta, rV); // Agrego la venta a la lista
    a^.dato.cantVenta := 1;
    a^.dato.montoTotalVenta := rV.precio * rV.cantUnidadVendida;
    a^.hi := nil; 
    a^.hd := nil; // Inicializo hijos
  end
  else if (rP.codigo = a^.dato.codigo) then
  begin
    // El producto ya existe, agregamos la venta
    agregarVenta(a^.dato.venta, rV);
    a^.dato.cantVenta := a^.dato.cantVenta + rV.cantUnidadVendida;
    a^.dato.montoTotalVenta := a^.dato.montoTotalVenta + (rV.precio * rV.cantUnidadVendida);
  end
  else if (rP.codigo < a^.dato.codigo) then
    agregarProducto(a^.hi, rP, rV)
  else
    agregarProducto(a^.hd, rP, rV);
end;

procedure leerProducto(var a: aProducto);
var
  rP: rProducto;
  rV: rVenta;
  numVentas: integer;
begin
  // Asignamos un código al producto
  rP.codigo := random(100) + 1; // Código de producto
  
  if (rP.codigo <> fin) then
  begin
    rP.cantVenta := 0;
    rP.montoTotalVenta := 0;
    rP.venta := nil;
    
    // Leemos varias ventas para el producto
    numVentas := random(5) + 1; // Definir cuántas ventas tiene el producto
    
    while numVentas > 0 do
    begin
      leerVenta(rV, rP.codigo); // Leer venta con el código del producto actual
      agregarProducto(a, rP, rV);
      numVentas := numVentas - 1;
    end;
  end;
end;

procedure crearArbol(var a: aProducto);
var

begin
  a := nil;
  
  while numProductos > 0 do
  begin
    leerProducto(a); // Leemos cada producto y sus ventas
  end;
end;

procedure imprimirVentas(l: lVenta);
begin
  while (l <> nil) do
  begin
    writeln;
    write('Codigo de venta: ', l^.dato.codigo);
    write(' | Cantidad vendida: ', l^.dato.cantUnidadVendida);
    write(' | Precio unitario: ', l^.dato.precio:0:2);
    l := l^.sig;
  end;
end;

procedure imprimirArbol(a: aProducto);
begin
  if (a <> nil) then
  begin
    imprimirArbol(a^.hi);
	writeln;writeln;
    writeln('Codigo de producto: ', a^.dato.codigo);
    writeln('Cantidad total de unidades vendidas: ', a^.dato.cantVenta);
    writeln('Monto total de ventas: ', a^.dato.montoTotalVenta:0:2);
    writeln('---------Ventas del producto--------- ');
    imprimirVentas(a^.dato.venta);
    writeln;writeln('-----------------------------------------------------------------------');
    imprimirArbol(a^.hd);
  end;
end;

var
  a: aProducto;
begin
  randomize;
  crearArbol(a);
  imprimirArbol(a);
end.
