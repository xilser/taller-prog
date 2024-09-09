program p1ej3;
const
	dimF = 8;
	fin = -1;
type
	rangoGen = 1..dimF;
	
	rFilm = record
		codigo: integer;
		genero: rangoGen;
		puntaje: real;
	end;
	
	lFilm = ^nodo;
	
	nodo = record
		dato:rFilm;
		sig:lFilm;
	end;
	
	punteros = record
		pri: lFilm;
		ult:lFilm;
	end;
	
	vFilm = array [rangoGen] of punteros;
	
	rCodigoGenero = record
        codigo: integer;
        genero: rangoGen;
    end;
	
	vContador = array [rangoGen] of rCodigoGenero;
	



procedure inicializarVectorListas(var v:vFilm);
var
    i:integer;
begin
    for i:= 1 to dimF do
    begin
        v[i].pri:= nil;
		v[i].ult:= nil;
    end;
end;

procedure leerFilm(var r:rFilm);
begin
	writeln('--------------------------------');
    writeln('Codigo de Pelicula: '); readln(r.codigo);
    if (r.codigo <> fin) then
    begin
        writeln('Codigo de Genero (1-8): '); readln(r.genero);
        writeln('Puntaje Promedio: '); readln(r.puntaje);
    end;
end;

procedure agregarFinal(var v:vFilm; i:integer; r:rFilm);
var
	nue, ultimo:lFilm;
begin
	new(nue);				//creo nuevo nodo 
	nue^.dato:= r;			//asigno el elemento deseado
	nue^.sig:= nil;			//se convierte en el final de la lista
	
	if (v[i].pri = nil) then 		//si está vacía
	begin
		v[i].pri:= nue;			//actualizo el inicio
		v[i].ult:= nue;			//actualizo el final
	end			
	else
	begin
        ultimo := v[i].ult; 	// guardo el último nodo actual
        ultimo^.sig := nue;		// realizo enlace con el último
        v[i].ult := nue;   		// actualizo el final
	end;
end;

procedure cargarDato (var v:vFilm);  
var
	r:rFilm;
begin
	inicializarVectorListas(v);
	leerFilm(r);
	while (r.codigo <> fin) do
	begin
		agregarFinal(v,r.genero,r);
		leerFilm(r);
	end;
end;

function maxCodigo (l:punteros):integer;
var
	nodoActual:lFilm;
	maxPuntaje:real;
	codMaxPuntaje: integer;
begin
	maxPuntaje:= -9999;
	nodoActual:= l.pri;
	while (nodoActual <> nil) do
    begin
        if (nodoActual^.dato.puntaje > maxPuntaje) then
        begin
            maxPuntaje := nodoActual^.dato.puntaje;
            codMaxPuntaje := nodoActual^.dato.codigo;
        end;
        nodoActual := nodoActual^.sig;
    end;
    
    maxCodigo:= codMaxPuntaje;
end;

procedure maximos (v:vFilm; var vMax:vContador);
var
	i:rangoGen;
begin
	for i:= 1 to dimF do
	begin
		vMax[i].genero:= i;
		vMax[i].codigo:= maxCodigo(v[i]);
	end;
end;

procedure ordenSeleccion (var v:vContador);
var
	i,j,pos:integer;
	aux: rCodigoGenero;
begin
	for i:= 1 to dimF-1 do
	begin 
		//busca el minimo (v[pos]) entre (v[i]..v[j])
		pos:= i;
		for j:= i+1 to dimF do
			if v[j].codigo < v[pos].codigo then 
				pos:=j;
			
		//intercambia v[i] y v[p]
		aux:= v[pos];
		v[pos]:= v[i];
		v[i]:= aux;
	end;
end;

procedure minmax(v:vContador);
begin
	writeln('El codigo de la pelicula con menor puntaje es: ',v[1].codigo,' y pertenece al genero: ',v[1].genero);
	writeln('El codigo de la pelicula con menor puntaje es: ',v[dimF].codigo,' y pertenece al genero: ',v[dimF].genero);
end;

var
	v:vFilm;
	vMaximos:vContador;
begin
	cargarDato(v);
	maximos(v,vMaximos);
	ordenSeleccion(vMaximos);
	minmax(vMaximos);
end.

{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.
* 
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
* 
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c)}
