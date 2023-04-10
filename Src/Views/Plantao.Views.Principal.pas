unit Plantao.Views.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  Plantao.Views.Cadastro.Plantao,
  Plantao.Views.Editar.Plantao,
  dxGDIPlusClasses,
  Plantao.Models.Query,
  cxControls,
  cxStyles,
  cxCustomData,
  cxFilter, cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  Data.DB,
  cxDBData,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid, frxClass, frxDBSet, MemDS, DBAccess, Uni, frxDACComponents,
  frxUniDACComponents;

type
  TPlantaoPrincipal = class(TForm)
    pnHeader: TPanel;
    pnMenu: TPanel;
    pnContent: TPanel;
    pnClose: TPanel;
    btnClose: TcxButton;
    btnCadastroPlantao: TcxButton;
    Panel1: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dsConsultas: TDataSource;
    Label1: TLabel;
    btneditar: TcxButton;
    Plantao: TUniConnection;
    img: TImage;
    frxUniDACComponents1: TfrxUniDACComponents;
    btnImprimir: TcxButton;
    ReportPlantao: TfrxReport;
    procedure btnCloseClick(Sender: TObject);
    procedure btnCadastroPlantaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btneditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnImprimirClick(Sender: TObject);
  private
    FConsulta: iQuery;

    procedure MontarQuery;
    procedure Pesquisar;

    procedure MostrarForm(AID: Integer = 0);
  public
    { Public declarations }
  end;

var
  PlantaoPrincipal: TPlantaoPrincipal;

implementation

{$R *.dfm}

procedure TPlantaoPrincipal.btnCadastroPlantaoClick(Sender: TObject);
begin
  inherited;
  MostrarForm;
end;

procedure TPlantaoPrincipal.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPlantaoPrincipal.btneditarClick(Sender: TObject);
begin
  if not Assigned(PlantaoViewsEditarPlantao) then
    Application.CreateForm(TPlantaoViewsEditarPlantao, PlantaoViewsEditarPlantao);

  PlantaoViewsEditarPlantao.EditarP(dsConsultas.DataSet.FieldByName('ID').AsInteger);

  PlantaoViewsEditarPlantao.ShowModal;
  FreeAndNil(PlantaoViewsEditarPlantao);

  Pesquisar;
end;

procedure TPlantaoPrincipal.btnImprimirClick(Sender: TObject);
begin
  ReportPlantao.ShowReport;
end;

procedure TPlantaoPrincipal.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  if MessageDlg('Confirma a exclusão do registros.', mtConfirmation, mbYesNo, 0) = mrNo then
    Exit;

  TQuery
    .New
    .SQL('DELETE FROM PLANTAO WHERE ID = :ID')
    .Parametro('ID', FConsulta.Campo('ID').AsInteger)
    .Executar;

  Pesquisar;
end;

procedure TPlantaoPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  MontarQuery;
end;

procedure TPlantaoPrincipal.FormShow(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TPlantaoPrincipal.MontarQuery;
begin
  FConsulta := TQuery
    .New
    .DataSource(dsConsultas)
    .SQL('SELECT')
    .SQL('  P.ID,')
    .SQL('  P.NOME,')
    .SQL('  P.DATA')
    .SQL('FROM')
    .SQL('  PLANTAO P');
end;

procedure TPlantaoPrincipal.MostrarForm(AID: Integer = 0);
begin
  try
    if not Assigned(PlantaoViewCadastroPlantao) then
    Application.CreateForm(TPlantaoViewCadastroPlantao, PlantaoViewCadastroPlantao);

    PlantaoViewCadastroPlantao.ShowModal;

    Pesquisar;
  finally
    FreeAndNil(PlantaoViewCadastroPlantao);
  end;
end;

procedure TPlantaoPrincipal.Pesquisar;
begin
  FConsulta
    .Abrir;

  with cxGrid1DBTableView1 do
  begin
    ClearItems;
    DataController.CreateAllItems();
    ApplyBestFit();
  end;
end;
end.
