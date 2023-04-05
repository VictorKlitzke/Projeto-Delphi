object PlantaoViewsEditarPlantao: TPlantaoViewsEditarPlantao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'PlantaoViewsEditarPlantao'
  ClientHeight = 241
  ClientWidth = 378
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnContent: TPanel
    Left = 0
    Top = 0
    Width = 378
    Height = 241
    Align = alClient
    BevelOuter = bvNone
    Color = clGray
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 41
      Width = 34
      Height = 17
      Caption = 'DATA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 56
      Top = 94
      Width = 39
      Height = 17
      Caption = 'NOME'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnEditar: TcxButton
      Left = 56
      Top = 168
      Width = 257
      Height = 25
      Caption = 'Editar'
      Colors.Default = clBlack
      Colors.DefaultText = clBlack
      Colors.Normal = clBlue
      Colors.Pressed = clBlack
      PaintStyle = bpsCaption
      SpeedButtonOptions.CanBeFocused = False
      TabOrder = 0
      OnClick = btnEditarClick
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 378
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lbForm: TLabel
        Left = 0
        Top = 0
        Width = 321
        Height = 33
        Align = alClient
        Alignment = taCenter
        Caption = 'Editar Plant'#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 138
        ExplicitHeight = 30
      end
      object btnClose: TcxButton
        Left = 321
        Top = 0
        Width = 57
        Height = 33
        Align = alRight
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
          F40000000473424954080808087C0864880000000970485973000000EC000000
          EC01792871BD0000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000001C0494441545885ED963D4B2B4114869F0937
          B3B92277300B72B594A4F0FF68A9D62641B0D15B295C7F4120C642BB2DF5AF5C
          4B5324D8292826B228213B098C45CC65935DE30647F1EBAD9699B3E77DE6E30C
          07BEF5D5254607CCF2B2C4983D600598B3E473097808B1238E8F7578E24724D4
          98BFC09625E381E6816D8C01F8139E48C504AF5A360F6B6D74200EC0D6B6C7E9
          77128037D50702383A3AC5F36A28D57C3246A9269E57E3F0F09F7D00C7F94926
          B348B5DA8A8550AA49B5DA22935944CA29FB00A5D22C5AD79132CFC1814F367B
          1D3197324FB77BCEE6A66B1FC0F75D0A852C5AD749A717A854EE71DDAB8879A9
          344DAB359B346DF4255C5A3263FF50AAC9FEFE2D8E9323081A00FFBF8BC5197C
          7FECEAC5C9C990E7E455E0FB2EC5E20C5AD7719C1C8E93A3DB3D6763E3D773E6
          71B25786428CDF396B00832390324F1034088206E9F402E5F2DDD812B50230B8
          70E16D0F1FC76875580578EAB6C755C70410C9012A956BA4CCA3759DF5753554
          6AA310E5F28D7D804EA74DBB5DA350C8C6DEF60144A77346AFD74B9A76F277E0
          857AF93B6059EF12E0F215FD2E920078AF666F4C2477B42B1662E7B17B5DA1DF
          CDDA50BF2D4FA5762DE5FBD627D20377FAB9B6D8D488810000000049454E44AE
          426082}
        SpeedButtonOptions.CanBeFocused = False
        SpeedButtonOptions.Flat = True
        TabOrder = 0
        OnClick = btnCloseClick
      end
    end
    object edNome: TcxDBTextEdit
      Left = 56
      Top = 128
      DataBinding.DataField = 'NOME'
      DataBinding.DataSource = dsEditar
      TabOrder = 2
      Width = 257
    end
    object edData: TcxDBDateEdit
      Left = 56
      Top = 67
      DataBinding.DataField = 'DATA'
      DataBinding.DataSource = dsEditar
      TabOrder = 3
      Width = 257
    end
  end
  object dsEditar: TDataSource
    Left = 200
    Top = 200
  end
end
