unit uPedidoService;

interface

uses
  uIPedidoService,
  uIPedidoRepository,
  uPedido,
  System.SysUtils;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)
  private
    FRepository: IPedidoRepository;
  public
    constructor Create(ARepository: IPedidoRepository);
    function BuscarPorNumero(ANumero: Integer): TPedido;
    procedure Inserir(APedido: TPedido);
  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create(ARepository: IPedidoRepository);
begin
  FRepository := ARepository;
end;

function TPedidoService.BuscarPorNumero(ANumero: Integer): TPedido;
begin
  if ANumero <= 0 then
    raise Exception.Create('Número do pedido inválido');

  Result := FRepository.GetById(ANumero);

  if not Assigned(Result) then
    raise Exception.Create('Pedido não encontrado');
end;

procedure TPedidoService.Inserir(APedido: TPedido);
begin
  if APedido.CodigoCliente <= 0 then
    raise Exception.Create('Cliente deve ser informado');

  APedido.NumeroPedido := FRepository.GetNextId;

  APedido.DataEmissao := Date;

  if APedido.ValorTotal = 0 then
    APedido.ValorTotal := 0;

  FRepository.Insert(APedido);
end;

end.
