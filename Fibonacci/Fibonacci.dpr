program Fibonacci;

uses
  SysUtils;

function ValidaNumero(n: Integer): Boolean;
var
  a, b, temp: Integer;
begin
  a := 0;
  b := 1;

  if (n = a) or (n = b) then
  begin
    Result := True;
    Exit;
  end;

  while b < n do
  begin
    temp := a + b;
    a := b;
    b := temp;
  end;

  Result := (b = n);
end;

procedure MostraResultado(n: Integer);
var
  a, b, temp: Integer;
begin
  a := 0;
  b := 1;
  Write('Sequência de Fibonacci até o número ', n, ': ', a, ' ', b);

  while (a + b) <= n do
  begin
    temp := a + b;
    Write(' ', temp);
    a := b;
    b := temp;
  end;
  Writeln;
end;

var
  num: Integer;
begin
  Write('Digite um número: ');
  Readln(num);
  MostraResultado(num);

  if ValidaNumero(num) then
    Writeln('O número ', num, ' pertence à sequência Fibonacci.')
  else
    Writeln('O número ', num, ' não pertence à sequência Fibonacci.');

  Readln;
end.

