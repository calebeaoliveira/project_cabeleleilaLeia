unit uCadAgendamento;

interface

uses
  System.Classes, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  System.SysUtils, FireDAC.Stan.Param, Math, System.UITypes;

type
  TTpStatus = (
    TtpSt_Ativo,
    TtpSt_Inativo
  );

  TCadAgendamento = class(TComponent)
  private
    FAgendamento: TFDTable;
    FServicos: TFDQuery;
    FHorarios: TFDMemTable;

    FDSAgendamento: TDataSource;
    FDSServicos: TDataSource;
    FDSHorarios: TDataSource;

    FClientes: TFDQuery;
    FDSClientes: TDataSource;

    FFrameAgenda : Boolean;

    function GetDuracaoServico: Integer;
    function TemConflito(AData: TDate; AInicio, AFim: TTime): Boolean;
    procedure OnChange(Sender: TField);
    procedure BefPost(DataSet : TDataSet);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Novo;
    procedure Editar;
    procedure Salvar;
    procedure Cancelar;

    procedure CarregarServicos;
    procedure CarregarClientes;
    procedure GerarHorariosDisponiveis(AData: TDate);
    procedure SelecionarHorario(Horario: TTime);

    function RevisarData : Boolean;

    property DSAgendamento: TDataSource read FDSAgendamento;
    property DSServicos: TDataSource read FDSServicos;
    property DSHorarios: TDataSource read FDSHorarios;
    property FrameAgenda: Boolean read FFrameAgenda write FFrameAgenda;
    property DSClientes: TDataSource read FDSClientes;

    procedure Abrir(pID: Integer);
  end;

implementation

uses
  uDMConexao, DateUtils, uSessao, uUsuario, Vcl.Dialogs;

{ TCadAgendamento }

constructor TCadAgendamento.Create(AOwner: TComponent);
begin
  inherited;

  FAgendamento := TFDTable.Create(Self);
  FAgendamento.Connection := DMConexao.FDConnection;
  FAgendamento.TableName := 'AGENDAMENTOS';
  FAgendamento.Open;

  FDSAgendamento := TDataSource.Create(Self);
  FDSAgendamento.DataSet := FAgendamento;

  FServicos := TFDQuery.Create(Self);
  FServicos.Connection := DMConexao.FDConnection;

  FDSServicos := TDataSource.Create(Self);
  FDSServicos.DataSet := FServicos;

  CarregarServicos;

  FHorarios := TFDMemTable.Create(Self);
  FHorarios.FieldDefs.Add('HORARIO_INICIO', ftTime);
  FHorarios.FieldDefs.Add('HORARIO_FIM', ftTime);
  FHorarios.FieldDefs.Add('INTERVALO', ftString, 20);
  FHorarios.CreateDataSet;

  FDSHorarios := TDataSource.Create(Self);
  FDSHorarios.DataSet := FHorarios;

  FAgendamento.FieldByName('DATA').EditMask :=  '!99/99/9999;1;_';
  FAgendamento.FieldByName('HORA').EditMask :=  '!90:00;1;_';
  FAgendamento.FieldByName('HORA_FIM').EditMask :=  '!90:00;1;_';


  FAgendamento.FieldByName('DATA').OnChange := OnChange;
  FAgendamento.FieldByName('FK_SERVICO').OnChange := OnChange;

  FAgendamento.BeforePost := BefPost;

  FFrameAgenda := False;

  FClientes := TFDQuery.Create(Self);
  FClientes.Connection := DMConexao.FDConnection;

  FDSClientes := TDataSource.Create(Self);
  FDSClientes.DataSet := FClientes;

  CarregarClientes;
end;

destructor TCadAgendamento.Destroy;
begin
  FHorarios.Free;
  FServicos.Free;
  FAgendamento.Free;

  inherited;
end;

