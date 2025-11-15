object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Sistema CabeleleilaLeila'
  ClientHeight = 461
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
    Top = 0
    Width = 984
    Height = 461
    ActivePage = Tb_Consulta
    Align = alClient
    TabOrder = 0
    ExplicitTop = 33
    ExplicitHeight = 628
    object Tb_Consulta: TTabSheet
      Caption = 'Tb_Consulta'
      TabVisible = False
      object Pnl_Principal: TPanel
        Left = 0
        Top = 0
        Width = 976
        Height = 451
        Align = alClient
        TabOrder = 0
        ExplicitHeight = 618
        object Pnl_Agendamentos: TPanel
          Left = 1
          Top = 50
          Width = 974
          Height = 400
          Align = alBottom
          TabOrder = 0
          object DBGrd_Agendamento: TDBGrid
            Left = 1
            Top = 1
            Width = 972
            Height = 398
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
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = 'Observa'#231#245'es'
                Width = 300
                Visible = True
              end
              item
                Expanded = False
                Title.Alignment = taCenter
                Title.Caption = 'Valor'
                Width = 150
                Visible = True
              end>
          end
        end
        object Button1: TButton
          AlignWithMargins = True
          Left = 882
          Top = 4
          Width = 90
          Height = 43
          Align = alRight
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = Button1Click
          ExplicitLeft = 602
          ExplicitHeight = 25
        end
      end
    end
  end
end
