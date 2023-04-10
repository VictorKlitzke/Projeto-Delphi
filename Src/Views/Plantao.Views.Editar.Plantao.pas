unit Plantao.Views.Editar.Plantao;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls, cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer, cxEdit,
  Vcl.Menus,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  Vcl.StdCtrls,
  cxButtons,
  cxTextEdit,
  Vcl.ExtCtrls,
  Plantao.Models.Query,
  Data.DB, cxDBEdit;

type
  TPlantaoViewsEditarPlantao = class(TForm)
    pnContent: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    btnEditar: TcxButton;
    Panel1: TPanel;
    lbForm: TLabel;
    btnClose: TcxButton;
    edNome: TcxDBTextEdit;
    edData: TcxDBDateEdit;
    dsEditar: TDataSource;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
  private
    FEditar: iQuery;
  public
    function EditarP(UID: Integer): Integer;
  end;

var
  PlantaoViewsEditarPlantao: TPlantaoViewsEditarPlantao;

implementation

{$R *.dfm}

procedure TPlantaoViewsEditarPlantao.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPlantaoViewsEditarPlantao.btnEditarClick(Sender: TObject);
begin
  edData.ValidateEdit();
  edNome.ValidateEdit();

  FEditar.Editar;
  ModalResult := mrOk;
end;

function TPlantaoViewsEditarPlantao.EditarP(UID: Integer): Integer;
begin
  if not FEditar.DataSet.Active then
    FEditar.DataSet.Open;

  FEditar.Editar.Campo('ID', UID).Abrir;
end;

procedure TPlantaoViewsEditarPlantao.FormCreate(Sender: TObject);
begin
  FEditar := TQuery.New.DataSource(dsEditar);
end;

end.
