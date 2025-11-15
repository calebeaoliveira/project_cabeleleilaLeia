unit uCnsServico;

interface

uses FireDAC.Comp.Client, System.Classes, Data.DB;

type
  TCnsServico = class (TComponent)
    private
      FQuery : TFDQuery;
      FDataSource : TDataSource;
    public
      property DS : TDataSource read FDataSource;
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure Pesquisar;
  end;

implementation

uses uDMConexao, uUsuario;

{ TCnsServico }


constructor TCnsServico.Create(AOwner: TComponent);
begin
  inherited;
  FQuery := TFDQuery.Create(Self);
  FQuery.Connection := DMConexao.FDConnection;

  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FQuery;
end;

destructor TCnsServico.Destroy;
begin
  FQuery.Free;
  inherited;
end;

procedure TCnsServico.Pesquisar;
begin
  FQuery.SQL.Text := 'SELECT * FROM SERVICOS';
  FQuery.Open;
end;

end.
