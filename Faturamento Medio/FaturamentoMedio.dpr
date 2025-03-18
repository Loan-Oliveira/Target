program FaturamentoDistribuidora;

uses
  System.SysUtils, System.Classes, System.JSON, System.Math;

function CarregarJSON(const FileName: string): TJSONArray;
var
  JSONString: TStringList;
  JSONObject: TJSONObject;
begin
  JSONString := TStringList.Create;
  try
    JSONString.LoadFromFile(FileName);
    JSONObject := TJSONObject.ParseJSONValue(JSONString.Text) as TJSONObject;
    Result := JSONObject.GetValue<TJSONArray>('faturamento');
  finally
    JSONString.Free;
  end;
end;

procedure CalcularFaturamento(const JSONData: TJSONArray);
var
  i, CountValidDays: Integer;
  Menor, Maior, Soma, Media: Double;
  DiasAcimaMedia: Integer;
  DiaObj: TJSONObject;
  Valor: Double;
begin
  Menor := MaxDouble;
  Maior := -MaxDouble;
  Soma := 0;
  CountValidDays := 0;
  DiasAcimaMedia := 0;

  for i := 0 to JSONData.Count - 1 do
  begin
    DiaObj := JSONData.Items[i] as TJSONObject;
    Valor := DiaObj.GetValue<Double>('valor'); // Obtem o valor

    if Valor > 0 then
    begin
      if Valor < Menor then
        Menor := Valor;
      if Valor > Maior then
        Maior := Valor;

      Soma := Soma + Valor;
      Inc(CountValidDays);
    end;
  end;

  if CountValidDays > 0 then
    Media := Soma / CountValidDays
  else
    Media := 0;

  for i := 0 to JSONData.Count - 1 do
  begin
    DiaObj := JSONData.Items[i] as TJSONObject;
    Valor := DiaObj.GetValue<Double>('valor');

    if (Valor > 0) and (Valor > Media) then
      Inc(DiasAcimaMedia);
  end;

  WriteLn(Format('Menor faturamento: %.2f', [Menor]));
  WriteLn(Format('Maior faturamento: %.2f', [Maior]));
  WriteLn(Format('Dias com faturamento acima da média: %d', [DiasAcimaMedia]));
end;

var
  FaturamentoJSON: TJSONArray;
begin
  try
    FaturamentoJSON := CarregarJSON('faturamento.json');
    if Assigned(FaturamentoJSON) then
    begin
      CalcularFaturamento(FaturamentoJSON);
    end
    else
      WriteLn('Erro ao carregar JSON.');
  except
    on E: Exception do
      WriteLn('Erro: ', E.Message);
  end;

  readln;
end.
