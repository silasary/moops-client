program NGScan;

uses
  Forms,
  Datamodule in 'Datamodule.pas' {dataMain: TdataDemo},
  AboutForm in '..\AboutForm.pas' {formAbout},
  DemoUtils in '..\DemoUtils.pas',
  RootProp in 'RootProp.pas' {formRootProp},
  RootMainForm in '..\RootMainForm.pas' {formRootMain},
  HostsForm in 'HostsForm.pas' {formHosts},
  ListingForm in 'ListingForm.pas' {formListing},
  MainForm in 'MainForm.pas' {formMain},
  NewsgroupsForm in 'NewsgroupsForm.pas' {formNewsgroups},
  MsgRetrieveForm in 'MsgRetrieveForm.pas' {formMsgRetrieve},
  MsgSendForm in 'MsgSendForm.pas' {formMsgSend},
  SubscriptionsForm in 'SubscriptionsForm.pas' {formSubscriptions},
  TopTenForm in 'TopTenForm.pas' {formTopTen};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdataMain, dataMain);
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
