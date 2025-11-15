unit uSessao;

interface

uses uUsuario;

var
  GUsuarioLogado : TUsuario;

implementation

initialization
  GUsuarioLogado := nil;

finalization
   GUsuarioLogado.Free;

end.
