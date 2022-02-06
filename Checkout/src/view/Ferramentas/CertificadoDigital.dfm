object FrmCertificado: TFrmCertificado
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Certificado Digital'
  ClientHeight = 198
  ClientWidth = 604
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 153
    Width = 604
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Color = 15591134
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 226
    ExplicitWidth = 718
    DesignSize = (
      604
      45)
    object BitBtn1: TBitBtn
      Left = 382
      Top = 5
      Width = 88
      Height = 30
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      ExplicitLeft = 496
    end
    object BitBtn2: TBitBtn
      Left = 494
      Top = 5
      Width = 88
      Height = 30
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      ExplicitLeft = 608
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 604
    Height = 153
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    TabOrder = 1
    ExplicitWidth = 718
    ExplicitHeight = 226
  end
end
