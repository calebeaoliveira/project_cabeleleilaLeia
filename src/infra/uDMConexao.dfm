object DMConexao: TDMConexao
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Database=db_agendamento'
      'User_Name=root'
      'Password='
      'Server=127.0.0.1'
      'Port=3306')
    Left = 280
    Top = 88
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 280
    Top = 152
  end
end