procedure TCadAgendamento.Abrir(pID: Integer);
begin
  FAgendamento.Filtered := False;

  if pID > 0 then
  begin
    FAgendamento.Filter := 'ID = ' + IntToStr(pID);
    FAgendamento.Filtered := True;
  end;
end;

procedure TCadAgendamento.CarregarClientes;
begin
  FClientes.Close;
  FClientes.SQL.Text :=
    'SELECT ID, NOME FROM USUARIOS WHERE TIPO = '+InttoStr(Ord(tuCliente))+' ORDER BY NOME';
  FClientes.Open;
end;

procedure TCadAgendamento.CarregarServicos;
begin
  FServicos.Close;
  FServicos.SQL.Text := 'SELECT ID, NOME, DURACAO_MIN, VALOR FROM SERVICOS ORDER BY NOME';
  FServicos.Open;
end;

function TCadAgendamento.GetDuracaoServico: Integer;
begin
  Result := FServicos.FieldByName('DURACAO_MIN').AsInteger;
end;

function TCadAgendamento.TemConflito(AData: TDate; AInicio, AFim: TTime): Boolean;
var
  Q: TFDQuery;
begin
  Result := False;

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DMConexao.FDConnection;

    Q.SQL.Text :=
      'SELECT 1 FROM AGENDAMENTOS ' +
      'WHERE DATA = :DATA ' +
      '  AND (:INI < HORA_FIM) ' +
      '  AND (:FIM > HORA)';

    Q.ParamByName('DATA').AsDate := AData;
    Q.ParamByName('INI').AsTime := AInicio;
    Q.ParamByName('FIM').AsTime := AFim;
    Q.Open;

    Result := not Q.IsEmpty;
  finally
    Q.Free;
  end;
end;

procedure TCadAgendamento.GerarHorariosDisponiveis(AData: TDate);
var
  H, HFim: TTime;
  Duracao: Integer;
  LimiteFimDia: TTime;
begin
  FHorarios.DisableControls;
  try
    FHorarios.EmptyDataSet;

    Duracao := GetDuracaoServico;
    if Duracao <= 0 then
      Exit;

    H := EncodeTime(8, 0, 0, 0);
    LimiteFimDia := EncodeTime(18, 0, 0, 0);

    while H < LimiteFimDia do
    begin
      HFim := IncMinute(H, Duracao);

      if HFim > LimiteFimDia then
        Break;

      if not TemConflito(AData, H, HFim) then
      begin
        FHorarios.Append;
        FHorarios.FieldByName('HORARIO_INICIO').AsDateTime := H;
        FHorarios.FieldByName('HORARIO_FIM').AsDateTime    := HFim;
        FHorarios.FieldByName('INTERVALO').AsString :=
          FormatDateTime('hh:nn', H) + ' - ' + FormatDateTime('hh:nn', HFim);
        FHorarios.Post;
      end;

      H := HFim;
    end;

  finally
    FHorarios.EnableControls;
  end;
end;

procedure TCadAgendamento.SelecionarHorario(Horario: TTime);
var
  Duracao: Integer;
begin
  Duracao := GetDuracaoServico;
  if Duracao <= 0 then Exit;

  Editar;

  FAgendamento.FieldByName('HORA').AsDateTime := Horario;
  FAgendamento.FieldByName('HORA_FIM').AsDateTime := IncMinute(Horario, Duracao);
end;

