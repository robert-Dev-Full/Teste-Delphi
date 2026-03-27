unit uClienteService;

interface

uses
  uIClienteService,
  uIClienteRepository,
  uCliente,
  System.SysUtils;

type
  TClienteService = class(TInterfacedObject, IClienteService)
  private
    FRepository: IClienteRepository;
  public
    constructor Create(ARepository: IClienteRepository);
    function BuscarPorCodigo(ACodigo: Integer): TCliente;
  end;

implementation

{ TClienteService }

constructor TClienteService.Create(ARepository: IClienteRepository);
begin
  FRepository := ARepository;
end;

function TClienteService.BuscarPorCodigo(ACodigo: Integer): TCliente;
begin
  if ACodigo <= 0 then
    raise Exception.Create('Código inválido');

  Result := FRepository.GetById(ACodigo);

  if not Assigned(Result) then
    raise Exception.Create('Cliente não encontrado');
end;

end.
