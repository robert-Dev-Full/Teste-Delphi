unit uPedidoItem;

interface

type
  TPedidoItem = class
  private
    FID: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Double;
    FVlrUnitario: Currency;
    FVlrTotal: Currency;
  public
    property ID: Integer read FID write FID;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property VlrUnitario: Currency read FVlrUnitario write FVlrUnitario;
    property VlrTotal: Currency read FVlrTotal write FVlrTotal;
  end;

implementation

end.
