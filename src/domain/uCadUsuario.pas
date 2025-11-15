unit uCadUsuario;

interface

uses FireDAC.Comp.Client, System.Classes, Data.DB;

type
  TCadUsuario = class (TComponent)
    private
      FDataSet : TFDTable;
      FDataSource : TDataSource;
      procedure FieldGetText (Sender: TField; var Text: string; DisplayText: Boolean);
      procedure FieldSetText(Sender: TField; const Text: string);
    public
      property DS : TDataSource read FDataSource;
      property DataSet : TFDTable read FDataSet write FDataSet;
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure Abrir(pID : Integer);
  end;

implementation

uses uDMConexao, uUsuario, SysUtils;

{ TCnsUsuario }


procedure TCadUsuario.Abrir(pID: Integer);
begin
  FDataSet.Open;
  FDataSet.Filter := 'ID = '+InttoStr(pID);
  FDataSet.Filtered := True;
end;

constructor TCadUsuario.Create(AOwner: TComponent);
begin
  inherited;
  FDataSet := TFDTable.Create(Self);
  FDataSet.Connection := DMConexao.FDConnection;

  FDataSource := TDataSource.Create(Self);
  FDataSource.DataSet := FDataSet;

  FDataSet.TableName := 'USUARIOS';

  Abrir(0);
  FDataSet.FieldByName('TIPO').OnGetText := FieldGetText;
  FDataSet.FieldByName('TIPO').OnSetText := FieldSetText;
end;

destructor TCadUsuario.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

procedure TCadUsuario.FieldGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.AsInteger = ord(tuAdmin) then
    Text := 'True'
  else
    Text := 'False';
end;

procedure TCadUsuario.FieldSetText(Sender: TField; const Text: string);
begin
   if SameText(Text, 'True') then
    Sender.AsInteger := Ord(tuAdmin)
  else
    Sender.AsInteger := Ord(tuCliente);
end;

end.
