unit uClienteController;

interface

uses
  uIClienteService,
  uCliente;

type
  TClienteController = class
  private
    FService: IClienteService;
  public
    constructor Create(AService: IClienteService);
    function Buscar(ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteController }

constructor TClienteController.Create(AService: IClienteService);
begin
  FService := AService;
end;

function TClienteController.Buscar(ACodigo: Integer): TCliente;
begin
  Result := FService.BuscarPorCodigo(ACodigo);
end;

end.
