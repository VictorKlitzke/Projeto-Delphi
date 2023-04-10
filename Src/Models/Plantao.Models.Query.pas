unit Plantao.Models.Query;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Uni,
  Plantao.Models.Conexao;

type
  QueryErroEdicao = class(Exception);

  iQuery = interface
    ['{BB764DDB-BCBE-4C1F-8B4F-5A949D243778}']

    function DataSource(var ADataSource: TDataSource): iQuery;
    function DataSet: TDataSet;
    function Abrir: iQuery;
    function Fechar: iQuery;

    function Adicionar: iQuery;
    function Editar: iQuery;
    function Apagar: iQuery;
    function Salvar: iQuery;
    function Cancelar: iQuery;
    function Executar: iQuery;

    function SQL(AValue: string): iQuery;
    function Parametro(AKey: string; AValue: Variant): iQuery;

    function Campo(AField: string): TField; overload;
    function Campo(AField: string; AValue: Variant): iQuery; overload;

    function PosicaoSalvar: iQuery;
    function PosicaoVoltar: iQuery;
  end;

  TQuery = class(TInterfacedObject, iQuery)
  private
    FConexao: iConexao;
    FQuery: TUniQuery;

    FBookMark: TBookmark;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iQuery;

    function DataSource(var ADataSource: TDataSource): iQuery;
    function DataSet: TDataSet;
    function Abrir: iQuery;
    function Fechar: iQuery;

    function Adicionar: iQuery;
    function Editar: iQuery;
    function Apagar: iQuery;
    function Salvar: iQuery;
    function Cancelar: iQuery;
    function Executar: iQuery;

    function SQL(AValue: string): iQuery;
    function Parametro(AKey: string; AValue: Variant): iQuery;

    function Campo(AField: string): TField; overload;
    function Campo(AField: string; AValue: Variant): iQuery; overload;

    function PosicaoSalvar: iQuery;
    function PosicaoVoltar: iQuery;
  end;

implementation

{ TQuery }

function TQuery.Abrir: iQuery;
begin
  Result := Self;

  if FQuery.SQL.Text = 'ID' then
    raise QueryErroEdicao.Create('Não é possível abrir uma query sem instrução SQL');

  if FQuery.Active then
    FQuery.Close;

  FQuery.Open;
end;

function TQuery.Adicionar: iQuery;
begin
  Result := Self;

  if not FQuery.Active then
    FQuery.Open;

  FQuery.Insert;
end;

function TQuery.Apagar: iQuery;
begin
 Result := Self;

  FQuery.Delete;

  if FQuery.CachedUpdates then
    FQuery.ApplyUpdates();
end;

function TQuery.Campo(AField: string; AValue: Variant): iQuery;
begin
  Result := Self;
  if not (FQuery.State in [dsEdit, dsInsert]) then
    raise QueryErroEdicao.Create('Não é possivel editar um campo se a query não estiver em edição');

  FQuery.FieldByName(AField).Value := AValue;
end;

function TQuery.Campo(AField: string): TField;
begin
  Result := FQuery.FieldByName(AField);
end;

function TQuery.Cancelar: iQuery;
begin
  Result := Self;
  FQuery.Cancel;
end;

constructor TQuery.Create;
begin
FConexao := TConexao.New;

  FQuery := TUniQuery.Create(nil);
  FQuery.Connection := FConexao.Conexao;
  FQuery.CachedUpdates := True;
  FQuery.DMLRefresh := True;
  FQuery.SpecificOptions.Values['FetchAll'] := 'False';
  FQuery.FetchRows := 50;
end;

function TQuery.DataSet: TDataSet;
begin
  Result := FQuery;
end;

function TQuery.DataSource(var ADataSource: TDataSource): iQuery;
begin
  Result := Self;
  ADataSource.DataSet := FQuery;
end;

destructor TQuery.Destroy;
begin
  FQuery.DisposeOf;
  inherited;
end;

function TQuery.Editar: iQuery;
begin
  Result := Self;
  FQuery.Edit;
end;

function TQuery.Executar: iQuery;
begin
  Result := Self;
  FQuery.ExecSQL;
end;

function TQuery.Fechar: iQuery;
begin
  Result := Self;
  FQuery.Close;
end;

class function TQuery.New: iQuery;
begin
  Result := Self.Create;
end;

function TQuery.Parametro(AKey: string; AValue: Variant): iQuery;
begin
  Result := Self;
  FQuery.ParamByName(AKey).Value := AValue;
end;

function TQuery.PosicaoSalvar: iQuery;
begin
  Result := Self;

  if FQuery.RecordCount > 0 then
    FBookMark := FQuery.GetBookmark;
end;

function TQuery.PosicaoVoltar: iQuery;
begin
  Result := Self;

  if FQuery.BookmarkValid(FBookMark) then
  begin
    FQuery.GotoBookmark(FBookMark);
    FQuery.FreeBookmark(FBookMark);
  end;
end;

function TQuery.Salvar: iQuery;
begin
  Result := Self;

  if FQuery.State in dsEditModes then
    FQuery.Post;

  if FQuery.CachedUpdates then
    FQuery.ApplyUpdates();
end;

function TQuery.SQL(AValue: string): iQuery;
begin
  Result := Self;
  FQuery.SQL.Add(AValue);
end;

end.
