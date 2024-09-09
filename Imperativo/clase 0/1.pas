program NumAleatorio;
var
	num,a,b,f: integer;
begin
	randomize;
	//pido datos
	writeln('dame rango a'); readln(a);
	writeln('dame rango b'); readln(b);
	writeln('dame valor para f'); readln(f);
	//me fijo que esten bien, sino los intercambio
	if (a < b) then
	begin
		a:= a + b;
		b:= a - b;
		a:= a - b;
	end;
	
	num := random (a)+ b;
	if (a >= f) and (f >= b) then
	begin
		while (num <> f) do
		begin
			writeln ('El numero aleatorio generado es: ', num);
			num := random (a)+ b;
		end;
	end;
	readln;
end.
{c)Modifique el programa para que imprima 20 números
aleatorios.
* 
d) Modifique el programa para que imprima N números
aleatorios en el rango (A,B), donde N, A y B son
números enteros que se leen por teclado.
* 
e) Modifique el programa para que imprima números
aleatorios en el rango (A,B) hasta que se genere un
valor igual a F, el cual no debe imprimirse. F, A y B
son números enteros que se leen por teclado.}
