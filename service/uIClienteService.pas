unit uIClienteService;

interface

uses
  uCliente;

type
  IClienteService = interface
    ['{BBBBCCCC-1111-2222-3333-444455556666}']
    function BuscarPorCodigo(ACodigo: Integer): TCliente;
  end;

implementation

end.
