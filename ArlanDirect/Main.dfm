object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 577
  ClientWidth = 979
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI Semibold'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 304
    Top = 144
    object ArlanD1: TMenuItem
      Caption = 'ArlanD'
      object MMConnect: TMenuItem
        Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
        OnClick = MMConnectClick
      end
      object MMSetting: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MMExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = MMExitClick
      end
    end
    object MMDirS1: TMenuItem
      Caption = #1050#1072#1090#1072#1083#1086#1075
      OnClick = MMDirS1Click
    end
  end
  object ActionList1: TActionList
    Left = 416
    Top = 144
    object Action1: TAction
      Caption = 'Action1'
      OnExecute = Action1Execute
    end
  end
end
