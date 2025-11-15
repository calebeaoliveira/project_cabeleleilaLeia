unit fHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uCnsAgendamento, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, uCadAgendamento;

type
  TfrmHistorico = class(TForm)
    Pnl_Principal: TPanel;
    Pnl_Agendamentos: TPanel;
    DBGrd_Agendamento: TDBGrid;
    Pg_Principal: TPageControl;
    Tb_Consulta: TTabSheet;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FCns : TCnsAgendamento;
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

uses DateUtils;

{$R *.dfm}

procedure TfrmHistorico.Button1Click(Sender: TObject);
begin
  FCns.Pesquisar;
end;

procedure TfrmHistorico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmHistorico.FormCreate(Sender: TObject);
begin
  FCns := TCnsAgendamento.Create(Self);

  DBGrd_Agendamento.DataSource := FCns.DS;
  DBGrd_Agendamento.Columns[0].FieldName := 'SERVICO';
  DBGrd_Agendamento.Columns[1].FieldName := 'DATA';
  DBGrd_Agendamento.Columns[2].FieldName := 'INTERVALO';
  DBGrd_Agendamento.Columns[3].FieldName := 'OBSERVACOES';
  DBGrd_Agendamento.Columns[4].FieldName := 'VALOR';
end;

procedure TfrmHistorico.FormShow(Sender: TObject);
begin
  FCns.Pesquisar;
  Pg_Principal.ActivePage := Tb_Consulta;
end;

end.
