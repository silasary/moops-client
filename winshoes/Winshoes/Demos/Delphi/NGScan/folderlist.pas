unit FolderList;

interface

uses
  Classes, DBTables, ComCtrls;

type
  TObjectData = class(TPersistent)
  private
    FDataSet: TTable;
    FData: Pointer;
    FOnDataUpdate: TNotifyEvent;
    FModified: Boolean;
  protected
    function GetRefID : Integer; virtual;
  public
    constructor Create(RecID: Integer); virtual;
    procedure DataUpdate;
    procedure Load; virtual; abstract;
    procedure Save; virtual; abstract;
    property DataSet: TTable read FDataSet write FDataSet;
    property RefID: Integer read GetRefID;
    property Data: Pointer read FData write FData;
    property OnDataUpdate: TNotifyEvent read FOnDataUpdate write FOnDataUpdate;
    property Modified: Boolean read FModified write FModified;
  end;

  TFolderData = class(TObjectData)
  private
    FFolderID: Integer;
    FFolderDesc: string;
  protected
    function GetRefID : Integer; override;
    procedure PositionDataSet;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(RecID: Integer); override;
    procedure Load; override;
    procedure Save; override;
    property FolderID: Integer read FFolderID write FFolderID;
    property FolderDesc: string read FFolderDesc write FFolderDesc;
  end;

  THostData = class(TObjectData)
  private
    FHostID: Integer;
    FHostName: string;
    FHostDesc: string;
    FFolderID: Integer;
    FFullName: string;
    FOrganization: string;
    FEmail: string;
    FReply: string;
    FIncludeDuringScan: Boolean;
    FPort: Integer;
    FLoginRequired: Boolean;
    FUserID: string;
    FPassword: string;
  protected
    function GetRefID : Integer; override;
    procedure PositionDataSet;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(RecID: Integer); override;
    procedure Load; override;
    procedure Save; override;
    property HostID: Integer read FHostID write FHostID;
    property HostName: string read FHostName write FHostName;
    property HostDesc: string read FHostDesc write FHostDesc;
    property FolderID: Integer read FFolderID write FFolderID;
    property FullName: string read FFullName write FFullName;
    property Organization: string read FOrganization write FOrganization;
    property Email: string read FEmail write FEmail;
    property Reply: string read FReply write FReply;
    property IncludeDuringScan: Boolean read FIncludeDuringScan write FIncludeDuringScan;
    property Port: Integer read FPort write FPort;
    property LoginRequired: Boolean read FLoginRequired write FLoginRequired;
    property UserID: string read FUserID write FUserID;
    property Password: string read FPassword write FPassword;
  end;

  TNewsgroupData = class(TObjectData)
  private
    FNewsgroupID: Integer;
    FNewsgroupName: string;
    FNewsgroupDesc: string;
    FHostID: Integer;
    FSubscribed: Boolean;
    FHiMsg: Integer;
    FList: TStringList;
  protected
    function GetRefID : Integer; override;
    procedure PositionDataSet;
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(RecID: Integer); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure Save; override;
    property NewsgroupID: Integer read FNewsgroupID write FNewsgroupID;
    property NewsgroupName: string read FNewsgroupName write FNewsgroupName;
    property NewsgroupDesc: string read FNewsgroupDesc write FNewsgroupDesc;
    property HostID: Integer read FHostID write FHostID;
    property Subscribed: Boolean read FSubscribed write FSubscribed;
    property HiMsg: Integer read FHiMsg write FHiMsg;
    property List: TStringList read FList write FList;
  end;

  TObjectDataClass = class of TObjectData;

implementation

uses
  MainForm, Datamodule, SysUtils;

constructor TObjectData.Create(RecID: Integer);
begin
  inherited Create;
  Load;
end;

function TObjectData.GetRefID : Integer;
begin
  Result := 0;
end;

procedure TObjectData.DataUpdate;
begin
  if Assigned(FOnDataUpdate) then
    FOnDataUpdate(Self);
end;

{=====================================================}

constructor TFolderData.Create(RecID: Integer);
begin
  FolderID := RecID;
  DataSet := dataMain.tablFolders;
  inherited Create(RecID);
end;

function TFolderData.GetRefID : Integer;
begin
  Result := FolderID;
end;

procedure TFolderData.PositionDataSet;
begin
  if not DataSet.FindKey([FolderID]) then
    raise Exception.Create('Unable to locate FolderID: '+IntToStr(FolderID));
end;

procedure TFolderData.Load;
begin
  PositionDataSet;
  with dataMain do begin
    FolderID   := tablFoldersFolder_ID.Value;
    FolderDesc := tablFoldersFolder_Desc.Value;
  end;
  DataUpdate;
end;

procedure TFolderData.Save;
begin
  PositionDataSet;
  with dataMain do begin
    DataSet.Edit;
    tablFoldersFolder_ID.Value   := FolderID;
    tablFoldersFolder_Desc.Value := FolderDesc;
    DataSet.Post;
  end;
end;

procedure TFolderData.AssignTo(Dest: TPersistent);
var
  Item: TFolderData;
begin
  if not (Dest is TFolderData) then
    inherited AssignTo(Dest)
  else begin
    Item := Dest as TFolderData;
    Item.DataSet    := DataSet;
    Item.FolderID   := FolderID;
    Item.FolderDesc := FolderDesc;
  end;
end;

