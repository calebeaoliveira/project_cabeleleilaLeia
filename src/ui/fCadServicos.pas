unit fCadServicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uCnsServico, Vcl.Mask, Vcl.DBCtrls, uCadServico;

type
  TfrmCadServicos = class(TForm)
    Pg_Principal: TPageControl;
    Tb_Consulta: TTabSheet;
    Tb_Cadastro: TTabSheet;
    Panel1: TPanel;
    btn_Pesquisar: TButton;
    DBGrd_Consulta: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Pnl_Botoes: TPanel;
    Btn_Gravar: TButton;
    Btn_Novo: TButton;
    Btn_Editar: TButton;
    Btn_Cancelar: TButton;
    DBEd_Nome: TDBEdit;
    DBEd_Duracao: TDBEdit;
    DBEd_Valor: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure Btn_NovoClick(Sender: TObject);
    procedure Btn_EditarClick(Sender: TObject);
    procedure Btn_GravarClick(Sender: TObject);
    procedure Btn_CancelarClick(Sender: TObject);
    procedure DBGrd_ConsultaDblClick(Sender: TObject);
    procedure Pg_PrincipalChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FCns : TCnsServico;
    FCad : TCadServico;

    procedure HabilitaForm(pEnabled : Boolean);
  public
    { Public declarations }
  end;

var
  frmCadServicos: TfrmCadServicos;

implementation

{$R *.dfm}

procedure TfrmCadServicos.btn_PesquisarClick(Sender: TObject);
begin
  FCns.Pesquisar;
end;

procedure TfrmCadServicos.DBGrd_ConsultaDblClick(Sender: TObject);
begin
  if not FCns.DS.DataSet.IsEmpty then
  begin
    FCad.Abrir(FCns.DS.DataSet.FieldByName('ID').AsInteger);
    Pg_Principal.ActivePage := Tb_Cadastro;
  end;
end;

procedure TfrmCadServicos.Btn_CancelarClick(Sender: TObject);
begin
  FCad.DataSet.Cancel;
  HabilitaForm(False);
end;

procedure TfrmCadServicos.Btn_EditarClick(Sender: TObject);
begin
  FCad.DataSet.Edit;
  Pg_Principal.ActivePage := Tb_Cadastro;
  HabilitaForm(True);
end;

procedure TfrmCadServicos.Btn_GravarClick(Sender: TObject);
begin
  FCad.DataSet.post;
  HabilitaForm(False);
end;

procedure TfrmCadServicos.Btn_NovoClick(Sender: TObject);
begin
  FCad.DataSet.Append;
  Pg_Principal.ActivePage := Tb_Cadastro;
  HabilitaForm(True);
end;

procedure TfrmCadServicos.FormCreate(Sender: TObject);
begin
  FCns := TCnsServico.Create(Self);
  FCad := TCadServico.Create(Self);

  DBGrd_Consulta.DataSource := FCns.DS;
  DBGrd_Consulta.Columns[0].FieldName := 'NOME';

  DBEd_Nome.DataSource := FCad.DS;
  DBEd_Nome.DataField := 'NOME';
  DBEd_Duracao.DataSource := FCad.DS;
  DBEd_Duracao.DataField := 'DURACAO_MIN';
  DBEd_Valor.DataSource := FCad.DS;
  DBEd_Valor.DataField := 'VALOR';
  Pg_Principal.ActivePage := Tb_Consulta;
end;

procedure TfrmCadServicos.FormShow(Sender: TObject);
begin
  HabilitaForm(False);
end;

procedure TfrmCadServicos.HabilitaForm(pEnabled: Boolean);
begin
  Btn_Novo.Enabled := not pEnabled;
  Btn_Editar.Enabled := not pEnabled;

  Btn_Gravar.Enabled := pEnabled;
  Btn_Cancelar.Enabled := pEnabled;

  DBEd_Nome.Enabled := pEnabled;
  DBEd_Duracao.Enabled := pEnabled;
  DBEd_Valor.Enabled := pEnabled;
end;

procedure TfrmCadServicos.Pg_PrincipalChange(Sender: TObject);
begin
  if Pg_Principal.ActivePage = Tb_Cadastro then
    if (not FCns.DS.DataSet.IsEmpty) then
      FCad.Abrir(FCns.DS.DataSet.FieldByName('ID').AsInteger);
end;

end.
