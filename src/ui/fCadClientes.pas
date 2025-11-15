unit fCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uCnsUsuario, Vcl.Mask, Vcl.DBCtrls, uCadUsuario;

type
  TfrmCadClientes = class(TForm)
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
    DBEd_Usuario: TDBEdit;
    DBEd_Senha: TDBEdit;
    DBChk_Tipo: TDBCheckBox;
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
    FCns : TCnsUsuario;
    FCad : TCadUsuario;

    procedure HabilitaForm(pEnabled : Boolean);
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

{$R *.dfm}

procedure TfrmCadClientes.btn_PesquisarClick(Sender: TObject);
begin
  FCns.Pesquisar;
end;

procedure TfrmCadClientes.DBGrd_ConsultaDblClick(Sender: TObject);
begin
  if not FCns.DS.DataSet.IsEmpty then
  begin
    FCad.Abrir(FCns.DS.DataSet.FieldByName('ID').AsInteger);
    Pg_Principal.ActivePage := Tb_Cadastro;
  end;
end;

procedure TfrmCadClientes.Btn_CancelarClick(Sender: TObject);
begin
  FCad.DataSet.Cancel;
  HabilitaForm(False);
end;

procedure TfrmCadClientes.Btn_EditarClick(Sender: TObject);
begin
  FCad.DataSet.Edit;
  Pg_Principal.ActivePage := Tb_Cadastro;
  HabilitaForm(True);
end;

procedure TfrmCadClientes.Btn_GravarClick(Sender: TObject);
begin
  FCad.DataSet.post;
  HabilitaForm(False);
end;

procedure TfrmCadClientes.Btn_NovoClick(Sender: TObject);
begin
  FCad.DataSet.Append;
  Pg_Principal.ActivePage := Tb_Cadastro;
  HabilitaForm(True);
end;

procedure TfrmCadClientes.FormCreate(Sender: TObject);
begin
  FCns := TCnsUsuario.Create(Self);
  FCad := TCadUsuario.Create(Self);

  DBGrd_Consulta.DataSource := FCns.DS;
  DBGrd_Consulta.Columns[0].FieldName := 'NOME';

  DBEd_Nome.DataSource := FCad.DS;
  DBEd_Nome.DataField := 'NOME';
  DBEd_Usuario.DataSource := FCad.DS;
  DBEd_Usuario.DataField := 'LOGIN';
  DBEd_Senha.DataSource := FCad.DS;
  DBEd_Senha.DataField := 'SENHA';
  DBChk_Tipo.DataSource := FCad.DS;
  DBChk_Tipo.DataField := 'TIPO';

  Pg_Principal.ActivePage := Tb_Consulta;
end;

procedure TfrmCadClientes.FormShow(Sender: TObject);
begin
  HabilitaForm(False);
end;

procedure TfrmCadClientes.HabilitaForm(pEnabled: Boolean);
begin
  Btn_Novo.Enabled := not pEnabled;
  Btn_Editar.Enabled := not pEnabled;

  Btn_Gravar.Enabled := pEnabled;
  Btn_Cancelar.Enabled := pEnabled;

  DBEd_Nome.Enabled := pEnabled;
  DBEd_Usuario.Enabled := pEnabled;
  DBEd_Senha.Enabled := pEnabled;
  DBChk_Tipo.Enabled := pEnabled;
end;

procedure TfrmCadClientes.Pg_PrincipalChange(Sender: TObject);
begin
  if Pg_Principal.ActivePage = Tb_Cadastro then
    if (not FCns.DS.DataSet.IsEmpty) then
      FCad.Abrir(FCns.DS.DataSet.FieldByName('ID').AsInteger);
end;

end.
