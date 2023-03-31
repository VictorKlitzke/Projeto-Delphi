program Plantão;

uses
  Vcl.Forms,
  Plantao.Views.Principal in 'Src\Views\Plantao.Views.Principal.pas' {PlantaoPrincipal},
  Plantao.Models.Conexao in 'Src\Models\Plantao.Models.Conexao.pas',
  Plantao.Models.Query in 'Src\Models\Plantao.Models.Query.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPlantaoPrincipal, PlantaoPrincipal);
  Application.Run;
end.
