unit MoopsHelp;

interface

uses
  ClientPage;

procedure ShowHelp(CP: TNetClientPage);
procedure ShowDefaultHelp(CP: TNetClientPage);

implementation

uses
  SysUtils, BeChatView, UpdateCheck;

procedure ShowDefaultHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CP.AddToChat(DoColor(cvYellow,cvRed));
    CP.AddToChat('Beryllium Engineering Moops! '+UpdChecker.ThisVersion);
    CP.AddToChat('Copyright (C) '+DoColor(cvWhite,cvRed)+'@[mailto:martin@beryllium.net]Martin Poelstra@[/]'+DoColor(cvYellow,cvRed)+' 2000-2002');
    CP.AddToChat('Maintained by '+DoColor(cvWhite,cvRed)+'@[mailto:clockwork.singularity@gmail.com]Katelyn Gigante@[/]'+DoColor(cvYellow,cvRed)+' 2011-2023');
	//CP.AddToChat('Moops schopt kont!');
    CP.AddToChat(DoColor(cvYellow,cvMaroon));
    CP.AddToChat('You can visit the website for online help:');
    CP.AddToChat('@[ansi:underline]@[http://beryllium.net/moops/]http://beryllium.net/moops/@[/]'+DoColor(cvYellow,cvMaroon));
    CP.AddToChat('');
    CP.AddToChat('For quick help about available commands, see:');
    CP.AddToChat('   @[ansi:underline]@[clnt:/help commands]/help commands@[/]'+DoColor(cvYellow,cvMaroon));
    CP.AddToChat('You can also type "/help <command>", e.g. "@[ansi:underline]@[clnt:/help connect]/help connect@[/]'+DoColor(cvYellow,cvMaroon)+'".');
    CP.AddToChat('');
    CP.AddToChat(DoColor(cvYellow,cvRed)+'Thanks to:');
    CP.AddToChat(DoColor(cvWhite,cvMaroon)+'Christian Luijten');
    CP.AddToChat('Matthijs Braamhaar');
    CP.AddToChat('@[mailto:matty@beryllium.net]Matthijs van de Water@[/]');
    CP.AddToChat('Pim Arts');
    CP.AddToChat('Simon Gijsen');
    CP.AddToChat('@[http://upx.sourceforge.net]Ultimate Packer for eXecutables@[/]');
    CP.AddToChat('mwEdit component');
    CP.AddToChat('Peter ''R-four'' Corcoran');
    CP.AddToChat('');
    CP.AddToChat(DoColor(cvYellow,cvRed)+'And VERY special thanks go to:');
    CP.AddToChat(DoColor(cvWhite,cvMaroon)+'@[mailto:eligia@beryllium.net]Alice Bakker@[/]');
    CP.AddToChat(DoColor(cvYellow,cvMaroon));
    CP.ChatView.DoColor(cvNormal,cvNormal);
  end;
end;

procedure ShowClientHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CommanderMsg('');
    CommanderMsg('The client');
    CommanderMsg('**********');
    CommanderMsg('');
    CommanderMsg('Moops is very easy to use, so at the moment, no help is available here...');
    CommanderMsg('');
  end;
end;

procedure ShowEditorHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CommanderMsg('');
    CommanderMsg('The editor');
    CommanderMsg('**********');
    CommanderMsg('');
    CommanderMsg('You can invoke the editor through the following commands:');
    CommanderMsg('  /localedit <str:FileName>    : Open <FileName>');
    CommanderMsg('  /le        <str:FileName>    : Open <FileName>');
    CommanderMsg('  /edit      <nes:VerbName>    : Load verb <VerbName> from the server');
    CommanderMsg('  /e         <nes:VerbName>    : Load verb <VerbName> from the server');
    CommanderMsg('  /notedit   <nes:PropName>    : Load property <PropName> from the server');
    CommanderMsg('  /ne        <nes:PropName>    : Load property <PropName> from the server');
    CommanderMsg('  /he                          : Edit the description of the current location');
    CommanderMsg('  /me                          : Edit the description of yourself');
    CommanderMsg('  /de        <nes:Object>      : Edit the description of <object>');
    CommanderMsg('');
{    CommanderMsg('For Moo''s that don''t support the new edit-packages, Moops uses the old');
    CommanderMsg('(and bad) simple-edit-package. However, Moo''s are encouraged to implement the');
    CommanderMsg('dns-net-beryllium-edit package. This package DOES conform to MCP 2.1 and enables');
    CommanderMsg('some very handy features...');}
  end;
end;

