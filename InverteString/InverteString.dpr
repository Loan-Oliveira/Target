program InverteString;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  str, strInversa : String;
  i, pos, contador : Integer;

begin
  try
    Write('Digite uma palavra: ');
    Readln(str);
    pos := length(str);

    for I := 0 to length(str) - 1 do
    begin
      strInversa := strInversa + copy(str, pos, 1);
      inc(contador);
      pos := pos - 1;
    end;

    Writeln(strInversa);
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
