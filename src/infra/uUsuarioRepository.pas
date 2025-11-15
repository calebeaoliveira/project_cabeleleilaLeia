unit uUsuarioRepository;

interface

uses
  uUsuario, FireDAC.Comp.Client, Data.DB;

type
  TUsuarioRepository = class
  public
    class function BuscarPorLogin(const pLogin, pSenha: string; pConn: TFDConnection): TUsuario;
  end;

implementation

uses
  System.SysUtils;

{ TUsuarioRepository }

class function TUsuarioRepository.BuscarPorLogin(const pLogin, pSenha: string;
  pConn: TFDConnection): TUsuario;
var
  vQuery: TFDQuery;
begin
  Result := nil;
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := pConn;
    vQuery.SQL.Text :=
      'SELECT ID, NOME, LOGIN, SENHA, TIPO ' +
      'FROM USUARIOS ' +
      'WHERE LOGIN = :LOGIN AND SENHA = :SENHA';
    vQuery.ParamByName('LOGIN').AsString := pLogin;
    vQuery.ParamByName('SENHA').AsString := pSenha;
    vQuery.Open;
    if not vQuery.IsEmpty then
    begin
      Result := TUsuario.Create;
      Result.Id    := vQuery.FieldByName('ID').AsInteger;
      Result.Nome  := vQuery.FieldByName('NOME').AsString;
      Result.Login := vQuery.FieldByName('LOGIN').AsString;
      Result.Tipo := TTipoUsuario(vQuery.FieldByName('TIPO').AsInteger);
    end;
  finally
    vQuery.Free;
  end;
end;

end.