procedure ShowScriptHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CommanderMsg('');
    CommanderMsg('The Scripting language of Moops');
    CommanderMsg('*******************************');
    CommanderMsg('');
    CommanderMsg('Scripts are normal textfiles with the extension ".msc", like "test.msc".');
    CommanderMsg('You can then execute scripts like this: "/x test".');
    CommanderMsg('There is almost no difference between what you type in the input-field at the bottom of');
    CommanderMsg('the window and the lines in a script.');
    CommanderMsg('');
    CommanderMsg('Commands in Moops consist of a slash ("/") followed by a command-name and optionally');
    CommanderMsg('some arguments. Command-names are case-insensitive.');
    CommanderMsg('There are several types of arguments:');
    CommanderMsg(' - <int>: The argument should be a decimal value like -10 or 12345');
    CommanderMsg(' - <flt>: The argument should be a floating-point value like 1.1 or -2.4e-6');
    CommanderMsg(' - <str>: A string, which may be quoted with '' and can be empty');
    CommanderMsg(' - <nes>: A Non Empty String, which may be quoted with '' and can not be empty');
    CommanderMsg(' - <any>: A special argument: the rest of the line is parsed as being the first argument');
    CommanderMsg('');
    CommanderMsg('Script-specific commands: ');
    CommanderMsg('  /exec <nes:ScriptName>   : Execute "<ScriptName>.msc"');
    CommanderMsg('  /x    <nes:ScriptName>   : Execute "<ScriptName>.msc"');
    CommanderMsg('');
    CommanderMsg('There is a special script "AutoExec.msc" that is executed automatically when Moops! starts.');
    CommanderMsg('If this file isn''t found at startup, the "/help" command is executed. You may create an empty');
    CommanderMsg('file if you like...');
    CommanderMsg('');
  end;
end;

procedure ShowGetStartedHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CommanderMsg('');
    CommanderMsg('Getting started with Moops!');
    CommanderMsg('***************************');
    CommanderMsg('');
    CommanderMsg('Moops is very simple to use, and so is this mini-tutorial:');
    CommanderMsg('First, we have to create a script so we can login to a MUD-server.');
    CommanderMsg('So, create a file like "test.msc". ');
    CommanderMsg('Now, we can place commands in this file:');
    CommanderMsg('/new Test');
    CommanderMsg('/connect your.mud.server.org 1234');
    CommanderMsg('');
    CommanderMsg('If we execute this script, we are connected. But now, we must login.');
    CommanderMsg('Moops has two commands to login: /plainlogin and /cryptlogin. We''ll use the latter.');
    CommanderMsg('To be able to ''cryptlogin'' you must create an encrypted version of your password:');
    CommanderMsg('Just type "/encrypt yourpassword" now...');
    CommanderMsg('Then enter a line like the following in your Test.msc:');
    CommanderMsg('/cryptlogin yourusername 364738747236264637');
    CommanderMsg('');
    CommanderMsg('Ok. Now save your file and try it by typing:');
    CommanderMsg('/x Test');
    CommanderMsg('');
    CommanderMsg('That''s all...');
    CommanderMsg('Note: users that are behind a proxy should replace the /connect line by something like this:');
    CommanderMsg('/connect your.proxy.com 23');
    CommanderMsg('c your.mud.server.org 1234');
    CommanderMsg('');
  end;
end;

procedure ShowDebugHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CommanderMsg('');
    CommanderMsg('Debug functions');
    CommanderMsg('***************');
    CommanderMsg('');
    CommanderMsg('To debug the mcp, you can use the following:');
    CommanderMsg('  /debug-mcp 0   : Turn off MCP-messages');
    CommanderMsg('  /debug-mcp 1   : Only show import things like errors');
    CommanderMsg('  /debug-mcp 2   : Log everything');
    CommanderMsg('');
    CommanderMsg('You can also use the following commands:');
    CommanderMsg('  /in <nes:Msg>                          : Fake incoming data');
    CommanderMsg('  /out <nes:Msg>                         : Send <Msg> to the server');
    CommanderMsg('  /debug-mcp <nes:Level>                 : Set verbosity of mcp-debugger');
    CommanderMsg('  /dump-ml <str:DataTag>                 : Show active multilines');
    CommanderMsg('  /plugindump                            : Show active plugins');
    CommanderMsg('  /pluginpri <int:PluginNr> <int:NewPri> : Change priority of plugin');
    CommanderMsg('');
    CommanderMsg('When the /dump-ml command is invoked without a DataTag, it displays the');
    CommanderMsg('current list of open multilines. You can then view any incoming multiline');
    CommanderMsg('in detail by supplying the correct DataTag.');
  end;
end;

