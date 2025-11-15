unit fAgendaFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, Vcl.ComCtrls, uCnsAgendamento, uCadAgendamento;

type
  TfAgendaAdm = class(TFrame)
    Pg_Principal: TPageControl;
    Tb_Consulta: TTabSheet;
    Panel1: TPanel;
    btn_Pesquisar: TButton;
    DBGrd_Consulta: TDBGrid;
    Tb_Cadastro: TTabSheet;
    Panel2: TPanel;
    Label2: TLabel;
    DBEd_OBS: TDBEdit;
    Pnl_Botoes: TPanel;
    Btn_Gravar: TButton;
    Btn_Novo: TButton;
    Btn_Editar: TButton;
    Btn_Cancelar: TButton;
    DBLkp_Servico: TDBLookupComboBox;
    Label5: TLabel;
    DBEd_Data: TDBEdit;
    Label6: TLabel;
    Label4: TLabel;
    DBEd_HoraFim: TDBEdit;
    DBEd_Valor: TDBEdit;
    Label3: TLabel;
    Label7: TLabel;
    DBEd_HoraIni: TDBEdit;
    Label1: TLabel;
    DBLkp_Cliente: TDBLookupComboBox;
    procedure DBGrd_ConsultaDblClick(Sender: TObject);
    procedure Btn_NovoClick(Sender: TObject);
    procedure Pg_PrincipalChange(Sender: TObject);
    procedure Btn_EditarClick(Sender: TObject);
    procedure Btn_GravarClick(Sender: TObject);
    procedure Btn_CancelarClick(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
  private
    { Private declarations }
    FCns : TCnsAgendamento;
    FCad : TCadAgendamento;
    procedure HabilitaForm(pEnabled : Boolean);
  public
    { Public declarations }
    procedure Inicializar;
  end;

implementation

{$R *.dfm}

{ TfAgendaAdm }

procedure TfAgendaAdm.Btn_CancelarClick(Sender: TObject);
begin
  FCad.Cancelar;
  HabilitaForm(False);
end;

procedure TfAgendaAdm.Btn_EditarClick(Sender: TObject);
begin
  Pg_Principal.ActivePage := Tb_Cadastro;
  FCad.Editar;
  HabilitaForm(True);
end;

procedure TfAgendaAdm.Btn_GravarClick(Sender: TObject);
begin
  FCad.Salvar;
  HabilitaForm(False);
end;

procedure TfAgendaAdm.Btn_NovoClick(Sender: TObject);
begin
  Pg_Principal.ActivePage := Tb_Cadastro;
  FCad.Novo;
  HabilitaForm(True);
end;

procedure TfAgendaAdm.btn_PesquisarClick(Sender: TObject);
begin
  FCns.Pesquisar(False);
end;

procedure TfAgendaAdm.DBGrd_ConsultaDblClick(Sender: TObject);
begin
  if not FCns.DS.DataSet.IsEmpty then
  begin
    FCad.Abrir(FCns.DS.DataSet.FieldByName('ID').AsInteger);
    Pg_Principal.ActivePage := Tb_Cadastro;
  end;
end;

procedure TfAgendaAdm.HabilitaForm(pEnabled: Boolean);
begin
  Btn_Novo.Enabled := not pEnabled;
  Btn_Editar.Enabled := not pEnabled;

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

procedure TfAgendaAdm.Inicializar;
begin
  FCns := TCnsAgendamento.Create(Self);
  FCad := TCadAgendamento.Create(Self);
  FCad.FrameAgenda := True;

  DBGrd_Consulta.DataSource := FCns.DS;
  DBGrd_Consulta.Columns[0].FieldName := 'CLIENTE';
  DBGrd_Consulta.Columns[1].FieldName := 'SERVICO';
  DBGrd_Consulta.Columns[2].FieldName := 'DATA';
  DBGrd_Consulta.Columns[3].FieldName := 'INTERVALO';

  DBLkp_Servico.DataSource := FCad.DSAgendamento;
  DBLkp_Servico.DataField := 'FK_SERVICO';

  DBLkp_Servico.ListSource := FCad.DSServicos;
  DBLkp_Servico.ListField := 'NOME';
  DBLkp_Servico.KeyField := 'ID';

  DBEd_Data.DataSource := FCad.DSAgendamento;
  DBEd_Data.DataField := 'DATA';

  DBEd_HoraIni.DataSource := FCad.DSAgendamento;
  DBEd_HoraIni.DataField := 'HORA';

  DBEd_HoraFim.DataSource := FCad.DSAgendamento;
  DBEd_HoraFim.DataField := 'HORA_FIM';

  DBEd_OBS.DataSource := FCad.DSAgendamento;
  DBEd_OBS.DataField := 'OBSERVACOES';

  DBEd_Valor.DataSource := FCad.DSAgendamento;
  DBEd_Valor.DataField := 'VALOR';

  DBLkp_Cliente.DataSource := FCad.DSAgendamento;
  DBLkp_Cliente.DataField := 'FK_CLIENTE';

  DBLkp_Cliente.ListSource := FCad.DSClientes;
  DBLkp_Cliente.ListField := 'NOME';
  DBLkp_Cliente.KeyField := 'ID';

  Pg_Principal.ActivePage := Tb_Consulta;
  HabilitaForm(False);

  btn_Pesquisar.Click;
end;

procedure TfAgendaAdm.Pg_PrincipalChange(Sender: TObject);
begin
  if Pg_Principal.ActivePage = Tb_Cadastro then
    if (not FCns.DS.DataSet.IsEmpty) then
      FCad.Abrir(FCns.DS.DataSet.FieldByName('ID').AsInteger);
end;

end.
