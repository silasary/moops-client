�
 TDATAMAIN 0  TPF0	TdataMaindataMainOldCreateOrder	Left�Top� Height� WidthK TTable
tablAuthorDatabaseName*W:\source\Kudzu\Winshoes\Demos\ngscan\Data	FieldDefsName	Author_ID
Attributes
faReadonly DataType	ftAutoInc NameAuthor_Name
Attributes
faRequired DataTypeftStringSized NameReply_ToDataTypeftStringSized  	IndexDefsNametablAuthorIndex1Fields	Author_IDOptions	ixPrimaryixUnique  NameIX_NameFieldsAuthor_NameOptionsixUniqueixCaseInsensitive   	IndexNameIX_Name	StoreDefs		TableName	Author.dbLeft� TopH TAutoIncFieldtablAuthorAuthor_ID	FieldName	Author_IDReadOnly	  TStringFieldtablAuthorAuthor_Name	FieldNameAuthor_NameRequired	Sized  TStringFieldtablAuthorReply_To	FieldNameReply_ToSized   TTabletablArticleDatabaseName*W:\source\Kudzu\Winshoes\Demos\ngscan\Data	FieldDefsName
Article_ID
Attributes
faReadonly DataType	ftAutoInc Name
Article_No
Attributes
faRequired DataType	ftInteger Name	Author_ID
Attributes
faRequired DataType	ftInteger NameArticle_Date
Attributes
faRequired DataTypeftDate NameHost_ID
Attributes
faRequired DataType	ftInteger NameNewsgroup_ID
Attributes
faRequired DataType	ftInteger  	StoreDefs		TableName
Article.dbLeft� Top TAutoIncFieldtablArticleArticle_ID	FieldName
Article_IDReadOnly	  TIntegerFieldtablArticleArticle_No	FieldName
Article_NoRequired	  TIntegerFieldtablArticleAuthor_ID	FieldName	Author_IDRequired	  
TDateFieldtablArticleArticle_Date	FieldNameArticle_DateRequired	  TIntegerFieldtablArticleHost_ID	FieldNameHost_ID  TIntegerFieldtablArticleNewsgroup_ID	FieldNameNewsgroup_IDRequired	   TQueryqeryArticleCountByAuthorDatabaseName*W:\source\Kudzu\Winshoes\Demos\ngscan\DataSQL.Strings>SELECT count(Article_ID) Article_Count, Author_Name, Reply_To FROM  Article Art, Author A #WHERE  Art.Author_ID = A.Author_ID ' and  Art.Newsgroup_ID = :Newsgroup_ID ! and Article_Date >= :Date_Begin  and Article_Date <= :Date_End  GROUP BY  Author_Name, Reply_To ORDER BY  1 Desc Left� Top	ParamDataDataType	ftUnknownNameNewsgroup_ID	ParamType	ptUnknown DataType	ftUnknownName
Date_Begin	ParamType	ptUnknown DataType	ftUnknownNameDate_End	ParamType	ptUnknown   TIntegerField%qeryArticleCountByAuthorArticle_Count	FieldNameArticle_Count  TStringField#qeryArticleCountByAuthorAuthor_Name	FieldNameAuthor_NameSized  TStringField qeryArticleCountByAuthorReply_To	FieldNameReply_ToSized   TQueryqeryTotalMessagesDatabaseName*W:\source\Kudzu\Winshoes\Demos\ngscan\DataSQL.Strings'SELECT count(Article_ID) Article_Count FROM  Article "WHERE Article_Date >= :Date_Begin  and Article_Date <= :Date_End " and Newsgroup_ID = :Newsgroup_ID  Left� TopH	ParamDataDataType	ftUnknownName
Date_Begin	ParamType	ptUnknown DataType	ftUnknownNameDate_End	ParamType	ptUnknown DataType	ftUnknownNameNewsgroup_ID	ParamType	ptUnknown   TIntegerFieldqeryTotalMessagesArticle_Count	FieldNameArticle_Count   TTabletablNewsgroupsDatabaseName*W:\source\Kudzu\Winshoes\demos\ngscan\Data	FieldDefsNameNewsgroup_ID
Attributes
faReadonly DataType	ftAutoInc NameNewsgroup_Name
Attributes
faRequired DataTypeftStringSized NameNewsgroup_DescDataTypeftStringSized NameHost_IDDataType	ftInteger Name
SubscribedDataType	ftBoolean NameMsg_HighDataType	ftInteger  	IndexDefsNametablNewsgroupsIndex1FieldsNewsgroup_IDOptions	ixPrimaryixUnique  NameIX_HostNewsgroupFieldsHost_ID;Newsgroup_NameOptionsixUniqueixCaseInsensitive   	StoreDefs		TableNameNewsgroups.dbLeft Top�  TAutoIncFieldtablNewsgroupsNewsgroup_ID	FieldNameNewsgroup_ID  TStringFieldtablNewsgroupsNewsgroup_Name	FieldNameNewsgroup_NameRequired	Sized  TStringFieldtablNewsgroupsNewsgroup_Desc	FieldNameNewsgroup_DescSized  TIntegerFieldtablNewsgroupsHost_ID	FieldNameHost_ID  TBooleanFieldtablNewsgroupsSubscribed	FieldName
Subscribed  TIntegerFieldtablNewsgroupsMsg_High	FieldNameMsg_High   TTabletablFoldersDatabaseName+w:\source\kudzu\winshoes\demos\ngscan\data\	FieldDefsName	Folder_ID
Attributes
faReadonly DataType	ftAutoInc NameFolder_DescDataTypeftStringSized  	IndexDefsNametablFoldersIndex1Fields	Folder_IDOptions	ixPrimaryixUnique   	StoreDefs		TableName
Folders.dbLeft Top TAutoIncFieldtablFoldersFolder_ID	FieldName	Folder_ID  TStringFieldtablFoldersFolder_Desc	FieldNameFolder_DescSized   TTable	tablHostsDatabaseName+w:\source\kudzu\winshoes\demos\ngscan\data\	FieldDefsNameHost_ID
Attributes
faReadonly DataType	ftAutoInc Name	Host_NameDataTypeftStringSized Name	Host_DescDataTypeftStringSized Name	Folder_IDDataType	ftInteger Name	Full_NameDataTypeftStringSize2 NameOrganizationDataTypeftStringSized NameEmailDataTypeftStringSized NameReplyDataTypeftStringSized NameInclude_During_ScanDataType	ftBoolean NamePortDataType	ftInteger NameTime_OutDataType	ftInteger NameLogin_RequiredDataType	ftBoolean NameUser_IDDataTypeftStringSized NamePasswordDataTypeftStringSize  	IndexDefsNametablHostsIndex1FieldsHost_IDOptions	ixPrimaryixUnique   	StoreDefs		TableNameHosts.dbLeft TopH TAutoIncFieldtablHostsHost_ID	FieldNameHost_ID  TStringFieldtablHostsHost_Name	FieldName	Host_NameSized  TStringFieldtablHostsHost_Desc	FieldName	Host_DescSized  TIntegerFieldtablHostsFolder_ID	FieldName	Folder_ID  TStringFieldtablHostsFull_Name	FieldName	Full_NameSize2  TStringFieldtablHostsOrganization	FieldNameOrganizationSized  TStringFieldtablHostsEmail	FieldNameEmailSized  TStringFieldtablHostsReply	FieldNameReplySized  TBooleanFieldtablHostsInclude_During_Scan	FieldNameInclude_During_Scan  TIntegerFieldtablHostsPort	FieldNamePort  TBooleanFieldtablHostsLogin_Required	FieldNameLogin_Required  TStringFieldtablHostsUser_ID	FieldNameUser_IDSized  TStringFieldtablHostsPassword	FieldNamePasswordSize    