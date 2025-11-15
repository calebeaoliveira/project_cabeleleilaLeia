program CabeleleilaLeila;

uses
  Vcl.Forms,
  System.UITypes,
  fLogin in 'src\ui\fLogin.pas' {frmLogin},
  uDMConexao in 'src\infra\uDMConexao.pas' {DMConexao: TDataModule},
  uUsuario in 'src\domain\uUsuario.pas',
  uSessao in 'src\domain\uSessao.pas',
  uUsuarioRepository in 'src\infra\uUsuarioRepository.pas',
  fMainAdmin in 'src\ui\fMainAdmin.pas' {frmMainAdmin},
  fMainCliente in 'src\ui\fMainCliente.pas' {frmMainCliente},
  fCadClientes in 'src\ui\fCadClientes.pas' {frmCadClientes},
  uCadUsuario in 'src\domain\uCadUsuario.pas',
  uCnsUsuario in 'src\domain\uCnsUsuario.pas',
  fCadServicos in 'src\ui\fCadServicos.pas' {frmCadServicos},
  uCadServico in 'src\domain\uCadServico.pas',
  uCnsServico in 'src\domain\uCnsServico.pas',
  uCnsAgendamento in 'src\domain\uCnsAgendamento.pas',
  uCadAgendamento in 'src\domain\uCadAgendamento.pas',
  fAgendaFrame in 'src\ui\fAgendaFrame.pas' {fAgendaAdm: TFrame},
  fHistorico in 'src\ui\fHistorico.pas' {frmHistorico};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TDMConexao, DMConexao);

  // Exibe o login como modal
  frmLogin := TfrmLogin.Create(nil);
  try
    if frmLogin.ShowModal = mrOk then
    begin
      if GUsuarioLogado.Tipo = tuAdmin then
        Application.CreateForm(TfrmMainAdmin, frmMainAdmin)
      else
        Application.CreateForm(TfrmMainCliente, frmMainCliente);

      Application.Run;
    end;
  finally
    frmLogin.Free;
  end;
end.
