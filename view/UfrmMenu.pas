unit UfrmMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Menus;

type
  TfrmMenu = class(TForm)
    pnlMenu: TPanel;
    btnNovoPedido: TSpeedButton;
    imgLogo: TImage;
    procedure btnNovoPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

{$R *.dfm}

uses UfrmPedido;

procedure TfrmMenu.btnNovoPedidoClick(Sender: TObject);
var
  Frm: TfrmPedido;
begin
  Frm := TfrmPedido.Create(nil);
  try
    Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

end.
