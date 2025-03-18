program FaturamentoMedio;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  SuperObject;

type
  TDiaFaturamento = record
    Dia: Integer;
    Valor: Double;
  end;

var
  JSONData: ISuperObject;
  JSONArray: TSuperArray;
  Faturamento: array of TDiaFaturamento;
  MenorValor, MaiorValor, SomaValores, MediaMensal: Double;
  DiasComFaturamento, DiasAcimaDaMedia, I: Integer;

begin
  try
    // Carregar JSON do arquivo
    JSONData := TSuperObject.ParseFile('faturamento.json', True);
    if JSONData = nil then
      raise Exception.Create('Erro ao carregar o arquivo JSON.');

    JSONArray := JSONData.A['faturamento'];
    SetLength(Faturamento, JSONArray.Length);

    DiasComFaturamento := 0;
    SomaValores := 0;

    // Ler valores do JSON
    for I := 0 to JSONArray.Length - 1 do
    begin
      Faturamento[I].Dia := JSONArray.O[I].I['dia'];
      Faturamento[I].Valor := JSONArray.O[I].D['valor'];

      if Faturamento[I].Valor > 0 then
      begin
        if (DiasComFaturamento = 0) or (Faturamento[I].Valor < MenorValor) then
          MenorValor := Faturamento[I].Valor;

        if (DiasComFaturamento = 0) or (Faturamento[I].Valor > MaiorValor) then
          MaiorValor := Faturamento[I].Valor;

        SomaValores := SomaValores + Faturamento[I].Valor;
        Inc(DiasComFaturamento);
      end;
    end;

    if DiasComFaturamento = 0 then
    begin
      Writeln('Nenhum dia com faturamento registrado.');
      Exit;
    end;

    // Calcular média mensal
    MediaMensal := SomaValores / DiasComFaturamento;
    DiasAcimaDaMedia := 0;

    for I := 0 to High(Faturamento) do
    begin
      if (Faturamento[I].Valor > 0) and (Faturamento[I].Valor > MediaMensal) then
        Inc(DiasAcimaDaMedia);
    end;

    // Exibir resultados
    Writeln(Format('Menor valor de faturamento: %.2f', [MenorValor]));
    Writeln(Format('Maior valor de faturamento: %.2f', [MaiorValor]));
    Writeln(Format('Número de dias com faturamento acima da média: %d', [DiasAcimaDaMedia]));

  except
    on E: Exception do
      Writeln('Erro: ', E.Message);
  end;

  Readln;
end.
