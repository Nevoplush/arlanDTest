object Form_CustomDialog: TForm_CustomDialog
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form_CustomDialog'
  ClientHeight = 192
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    400
    192)
  PixelsPerInch = 96
  TextHeight = 13
  object SB_Cancel: TSpeedButton
    Left = 312
    Top = 152
    Width = 80
    Height = 32
    Anchors = [akRight, akBottom]
    OnClick = SB_CancelClick
  end
end
