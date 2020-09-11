object DBPlaceModule: TDBPlaceModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 260
  Width = 403
  object FDConnectionDef: TFDConnection
    Params.Strings = (
      'DriverID=SQLite'
      'Database=content\database\arlan.sqlite3')
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object FDTransactionDef: TFDTransaction
    Connection = FDConnectionDef
    Left = 40
    Top = 80
  end
  object FDQueryDef: TFDQuery
    Connection = FDConnectionDef
    Left = 40
    Top = 144
  end
  object FDMemTableDef: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 152
    Top = 16
  end
end
