unit uProdutoController;

interface

uses
  uIProdutoService,
  uProduto;

type
  TProdutoController = class
  private
    FService: IProdutoService;
  public
    constructor Create(AService: IProdutoService);
    function Buscar(ACodigo: Integer): TProduto;
  end;

implementation

{ TProdutoController }

constructor TProdutoController.Create(AService: IProdutoService);
begin
  FService := AService;
end;

function TProdutoController.Buscar(ACodigo: Integer): TProduto;
begin
  Result := FService.BuscarPorCodigo(ACodigo);
end;

end.
