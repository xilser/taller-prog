{Escribir un programa que:
* a. Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
	i. Informar los datos de los socios en orden creciente.
	ii. Informar los datos de los socios en orden decreciente.
	iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
	iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
	vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
	vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
	viii. Informar el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.
﻿}
Program ImperativoClase3;
type rangoEdad = 12..100;
	 cadena15 = string [15];
	 socio = record
			   numero: integer;
			   nombre: cadena15;
			   edad: rangoEdad;
			 end;
	 arbol = ^nodoArbol;
	 nodoArbol = record
					dato: socio;
					HI: arbol;
					HD: arbol;
				 end;
				 
  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
	s.numero:= random (51) * 100;
	If (s.numero <> 0)
	then begin
		   s.nombre:= vNombres[random(10)];
		   s.edad:= 12 + random (79);
		 end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
	if (a = nil) 
	then begin
		   new(a);
		   a^.dato:= elem; 
		   a^.HI:= nil; 
		   a^.HD:= nil;
		 end
	else if (elem.numero < a^.dato.numero) 
		 then InsertarElemento(a^.HI, elem)
		 else InsertarElemento(a^.HD, elem); 
  End;
procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
	if ((a <> nil) and (a^.HI <> nil))
	then InformarDatosSociosOrdenCreciente (a^.HI);
	writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
	if ((a <> nil) and (a^.HD <> nil))
	then InformarDatosSociosOrdenCreciente (a^.HD);
  end;
Begin
	writeln;
	writeln ('----- Socios en orden creciente por numero de socio ----->');
	writeln;
	InformarDatosSociosOrdenCreciente (a);
	writeln;
	writeln ('//////////////////////////////////////////////////////////');
	writeln;
end;




procedure GenerarArbol (var a: arbol);
var
	s:socio;
begin
	a:= nil;
	writeln; writeln ('----- Ingreso de socios y armado del arbol ----->'); writeln;
	CargarSocio(s);
	while (s.numero <> 0) do
	begin
		InsertarElemento(a,s);
		CargarSocio(s);
	end;
	writeln;
	writeln ('//////////////////////////////////////////////////////////');
	writeln;
end;
procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }
	 procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;




var maxEdad, maxNum: integer;
begin
  writeln;
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
		 write ('----- Informar Numero Socio Con Mas Edad -----> ',maxNum);
		 writeln;
	   end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;
procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var 
	resto: integer;
  begin
	if (a = nil) then
		AumentarEdad:= 0//vacio
	else begin
			resto:= a^.dato.edad mod 2;
			if (resto = 1) then //si es impar
				a^.dato.edad:= a^.dato.edad + 1;//aumento 1
			AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
		end;  
  end;
begin
  writeln;write ('----- Cantidad de socios con edad aumentada -----> ');
  write (AumentarEdad (a)); writeln; writeln;
  writeln ('//////////////////////////////////////////////////////////');writeln;
end;




procedure InformarSociosOrdenDecreciente (a:arbol);
begin
	if (a <> nil) then
	begin
		InformarSociosOrdenDecreciente(a^.HD); //hace falta (a^.HD <> nil)??
		writeln ('|Numero: ', a^.dato.numero, ' |Nombre: ', a^.dato.nombre, ' |Edad: ', a^.dato.edad);
		InformarSociosOrdenDecreciente(a^.HI);
	end;
end;




function buscarNombreRec(a: arbol; nom: string): boolean;
begin
	if (a = nil) then
		buscarNombreRec := false
	else if (a^.dato.nombre = nom) then
		buscarNombreRec := true
	else
		buscarNombreRec := buscarNombreRec(a^.HI, nom) or buscarNombreRec(a^.HD, nom);
end;








procedure InformarExistenciaNombreSocio(a: arbol);
var
	nom:string;
begin
	writeln('Dame nombre a buscar: '); read(nom);
	if (buscarNombreRec(a,nom)) then
		writeln('existe')
	else
		writeln('no existe');
end;




procedure contarRec (a: arbol; var cant: integer);
begin
	if (a <> nil) then
	begin
		contarRec(a^.HI, cant);
		cant := cant + 1;
		contarRec(a^.HD, cant);
	end;
end;




procedure informarCantidadSocios(a: arbol);
var
    cant: integer;
