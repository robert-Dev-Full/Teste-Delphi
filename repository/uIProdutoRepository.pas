unit uIProdutoRepository;

interface

uses
  uProduto;

type
  IProdutoRepository = interface
    ['{D1E2F3A4-1111-2222-3333-444455556777}']
    function GetById(ACodigo: Integer): TProduto;
  end;

implementation

end.
