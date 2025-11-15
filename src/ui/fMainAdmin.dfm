object frmMainAdmin: TfrmMainAdmin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Painel do Administrador'
  ClientHeight = 661
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 661
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 113
      Height = 15
      Margins.Bottom = 10
      Align = alTop
      Alignment = taCenter
      Caption = 'Cadastros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 53
    end
    object btn_Clientes: TButton
      AlignWithMargins = True
      Left = 4
      Top = 32
      Width = 113
      Height = 25
      Align = alTop
      Caption = 'Clientes'
      TabOrder = 0
      OnClick = btn_ClientesClick
    end
    object btn_Servicos: TButton
      AlignWithMargins = True
      Left = 4
      Top = 63
      Width = 113
      Height = 25
      Align = alTop
      Caption = 'Servi'#231'os'
      TabOrder = 1
      OnClick = btn_ServicosClick
    end
  end
  object Pnl_Agenda: TPanel
    Left = 121
    Top = 0
    Width = 863
    Height = 661
    Align = alClient
    TabOrder = 1
    inline fAgendaAdm1: TfAgendaAdm
      Left = 0
      Top = 8
      Width = 863
      Height = 600
      TabOrder = 0
      ExplicitTop = 8
      inherited Pg_Principal: TPageControl
        ActivePage = fAgendaAdm1.Tb_Consulta
        ExplicitWidth = 863
        ExplicitHeight = 567
        inherited Tb_Consulta: TTabSheet
          inherited Panel1: TPanel
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 855
          end
        end
        inherited Tb_Cadastro: TTabSheet
          inherited Panel2: TPanel
            StyleElements = [seFont, seClient, seBorder]
            inherited Label2: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label5: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label6: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label4: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label3: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label7: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited Label1: TLabel
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited DBEd_OBS: TDBEdit
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited DBEd_Data: TDBEdit
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited DBEd_HoraFim: TDBEdit
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited DBEd_Valor: TDBEdit
              StyleElements = [seFont, seClient, seBorder]
            end
            inherited DBEd_HoraIni: TDBEdit
              StyleElements = [seFont, seClient, seBorder]
            end
          end
        end
      end
      inherited Pnl_Botoes: TPanel
        StyleElements = [seFont, seClient, seBorder]
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 863
        inherited Btn_Gravar: TButton
          ExplicitLeft = 673
        end
        inherited Btn_Novo: TButton
          ExplicitTop = 4
        end
        inherited Btn_Cancelar: TButton
          ExplicitLeft = 769
        end
      end
    end
  end
end
