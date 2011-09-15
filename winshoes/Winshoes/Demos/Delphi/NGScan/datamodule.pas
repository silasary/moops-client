unit Datamodule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Menus;

type
  TdataMain = class(TDataModule)
    tablAuthor: TTable;
    tablAuthorAuthor_ID: TAutoIncField;
    tablAuthorAuthor_Name: TStringField;
    tablArticle: TTable;
    tablArticleArticle_ID: TAutoIncField;
    tablArticleArticle_No: TIntegerField;
    tablArticleAuthor_ID: TIntegerField;
    tablArticleArticle_Date: TDateField;
    tablArticleNewsgroup_ID: TIntegerField;
    qeryArticleCountByAuthor: TQuery;
    qeryTotalMessages: TQuery;
    qeryTotalMessagesArticle_Count: TIntegerField;
    qeryArticleCountByAuthorArticle_Count: TIntegerField;
    qeryArticleCountByAuthorAuthor_Name: TStringField;
    tablNewsgroups: TTable;
    tablFolders: TTable;
    tablHosts: TTable;
    tablFoldersFolder_ID: TAutoIncField;
    tablFoldersFolder_Desc: TStringField;
    tablNewsgroupsNewsgroup_ID: TAutoIncField;
    tablNewsgroupsNewsgroup_Name: TStringField;
    tablNewsgroupsNewsgroup_Desc: TStringField;
    tablNewsgroupsHost_ID: TIntegerField;
    tablNewsgroupsSubscribed: TBooleanField;
    tablNewsgroupsMsg_High: TIntegerField;
    tablHostsHost_ID: TAutoIncField;
    tablHostsHost_Name: TStringField;
    tablHostsHost_Desc: TStringField;
    tablHostsFolder_ID: TIntegerField;
    tablHostsFull_Name: TStringField;
    tablHostsOrganization: TStringField;
    tablHostsEmail: TStringField;
    tablHostsReply: TStringField;
    tablHostsInclude_During_Scan: TBooleanField;
    tablHostsPort: TIntegerField;
    tablHostsLogin_Required: TBooleanField;
    tablHostsUser_ID: TStringField;
    tablHostsPassword: TStringField;
    tablAuthorReply_To: TStringField;
    qeryArticleCountByAuthorReply_To: TStringField;
    tablArticleHost_ID: TIntegerField;
  private
    FDatabasePath: string;
  public
    constructor Create(AOwner: TComponent); override;
    function SelectQuery(const SQL: string) : TQuery;
    procedure DeleteHost(HostID: Integer);
    property DatabasePath: string read FDatabasePath write FDatabasePath;
  end;

var
  dataMain: TdataMain;

implementation

{$R *.DFM}

uses
  FileCtrl;

constructor TdataMain.Create(AOwner: TComponent);
var
  X: Integer;
begin
  inherited Create(AOwner);
  DatabasePath := ExtractFilePath(Application.EXEName) + 'Data\';
  ForceDirectories(DatabasePath);
  for X := 0 to Pred(ComponentCount) do begin
    if Components[X] is TDBDataset then
      TDBDataset(Components[X]).Databasename := DatabasePath;
  end;

  {-Create tables if they don't exist}
  for X := 0 to Pred(ComponentCount) do begin
    if Components[X] is TTable then begin
      with TTable(Components[X]) do begin
        if not FileExists(DatabaseName + TableName) then begin
          CreateTable;
          if CompareText(TableName, 'Folders.db') = 0 then begin
            Open;
            try
              Append;
              Fields[1].AsString := 'NGScan';
              Post;
            finally
              Close;
            end;
          end;
        end;
      end;
    end;
  end;

  tablNewsgroups.Open;
  tablFolders.Open;
  tablHosts.Open;
end;

function TdataMain.SelectQuery(const SQL: string) : TQuery;
begin
  Result := TQuery.Create(nil);
  Result.DatabaseName := DatabasePath;
  Result.SQL.Text := SQL;
end;

procedure TdataMain.DeleteHost(HostID: Integer);
begin
  with SelectQuery('') do begin
    try
      {-Delete associated articles}
      SQL.Add('DELETE FROM Article');
      SQL.Add('WHERE Host_ID=' + IntToStr(HostID));
      ExecSQL;

      {-Delete hosts associated newsgroups}
      SQL.Clear;
      SQL.Add('DELETE FROM Newsgroups');
      SQL.Add('WHERE Host_ID=' + IntToStr(HostID));
      ExecSQL;

      {-Delete host}
      SQL.Clear;
      SQL.Add('DELETE FROM Hosts');
      SQL.Add('WHERE Host_ID=' + IntToStr(HostID));
      ExecSQL;
    finally
      Free;
    end;
  end;
end;

end.



 