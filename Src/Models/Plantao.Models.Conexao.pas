unit Plantao.Models.Conexao;

interface

uses
  Vcl.Forms,
  System.SysUtils,
  Uni,
  InterBaseUniProvider;

type
  ConexaoErro = class(Exception);

  iConexao = interface
    ['{5A7C2F90-15F7-4ECD-85B5-725244390826}']
    function Conectar: iConexao;
    function Desconectar: iConexao;

    function Conexao: TUniConnection;
  end;

  TConexao = class(TInterfacedObject, iConexao)
  private
    FConexao: TUniConnection;
    FProvider: TInterBaseUniProvider;

    procedure CarregarConfigConexao;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iConexao;

    function Conectar: iConexao;
    function Desconectar: iConexao;
    function Conexao: TUniConnection;
  end;

var
  GConexao: iConexao;

implementation

{ TConexao }

procedure TConexao.CarregarConfigConexao;
begin
  with FConexao do
  begin
    ProviderName := 'Interbase';
    Username := 'SYSDBA';
    Password := 'masterkey';
    Server := '127.0.0.1';
    Database := 'C:\Projetos\Plantão\Dados\DADOS.FDB';
    Port := 3050;
    SpecificOptions.Values['Charset'] := 'UTF8';
    SpecificOptions.Values['ClientLibrary'] := 'fbclient.dll';
  end;
end;

function TConexao.Conectar: iConexao;
begin
  Result := Self;
  try
    CarregarConfigConexao;
    FConexao.Connect;
  except
    on e: Exception do
      raise ConexaoErro.Create('Falha ao conectar com banco de dados.' + #13 + e.Message);
  end;
end;

function TConexao.Conexao: TUniConnection;
begin
  Result := FConexao;
end;

constructor TConexao.Create;
begin
  FConexao := TUniConnection.Create(nil);
  FProvider := TInterBaseUniProvider.Create(nil);
end;

function TConexao.Desconectar: iConexao;
begin
  Result := Self;

  if FConexao.Connected then
    FConexao.Disconnect;
end;

destructor TConexao.Destroy;
begin
  FConexao.DisposeOf;
  FProvider.DisposeOf;
  inherited;
end;

class function TConexao.New: iConexao;
begin
  if not Assigned(GConexao) then
    GConexao := Self.Create;

  Result := GConexao;
end;

initialization
  TConexao.New.Conectar;

end.
