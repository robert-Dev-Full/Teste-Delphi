unit uPedidoItemRepository;

interface

uses
  uIPedidoItemRepository,
  uPedidoItem,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.SysUtils,
  System.Generics.Collections;

type
  TPedidoItemRepository = class(TInterfacedObject, IPedidoItemRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);

    function GetByPedido(ANumeroPedido: Integer): TObjectList<TPedidoItem>;
    function GetByPedidoProduto(ANumeroPedido, ACodProduto: Integer): TPedidoItem;
    function GetDataSetByPedido(ANumeroPedido: Integer): TFDQuery;
    function GetNextId: Integer;

    procedure Insert(AItem: TPedidoItem);
    procedure Update(AItem: TPedidoItem);
    procedure Delete(AId: Integer);
  end;

implementation

constructor TPedidoItemRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TPedidoItemRepository.GetNextId: Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'SELECT NEXT VALUE FOR GEN_TBPEDIDO_ITEM_ID AS ID FROM RDB$DATABASE';
    Qry.Open;
    Result := Qry.FieldByName('ID').AsInteger;
  finally
    Qry.Free;
  end;
end;

function TPedidoItemRepository.GetByPedido(ANumeroPedido: Integer): TObjectList<TPedidoItem>;
var
  Qry: TFDQuery;
  Item: TPedidoItem;
begin
  Result := TObjectList<TPedidoItem>.Create(True);

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT * FROM TBPEDIDO_ITEM WHERE NUMERO_PEDIDO = :NUMERO';

    Qry.ParamByName('NUMERO').AsInteger := ANumeroPedido;
    Qry.Open;

    while not Qry.Eof do
    begin
      Item := TPedidoItem.Create;
      Item.ID := Qry.FieldByName('ID').AsInteger;
      Item.NumeroPedido := Qry.FieldByName('NUMERO_PEDIDO').AsInteger;
      Item.CodigoProduto := Qry.FieldByName('CODIGO_PRODUTO').AsInteger;
      Item.Quantidade := Qry.FieldByName('QUANTIDADE').AsFloat;
      Item.VlrUnitario := Qry.FieldByName('VLR_UNITARIO').AsCurrency;
      Item.VlrTotal := Qry.FieldByName('VLR_TOTAL').AsCurrency;

      Result.Add(Item);
      Qry.Next;
    end;

  finally
    Qry.Free;
  end;
end;

function TPedidoItemRepository.GetByPedidoProduto(ANumeroPedido,
  ACodProduto: Integer): TPedidoItem;
var
  Qry: TFDQuery;
begin
  Result := nil;
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT * FROM TBPEDIDO_ITEM ' +
      'WHERE NUMERO_PEDIDO = :PEDIDO AND CODIGO_PRODUTO = :PRODUTO';
    Qry.ParamByName('PEDIDO').AsInteger := ANumeroPedido;
    Qry.ParamByName('PRODUTO').AsInteger := ACodProduto;
    Qry.Open;
    if not Qry.IsEmpty then
    begin
      Result := TPedidoItem.Create;
      Result.ID := Qry.FieldByName('ID').AsInteger;
      Result.NumeroPedido := Qry.FieldByName('NUMERO_PEDIDO').AsInteger;
      Result.CodigoProduto := Qry.FieldByName('CODIGO_PRODUTO').AsInteger;
      Result.Quantidade := Qry.FieldByName('QUANTIDADE').AsFloat;
      Result.VlrUnitario := Qry.FieldByName('VLR_UNITARIO').AsCurrency;
      Result.VlrTotal := Qry.FieldByName('VLR_TOTAL').AsCurrency;
    end;
  finally
    Qry.Free;
  end;
end;

function TPedidoItemRepository.GetDataSetByPedido(
  ANumeroPedido: Integer): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FConnection;
  Result.SQL.Text :=
    'SELECT ped.*, prd.DESCRICAO '+
    '  FROM TBPEDIDO_ITEM ped    '+
    '    INNER JOIN tbproduto prd  '+
    '  ON ped.CODIGO_PRODUTO = prd.CODIGO '+
    '  WHERE ped.NUMERO_PEDIDO = :NUMERO '+
    '  ORDER by prd.DESCRICAO ';
  Result.ParamByName('NUMERO').AsInteger := ANumeroPedido;
  Result.Open;
end;

procedure TPedidoItemRepository.Insert(AItem: TPedidoItem);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;

    Qry.SQL.Text :=
      'INSERT INTO TBPEDIDO_ITEM ' +
      '(ID, NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VLR_UNITARIO, VLR_TOTAL) ' +
      'VALUES (:ID, :PEDIDO, :PRODUTO, :QTD, :VLRU, :VLRT)';

    Qry.ParamByName('ID').AsInteger := AItem.ID;
    Qry.ParamByName('PEDIDO').AsInteger := AItem.NumeroPedido;
    Qry.ParamByName('PRODUTO').AsInteger := AItem.CodigoProduto;
    Qry.ParamByName('QTD').AsFloat := AItem.Quantidade;
    Qry.ParamByName('VLRU').AsCurrency := AItem.VlrUnitario;
    Qry.ParamByName('VLRT').AsCurrency := AItem.VlrTotal;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TPedidoItemRepository.Update(AItem: TPedidoItem);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;

    Qry.SQL.Text :=
      'UPDATE TBPEDIDO_ITEM SET ' +
      'CODIGO_PRODUTO = :PRODUTO, ' +
      'QUANTIDADE = :QTD, ' +
      'VLR_UNITARIO = :VLRU, ' +
      'VLR_TOTAL = :VLRT ' +
      'WHERE ID = :ID';

    Qry.ParamByName('ID').AsInteger := AItem.ID;
    Qry.ParamByName('PRODUTO').AsInteger := AItem.CodigoProduto;
    Qry.ParamByName('QTD').AsFloat := AItem.Quantidade;
    Qry.ParamByName('VLRU').AsCurrency := AItem.VlrUnitario;
    Qry.ParamByName('VLRT').AsCurrency := AItem.VlrTotal;

    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

procedure TPedidoItemRepository.Delete(AId: Integer);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text := 'DELETE FROM TBPEDIDO_ITEM WHERE ID = :ID';
    Qry.ParamByName('ID').AsInteger := AId;
    Qry.ExecSQL;
  finally
    Qry.Free;
  end;
end;

end.
