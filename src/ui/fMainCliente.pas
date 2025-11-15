unit fMainCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uCnsAgendamento, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls, uCadAgendamento;

type
  TfrmMainCliente = class(TForm)
    Pnl_Principal: TPanel;
    Label1: TLabel;
    Pnl_Agendamentos: TPanel;
    DBGrd_Agendamento: TDBGrid;
    Pg_Principal: TPageControl;
    Tb_Consulta: TTabSheet;
    Tb_Cadastro: TTabSheet;
    DBLkp_Servico: TDBLookupComboBox;
    Label5: TLabel;
    DBEd_Data: TDBEdit;
    Label6: TLabel;
    DBGrd_Horarios: TDBGrid;
    Pnl_Informacoes: TPanel;
    Pnl_Confirmacao: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    DBEd_OBS: TDBEdit;
    Tb_Editar: TTabSheet;
    Panel2: TPanel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBEd_OBS2: TDBEdit;
    DBLkp_Servico2: TDBLookupComboBox;
    DBEd_Data2: TDBEdit;
    DBEd_HoraFim: TDBEdit;
    DBEd_Valor: TDBEdit;
    DBEd_HoraIni: TDBEdit;
    DBLkp_Cliente: TDBLookupComboBox;
    Pnl_Botoes: TPanel;
    Btn_Gravar: TButton;
    Btn_Novo: TButton;
    Btn_Editar: TButton;
    Btn_Cancelar: TButton;
    Btn_Excluir: TButton;
    Btn_Historico: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Btn_GravarClick(Sender: TObject);
    procedure Btn_CancelarClick(Sender: TObject);
    procedure DBGrd_HorariosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrd_HorariosCellClick(Column: TColumn);
    procedure btn_excluirClick(Sender: TObject);
    procedure Btn_NovoClick(Sender: TObject);
    procedure Btn_EditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Btn_HistoricoClick(Sender: TObject);
  private
    { Private declarations }
    FCns : TCnsAgendamento;
    FCad : TCadAgendamento;
    procedure HabilitaForm(pEnabled : Boolean);
    function PodeEditarDataAtual: Boolean;
  public
    { Public declarations }
  end;

var
  frmMainCliente: TfrmMainCliente;

implementation

uses DateUtils, fHistorico;

{$R *.dfm}

procedure TfrmMainCliente.Btn_CancelarClick(Sender: TObject);
begin
  FCad.Cancelar;
  Pg_Principal.ActivePage := Tb_Consulta;
  FCns.Pesquisar;
  HabilitaForm(False);
end;

procedure TfrmMainCliente.Btn_EditarClick(Sender: TObject);
begin
  Pg_Principal.ActivePage := Tb_Editar;
  if not PodeEditarDataAtual then
  begin
    Pg_Principal.ActivePage := Tb_Consulta;
    Exit;
  end;
  FCad.Editar;
  HabilitaForm(True);
end;

procedure TfrmMainCliente.btn_excluirClick(Sender: TObject);
begin
  try
    FCad.DSAgendamento.DataSet.Delete;
    FCns.Pesquisar;
  except
    ShowMessage('Não foi possível excluir!');
  end;
end;

procedure TfrmMainCliente.Btn_GravarClick(Sender: TObject);
begin
  if not FCad.RevisarData then
    exit;

  FCad.Salvar;
  Pg_Principal.ActivePage := Tb_Consulta;
  FCns.Pesquisar;
  HabilitaForm(False);
end;

procedure TfrmMainCliente.Btn_HistoricoClick(Sender: TObject);
var
  vForm : TfrmHistorico;
begin
  vForm := TfrmHistorico.Create(Self);
  try
    vForm.ShowModal;
  finally
    FreeAndNil(vForm);
  end;
end;

procedure TfrmMainCliente.Btn_NovoClick(Sender: TObject);
begin
  FCad.DSServicos.DataSet.First;
  FCad.Novo;
  FCad.DSAgendamento.DataSet.FieldByName('FK_SERVICO').AsInteger :=  FCad.DSServicos.DataSet.FieldByName('ID').AsInteger;
  Pg_Principal.ActivePage := Tb_Cadastro;
  HabilitaForm(True);
end;

procedure TfrmMainCliente.DBGrd_HorariosCellClick(Column: TColumn);
var
  HIni: TTime;
begin
  if (FCad.DSHorarios.DataSet = nil) or
     (not FCad.DSHorarios.DataSet.Active) or
     (FCad.DSHorarios.DataSet.IsEmpty) then
    Exit;

  HIni := FCad.DSHorarios.DataSet.FieldByName('HORARIO_INICIO').AsDateTime;
  FCad.SelecionarHorario(HIni);
end;

