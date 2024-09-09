program ej;
const
	fin = 0;
type
	ranDia = 1..30;
	ranMes = 1..12;
	ranAno = 2000..4000;
	
	rFecha = record
		dia: ranDia;
		mes: ranMes;
		ano: ranAno;
	end;

//-----------------------------	

	rVenta = record
		codigo: integer;
		fecha: rFecha;
		cantVenta: integer;
	end;


	aVenta = ^nodo;
	nodo = record
		dato: rVenta;
		HI: aVenta;
		HD: aVenta;
		
	end;
	
//-----------------------------
	rProducto = record
		codigo: integer;
		cantTotal: integer;
	end;
	
	aProducto = ^nodo1;
	nodo1 = record
		dato: rProducto;
		hi: aProducto;
		hd: aProducto;
	end;
	
//-----------------------------
	
	rProdLista = record //dentro de cada lista, para no repetir codigo
		fecha:rFecha;
		cantVenta: integer;
	end;
	
	lProducto = ^nodoL;
	
	nodoL = record
		dato: rProdLista;
		sig: lProducto;
	end;
	
	rProductoLista = record //nodo para arbol de listas
		codigo: integer;
		listaProd: lProducto;
	end; 
	
	aLista = ^nodo2;
	
	nodo2 = record // arbol de listas
		dato: rProductoLista;
		hi:aLista;
		hd:aLista;
	end;
	
//-----------------------------
procedure crearVenta(var r:rVenta);
var
	rF: rFecha;
	num:integer;
begin
	num:= random(100 - 0 +1) + 0;//codigo 0..100
	r.codigo:= num;
	if (num <> fin) then
	begin
		num:= random(999 - 0 + 1) + 0;// cantidad 0..999
		r.cantVenta:= num;
		//deberia hacer globales para la fecha pero na
		//y variables con los rangos apropiados
		num:= random(30 - 1 + 1) + 1;
		rF.dia:= num;
		num:= random(12 - 1 + 1) + 1;
		rF.mes:= num;
		num:= random(4000 - 2000 +1) + 2000;
		rF.ano:= num;
		r.fecha:= rf;
	end;
end;



procedure agregar(var a:aVenta; r:rVenta);
//agrega dato a un arbol ordenado por codigo de forma ascendente
begin
	if (a = nil) then //esta vacio
	begin
		new(a);
		a^.dato:= r; a^.HI:= nil; a^.HD:= nil;
	end
	else
	if (r.codigo < a^.dato.codigo) then// los identicos van del lado derecho por <
		agregar(a^.HI, r)
	else
		agregar(a^.HD,r);
end;

procedure agregarVentas(var a:aProducto; r:rVenta);
begin
	if (a = nil) then //esta vacio
	begin
		new(a);
		a^.dato.codigo:= r.codigo;
		a^.dato.cantTotal:= r.cantVenta;
		a^.hi:= nil; a^.hd:= nil;
	end
	else
	if (r.codigo = a^.dato.codigo) then  // si el código ya existe, suma las ventas
        a^.dato.cantTotal := a^.dato.cantTotal + r.cantVenta
    else
    if (r.codigo < a^.dato.codigo) then  // si es menor, va al izquierdo
        agregarVentas(a^.hi, r)
    else  // si es mayor, va al  derecho
        agregarVentas(a^.hd, r);
end;

procedure agregarAdelante(var l:lProducto;r:rVenta);
var
	nue:lProducto;
begin
	new(nue);
	nue^.dato.fecha:= r.fecha;
	nue^.dato.cantVenta:= r.cantVenta;
	nue^.sig:= l;
	l:= nue;
end;

