unit uProdutoService;

interface

uses
  uIProdutoService,
  uIProdutoRepository,
  uProduto,
  System.SysUtils;

type
  TProdutoService = class(TInterfacedObject, IProdutoService)
  private
    FRepository: IProdutoRepository;
  public
    constructor Create(ARepository: IProdutoRepository);
    function BuscarPorCodigo(ACodigo: Integer): TProduto;
  end;

implementation

{ TProdutoService }

constructor TProdutoService.Create(ARepository: IProdutoRepository);
begin
  FRepository := ARepository;
end;

function TProdutoService.BuscarPorCodigo(ACodigo: Integer): TProduto;
begin
  if ACodigo <= 0 then
    raise Exception.Create('Código do produto inválido');

  Result := FRepository.GetById(ACodigo);

  if not Assigned(Result) then
    raise Exception.Create('Produto não encontrado');
end;

end.