procedure TfrmMainCliente.DBGrd_HorariosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (FCad.DSHorarios.DataSet = nil) or
     (not FCad.DSHorarios.DataSet.Active) or
     (Column.Field = nil) then
  begin
    DBGrd_Horarios.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    Exit;
  end;

  with DBGrd_Horarios.Canvas do
  begin
    if gdSelected in State then
    begin
      Brush.Color := $00CCFFCC;
      Font.Color := clBlack;
      FillRect(Rect);
      TextRect(Rect, Rect.Left + 4, Rect.Top + 2, Column.Field.AsString);
    end
    else
    begin
      DBGrd_Horarios.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;
procedure TfrmMainCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMainCliente.FormCreate(Sender: TObject);
begin
  FCns := TCnsAgendamento.Create(Self);
  FCad := TCadAgendamento.Create(Self);

  DBGrd_Agendamento.DataSource := FCns.DS;
  DBGrd_Agendamento.Columns[0].FieldName := 'SERVICO';
  DBGrd_Agendamento.Columns[1].FieldName := 'DATA';
  DBGrd_Agendamento.Columns[2].FieldName := 'INTERVALO';

  DBLkp_Servico.DataSource := FCad.DSAgendamento;
  DBLkp_Servico.DataField := 'FK_SERVICO';

  DBLkp_Servico.ListSource := FCad.DSServicos;
  DBLkp_Servico.ListField := 'NOME';
  DBLkp_Servico.KeyField := 'ID';

  DBGrd_Horarios.DataSource := FCad.DSHorarios;
  DBGrd_Horarios.Columns[0].FieldName := 'INTERVALO';

  DBEd_Data.DataSource := FCad.DSAgendamento;
  DBEd_Data.DataField := 'DATA';

  DBEd_OBS.DataSource := FCad.DSAgendamento;
  DBEd_OBS.DataField := 'OBSERVACOES';



  DBLkp_Servico2.DataSource := FCad.DSAgendamento;
  DBLkp_Servico2.DataField := 'FK_SERVICO';

  DBLkp_Servico.ListSource := FCad.DSServicos;
  DBLkp_Servico.ListField := 'NOME';
  DBLkp_Servico.KeyField := 'ID';

  DBEd_Data2.DataSource := FCad.DSAgendamento;
  DBEd_Data2.DataField := 'DATA';

  DBEd_HoraIni.DataSource := FCad.DSAgendamento;
  DBEd_HoraIni.DataField := 'HORA';

  DBEd_HoraFim.DataSource := FCad.DSAgendamento;
  DBEd_HoraFim.DataField := 'HORA_FIM';

  DBEd_OBS2.DataSource := FCad.DSAgendamento;
  DBEd_OBS2.DataField := 'OBSERVACOES';

  DBEd_Valor.DataSource := FCad.DSAgendamento;
  DBEd_Valor.DataField := 'VALOR';

  DBLkp_Cliente.DataSource := FCad.DSAgendamento;
  DBLkp_Cliente.DataField := 'FK_CLIENTE';

  DBLkp_Cliente.ListSource := FCad.DSClientes;
  DBLkp_Cliente.ListField := 'NOME';
  DBLkp_Cliente.KeyField := 'ID';
end;

procedure TfrmMainCliente.FormShow(Sender: TObject);
begin
  FCns.Pesquisar;
  Pg_Principal.ActivePage := Tb_Consulta;

  HabilitaForm(False);
end;

procedure TfrmMainCliente.HabilitaForm(pEnabled: Boolean);
begin
  Btn_Novo.Enabled := not pEnabled;
  Btn_Editar.Enabled := not pEnabled;
  Btn_Excluir.Enabled := not pEnabled;

  Btn_Gravar.Enabled := pEnabled;
  Btn_Cancelar.Enabled := pEnabled;

  DBLkp_Cliente.Enabled := pEnabled;
  DBLkp_Servico.Enabled := pEnabled;
  DBEd_Data.Enabled := pEnabled;
  DBEd_HoraIni.Enabled := pEnabled;
  DBEd_HoraFim.Enabled := pEnabled;
  DBEd_OBS.Enabled := pEnabled;
  DBEd_Valor.Enabled := pEnabled;
end;

function TfrmMainCliente.PodeEditarDataAtual: Boolean;
var
  DataAg: TDate;
  Dias: Integer;
begin
  Result := True;

  if FCad.DSAgendamento.DataSet.FieldByName('ID').IsNull then
    Exit;

  DataAg := FCad.DSAgendamento.DataSet.FieldByName('DATA').AsDateTime;

  Dias := DaysBetween(Date, DataAg);

  if Dias < 2 then
  begin
    ShowMessage(
      'Este agendamento não pode ser editado porque falta menos de 2 dias para a data marcada (' +
      FormatDateTime('dd/mm/yyyy', DataAg) + '). Ligue para a Leila!'
    );
    Result := False;
  end;
end;

end.
