unit uCnsUsuario;

interface

uses FireDAC.Comp.Client, System.Classes, Data.DB;

type
  TCnsUsuario = class (TComponent)
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

{ TCnsUsuario }


constructor TCnsUsuario.Create(AOwner: TComponent);
begin
  inherited;
  FQuery := TFDQuery.Create(Self);
  FQuery.Connection := DMConexao.FDConnection;

  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FQuery;
end;

destructor TCnsUsuario.Destroy;
begin
  FQuery.Free;
  inherited;
end;

procedure TCnsUsuario.Pesquisar;
begin
  FQuery.SQL.Text := 'SELECT * FROM USUARIOS';
  FQuery.Open;
end;

end.
