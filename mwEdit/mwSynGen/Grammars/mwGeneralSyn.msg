{Sample Grammar for a Pascal HighLighter}
{No syntax check takes Place}
{ DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.}
{ You use it at your own risc. }

TmwGeneralSyn {first Identifier is considered to be the Class Name }
tk        {second Identifier is considered to be the Identifier Prefix }
{Sensitive : Optional}
IdentStart '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

KEYS  { all between KEYS and |><| is considered to be a keyword }
aaaaa
|><| { token names }
Comment
Identifier
Key
Null
Number
Space
String
Symbol
Unknown
|><|

CHARS

#0:: Null
BeginProc
  fTokenID := tkNull;
  fEol := True;
EndProc

#10:: LF
BeginProc
  fTokenID := tkSpace;
  inc(Run);
EndProc

#13:: CR
BeginProc
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
EndProc

#1..#9, #11, #12, #14..#32:: Space
BeginProc
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
EndProc

'#':: AsciiChar
BeginProc
  fTokenID := tkString;
  inc(Run);
  while FLine[Run] in ['0'..'9'] do inc(Run);
EndProc

'$'::  Integer
BeginProc
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', 'A'..'F', 'a'..'f'] do inc(Run);
EndProc

#39::  String
BeginProc
  fTokenID := tkString;
  if (FLine[Run + 1] = #39) and (FLine[Run + 2] = #39) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #39;
  if FLine[Run] <> #0 then inc(Run);
EndProc

'0'..'9':: Number 
BeginProc
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.', 'e', 'E'] do
  begin
    case FLine[Run] of
      '.':
        if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
EndProc

'A'..'Z', 'a'..'z', '_':: Ident
BeginProc
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
EndProc

'{':: BraceOpen
BeginProc
  fTokenID := tkComment;
  fRange := rsBor;
  inc(Run);
  while FLine[Run] <> #0 do
    case FLine[Run] of
      '}':
        begin
          fRange := rsUnKnown;
          inc(Run);
          break;
        end;
      #10: break;

      #13: break;
    else inc(Run);
    end;
EndProc

'(':: RoundOpen
BeginProc
  inc(Run);
  case fLine[Run] of
    '*':
      begin
        fTokenID := tkComment;
        fRange := rsAnsi;
        inc(Run);
        while fLine[Run] <> #0 do
          case fLine[Run] of
            '*':
              if fLine[Run + 1] = ')' then
              begin
                fRange := rsUnKnown;
                inc(Run, 2);
                break;
              end else inc(Run);
            #10: break;
            #13: break;
          else inc(Run);
          end;
      end;
    '.':
      begin
        inc(Run);
        fTokenID := tkSymbol;
      end;
  else
    begin
      inc(Run);
      FTokenID := tkSymbol;
    end;
  end;
EndProc

'/':: Slash
BeginProc
  case FLine[Run + 1] of
    '/':
      begin
        inc(Run, 2);
        fTokenID := tkComment;
        while FLine[Run] <> #0 do
        begin
          case FLine[Run] of
            #10, #13: break;
          end;
          inc(Run);
        end;
      end;
    *:
      begin
        fTokenID := tkComment;
        fRange := rsCStyle;
        inc(Run);
        while fLine[Run] <> #0 do
          case fLine[Run] of
            '*':
              if fLine[Run + 1] = '/' then
              begin
                fRange := rsUnKnown;
                inc(Run, 2);
                break;
              end else inc(Run);
            #10: break;
            #13: break;
          else inc(Run);
          end;
      end;
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc
|><|

