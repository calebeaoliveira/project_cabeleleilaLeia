unit fLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmLogin = class(TForm)
    Btn_Entrar: TButton;
    ed_Login: TEdit;
    Ed_Senha: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    procedure Btn_EntrarClick(Sender: TObject);
    procedure Ed_SenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses   uUsuarioRepository, uSessao, fMainAdmin, fMainCliente, uDMConexao, uUsuario;

{$R *.dfm}

procedure TfrmLogin.Btn_EntrarClick(Sender: TObject);
begin
  GUsuarioLogado := TUsuarioRepository.BuscarPorLogin(
    ed_Login.Text,
    Ed_Senha.Text,
    DMConexao.FDConnection
  );

  if Assigned(GUsuarioLogado) then
  begin
    if GUsuarioLogado.Tipo = tuAdmin then
      ModalResult := mrOk
    else
      ModalResult := mrOk;
  end
  else
    ShowMessage('Usuário ou senha inválidos.');
end;

procedure TfrmLogin.Ed_SenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Btn_Entrar.Click;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  ed_Login.SetFocus;
end;

end.
