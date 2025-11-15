object fAgendaAdm: TfAgendaAdm
  Left = 0
  Top = 0
  Width = 863
  Height = 600
  TabOrder = 0
  object Pg_Principal: TPageControl
    Left = 0
    Top = 33
    Width = 863
    Height = 567
    ActivePage = Tb_Cadastro
    Align = alClient
    TabOrder = 0
    OnChange = Pg_PrincipalChange
    ExplicitWidth = 684
    ExplicitHeight = 408
    object Tb_Consulta: TTabSheet
      Caption = 'Consulta'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 855
        Height = 73
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 676
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
        Width = 855
        Height = 464
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
            Title.Caption = 'Cliente'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            Title.Caption = 'Servi'#231'o'
            Width = 200
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            Title.Alignment = taCenter
            Title.Caption = 'Data'
            Width = 100
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            Title.Alignment = taCenter
            Title.Caption = 'Hor'#225'rio'
            Width = 150
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
        Width = 855
        Height = 537
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 637
        object Label2: TLabel
          Left = 24
          Top = 224
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Observa'#231#227'o'
        end
        object Label5: TLabel
          Left = 24
          Top = 67
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Servi'#231'o'
        end
        object Label6: TLabel
          Left = 24
          Top = 107
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Data'
        end
        object Label4: TLabel
          Left = 24
          Top = 187
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Hora Fim'
        end
        object Label3: TLabel
          Left = 24
          Top = 261
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Valor'
        end
        object Label7: TLabel
          Left = 24
          Top = 147
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Hora In'#237'cio'
        end
        object Label1: TLabel
          Left = 24
          Top = 27
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Cliente'
        end
        object DBEd_OBS: TDBEdit
          Left = 146
          Top = 221
          Width = 271
          Height = 23
          TabOrder = 0
        end
        object DBLkp_Servico: TDBLookupComboBox
          Left = 146
          Top = 64
          Width = 271
          Height = 23
          TabOrder = 1
        end
        object DBEd_Data: TDBEdit
          Left = 146
          Top = 104
          Width = 271
          Height = 23
          TabOrder = 2
        end
        object DBEd_HoraFim: TDBEdit
          Left = 146
          Top = 184
          Width = 271
          Height = 23
          TabOrder = 3
        end
        object DBEd_Valor: TDBEdit
          Left = 146
          Top = 258
          Width = 271
          Height = 23
          TabOrder = 4
        end
        object DBEd_HoraIni: TDBEdit
          Left = 146
          Top = 144
          Width = 271
          Height = 23
          TabOrder = 5
        end
        object DBLkp_Cliente: TDBLookupComboBox
          Left = 146
          Top = 24
          Width = 271
          Height = 23
          TabOrder = 6
        end
      end
    end
  end
  object Pnl_Botoes: TPanel
    Left = 0
    Top = 0
    Width = 863
    Height = 33
    Align = alTop
    TabOrder = 1
    ExplicitTop = -6
    object Btn_Gravar: TButton
      AlignWithMargins = True
      Left = 673
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Gravar'
      TabOrder = 2
      OnClick = Btn_GravarClick
      ExplicitLeft = 494
    end
    object Btn_Novo: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 90
      Height = 25
      Align = alLeft
      Caption = 'Novo'
      TabOrder = 0
      OnClick = Btn_NovoClick
      ExplicitTop = 2
    end
    object Btn_Editar: TButton
      AlignWithMargins = True
      Left = 100
      Top = 4
      Width = 90
      Height = 25
      Align = alLeft
      Caption = 'Editar'
      TabOrder = 1
      OnClick = Btn_EditarClick
    end
    object Btn_Cancelar: TButton
      AlignWithMargins = True
      Left = 769
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = Btn_CancelarClick
      ExplicitLeft = 590
    end
  end
end
