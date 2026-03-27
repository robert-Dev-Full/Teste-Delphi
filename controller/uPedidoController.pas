unit uPedidoController;

interface

uses
  uIPedidoService,
  uPedido;

type
  TPedidoController = class
  private
    FService: IPedidoService;
  public
    constructor Create(AService: IPedidoService);
    function Buscar(ANumero: Integer): TPedido;
    procedure Inserir(APedido: TPedido);
  end;

implementation

{ TPedidoController }

constructor TPedidoController.Create(AService: IPedidoService);
begin
  FService := AService;
end;

function TPedidoController.Buscar(ANumero: Integer): TPedido;
begin
  Result := FService.BuscarPorNumero(ANumero);
end;

procedure TPedidoController.Inserir(APedido: TPedido);
begin
  FService.Inserir(APedido);
end;

end.
