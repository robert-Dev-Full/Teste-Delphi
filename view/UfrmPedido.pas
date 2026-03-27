unit UfrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, uClienteController,
  uProdutoController, Vcl.Buttons, uPedidoController, uPedidoItemController,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPedido = class(TForm)
    pnlCliente: TPanel;
    pnlProduto: TPanel;
    pnlTotal: TPanel;
    pnlItens: TPanel;
    Label1: TLabel;
    edtCodigoCliente: TEdit;
    edtNome: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodProduto: TEdit;
    edtDescricao: TEdit;
    Label5: TLabel;
    edtPreco: TEdit;
    btnIniciarPedido: TBitBtn;
    btnInserirProduto: TBitBtn;
    Label6: TLabel;
    edtNumPedido: TEdit;
    Label7: TLabel;
    edtQtd: TEdit;
    qryItens: TFDQuery;
    dsItens: TDataSource;
    dbgProdutos: TDBGrid;
    qryItensID: TIntegerField;
    qryItensNUMERO_PEDIDO: TIntegerField;
    qryItensCODIGO_PRODUTO: TIntegerField;
    qryItensQUANTIDADE: TFMTBCDField;
    qryItensVLR_UNITARIO: TFMTBCDField;
    qryItensVLR_TOTAL: TFMTBCDField;
    qryItensDESCRICAO: TStringField;
    btnVisualizarPedido: TBitBtn;
    Label8: TLabel;
    edtTotalPedido: TEdit;
    btnFinalizar: TBitBtn;
    btnLimpar: TBitBtn;
    Label9: TLabel;
    memoObs: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure btnIniciarPedidoClick(Sender: TObject);
    procedure btnInserirProdutoClick(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVisualizarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdKeyPress(Sender: TObject; var Key: Char);
    procedure btnFinalizarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    FClienteController: TClienteController;
    FProdutoController: TProdutoController;
    FPedidoController: TPedidoController;
    FItemController: TPedidoItemController;
    FAtualizarProduto: Boolean;

    procedure CarregarPedido(pnNumPedido: Integer);
    procedure InserirProduto;
    procedure ExlcuirProduto(AID: Integer);
    procedure CarregarProdutos;
    procedure CarregarItemSelecionado;
    procedure AbrirPedidoPorNumero;
    function TotalPedido: Currency;
    procedure ValidacoesProduto;
    procedure AtualizarProduto;
  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

uses
  uClienteService,
  uIClienteService,
  uClienteRepository,
  uIClienteRepository,
  uCliente,
  uDmConexao,
  uProdutoService,
  uProdutoRepository,
  uIProdutoRepository,
  uIProdutoService,
  uProduto,
  uPedido,
  uPedidoService,
  uPedidoRepository,
  uIPedidoRepository,
  uIPedidoService,
  uIPedidoItemRepository,
  uPedidoItemService,
  uPedidoItemRepository,
  uPedidoItem;

procedure TfrmPedido.edtCodProdutoExit(Sender: TObject);
var
  Produto: TProduto;
begin
  FAtualizarProduto := False;
  edtDescricao.Text := EmptyStr;
  edtPreco.Text := EmptyStr;

  if edtCodProduto.Text = EmptyStr then
    Exit;

  Produto := FProdutoController.Buscar(StrToInt(edtCodProduto.Text));
  try
    edtDescricao.Text := Produto.Descricao;
    edtPreco.Text := CurrToStr(Produto.PrecoVenda);
  finally
    Produto.Free;
  end;
end;

procedure TfrmPedido.edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmPedido.edtPrecoKeyPress(Sender: TObject; var Key: Char);
var
  Separador: Char;
begin
  Separador := FormatSettings.DecimalSeparator;
  if not (Key in ['0'..'9', Separador, #8]) then
    Key := #0;
  if (Key = Separador) and (Pos(Separador, TEdit(Sender).Text) > 0) then
    Key := #0;
end;

procedure TfrmPedido.edtQtdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    btnInserirProdutoClick(Self);
  end;
end;

procedure TfrmPedido.edtQtdKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmPedido.ExlcuirProduto(AID: Integer);
begin
  FItemController.Excluir(AId);
  CarregarProdutos;
end;

procedure TfrmPedido.AbrirPedidoPorNumero;
var
  NumeroStr: string;
  Numero: Integer;
begin
  NumeroStr := InputBox('Abrir Pedido', 'Informe o número do pedido:', '');
  if NumeroStr = '' then
    Exit;
  Numero := StrToIntDef(NumeroStr, 0);
  if Numero <= 0 then
  begin
    ShowMessage('Número inválido');
    Exit;
  end;
  CarregarPedido(Numero);
  CarregarProdutos;
end;

procedure TfrmPedido.AtualizarProduto;
var
  Item: TPedidoItem;
begin
  Item := TPedidoItem.Create;
  try
    Item.ID := qryItens.FieldByName('ID').AsInteger;
    Item.NumeroPedido := StrToInt(edtNumPedido.Text);
    Item.CodigoProduto := StrToInt(edtCodProduto.Text);
    Item.Quantidade := StrToFloat(edtQtd.Text);
    Item.VlrUnitario := StrToCurr(edtPreco.Text);
    FItemController.Atualizar(Item);
  finally
    Item.Free;
  end;
end;

procedure TfrmPedido.btnFinalizarClick(Sender: TObject);
begin
  ShowMessage('Pedido Finalizaro!');
  Close;
end;

procedure TfrmPedido.btnIniciarPedidoClick(Sender: TObject);
var
  Pedido: TPedido;
  FValidaValores: Integer;
begin
  if (trim(edtCodigoCliente.Text) = '') or
    (trim(edtCodigoCliente.Text) = '0') then
  begin
    ShowMessage('Cliente deve ser informado!');
    Exit;
  end else
  begin
    try
      FValidaValores := StrToInt(edtCodigoCliente.Text);
    Except
      ShowMessage('Cliente Inválido!');
      Exit;
    end;
  end;

  Pedido := TPedido.Create;
  try
    Pedido.CodigoCliente := StrToInt(edtCodigoCliente.Text);
    Pedido.ValorTotal := 0;
    Pedido.Observacao := memoObs.Text;
    FPedidoController.Inserir(Pedido);
    edtNumPedido.Text := Pedido.NumeroPedido.ToString;
    ShowMessage('Pedido criado com sucesso');
  finally
    Pedido.Free;
  end;

  btnIniciarPedido.Enabled := False;
  btnVisualizarPedido.Enabled := False;
  btnInserirProduto.Enabled := True;
  btnFinalizar.Enabled := True;
end;

procedure TfrmPedido.btnInserirProdutoClick(Sender: TObject);
begin
  ValidacoesProduto;

  if FAtualizarProduto then
    AtualizarProduto
  else
    InserirProduto;

  CarregarProdutos;

  edtCodProduto.Text := EmptyStr;
  edtDescricao.Text := EmptyStr;
  edtPreco.Text := EmptyStr;
  edtQtd.Text := EmptyStr;

  edtCodProduto.SetFocus;
end;

procedure TfrmPedido.btnLimparClick(Sender: TObject);
begin
  btnLimpar.Enabled := False;
  btnVisualizarPedido.Enabled := True;
  btnInserirProduto.Enabled := False;

  qryItens.Close;

  edtCodProduto.Text := EmptyStr;
  edtDescricao.Text := EmptyStr;
  edtPreco.Text := EmptyStr;
  edtQtd.Text := EmptyStr;

  edtCodigoCliente.Text := EmptyStr;
  edtNome.Text := EmptyStr;
  edtCidade.Text := EmptyStr;
  edtUF.Text := EmptyStr;
  edtNumPedido.Text := EmptyStr;

  edtCodigoCliente.SetFocus;
end;

procedure TfrmPedido.btnVisualizarPedidoClick(Sender: TObject);
begin
  AbrirPedidoPorNumero;
  btnInserirProduto.Enabled := False;
  btnFinalizar.Enabled := False;
  btnLimpar.Enabled := True;
  btnVisualizarPedido.Enabled := False;
end;

procedure TfrmPedido.CarregarItemSelecionado;
begin
  if qryItens.IsEmpty then
    Exit;
  edtCodProduto.Text :=
    qryItens.FieldByName('CODIGO_PRODUTO').AsString;
  edtQtd.Text :=
    qryItens.FieldByName('QUANTIDADE').AsString;
  edtPreco.Text :=
    qryItens.FieldByName('VLR_UNITARIO').AsString;
  edtQtd.SetFocus;
end;

procedure TfrmPedido.CarregarPedido(pnNumPedido: Integer);
var
  Pedido: TPedido;
begin
  Pedido := FPedidoController.Buscar(pnNumPedido);
  try
    edtCodigoCliente.Text := Pedido.CodigoCliente.ToString;
    edtCodigoClienteExit(Self);
    edtNumPedido.Text := Pedido.NumeroPedido.ToString;
    memoObs.Text := Pedido.Observacao;
  finally
    Pedido.Free;
  end;
end;

procedure TfrmPedido.CarregarProdutos;
begin
  if Assigned(qryItens) then
    FreeAndNil(qryItens);
  qryItens := FItemController.GetDataSet(
    StrToIntDef(edtNumPedido.Text, 0)
  );
  dsItens.DataSet := qryItens;

  edtTotalPedido.Text := 'R$ ' + FormatFloat('#,##0.00', TotalPedido);

  FAtualizarProduto := False;
end;

procedure TfrmPedido.dbgProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    CarregarItemSelecionado;
    FAtualizarProduto := True;
    Key := 0;
  end;

  if Key = VK_DELETE then
  begin
    if qryItens.IsEmpty then
      Exit;
    if MessageDlg('Deseja realmente excluir este produto?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ExlcuirProduto(qryItens.FieldByName('ID').AsInteger);
      CarregarProdutos;
    end;
    Key := 0;
  end;
end;

procedure TfrmPedido.edtCodigoClienteExit(Sender: TObject);
var
  Cliente: TCliente;
begin
  edtNome.Text := EmptyStr;
  edtCidade.Text := EmptyStr;
  edtUF.Text := EmptyStr;

  if edtCodigoCliente.Text = EmptyStr then
    Exit;

  Cliente := FClienteController.Buscar(StrToInt(edtCodigoCliente.Text));

  try
    edtNome.Text := Cliente.Nome;
    edtCidade.Text := Cliente.Cidade;
    edtUF.Text := Cliente.UF;
  finally
    Cliente.Free;
  end;

  btnIniciarPedido.Enabled := True;
  btnVisualizarPedido.Enabled := False;
end;

procedure TfrmPedido.edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
var
  RepositoryCliente: IClienteRepository;
  ServiceCliente: IClienteService;
  RepositoryProduto: IProdutoRepository;
  ServiceProduto: IProdutoService;
  RepositoryPedido: IPedidoRepository;
  ServicePedido: IPedidoService;
  RepositoryItensPedido: IPedidoItemRepository;
  ServiceItensPedido: TPedidoItemService;
begin
  RepositoryCliente := TClienteRepository.Create(dmConexao.ConnDb);
  ServiceCliente := TClienteService.Create(RepositoryCliente);
  FClienteController := TClienteController.Create(ServiceCliente);

  RepositoryProduto := TProdutoRepository.Create(dmConexao.ConnDb);
  ServiceProduto := TProdutoService.Create(RepositoryProduto);
  FProdutoController := TProdutoController.Create(ServiceProduto);

  RepositoryPedido := TPedidoRepository.Create(dmConexao.ConnDb);
  ServicePedido := TPedidoService.Create(RepositoryPedido);
  FPedidoController := TPedidoController.Create(ServicePedido);

  RepositoryItensPedido := TPedidoItemRepository.Create(dmConexao.ConnDb);
  ServiceItensPedido := TPedidoItemService.Create(RepositoryItensPedido);
  FItemController := TPedidoItemController.Create(ServiceItensPedido);
end;

procedure TfrmPedido.InserirProduto;
var
  Item: TPedidoItem;
begin
  Item := TPedidoItem.Create;
  try
    Item.NumeroPedido := StrToInt(edtNumPedido.Text);
    Item.CodigoProduto := StrToInt(edtCodProduto.Text);
    Item.Quantidade := StrToFloat(edtQtd.Text);
    Item.VlrUnitario := StrToCurr(edtPreco.Text);
    FItemController.Inserir(Item);
  finally
    Item.Free;
  end;
end;

function TfrmPedido.TotalPedido: Currency;
var
  nTotalPedido: Currency;
begin
  nTotalPedido := 0;

  qryItens.DisableControls;

  try
    qryItens.First;

    while not qryItens.Eof do
    begin
      nTotalPedido := nTotalPedido + qryItens.FieldByName('VLR_TOTAL').AsFloat;

      qryItens.Next;
    end;
  finally
    qryItens.EnableControls;
  end;

  Result := nTotalPedido;
end;

procedure TfrmPedido.ValidacoesProduto;
var
  FValidaValores: Currency;
begin
  if (trim(edtCodProduto.Text) = '') or
    (trim(edtCodProduto.Text) = '0') then
  begin
    ShowMessage('Produto deve ser informado!');
    Abort;
  end;

  if (trim(edtPreco.Text) = '') or
    (trim(edtPreco.Text) = '0') then
  begin
    ShowMessage('Valor do produto deve ser informado!');
    Abort;
  end else
  begin
    try
      FValidaValores := StrToFloat(edtPreco.Text);
    Except
      ShowMessage('Valor do Produto Inválido!');
      Abort;
    end;

    if FValidaValores < 0 then
    begin
      ShowMessage('Valor do produto deve ser maior que zero(0)!');
      Abort;
    end;
  end;

  if (trim(edtQtd.Text) = '') or
    (trim(edtQtd.Text) = '0') then
  begin
    ShowMessage('Quantidade do produto deve ser informada!');
    Abort;
  end else
  begin
    try
      FValidaValores := StrToFloat(edtQtd.Text);
    Except
      ShowMessage('Quantidade Inválido!');
      Abort;
    end;

    if FValidaValores < 0 then
    begin
      ShowMessage('Quantidade do produto deve ser maior que zero(0)!');
      Abort;
    end;
  end;
end;

end.
