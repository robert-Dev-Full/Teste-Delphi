unit uIClienteRepository;

interface

uses
  uCliente;

type
  IClienteRepository = interface
    ['{A1B2C3D4-1111-2222-3333-444455556666}']
    function GetById(ACodigo: Integer): TCliente;
  end;

implementation

end.
