unit uPedidoItemController;

interface

uses
  uPedidoItemService,
  uPedidoItem,
  System.Generics.Collections,
  FireDAC.Comp.Client;

type
  TPedidoItemController = class
  private
    FService: TPedidoItemService;
  public
    constructor Create(AService: TPedidoItemService);

    function Listar(ANumeroPedido: Integer): TObjectList<TPedidoItem>;
    function GetDataSet(ANumeroPedido: Integer): TFDQuery;
    procedure Inserir(AItem: TPedidoItem);
    procedure Atualizar(AItem: TPedidoItem);
    procedure Excluir(AId: Integer);
  end;

implementation

constructor TPedidoItemController.Create(AService: TPedidoItemService);
begin
  FService := AService;
end;

function TPedidoItemController.Listar(ANumeroPedido: Integer): TObjectList<TPedidoItem>;
begin
  Result := FService.Listar(ANumeroPedido);
end;

procedure TPedidoItemController.Inserir(AItem: TPedidoItem);
begin
  FService.Inserir(AItem);
end;

procedure TPedidoItemController.Atualizar(AItem: TPedidoItem);
begin
  FService.Atualizar(AItem);
end;

procedure TPedidoItemController.Excluir(AId: Integer);
begin
  FService.Excluir(AId);
end;

function TPedidoItemController.GetDataSet(ANumeroPedido: Integer): TFDQuery;
begin
  Result := FService.GetDataSet(ANumeroPedido);
end;

end.
