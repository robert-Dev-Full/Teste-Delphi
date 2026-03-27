unit uDmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client, System.IniFiles;

type
  TdmConexao = class(TDataModule)
    ConnDb: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
  private
    { Private declarations }
    procedure CarregarConfiguracao;
  public
    { Public declarations }
    procedure Conectar;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TdmConexao.CarregarConfiguracao;
var
  Ini: TIniFile;
  CaminhoIni: string;
begin
  CaminhoIni := ExtractFilePath(ParamStr(0)) + 'config.ini';
  if not FileExists(CaminhoIni) then
    raise Exception.Create('Arquivo config.ini não encontrado');
  Ini := TIniFile.Create(CaminhoIni);
  try
    ConnDb.Params.Clear;
    ConnDb.Params.Add('DriverID=' + Ini.ReadString('DATABASE', 'DriverID', 'FB'));
    ConnDb.Params.Add('Database=' + Ini.ReadString('DATABASE', 'Database', ''));
    ConnDb.Params.Add('User_Name=' + Ini.ReadString('DATABASE', 'User_Name', 'SYSDBA'));
    ConnDb.Params.Add('Password=' + Ini.ReadString('DATABASE', 'Password', 'masterkey'));
    ConnDb.Params.Add('Server=' + Ini.ReadString('DATABASE', 'Server', 'localhost'));
    ConnDb.Params.Add('Port=' + Ini.ReadString('DATABASE', 'Port', '3050'));
    ConnDb.Params.Add('CharacterSet=UTF8');
    ConnDb.LoginPrompt := False;

    FDPhysFBDriverLink1.VendorLib := Ini.ReadString('DATABASE', 'ClientLibrary', 'X');
  finally
    Ini.Free;
  end;
end;

procedure TdmConexao.Conectar;
begin
  if ConnDb.Connected then
    Exit;
  CarregarConfiguracao;
  try
    ConnDb.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar no banco: ' + E.Message);
  end;
end;

end.
