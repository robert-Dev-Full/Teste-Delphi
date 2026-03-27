unit uIProdutoService;

interface

uses
  uProduto;

type
  IProdutoService = interface
    ['{AAAAEEEE-1111-2222-3333-444455556777}']
    function BuscarPorCodigo(ACodigo: Integer): TProduto;
  end;

implementation

end.
