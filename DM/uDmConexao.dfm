object dmConexao: TdmConexao
  OldCreateOrder = False
  Height = 364
  Width = 506
  object ConnDb: TFDConnection
    Params.Strings = (
      'Database=F:\Desenvolvimento\Fontes\TesteBitway\DB\TESTE.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 88
    Top = 56
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 152
    Top = 56
  end
end
