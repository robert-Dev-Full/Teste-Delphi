program SistDelphi;

uses
  Vcl.Forms,
  UfrmMenu in 'view\UfrmMenu.pas' {frmMenu},
  UfrmPedido in 'view\UfrmPedido.pas' {frmPedido},
  uCliente in 'model\uCliente.pas',
  uIClienteRepository in 'repository\uIClienteRepository.pas',
  uClienteRepository in 'repository\uClienteRepository.pas',
  uIClienteService in 'service\uIClienteService.pas',
  uClienteService in 'service\uClienteService.pas',
  uClienteController in 'controller\uClienteController.pas',
  uDmConexao in 'DM\uDmConexao.pas' {dmConexao: TDataModule},
  uProduto in 'model\uProduto.pas',
  uIProdutoRepository in 'repository\uIProdutoRepository.pas',
  uProdutoRepository in 'repository\uProdutoRepository.pas',
  uIProdutoService in 'service\uIProdutoService.pas',
  uProdutoService in 'service\uProdutoService.pas',
  uProdutoController in 'controller\uProdutoController.pas',
  uPedido in 'model\uPedido.pas',
  uIPedidoRepository in 'repository\uIPedidoRepository.pas',
  uPedidoRepository in 'repository\uPedidoRepository.pas',
  uIPedidoService in 'service\uIPedidoService.pas',
  uPedidoService in 'service\uPedidoService.pas',
  uPedidoController in 'controller\uPedidoController.pas',
  uPedidoItem in 'model\uPedidoItem.pas',
  uIPedidoItemRepository in 'repository\uIPedidoItemRepository.pas',
  uPedidoItemRepository in 'repository\uPedidoItemRepository.pas',
  uPedidoItemService in 'service\uPedidoItemService.pas',
  uPedidoItemController in 'controller\uPedidoItemController.pas';

{$R *.res}

begin
  Application.Initialize;

  Application.CreateForm(TdmConexao, dmConexao);
  dmConexao.Conectar;

  Application.CreateForm(TfrmMenu, frmMenu);

  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
