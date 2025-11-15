unit uCadServico;

interface

uses FireDAC.Comp.Client, System.Classes, Data.DB;

type
  TCadServico = class (TComponent)
    private
      FDataSet : TFDTable;
      FDataSource : TDataSource;
    public
      property DS : TDataSource read FDataSource;
      property DataSet : TFDTable read FDataSet write FDataSet;
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure Abrir(pID : Integer);
  end;

implementation

uses uDMConexao, uUsuario, SysUtils;

{ TCadServico }


procedure TCadServico.Abrir(pID: Integer);
begin
  FDataSet.Open;
  FDataSet.Filter := 'ID = '+InttoStr(pID);
  FDataSet.Filtered := True;
end;

constructor TCadServico.Create(AOwner: TComponent);
begin
  inherited;
  FDataSet := TFDTable.Create(Self);
  FDataSet.Connection := DMConexao.FDConnection;

  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FDataSet;

  FDataSet.TableName := 'SERVICOS';

  Abrir(0);
end;

destructor TCadServico.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

end.
