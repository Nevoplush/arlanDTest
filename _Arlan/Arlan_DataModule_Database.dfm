object DataModule_Database: TDataModule_Database
  OldCreateOrder = False
  Height = 208
  Width = 283
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=content\database\arlan.sqlite3'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 24
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 136
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 216
    Top = 24
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 216
    Top = 72
  end
  object FDQuery3: TFDQuery
    Connection = FDConnection1
    Left = 216
    Top = 128
  end
  object FDQuery4: TFDQuery
    Connection = FDConnection1
    Left = 160
    Top = 128
  end
end