begin
	cant:= 0;
    contarRec(a,cant);
    writeln('En total, hay ', cant, ' socios');
end;




function totalEdadRec(a: arbol; total: integer): integer;
begin
    if (a <> nil) then
    begin
        total:= totalEdadRec(a^.HI, total);
        total:= total + a^.dato.edad;
        total:= totalEdadRec(a^.HD, total);
    end;
    totalEdadRec:= total;
end;








procedure InformarPromedioDeEdad (a: arbol);
var
	cant, total:integer;
	avg: real;
begin
	cant:= 0; total:= 0;
	total:= totalEdadRec(a,total);
	contarRec(a,cant);
	writeln('cant = ',cant,' total = ',total);// para verificar
	avg:= (total/cant);
	writeln('El promedio de edad es: ',avg:0:2);
end;


function socioGrande (a:arbol):integer;
//busca la hoja mas a la derecha (el num de socio mayor)
begin
	if (a = nil) then
		socioGrande:= -1
	else 
	if (a^.HD = nil) then				//vamos hasta el ultimo
		socioGrande:= a^.dato.numero 	//la hoja mas a la derecha
	else
		socioGrande:= socioGrande(a^.HD);
end;


procedure socioChico (a:arbol);
//busca la hoja mas a la izq e informa su contenido
begin
	if (a = nil) then
		writeln('arbol vacio')
	else 
	if (a^.HI = nil) then
		writeln('Numero: ', a^.dato.numero, ' | Nombre: ', a^.dato.nombre, ' | Edad: ', a^.dato.edad)
	else
		socioChico(a^.HI);
end;




procedure informarExistenciaNumeroSocio(a:arbol);


	function existeNumSocio(a:arbol;num:integer):boolean;
	begin
		if (a = nil) then
			existeNumSocio:= false
		else
		if (a^.dato.numero = num) then
			existeNumSocio:= true
		else
		if (a^.dato.numero > num) then
			existeNumSocio:= existeNumSocio(a^.HI, num)
		else 
			existeNumSocio:= existeNumSocio(a^.HD, num);
	end;




var
	num:integer;
begin
	writeln;writeln('Ingrese num de socio a buscar: ');readln(num);
	if (existeNumSocio(a,num)) then
		writeln('Existe')
	else 
		writeln('No existe');
end;


procedure cantEntreValores(a:arbol);


//contar incluyendo los limites
	function contarEntreValores(a:arbol; num1,num2:integer):integer;
	begin
		if (a = nil) then
			contarEntreValores:= 0
		else
		if (num1 <= a^.dato.numero) and (a^.dato.numero <= num2) then
			contarEntreValores:= 1 + contarEntreValores(a^.HI,num1,num2) + contarEntreValores(a^.HD,num1,num2)
		else
		if (num1 > a^.dato.numero) then
			contarEntreValores:= contarEntreValores(a^.HD,num1,num2)
		else 
			contarEntreValores:= contarEntreValores(a^.HI,num1,num2);
	end;


var
	num1,num2,total:integer;
begin
	writeln;writeln('Dame el primer valor del rango: ');readln(num1);
	writeln('Dame el segundo valor del rango: ');readln(num2);
	//me aseguro que esten en orden
	if (num1 > num2) then
	begin
		num1:= num1 + num2;
		num2:= num1 - num2;
		num1:= num1 - num2;
	end;
	total:= contarEntreValores(a,num1,num2);
	writeln('la cant de socios entre los numeros ',num1,' y ',num2,' son: ',total);
end;


var 
	a: arbol; 
begin
	randomize;
	GenerarArbol (a);
	InformarSociosOrdenCreciente (a);
	writeln ('----- Socios en orden decreciente por numero de socio ----->');
	InformarSociosOrdenDecreciente (a);
	InformarNumeroSocioConMasEdad (a);
	AumentarEdadNumeroImpar (a);
	informarExistenciaNombreSocio (a);
	InformarCantidadSocios (a); 
	InformarPromedioDeEdad (a); 
	writeln;write('El num de socio mas grande es: ',socioGrande(a));
	writeln;writeln;write('Los datos del socio con el num mas chico son: ');writeln;socioChico(a);
	informarExistenciaNumeroSocio(a);
	cantEntreValores(a);
end.
