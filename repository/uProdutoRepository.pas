unit uProdutoRepository;

interface

uses
  uIProdutoRepository,
  uProduto,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.SysUtils;

type
  TProdutoRepository = class(TInterfacedObject, IProdutoRepository)
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function GetById(ACodigo: Integer): TProduto;
  end;

implementation

{ TProdutoRepository }

constructor TProdutoRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TProdutoRepository.GetById(ACodigo: Integer): TProduto;
var
  Qry: TFDQuery;
begin
  Result := nil;

  Qry := TFDQuery.Create(nil);
  try
    Qry.Connection := FConnection;
    Qry.SQL.Text :=
      'SELECT CODIGO, DESCRICAO, PRECO_VENDA ' +
      'FROM TBPRODUTO WHERE CODIGO = :CODIGO';

    Qry.ParamByName('CODIGO').AsInteger := ACodigo;
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      Result := TProduto.Create;
      Result.Codigo := Qry.FieldByName('CODIGO').AsInteger;
      Result.Descricao := Qry.FieldByName('DESCRICAO').AsString;
      Result.PrecoVenda := Qry.FieldByName('PRECO_VENDA').AsCurrency;
    end;

  finally
    Qry.Free;
  end;
end;

end.
