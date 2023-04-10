unit Plantao.Views.Cadastro.Plantao;

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
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  Plantao.Models.Query,
  Data.DB;

type
  TPlantaoViewCadastroPlantao = class(TForm)
    pnContent: TPanel;
    edCadastroPlantao: TcxTextEdit;
    btnCadastrar: TcxButton;
    dsDados: TDataSource;
    Panel1: TPanel;
    btnClose: TcxButton;
    Label1: TLabel;
    Label2: TLabel;
    lbForm: TLabel;
    edData: TcxDateEdit;
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure edDataPropertiesChange(Sender: TObject);
  private
    FCadastroProduto : iQuery;
    FID : Integer;
    FData: TDateTime;

    function getEditando: Boolean;

    procedure MontarQuery;
    procedure CarregarDados;
  public
    property ID : Integer read FID write FID;
    property Editando: Boolean read getEditando;

  end;

var
  PlantaoViewCadastroPlantao: TPlantaoViewCadastroPlantao;

implementation

{$R *.dfm}



procedure TPlantaoViewCadastroPlantao.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TPlantaoViewCadastroPlantao.btnCadastrarClick(Sender: TObject);
var
  plantaoNome: string;
begin
  edData.ValidateEdit();
  edCadastroPlantao.ValidateEdit();

  plantaoNome := Trim(edCadastroPlantao.Text);
  if (plantaoNome = '') or (edData.Date = 0) then
  begin
    MessageDlg('Preencha todos os campos antes de cadastrar o plantão!', mtWarning, [mbOk], 0);
    Exit;
  end;
  begin
    try
      FCadastroProduto := TQuery
        .New
        .DataSource(dsDados)
        .SQL('INSERT INTO PLANTAO (DATA, NOME) VALUES (:DATA, :NOME)');

      FCadastroProduto
        .Parametro('DATA', edData.Date)
        .Parametro('NOME', edCadastroPlantao.Text);

      FCadastroProduto.Executar;
      MessageDlg('Plantão "' + plantaoNome + '" registrado com sucesso!', mtInformation, [mbOk], 0);
      Close;
    except
      on E: Exception do
        MessageDlg('Erro ao cadastrar plantão: ' + E.Message, mtError, [mbOk], 0);
    end;
  edCadastroPlantao.Clear;
  edData.Clear;
end;
end;

procedure TPlantaoViewCadastroPlantao.CarregarDados;
begin
  FCadastroProduto
    .Parametro('ID', ID)
    .Abrir;

  if Editando then
    FCadastroProduto.Editar
  else
    FCadastroProduto.Salvar;
end;

procedure TPlantaoViewCadastroPlantao.edDataPropertiesChange(Sender: TObject);
begin
  FData := Date();
end;

procedure TPlantaoViewCadastroPlantao.FormCreate(Sender: TObject);
begin
  inherited;
  MontarQuery;
end;

procedure TPlantaoViewCadastroPlantao.FormShow(Sender: TObject);
begin
  inherited;
  edData.Date := Date();
  CarregarDados;
end;

procedure TPlantaoViewCadastroPlantao.MontarQuery;
begin
  FCadastroProduto := TQuery
    .New
    .DataSource(dsDados)
    .SQL(' SELECT * FROM PLANTAO WHERE ID = :ID ');
end;

function TPlantaoViewCadastroPlantao.getEditando: Boolean;
begin
  Result := FID <> 0;
end;
end.
