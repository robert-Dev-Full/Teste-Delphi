object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pedido de Venda'
  ClientHeight = 606
  ClientWidth = 1052
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCliente: TPanel
    Left = 0
    Top = 0
    Width = 1052
    Height = 60
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 996
    object Label1: TLabel
      Left = 16
      Top = 23
      Width = 46
      Height = 14
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 335
      Top = 23
      Width = 45
      Height = 14
      Caption = 'Cidade:'
    end
    object Label3: TLabel
      Left = 591
      Top = 23
      Width = 18
      Height = 14
      Caption = 'UF:'
    end
    object Label6: TLabel
      Left = 671
      Top = 23
      Width = 46
      Height = 14
      Caption = 'Pedido:'
    end
    object edtCodigoCliente: TEdit
      Left = 68
      Top = 20
      Width = 45
      Height = 22
      TabOrder = 0
      OnExit = edtCodigoClienteExit
      OnKeyPress = edtCodigoClienteKeyPress
    end
    object edtNome: TEdit
      Left = 119
      Top = 20
      Width = 210
      Height = 22
      TabStop = False
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtCidade: TEdit
      Left = 386
      Top = 20
      Width = 199
      Height = 22
      TabStop = False
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtUF: TEdit
      Left = 615
      Top = 20
      Width = 50
      Height = 22
      TabStop = False
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object btnIniciarPedido: TBitBtn
      Left = 779
      Top = 14
      Width = 70
      Height = 35
      Caption = 'Confirmar'
      Enabled = False
      TabOrder = 4
      OnClick = btnIniciarPedidoClick
    end
    object edtNumPedido: TEdit
      Left = 723
      Top = 20
      Width = 50
      Height = 22
      TabStop = False
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object btnVisualizarPedido: TBitBtn
      Left = 852
      Top = 14
      Width = 87
      Height = 35
      Caption = 'Abrir Pedido'
      TabOrder = 6
      OnClick = btnVisualizarPedidoClick
    end
    object btnLimpar: TBitBtn
      Left = 945
      Top = 14
      Width = 87
      Height = 35
      Caption = 'Limpar'
      Enabled = False
      TabOrder = 7
      OnClick = btnLimparClick
    end
  end
  object pnlProduto: TPanel
    Left = 0
    Top = 60
    Width = 1052
    Height = 41
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 66
    object Label4: TLabel
      Left = 7
      Top = 12
      Width = 55
      Height = 14
      Caption = 'Produto:'
    end
    object Label5: TLabel
      Left = 335
      Top = 13
      Width = 35
      Height = 14
      Caption = 'Valor:'
    end
    object Label7: TLabel
      Left = 448
      Top = 13
      Width = 75
      Height = 14
      Caption = 'Quantidade:'
    end
    object edtCodProduto: TEdit
      Left = 68
      Top = 10
      Width = 45
      Height = 22
      TabOrder = 0
      OnExit = edtCodProdutoExit
      OnKeyPress = edtCodProdutoKeyPress
    end
    object edtDescricao: TEdit
      Left = 119
      Top = 10
      Width = 210
      Height = 22
      TabStop = False
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtPreco: TEdit
      Left = 376
      Top = 10
      Width = 68
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edtPrecoKeyPress
    end
    object btnInserirProduto: TBitBtn
      Left = 591
      Top = 3
      Width = 113
      Height = 35
      Caption = 'Confirmar'
      Enabled = False
      TabOrder = 3
      OnClick = btnInserirProdutoClick
    end
    object edtQtd: TEdit
      Left = 529
      Top = 10
      Width = 45
      Height = 22
      TabOrder = 4
      OnExit = edtCodigoClienteExit
      OnKeyDown = edtQtdKeyDown
      OnKeyPress = edtQtdKeyPress
    end
  end
  object pnlTotal: TPanel
    Left = 0
    Top = 565
    Width = 1052
    Height = 41
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 996
    object Label8: TLabel
      Left = 823
      Top = 9
      Width = 35
      Height = 14
      Caption = 'Total:'
    end
    object edtTotalPedido: TEdit
      Left = 864
      Top = 5
      Width = 121
      Height = 22
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnFinalizar: TBitBtn
      Left = 364
      Top = 2
      Width = 197
      Height = 35
      Caption = 'Finalizar Pedido'
      Enabled = False
      TabOrder = 1
      OnClick = btnFinalizarClick
    end
  end
  object pnlItens: TPanel
    Left = 0
    Top = 101
    Width = 1052
    Height = 464
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 996
    object dbgProdutos: TDBGrid
      Left = 1
      Top = 1
      Width = 1050
      Height = 462
      Align = alClient
      DataSource = dsItens
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = dbgProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'NUMERO_PEDIDO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CODIGO_PRODUTO'
          Title.Caption = 'C'#243'd. Prod.'
          Width = 57
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'Quantidade'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLR_UNITARIO'
          Title.Caption = 'Vlr. Un.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLR_TOTAL'
          Title.Caption = 'Vlr. Total'
          Visible = True
        end>
    end
  end
  object qryItens: TFDQuery
    Connection = dmConexao.ConnDb
    SQL.Strings = (
      'SELECT ped.*, prd.DESCRICAO '
      'FROM TBPEDIDO_ITEM ped'
      '  INNER JOIN tbproduto prd'
      'ON ped.CODIGO_PRODUTO = prd.CODIGO'
      'WHERE ped.NUMERO_PEDIDO = 1'
      'ORDER by prd.DESCRICAO ')
    Left = 496
    Top = 213
    object qryItensID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryItensNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
      Origin = 'NUMERO_PEDIDO'
      Required = True
    end
    object qryItensCODIGO_PRODUTO: TIntegerField
      FieldName = 'CODIGO_PRODUTO'
      Origin = 'CODIGO_PRODUTO'
      Required = True
    end
    object qryItensQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Origin = 'QUANTIDADE'
      Precision = 18
      Size = 3
    end
    object qryItensVLR_UNITARIO: TFMTBCDField
      FieldName = 'VLR_UNITARIO'
      Origin = 'VLR_UNITARIO'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryItensVLR_TOTAL: TFMTBCDField
      FieldName = 'VLR_TOTAL'
      Origin = 'VLR_TOTAL'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryItensDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'DESCRICAO'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
  object dsItens: TDataSource
    DataSet = qryItens
    Left = 536
    Top = 213
  end
end