procedure TCadAgendamento.BefPost(DataSet: TDataSet);
begin
  if not FFrameAgenda then
  begin
    FAgendamento.FieldByName('FK_CLIENTE').AsInteger := GUsuarioLogado.ID;
    FAgendamento.FieldByName('STATUS').AsInteger := Ord(TtpSt_Ativo);
    FAgendamento.FieldByName('HORA').Value := FHorarios.FieldByName('HORARIO_INICIO').Value;
    FAgendamento.FieldByName('HORA_FIM').Value := FHorarios.FieldByName('HORARIO_FIM').Value;
    FAgendamento.FieldByName('VALOR').Value := FServicos.FieldByName('VALOR').Value;
  end;

  if (FAgendamento.FieldByName('FK_SERVICO').IsNull) then
    raise Exception.Create('Preencha o serviço!');

  if (FAgendamento.FieldByName('DATA').IsNull) or  (FAgendamento.FieldByName('DATA').Value = 0) then
    raise Exception.Create('Selecione a data!');

  if (FAgendamento.FieldByName('HORA').IsNull) then
    raise Exception.Create('Selecione a hora inicial!');

  if (FAgendamento.FieldByName('HORA_FIM').IsNull) then
    raise Exception.Create('Selecione a hora final!');

  if (FAgendamento.FieldByName('VALOR').IsNull) then
    raise Exception.Create('Preencha o valor!');

end;

procedure TCadAgendamento.Novo;
begin
  CarregarServicos;
  CarregarClientes;
  FAgendamento.Append;

  FAgendamento.FieldByName('DATA').AsDateTime := Now;
end;

procedure TCadAgendamento.OnChange(Sender: TField);
begin
  if (Sender.FieldName = 'DATA') and
     (not Sender.IsNull) and
     (GetDuracaoServico > 0) then
    GerarHorariosDisponiveis(Sender.AsDateTime);

  if (Sender.FieldName = 'FK_SERVICO') then
    FAgendamento.FieldByName('VALOR').Value := FServicos.FieldByName('VALOR').Value;
end;

function TCadAgendamento.RevisarData : Boolean;
var
  Q: TFDQuery;
  DataInicioSemana, DataFimSemana: TDate;
  ClienteID: Integer;
  Msg: String;
begin
  Result := True;

  if FAgendamento.FieldByName('DATA').IsNull then
    Exit;

  ClienteID := GUsuarioLogado.ID;

  DataInicioSemana := StartOfTheWeek(FAgendamento.FieldByName('DATA').AsDateTime);

  DataFimSemana := EndOfTheWeek(FAgendamento.FieldByName('DATA').AsDateTime);

  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DMConexao.FDConnection;

    Q.SQL.Text :=
      'SELECT DATA, HORA ' +
      'FROM AGENDAMENTOS ' +
      'WHERE FK_CLIENTE = :CLI ' +
      '  AND ID <> :ATUAL ' +
      '  AND DATA BETWEEN :INI AND :FIM ' +
      'ORDER BY DATA, HORA LIMIT 1';

    Q.ParamByName('CLI').AsInteger := ClienteID;
    Q.ParamByName('ATUAL').AsInteger :=
      IfThen(FAgendamento.FieldByName('ID').IsNull, 0, FAgendamento.FieldByName('ID').AsInteger);
    Q.ParamByName('INI').AsDate := DataInicioSemana;
    Q.ParamByName('FIM').AsDate := DataFimSemana;

    Q.Open;

    if not Q.IsEmpty then
    begin
      Msg :=
        'Você já possui outro atendimento na mesma semana:' + sLineBreak +
        FormatDateTime('dd/mm/yyyy "às" hh:nn', Q.FieldByName('DATA').AsDateTime +
                                             Q.FieldByName('HORA').AsDateTime) +
        sLineBreak + sLineBreak +
        'Deseja continuar mesmo assim?' + sLineBreak +
        '(Recomendado marcar para a mesma data do atendimento já existente)';

      if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
        Result := False;
    end;

  finally
    Q.Free;
  end;
end;

procedure TCadAgendamento.Editar;
begin
  CarregarServicos;
  CarregarClientes;
  if not (FAgendamento.State in dsEditModes) then
    FAgendamento.Edit;
end;

procedure TCadAgendamento.Salvar;
begin
  if FAgendamento.State in dsEditModes then
    FAgendamento.Post;
end;

procedure TCadAgendamento.Cancelar;
begin
  if FAgendamento.State in dsEditModes then
    FAgendamento.Cancel;
end;

end.

