object FrmExcluirDados: TFrmExcluirDados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsNone
  Caption = 'Excluir Dados'
  ClientHeight = 106
  ClientWidth = 436
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object P_CONTAINER: TPanel
    Left = 0
    Top = 0
    Width = 436
    Height = 106
    Align = alClient
    BevelOuter = bvNone
    Color = 15591134
    ParentBackground = False
    TabOrder = 0
    object P_RODAPE: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 67
      Width = 430
      Height = 31
      Align = alTop
      BevelOuter = bvNone
      Color = clCream
      ParentBackground = False
      TabOrder = 0
      object SB_CANCELAR: TSpeedButton
        Left = 327
        Top = -6
        Width = 87
        Height = 38
        Cursor = crHandPoint
        Caption = 'Sair'
        Flat = True
        OnClick = SB_CANCELARClick
      end
    end
    object P_TOPO: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 430
      Height = 58
      Align = alTop
      Color = clCream
      ParentBackground = False
      TabOrder = 1
      object BtnExcluir: TSpeedButton
        Left = 332
        Top = 15
        Width = 73
        Height = 42
        Cursor = crHandPoint
        Caption = 'Excluir'
        Flat = True
        Glyph.Data = {
          FA090000424DFA09000000000000360000002800000019000000190000000100
          200000000000C4090000120B0000120B00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5B9
          B40067716A0030453900263E300028403200273F31002E4236005B655F00A7AA
          A700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BFC6C1003A47
          3E00000100000000000000080000000B0000000B0000000B0000000900000000
          00000000000026372A009FA5A100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008B9694000003
          000000000000001D0D0006221200052111000521110005211100052111000521
          11000522120001200F000005000000000000646D6A00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00738279000000
          0000001505000624130005211100052111000521110005211100052111000521
          110005211100052111000521110006231300001C0C000000000043544A00FCFC
          FC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008E9D95000000
          0000001707000623130005211100052111000521110005211100052111000521
          110005211100052111000521110005211100052111000622120002200E000000
          00005D706500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DBDEDD00000C
          0200001003000623130005211100052111000521110005211100052111000521
          1100052111000521110005211100052111000521110005211100052111000622
          1200011B0B0000000000B0B7B300FFFFFF00FFFFFF00FFFFFF00FFFFFF004D62
          5700000000000524130005211100052111000521110005211100052111000521
          1100052111000521110005211100052111000521110005211100052111000521
          11000521110006231300000300001E382800FFFFFF00FFFFFF00FFFFFF00E5E7
          E600001608000015040005211100052111000521110005211100052111000521
          1100052111000521110005211100052111000521110005211100052111000521
          1100052111000521110005211100021F0C0000000000B1B8B400FFFFFF00FFFF
          FF007F8B85000000000003221100052111000521110005211100052111000521
          1100052111000521110005211100052111000521110005211100052111000521
          11000521110005211100052111000521110005221200000000005B6B6300FFFF
          FF00FFFFFF003E51470000030000062212000521110005221300021E0E000013
          0200001302000014030000140300001403000014030000140300001403000014
          03000014030000120100001C0B00052313000521110005211100000700003348
          3C00FFFFFF00FFFFFF00354A3E00000700000521110005211100041D0D00102A
          1B002C4537002741330027413300274133002741330027413300274133002741
          3300274133002540310030483B0018322300041B0D000521110005211100000B
          0000263E3000FFFFFF00FFFFFF00344A3D000007000005211100052111000012
          0400243B2E00BABBB800C7C5C300C0BFBD00C0BFBD00C0BFBD00C0BFBD00C0BF
          BD00C0BFBD00C0BFBD00C5C3C100C1C1BE0041564A00000C0400052111000521
          1100000C0000273F3100FFFFFF00FFFFFF00354A3E0000070000052111000521
          110004211200021F0E0013291B001E3124001B2F22001B2F22001B2F22001B2F
          22001B2F22001B2F22001B2F22001E32250012281A00021E0E00042111000521
          110005211100000B000029403200FFFFFF00FFFFFF0044564C00000100000622
          1200052111000521110005211100001A09000017060000180700001807000018
          0700001807000018070000180700001807000017060000190800042010000522
          12000521110005211100000500003A4E4300FFFFFF00FFFFFF00909B95000000
          000003210F000521110005211100052111000521110005211100052111000521
          1100052111000521110005211100052111000521110005211100052111000521
          11000521110005211100052212000000000064746C00FFFFFF00FFFFFF00EEEE
          EE00031D0D000011030005211200052111000521110005211100052111000521
          1100052111000521110005211100052111000521110005211100052111000521
          1100052111000521110005211100001B0A0000060000C3C8C500FFFFFF00FFFF
          FF00FFFFFF0067786E0000000000052412000521110005211100052111000521
          1100052111000521110005211100052111000521110005211100052111000521
          11000521110005211100052111000624130000000000344D3F00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00EBEDEC00092013000008000006241300052111000521
          1100052111000521110005211100052111000521110005211100052111000521
          1100052111000521110005211100062313000014050000030000CCD1CE00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ABB5AF0000000000001001000624
          1300052111000521110005211100052111000521110005211100052111000521
          110005211100052111000521110006231300001809000000000083948A00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0095A29A000000
          0000000900000524130005221200052111000521110005211100052111000521
          110005211100052111000521110005241300001202000000000074827900FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00A5AEA900111E140000000000001201000422110005221200052111000521
          11000521110005221200052212000018070000000000000B000088928D00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00E8ECEA006C746C000A1B100000000000000300000007
          000000070000000700000004000000000000000F0200535C5600D0D5D200FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E4E5E400858D8800414F
          4500374C4000344A3D00374C40003B4C40007B857F00CFD2D000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        OnClick = BtnExcluirClick
      end
      object Label1: TLabel
        Left = 24
        Top = 7
        Width = 53
        Height = 13
        Caption = 'Data Inicial'
      end
      object Label2: TLabel
        Left = 184
        Top = 7
        Width = 48
        Height = 13
        Caption = 'Data Final'
      end
      object dataFinal: TDateTimePicker
        Left = 184
        Top = 23
        Width = 95
        Height = 21
        Date = 43535.000000000000000000
        Time = 0.808893749999697300
        TabOrder = 0
      end
      object dataInicial: TDateTimePicker
        Left = 24
        Top = 23
        Width = 95
        Height = 21
        Date = 43535.000000000000000000
        Time = 0.808893749999697300
        TabOrder = 1
      end
    end
  end
end
