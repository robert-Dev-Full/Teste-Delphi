unit uPedidoRepository;

interface

uses
  uIPedidoRepository,
  uPedido,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.SysUtils;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetById(ANumero: Integer): TPedido;
    function GetNextId: Integer;
    procedure Insert(APedido: TPedido);
  end;

implementation

{ TPedidoRepository }

constructor TPedidoRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TPedidoRepository.GetNextId: Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT NEXT VALUE FOR GEN_TBPEDIDO_ID AS ID FROM RDB$DATABASE';
    Qry.Open;

    Result := Qry.FieldByName('ID').AsInteger;
  finally
    Qry.Free;
  end;
end;

function TPedidoRepository.GetById(ANumero: Integer): TPedido;
var
  Qry: TFDQuery;
begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT NUMERO_PEDIDO, DATA_EMISSAO, CODIGO_CLIENTE, VALOR_TOTAL ' +
      'FROM TBPEDIDO WHERE NUMERO_PEDIDO = :NUMERO';

    Qry.ParamByName('NUMERO').AsInteger := ANumero;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TPedido.Create;
      Result.NumeroPedido := Qry.FieldByName('NUMERO_PEDIDO').AsInteger;
      Result.DataEmissao := Qry.FieldByName('DATA_EMISSAO').AsDateTime;
      Result.CodigoCliente := Qry.FieldByName('CODIGO_CLIENTE').AsInteger;
      Result.ValorTotal := Qry.FieldByName('VALOR_TOTAL').AsCurrency;
    end;

  finally
    Qry.Free;
  end;
end;

procedure TPedidoRepository.Insert(APedido: TPedido);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;

    Qry.SQL.Text :=
      'INSERT INTO TBPEDIDO ' +
      '(NUMERO_PEDIDO, DATA_EMISSAO, CODIGO_CLIENTE, VALOR_TOTAL) ' +
      'VALUES (:NUMERO, :DATA, :CLIENTE, :VALOR)';

    Qry.ParamByName('NUMERO').AsInteger := APedido.NumeroPedido;
    Qry.ParamByName('DATA').AsDate := APedido.DataEmissao;
    Qry.ParamByName('CLIENTE').AsInteger := APedido.CodigoCliente;
    Qry.ParamByName('VALOR').AsCurrency := APedido.ValorTotal;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

end.
