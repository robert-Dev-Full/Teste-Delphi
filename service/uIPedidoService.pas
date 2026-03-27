unit uIPedidoService;

interface

uses
  uPedido;

type
  IPedidoService = interface
    ['{9999AAAA-BBBB-CCCC-DDDD-EEEEFFFF0000}']
    function BuscarPorNumero(ANumero: Integer): TPedido;
    procedure Inserir(APedido: TPedido);
  end;

implementation

end.
