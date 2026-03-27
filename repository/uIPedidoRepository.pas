unit uIPedidoRepository;

interface

uses
  uPedido;

type
  IPedidoRepository = interface
    ['{AAAABBBB-CCCC-DDDD-EEEE-FFFF00001111}']
    function GetById(ANumero: Integer): TPedido;
    function GetNextId: Integer;
    procedure Insert(APedido: TPedido);
  end;

implementation

end.
