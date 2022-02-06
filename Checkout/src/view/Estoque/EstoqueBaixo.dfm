object FrmEstoqueBaixo: TFrmEstoqueBaixo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Estoque Baixo'
  ClientHeight = 424
  ClientWidth = 857
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object P_CONTAINER: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 424
    Align = alClient
    Color = 15591134
    ParentBackground = False
    TabOrder = 0
    object P_GRID: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 849
      Height = 368
      Align = alClient
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 847
        Height = 366
        Align = alClient
        DataSource = Model.DSProdutos
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
      end
    end
    object P_RODAPE: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 378
      Width = 849
      Height = 42
      Align = alBottom
      Color = clCream
      ParentBackground = False
      TabOrder = 1
      object SB_CANCELAR: TSpeedButton
        Left = 736
        Top = 0
        Width = 89
        Height = 38
        Cursor = crHandPoint
        Caption = 'Sair'
        Flat = True
        OnClick = SB_CANCELARClick
      end
    end
  end
end
