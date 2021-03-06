object FrmMovimentacoes: TFrmMovimentacoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Movimenta'#231#245'es'
  ClientHeight = 340
  ClientWidth = 720
  Color = 15591134
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object P_CONTAINER: TPanel
    Left = 0
    Top = 0
    Width = 720
    Height = 340
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object P_TOPO: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 714
      Height = 88
      Align = alTop
      BevelOuter = bvNone
      Color = clCream
      ParentBackground = False
      TabOrder = 0
      object Label1: TLabel
        Left = 280
        Top = 19
        Width = 57
        Height = 13
        Caption = 'Data Inicial'
      end
      object Label2: TLabel
        Left = 450
        Top = 19
        Width = 52
        Height = 13
        Caption = 'Data Final'
      end
      object Label3: TLabel
        Left = 48
        Top = 19
        Width = 78
        Height = 13
        Caption = 'Entrada / Sa'#237'da'
      end
      object cbEntradaSaida: TComboBox
        Left = 48
        Top = 46
        Width = 105
        Height = 21
        TabOrder = 0
        OnChange = cbEntradaSaidaChange
        Items.Strings = (
          'Tudo'
          'Entrada'
          'Sa'#237'da')
      end
      object dataFinal: TDateTimePicker
        Left = 545
        Top = 19
        Width = 95
        Height = 21
        Date = 43535.000000000000000000
        Time = 0.808893749999697300
        TabOrder = 1
        OnChange = dataFinalChange
      end
      object dataInicial: TDateTimePicker
        Left = 280
        Top = 46
        Width = 95
        Height = 21
        Date = 43535.000000000000000000
        Time = 0.808893749999697300
        TabOrder = 2
        OnChange = dataInicialChange
      end
    end
    object P_GRID: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 97
      Width = 714
      Height = 192
      Align = alTop
      BevelOuter = bvNone
      Color = clCream
      ParentBackground = False
      TabOrder = 1
      object gridVendas: TDBGrid
        Left = 0
        Top = 0
        Width = 714
        Height = 192
        Align = alClient
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
    object P_RODAPE: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 295
      Width = 714
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = clCream
      ParentBackground = False
      TabOrder = 2
      object Label8: TLabel
        Left = 139
        Top = 12
        Width = 36
        Height = 13
        Caption = 'Sa'#237'das:'
      end
      object lblVlrSaidas: TLabel
        Left = 180
        Top = 12
        Width = 6
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblVlrEntradas: TLabel
        Left = 66
        Top = 12
        Width = 6
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblTotal: TLabel
        Left = 562
        Top = 12
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label7: TLabel
        Left = 16
        Top = 12
        Width = 48
        Height = 13
        Caption = 'Entradas:'
      end
      object Label4: TLabel
        Left = 528
        Top = 12
        Width = 28
        Height = 13
        Caption = 'Total:'
      end
      object SB_CANCELAR: TSpeedButton
        Left = 631
        Top = 0
        Width = 87
        Height = 38
        Cursor = crHandPoint
        Caption = 'Sair'
        Flat = True
        OnClick = SB_CANCELARClick
      end
    end
  end
end
