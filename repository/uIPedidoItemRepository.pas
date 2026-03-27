unit uIPedidoItemRepository;

interface

uses
  uPedidoItem,
  System.Generics.Collections,
  FireDAC.Comp.Client;

type
  IPedidoItemRepository = interface
    ['{ABCDEF01-1111-2222-3333-444455556666}']
    function GetByPedido(ANumeroPedido: Integer): TObjectList<TPedidoItem>;
    function GetByPedidoProduto(ANumeroPedido, ACodProduto: Integer): TPedidoItem;
    function GetDataSetByPedido(ANumeroPedido: Integer): TFDQuery;
    function GetNextId: Integer;
    procedure Insert(AItem: TPedidoItem);
    procedure Update(AItem: TPedidoItem);
    procedure Delete(AId: Integer);
  end;

implementation

end.
