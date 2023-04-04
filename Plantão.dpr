program Plantão;

uses
  Vcl.Forms,
  Plantao.Views.Principal in 'Src\Views\Plantao.Views.Principal.pas' {PlantaoPrincipal},
  Plantao.Models.Conexao in 'Src\Models\Plantao.Models.Conexao.pas',
  Plantao.Models.Query in 'Src\Models\Plantao.Models.Query.pas',
  Plantao.Views.Cadastro.Plantao in 'Src\Views\Plantao.Views.Cadastro.Plantao.pas' {PlantaoViewCadastroPlantao},
  Plantao.Views.Editar.Plantao in 'Src\Views\Plantao.Views.Editar.Plantao.pas' {PlantaoViewsEditarPlantao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPlantaoPrincipal, PlantaoPrincipal);
  Application.CreateForm(TPlantaoViewCadastroPlantao, PlantaoViewCadastroPlantao);
  Application.CreateForm(TPlantaoViewsEditarPlantao, PlantaoViewsEditarPlantao);
  Application.Run;
end.
