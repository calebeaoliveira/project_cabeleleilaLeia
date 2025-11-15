unit uUsuario;

interface

type
  TTipoUsuario = (
    tuAdmin,
    tuCliente
  );

  TUsuario = class
    private
      FID : Integer;
      FNome : String;
      FLogin : String;
      FSenha : String;
      FTipo : TTipoUsuario;
    public
      property ID     : Integer       read FID    write FID;
      property Nome   : String        read FNome  write FNome;
      property Login  : String        read FLogin write FLogin;
      property Senha  : String        read FSenha write FSenha;
      property Tipo   : TTipoUsuario  read FTipo  write FTipo;
  end;

implementation

end.