procedure ShowCommandsHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CommanderMsg('');
    CommanderMsg('List of commands');
    CommanderMsg('****************');
    CommanderMsg('');
    CommanderMsg('For an explanation of the syntax, see "/help script"');
    CommanderMsg('');
    CommanderMsg('--- General:');
    CommanderMsg('/stop                                  : Stop current operation / Exit the running script');
    CommanderMsg('/help <any:Subject>                    : Show help about <Subject>');
    CommanderMsg('/quit                                  : Quit Moops!');
    CommanderMsg('/loadsession <nes:FileName>            : Load a session');
    CommanderMsg('/startsession                          : Start a session (i.e. connect to the world)');
    CommanderMsg('/new <nes:PageCaption>                 : Open new page');
    CommanderMsg('/connect <nes:Host> <int:Port>         : Connect to <Host>:<Port>');
    CommanderMsg('/reconnect                             : Reconnect to the last server');
    CommanderMsg('/disconnect                            : Disconnect from current server');
    CommanderMsg('/waitfor <nes:Trigger>                 : Wait for <Trigger> to appear in incoming data');
    CommanderMsg('/plainlogin <nes:User> <nes:PlainPW>   : Login using plaintext password');
    CommanderMsg('/cryptlogin <nes:User> <nes:CryptPW>   : Login using encrypted password');
    CommanderMsg('/relogin                               : Reconnect and relogin to the last server');
    CommanderMsg('/encrypt <nes:PlainPW>                 : Generate encrypted password');
    CommanderMsg('/leave                                 : Disconnect and close current page');
    CommanderMsg('/clear                                 : Clear current window');
    CommanderMsg('/logrotate <nes:FileName>              : Rename "<FileName>.log" to "<FileName>.1.log", etc.');
    CommanderMsg('/addtolog <nes:Msg>                    : Add <Msg> to the log');
    CommanderMsg('/addtochat <nes:Msg>                   : Add <Msg> to the window');
    CommanderMsg('/commandermsg <nes:Msg>                : Add <Msg> to the commanderlog');
    CommanderMsg('/setcaption <nes:PageCaption>          : Set the caption of the current page');
    CommanderMsg('/setstatus <str:StatusTxt>             : Set the text of the statusbar');
    CommanderMsg('/loadtheme <nes:FileName>              : Load a theme');
    CommanderMsg('/localedit <str:FileName>              : Open editor with local file');
    CommanderMsg('/le <str:FileName>                     : Open editor with local file');
    CommanderMsg('');
    CommanderMsg('--- Script:');
    CommanderMsg('/exec <nes:FileName>                   : Execute "<FileName>.msc"');
    CommanderMsg('/x <nes:FileName>                      : Execute "<FileName>.msc"');
    CommanderMsg('/delay <int:MilliSecs>                 : Sleep during <MilliSecs>');
    CommanderMsg('/end                                   : Exit the running script');
    CommanderMsg('/chdir <nes:NewDir>                    : Change current directory');
    CommanderMsg('/pwd                                   : Print Working Directory');
    CommanderMsg('/shell <nes:FileName>                  : Execute an external program');
    CommanderMsg('');
    CommanderMsg('--- Moo-commands:');
    CommanderMsg('/edit <any:Verb>                       : Open editor');
    CommanderMsg('/e <any:Verb>                          : Open editor');
    CommanderMsg('/notedit <any:Prop>                    : Open editor');
    CommanderMsg('/ne <any:Prop>                         : Open editor');
    CommanderMsg('/he                                    : Edit the description of the current location');
    CommanderMsg('/me                                    : Edit the description of yourself');
    CommanderMsg('/de <nes:Object>                       : Edit the description of <object>');
    CommanderMsg('');
    CommanderMsg('--- Debug:');
    CommanderMsg('/in <nes:Msg>                          : Fake incoming data');
    CommanderMsg('/out <nes:Msg>                         : Send <Msg> to the server');
    CommanderMsg('/debug-mcp <nes:Level>                 : Set verbosity of mcp-debugger');
    CommanderMsg('/dump-ml <str:DataTag>                 : Show active multilines');
    CommanderMsg('/info                                  : Show some info about memory usage etc');
    CommanderMsg('');
  end;
end;

procedure ShowNoHelp(CP: TNetClientPage);
begin
  with CP do
  begin
    CommanderMsg('Sorry. No help is available for "'+LowerCase(Commander.GetStr(1))+'".');
  end;
end;

procedure ShowHelp(CP: TNetClientPage);
var
  I: Integer;
  S: string;
begin
  with CP do
  begin
    ChatView.BeginUpdate;
    S:=LowerCase(CP.Commander.GetStr(1));
    if (S<>'') and (S[1]='/') then Delete(S,1,1);
    if S='' then ShowDefaultHelp(CP)
    else if S='client' then ShowClientHelp(CP)
    else if S='editor' then ShowEditorHelp(CP)
    else if S='script' then ShowScriptHelp(CP)
    else if S='scripts' then ShowScriptHelp(CP)
    else if S='debug' then ShowDebugHelp(CP)
    else if S='getstarted' then ShowGetStartedHelp(CP)
    else if S='commands' then ShowCommandsHelp(CP)
    else
    begin
      I:=CP.Commander.Commands.Find(S);
      if I>0 then
        CommanderMsg(CP.Commander.Commands.GetSyntax(I))
      else
        ShowNoHelp(CP);
    end;
    ChatView.EndUpdate;
  end;
end;

end.
