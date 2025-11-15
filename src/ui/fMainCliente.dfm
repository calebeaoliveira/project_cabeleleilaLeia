object frmMainCliente: TfrmMainCliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Sistema CabeleleilaLeila'
  ClientHeight = 661
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Pg_Principal: TPageControl
    Left = 0
    Top = 33
    Width = 984
    Height = 628
    ActivePage = Tb_Consulta
    Align = alClient
    TabOrder = 0
    ExplicitTop = 0
    ExplicitHeight = 661
    object Tb_Consulta: TTabSheet
      Caption = 'Tb_Consulta'
      TabVisible = False
      object Pnl_Principal: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 618
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 651
        object Label1: TLabel
          Left = 24
          Top = 32
          Width = 113
          Height = 15
          Caption = 'Meus Agendamentos'
        end
        object Pnl_Agendamentos: TPanel
          Left = 1
          Top = 77
          Width = 974
          Height = 540
          Align = alBottom
          TabOrder = 0
          ExplicitTop = 110
          object DBGrd_Agendamento: TDBGrid
            Left = 1
            Top = 1
            Width = 972
            Height = 538
            Align = alClient
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            Columns = <
              item
                Alignment = taCenter
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = 'Servi'#231'o'
                Width = 150
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = 'Dia'
                Width = 150
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
      end
    end
    object Tb_Cadastro: TTabSheet
      Caption = 'Tb_Cadastro'
      ImageIndex = 1
      TabVisible = False
      object DBGrd_Horarios: TDBGrid
        Left = 0
        Top = 161
        Width = 976
        Height = 326
        Align = alClient
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnCellClick = DBGrd_HorariosCellClick
        OnDrawColumnCell = DBGrd_HorariosDrawColumnCell
        Columns = <
          item
            Expanded = False
            Title.Caption = 'Hor'#225'rio'
            Width = 500
            Visible = True
          end>
      end
      object Pnl_Informacoes: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 161
        Align = alTop
        TabOrder = 0
        object Label5: TLabel
          Left = 40
          Top = 53
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Servi'#231'o'
        end
        object Label6: TLabel
          Left = 40
          Top = 91
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Data'
        end
        object Label2: TLabel
          Left = 16
          Top = 188
          Width = 177
          Height = 15
          AutoSize = False
          Caption = 'Selecione o Hor'#225'rio:'
        end
        object DBEd_Data: TDBEdit
          Left = 130
          Top = 88
          Width = 271
          Height = 23
          TabOrder = 1
        end
        object DBLkp_Servico: TDBLookupComboBox
          Left = 130
          Top = 48
          Width = 271
          Height = 23
          TabOrder = 0
        end
      end
      object Pnl_Confirmacao: TPanel
        Left = 0
        Top = 487
        Width = 976
        Height = 131
        Align = alBottom
        TabOrder = 2
        ExplicitTop = 520
        object Label3: TLabel
          Left = 40
          Top = 27
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Observacao'
        end
        object DBEd_OBS: TDBEdit
          Left = 130
          Top = 24
          Width = 271
          Height = 23
          TabOrder = 0
        end
      end
    end
    object Tb_Editar: TTabSheet
      Caption = 'Tb_Editar'
      ImageIndex = 2
      TabVisible = False
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 618
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 855
        ExplicitHeight = 637
        object Label4: TLabel
          Left = 24
          Top = 224
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Observa'#231#227'o'
        end
        object Label7: TLabel
          Left = 24
          Top = 67
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Servi'#231'o'
        end
        object Label8: TLabel
          Left = 24
          Top = 107
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Data'
        end
        object Label9: TLabel
          Left = 24
          Top = 187
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Hora Fim'
        end
        object Label10: TLabel
          Left = 24
          Top = 261
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Valor'
        end
        object Label11: TLabel
          Left = 24
          Top = 147
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Hora In'#237'cio'
        end
        object Label12: TLabel
          Left = 24
          Top = 27
          Width = 100
          Height = 15
          AutoSize = False
          Caption = 'Cliente'
        end
        object DBEd_OBS2: TDBEdit
          Left = 146
          Top = 221
          Width = 271
          Height = 23
          TabOrder = 0
        end
        object DBLkp_Servico2: TDBLookupComboBox
          Left = 146
          Top = 64
          Width = 271
          Height = 23
          TabOrder = 1
        end
        object DBEd_Data2: TDBEdit
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
    Width = 984
    Height = 33
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 863
    object Btn_Gravar: TButton
      AlignWithMargins = True
      Left = 794
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Gravar'
      TabOrder = 4
      OnClick = Btn_GravarClick
      ExplicitLeft = 673
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
      Left = 890
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = Btn_CancelarClick
      ExplicitLeft = 769
    end
    object Btn_Excluir: TButton
      AlignWithMargins = True
      Left = 698
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Excluir'
      TabOrder = 3
      OnClick = btn_excluirClick
      ExplicitLeft = 673
    end
    object Btn_Historico: TButton
      AlignWithMargins = True
      Left = 602
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Hist'#243'rico'
      TabOrder = 2
      OnClick = Btn_HistoricoClick
      ExplicitLeft = 673
    end
  end
end
