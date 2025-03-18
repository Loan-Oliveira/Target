program PercentualFaturamento;

{$APPTYPE CONSOLE}

uses
  System.SysUtils;

var
  FaturamentoSP, FaturamentoRJ, FaturamentoMG, FaturamentoES, FaturamentoOutros, FaturamentoTotal: Double;

procedure CalcularPercentual(Estado: String; Valor: Double; Total: Double);
var
  Percentual: Double;
begin
  if Total = 0 then
  begin
    Writeln('O faturamento total informado não pode ser zero.');
    Exit;
  end;

  Percentual := (Valor / Total) * 100;
  Writeln(Format('%s: %.2f%%', [Estado, Percentual]));
end;

begin
  try
    FaturamentoSP := 67836.43;
    FaturamentoRJ := 36678.66;
    FaturamentoMG := 29229.88;
    FaturamentoES := 27165.48;
    FaturamentoOutros := 19849.53;

    FaturamentoTotal := FaturamentoSP + FaturamentoRJ + FaturamentoMG + FaturamentoES + FaturamentoOutros;

    Writeln('Percentual de representação no faturamento total:');
    CalcularPercentual('SP', FaturamentoSP, FaturamentoTotal);
    CalcularPercentual('RJ', FaturamentoRJ, FaturamentoTotal);
    CalcularPercentual('MG', FaturamentoMG, FaturamentoTotal);
    CalcularPercentual('ES', FaturamentoES, FaturamentoTotal);
    CalcularPercentual('Outros', FaturamentoOutros, FaturamentoTotal);
  except
    on E: Exception do
      Writeln('Erro: ', E.Message);
  end;

  Readln;
end.
