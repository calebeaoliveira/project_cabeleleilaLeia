unit uCnsAgendamento;

interface

uses FireDAC.Comp.Client, System.Classes, Data.DB, SysUtils;

type
  TCnsAgendamento = class (TComponent)
    private
      FQuery : TFDQuery;
      FDataSource : TDataSource;
    public
      property DS : TDataSource read FDataSource;
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure Pesquisar(pFiltraUsuario : Boolean = True);
  end;

implementation

uses uDMConexao, uUsuario, uSessao;

{ TCnsAgendamento }


constructor TCnsAgendamento.Create(AOwner: TComponent);
begin
  inherited;
  FQuery := TFDQuery.Create(Self);
  FQuery.Connection := DMConexao.FDConnection;

  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FQuery;
end;

destructor TCnsAgendamento.Destroy;
begin
  FQuery.Free;
  inherited;
end;

procedure TCnsAgendamento.Pesquisar(pFiltraUsuario : Boolean);
begin
  FQuery.SQL.Text :=
    'SELECT'
     +#13+' A.*,'
     +#13+' U.NOME AS CLIENTE,'
     +#13+'CONCAT(DATE_FORMAT(A.HORA, ''%H:%i''), '' - '', DATE_FORMAT(A.HORA_FIM, ''%H:%i'') ) AS INTERVALO,'
     +#13+' S.NOME SERVICO'
  +#13+'FROM AGENDAMENTOS A'
  +#13+'INNER JOIN USUARIOS U ON U.ID = A.FK_CLIENTE'
  +#13+'INNER JOIN SERVICOS S ON S.ID = A.FK_SERVICO'
  +#13+'WHERE A.DATA >= :DATA';

  if (pFiltraUsuario) then
    FQuery.SQL.Text := FQuery.SQL.Text + ' AND U.ID = ' + InttoStr(GUsuarioLogado.ID);

  FQuery.SQL.Text := FQuery.SQL.Text
  +#13+'ORDER BY A.DATA, A.HORA';

  Fquery.ParamByName('DATA').AsDate := Now;
  FQuery.Open;
end;

end.
