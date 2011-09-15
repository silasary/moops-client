program SimpleNNTPClient;

uses
  Forms,
  frmMainUnit in 'frmMainUnit.pas' {frmMain},
  frmPropertiesUnit in 'frmPropertiesUnit.pas' {frmProperties},
  frmArticleUnit in 'frmArticleUnit.pas' {frmArticle};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmProperties, frmProperties);
  Application.CreateForm(TfrmArticle, frmArticle);
  with frmProperties do
    if (Server = '') or (Port = 0) then
      ShowModal;

  Application.Run;
end.