{===================================================================}

constructor THostData.Create(RecID: Integer);
begin
  HostID := RecID;
  DataSet := dataMain.tablHosts;
  inherited Create(RecID);
end;

function THostData.GetRefID : Integer;
begin
  Result := HostID;
end;

procedure THostData.PositionDataSet;
begin
  if not DataSet.FindKey([HostID]) then
    raise Exception.Create('Unable to locate HostID: '+IntToStr(HostID));
end;

procedure THostData.Load;
begin
  PositionDataSet;
  with dataMain do begin
    HostID        := tablHostsHost_ID.Value;
    HostName      := tablHostsHost_Name.Value;
    HostDesc      := tablHostsHost_Desc.Value;
    FolderID      := tablHostsFolder_ID.Value;
    FullName      := tablHostsFull_Name.Value;
    Organization  := tablHostsOrganization.Value;
    Email         := tablHostsEmail.Value;
    Reply         := tablHostsReply.Value;
    IncludeDuringScan := tablHostsInclude_During_Scan.Value;
    Port          := tablHostsPort.Value;
    LoginRequired := tablHostsLogin_Required.Value;
    UserID        := tablHostsUser_ID.Value;
    Password      := tablHostsPassword.Value;
  end;
  DataUpdate;
end;

procedure THostData.Save;
begin
  PositionDataSet;
  with dataMain do begin
    DataSet.Edit;
    tablHostsHost_ID.Value        := HostID;
    tablHostsHost_Name.Value      := HostName;
    tablHostsHost_Desc.Value      := HostDesc;
    tablHostsFolder_ID.Value      := FolderID;
    tablHostsFull_Name.Value      := FullName;
    tablHostsOrganization.Value   := Organization;
    tablHostsEmail.Value          := Email;
    tablHostsReply.Value          := Reply;
    tablHostsInclude_During_Scan.Value := IncludeDuringScan;
    tablHostsPort.Value           := Port;
    tablHostsLogin_Required.Value := LoginRequired;
    tablHostsUser_ID.Value        := UserID;
    tablHostsPassword.Value       := Password;
    DataSet.Post;
  end;
end;

procedure THostData.AssignTo(Dest: TPersistent);
var
  Item: THostData;
begin
  if not (Dest is THostData) then
    inherited AssignTo(Dest)
  else begin
    Item := Dest as THostData;
    Item.DataSet       := DataSet;
    Item.HostID        := HostID;
    Item.HostName      := HostName;
    Item.HostDesc      := HostDesc;
    Item.FolderID      := FolderID;
    Item.FullName      := FullName;
    Item.Organization  := Organization;
    Item.Email         := Email;
    Item.Reply         := Reply;
    Item.IncludeDuringScan := IncludeDuringScan;
    Item.Port          := Port;
    Item.LoginRequired := LoginRequired;
    Item.UserID        := UserID;
    Item.Password      := Password;
  end;
end;

{===================================================================}

constructor TNewsgroupData.Create(RecID: Integer);
begin
  NewsgroupID := RecID;
  DataSet := dataMain.tablNewsgroups;
  inherited Create(RecID);
  FList := TStringList.Create;
end;

destructor TNewsgroupData.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TNewsgroupData.GetRefID : Integer;
begin
  Result := NewsgroupID;
end;

procedure TNewsgroupData.PositionDataSet;
begin
  if not DataSet.FindKey([NewsgroupID]) then
    raise Exception.Create('Unable to locate NewsgroupID: '+IntToStr(NewsgroupID));
end;

procedure TNewsgroupData.Load;
begin
  PositionDataSet;
  with dataMain do begin
    NewsgroupID   := tablNewsgroupsNewsgroup_ID.Value;
    NewsgroupName := tablNewsgroupsNewsgroup_Name.Value;
    NewsgroupDesc := tablNewsgroupsNewsgroup_Desc.Value;
    HostID        := tablNewsgroupsHost_ID.Value;
    Subscribed    := tablNewsgroupsSubscribed.Value;
    HiMsg         := tablNewsgroupsMsg_High.Value;
  end;
  DataUpdate;
end;

procedure TNewsgroupData.Save;
begin
  PositionDataSet;
  with dataMain do begin
    DataSet.Edit;
    tablNewsgroupsNewsgroup_ID.Value   := NewsgroupID;
    tablNewsgroupsNewsgroup_Name.Value := NewsgroupName;
    tablNewsgroupsNewsgroup_Desc.Value := NewsgroupDesc;
    tablNewsgroupsHost_ID.Value        := HostID;
    tablNewsgroupsSubscribed.Value     := Subscribed;
    tablNewsgroupsMsg_High.Value       := HiMsg;
    DataSet.Post;
  end;
end;

procedure TNewsgroupData.AssignTo(Dest: TPersistent);
var
  Item: TNewsgroupData;
begin
  if not (Dest is TNewsgroupData) then
    inherited AssignTo(Dest)
  else begin
    Item := Dest as TNewsgroupData;
    Item.DataSet       := DataSet;
    Item.NewsgroupID   := NewsgroupID;
    Item.NewsgroupName := NewsgroupName;
    Item.NewsgroupDesc := NewsgroupDesc;
    Item.HostID        := HostID;
    Item.Subscribed    := Subscribed;
    Item.HiMsg         := HiMsg;
    Item.List.Assign(List);
  end;
end;

end.
