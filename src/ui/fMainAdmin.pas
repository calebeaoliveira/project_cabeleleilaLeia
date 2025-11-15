unit fMainAdmin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  fAgendaFrame;

type
  TfrmMainAdmin = class(TForm)
    Panel1: TPanel;
    btn_Clientes: TButton;
    Label1: TLabel;
    btn_Servicos: TButton;
    Pnl_Agenda: TPanel;
    fAgendaAdm1: TfAgendaAdm;
    procedure btn_ClientesClick(Sender: TObject);
    procedure btn_ServicosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainAdmin: TfrmMainAdmin;

implementation

uses fCadClientes, fCadServicos;

{$R *.dfm}

procedure TfrmMainAdmin.btn_ClientesClick(Sender: TObject);
var
  vForm : TfrmCadClientes;
begin
  vForm := TfrmCadClientes.Create(Self);
  try
    vForm.ShowModal;
  finally
    FreeAndNil(vForm);
  end;
end;

procedure TfrmMainAdmin.btn_ServicosClick(Sender: TObject);
var
  vForm : TfrmCadServicos;
begin
  vForm := TfrmCadServicos.Create(Self);
  try
    vForm.ShowModal;
  finally
    FreeAndNil(vForm);
  end;
end;

procedure TfrmMainAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMainAdmin.FormShow(Sender: TObject);
begin
  fAgendaAdm1.Inicializar;
end;

end.
