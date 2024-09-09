program ayudenme;

procedure binarioRec(n: integer);
var
	digito: integer;
begin
	if n > 0 then// caso base
	begin
		digito:= n mod 2;//obtengo el ultimo dig binario (menos significativo)
		binarioRec(n div 2); //divido en 2 para pasar al prox digito (OC fue util lmao)
		write(digito);
	end;
end;

var
	n: integer;
begin
	write('ingrese num (0 para terminar): ');	readln(n);
	while (n <> 0) do
	begin
		write('el equivalente en binario es: '); 
		binarioRec(n);
		writeln;
		write('ingrese num (0 para terminar): ');	readln(n);
	end;
end.
