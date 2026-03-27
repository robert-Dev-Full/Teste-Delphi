unit uClienteRepository;

interface

uses
  uIClienteRepository,
  uCliente,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.SysUtils;

type
  TClienteRepository = class(TInterfacedObject, IClienteRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetById(ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteRepository }

constructor TClienteRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TClienteRepository.GetById(ACodigo: Integer): TCliente;
var
  Qry: TFDQuery;
begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT CODIGO, NOME, CIDADE, UF ' +
      'FROM TBCLIENTE WHERE CODIGO = :CODIGO';

    Qry.ParamByName('CODIGO').AsInteger := ACodigo;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TCliente.Create;
      Result.Codigo := Qry.FieldByName('CODIGO').AsInteger;
      Result.Nome := Qry.FieldByName('NOME').AsString;
      Result.Cidade := Qry.FieldByName('CIDADE').AsString;
      Result.UF := Qry.FieldByName('UF').AsString;
    end;

  finally
    Qry.Free;
  end;
end;

end.
