unit uPedidoItemService;

interface

uses
  uIPedidoItemRepository,
  uPedidoItem,
  System.Generics.Collections,
  System.SysUtils,
  FireDAC.Comp.Client;

type
  TPedidoItemService = class(TInterfacedObject)
  private
    FRepository: IPedidoItemRepository;
  public
    constructor Create(ARepository: IPedidoItemRepository);

    function Listar(ANumeroPedido: Integer): TObjectList<TPedidoItem>;
    function GetDataSet(ANumeroPedido: Integer): TFDQuery;
    procedure Inserir(AItem: TPedidoItem);
    procedure Atualizar(AItem: TPedidoItem);
    procedure Excluir(AId: Integer);
  end;

implementation

constructor TPedidoItemService.Create(ARepository: IPedidoItemRepository);
begin
  FRepository := ARepository;
end;

function TPedidoItemService.Listar(ANumeroPedido: Integer): TObjectList<TPedidoItem>;
begin
  Result := FRepository.GetByPedido(ANumeroPedido);
end;

procedure TPedidoItemService.Inserir(AItem: TPedidoItem);
begin
  AItem.ID := FRepository.GetNextId;
  AItem.VlrTotal := AItem.Quantidade * AItem.VlrUnitario;

  FRepository.Insert(AItem);
end;

{procedure TPedidoItemService.Inserir(AItem: TPedidoItem);
var
  ItemExistente: TPedidoItem;
begin
  ItemExistente := FRepository.GetByPedidoProduto(
    AItem.NumeroPedido,
    AItem.CodigoProduto
  );

  if Assigned(ItemExistente) then
  begin
    try
      ItemExistente.Quantidade := AItem.Quantidade;

      ItemExistente.VlrUnitario := AItem.VlrUnitario;

      ItemExistente.VlrTotal :=
        ItemExistente.Quantidade * ItemExistente.VlrUnitario;

      FRepository.Update(ItemExistente);
    finally
      ItemExistente.Free;
    end;
  end
  else
  begin
    AItem.ID := FRepository.GetNextId;
    AItem.VlrTotal := AItem.Quantidade * AItem.VlrUnitario;

    FRepository.Insert(AItem);
  end;
end;    }

procedure TPedidoItemService.Atualizar(AItem: TPedidoItem);
begin
  AItem.VlrTotal := AItem.Quantidade * AItem.VlrUnitario;
  FRepository.Update(AItem);
end;

procedure TPedidoItemService.Excluir(AId: Integer);
begin
  FRepository.Delete(AId);
end;

function TPedidoItemService.GetDataSet(ANumeroPedido: Integer): TFDQuery;
begin
  Result := FRepository.GetDataSetByPedido(ANumeroPedido);
end;

end.