procedure agregarLista(var a:aLista;r:rVenta);
begin
	if (a = nil) then
	begin
		new(a);
		a^.dato.codigo:= r.codigo;
		a^.dato.listaProd:= nil;
		agregarAdelante(a^.dato.listaProd,r);//de r hay que sacar fecha y cant
		a^.hi:= nil; a^.hd:= nil;
	end
	else
	if (r.codigo = a^.dato.codigo) then //mismo cod, sumo a la lista
		agregarAdelante(a^.dato.listaProd,r)
	else
	if (r.codigo < a^.dato.codigo) then //si es menor, va al izq
		agregarLista(a^.hi,r)
	else  //si es mayor, va al derecho
		agregarLista(a^.hd,r);
	
end;

procedure cargarArbol(var aV:aVenta;var aP:aProducto;var aL: aLista);
var
	r:rVenta;
begin
	aV:= nil;
	aP:= nil;
	aL:= nil;
	crearVenta(r);
	while (r.codigo <> fin) do
	begin
		agregar(aV,r);// creo un arbol con nodos de ventas (i)
		agregarVentas(aP,r);//creo un arbol con nodos de productos
							// cada producto acumula el total de ventas de ese prod.
		agregarLista(aL,r);
		crearVenta(r);
	end;
end;


procedure imprimirArbolVentas(a:aVenta);
begin
	if (a <> nil)  then 
	begin
		imprimirArbolVentas(a^.hi);
		writeln;
		write('|codigo: ',a^.dato.codigo,'| cantidad: ',a^.dato.cantVenta);
		write('| Fecha: ',a^.dato.fecha.dia,'/',a^.dato.fecha.mes,'/',a^.dato.fecha.ano);
		imprimirArbolVentas(a^.hd);
	end;
end;


procedure imprimirArbolProductos(a:aProducto);
begin
	if (a <> nil)  then 
	begin
		imprimirArbolProductos(a^.hi);
		writeln;
		write('|codigo: ',a^.dato.codigo,'| cant total: ',a^.dato.cantTotal);
		imprimirArbolProductos(a^.hd);
	end;
end;

procedure imprimirLista(l:lProducto);
begin
	while (l <> nil) do
	begin
		writeln;
		write('> cantidad: ',l^.dato.cantVenta);
		write(' Fecha: ',l^.dato.fecha.dia,'/',l^.dato.fecha.mes,'/',l^.dato.fecha.ano);
		l:=l^.sig;
	end;
end;


procedure imprimirArbolLista(a:aLista);
begin
	if (a <> nil) then
	begin
		imprimirArbolLista(a^.hi);
		writeln;writeln;
		write('|codigo: ',a^.dato.codigo);write(' ---Lista de ventas-- ');
		imprimirLista(a^.dato.listaProd);
		imprimirArbolLista(a^.hd);
	end;
end;


function cantVentasFechaRec(a:aVenta; r:rFecha):integer;
begin
	if (a = nil) then
		cantVentasFechaRec:= 0//vacio
	else
	begin
	if (a^.dato.fecha.dia = r.dia) and (a^.dato.fecha.mes = r.mes) and (a^.dato.fecha.ano = r.ano) then
	//si coincide: sumo y sigo
		cantVentasFechaRec:=  a^.dato.cantVenta + cantVentasFechaRec(a^.HI, r) + cantVentasFechaRec(a^.HD, r)
	else
	//si no coincide: sigo
		cantVentasFechaRec:= cantVentasFechaRec(a^.HI, r) + cantVentasFechaRec(a^.HD, r);
	end;
end;

procedure totalVendidosFecha(a:aVenta);
var
	r:rFecha;
begin
	writeln;
	write('Ingrese una fecha (dd/mm/yy): ');
	read(r.dia); read(r.mes);read(r.ano);
	
	write(' La cantidad de ventas realizadas el dia ',a^.dato.fecha.dia,'/',a^.dato.fecha.mes,'/',a^.dato.fecha.ano);
	write(' fueron: ',cantVentasFechaRec(a,r));
end;

var
	aV:aVenta; aP:aProducto; aL:aLista;
begin
	randomize;
	cargarArbol(aV,aP,aL);
	imprimirArbolVentas(aV);
	imprimirArbolProductos(aP);
	imprimirArbolLista(al);
	totalVendidosFecha(aV);
end.

