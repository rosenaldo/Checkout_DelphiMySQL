object FrmCancelarItem: TFrmCancelarItem
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Cancelar Item'
  ClientHeight = 77
  ClientWidth = 292
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object P_CONTAINER: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 77
    Align = alClient
    BevelOuter = bvNone
    Color = 15591134
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 30
      Width = 87
      Height = 16
      Caption = 'C'#243'digo do Item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtIdItem: TEdit
      Left = 128
      Top = 24
      Width = 121
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
end
