object FRM_MENU: TFRM_MENU
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  ClientHeight = 542
  ClientWidth = 789
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Menu
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Menu: TMainMenu
    Left = 24
    Top = 48
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Funcionrio1: TMenuItem
        Caption = 'Funcion'#225'rio'
        OnClick = Funcionrio1Click
      end
      object Usurio1: TMenuItem
        Caption = 'Usu'#225'rio'
        OnClick = Usurio1Click
      end
      object Cargos1: TMenuItem
        Caption = 'Cargos'
        OnClick = Cargos1Click
      end
    end
    object Estoque1: TMenuItem
      Caption = 'Estoque'
    end
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
    end
    object Relatrio1: TMenuItem
      Caption = 'Relat'#243'rio'
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
end
