object frmCadClientes: TfrmCadClientes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro de Clientes'
  ClientHeight = 441
  ClientWidth = 684
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Pg_Principal: TPageControl
    Left = 0
    Top = 33
    Width = 684
    Height = 408
    ActivePage = Tb_Consulta
    Align = alClient
    TabOrder = 0
    OnChange = Pg_PrincipalChange
    object Tb_Consulta: TTabSheet
      Caption = 'Consulta'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 73
        Align = alTop
        TabOrder = 0
        object btn_Pesquisar: TButton
          Left = 544
          Top = 25
          Width = 89
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 0
          OnClick = btn_PesquisarClick
        end
      end
      object DBGrd_Consulta: TDBGrid
        Left = 0
        Top = 73
        Width = 676
        Height = 305
        Align = alClient
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = DBGrd_ConsultaDblClick
        Columns = <
          item
            Expanded = False
            Title.Caption = 'Nome'
            Width = 400
            Visible = True
          end>
      end
    end
    object Tb_Cadastro: TTabSheet
      Caption = 'Cadastro'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 378
        Align = alClient
        TabOrder = 0
        object Label1: TLabel
          Left = 24
          Top = 27
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Nome'
        end
        object Label2: TLabel
          Left = 24
          Top = 56
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Usu'#225'rio'
        end
        object Label3: TLabel
          Left = 24
          Top = 85
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Senha'
        end
        object DBEd_Nome: TDBEdit
          Left = 146
          Top = 24
          Width = 271
          Height = 23
          TabOrder = 0
        end
        object DBEd_Usuario: TDBEdit
          Left = 146
          Top = 53
          Width = 271
          Height = 23
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object DBEd_Senha: TDBEdit
          Left = 146
          Top = 82
          Width = 271
          Height = 23
          PasswordChar = '*'
          TabOrder = 2
        end
        object DBChk_Tipo: TDBCheckBox
          Left = 146
          Top = 119
          Width = 97
          Height = 17
          Caption = 'Administrador'
          TabOrder = 3
        end
      end
    end
  end
  object Pnl_Botoes: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 33
    Align = alTop
    TabOrder = 1
    object Btn_Gravar: TButton
      AlignWithMargins = True
      Left = 494
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = Btn_GravarClick
    end
    object Btn_Novo: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 90
      Height = 25
      Align = alLeft
      Caption = 'Novo'
      TabOrder = 1
      OnClick = Btn_NovoClick
    end
    object Btn_Editar: TButton
      AlignWithMargins = True
      Left = 100
      Top = 4
      Width = 90
      Height = 25
      Align = alLeft
      Caption = 'Editar'
      TabOrder = 2
      OnClick = Btn_EditarClick
    end
    object Btn_Cancelar: TButton
      AlignWithMargins = True
      Left = 590
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = Btn_CancelarClick
    end
  end
end
