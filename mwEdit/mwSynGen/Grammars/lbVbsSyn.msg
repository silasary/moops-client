{Grammar for a VbScript HighLighter}
{Copyright 1998 Luiz C. Vaz de Brito.  All right reserved}
{No syntax check takes Place}
{ DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.}
{ You use it at your own risc. }

TlbVbsSyn {first Identifier is considered to be the Class Name }
tk        {second Identifier is considered to be the Identifier Prefix }
{Sensitive : Optional}
IdentStart '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

KEYS  { all between KEYS and |><| is considered to be a keyword }

{Statements}
Call
Case
Class
Const
Dim
Do
Each
Else
End
Erase
Error
Exit
Explicit
For
Function
Get
If
Let
Loop
Next
On
Option
property
Private
Public
Randomize
ReDim
Rem
Select
Set
Sub
Then
Wend
While

{Operators Symbols Keywords}
And
Eqv
Imp
Is
Mod
Not
Or
Xor

|><|

{ token names }
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

'&':: Ampersand
beginproc
  inc(Run);
  fTokenId := tkSymbol;
endproc

#39:: Apostrophe
beginproc
  fTokenID := tkComment;
  inc(Run);
  while FLine[Run] <> #0 do
    case FLine[Run] of
      #10: break;
      #13: break;
    else inc(Run);
    end;
endproc

'}':: BraceClose
beginproc
  inc(Run);
  fTokenId := tkSymbol;
endproc

'{':: BraceOpen
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

#13:: CR
beginproc
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
endproc

':':: Colon
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

',':: Comma
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

'#':: Date
beginproc
  fTokenID := tkString;
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = '#';
  if FLine[Run] <> #0 then inc(Run);
endproc

'=':: Equal
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

'^':: Exponentiation
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

'>':: Greater
beginproc
  Case FLine[Run + 1] of
    '=':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
endproc

'A'..'Z', 'a'..'z', '_':: Ident
beginproc
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
endproc

#10:: LF
beginproc
  fTokenID := tkSpace;
  inc(Run);
endproc

'<':: Lower
beginproc
  case FLine[Run + 1] of
    '=':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '>':
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end
  else
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
endproc

'-':: Minus
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

#0:: Null
beginproc
  fTokenID := tkNull;
  fEol := True;
endproc

'0'..'9':: Number
beginproc
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.', 'e', 'E'] do inc(Run);
endproc

'+':: Plus
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

'.':: Point
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

')':: RoundClose
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

'(':: RoundOpen
beginproc
  inc(Run);
  FTokenID := tkSymbol;
endproc

';':: SemiColon
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

'/':: Slash
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

#1..#9, #11, #12, #14..#32:: Space
beginproc
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
endproc

'*':: Star
beginproc
  inc(Run);
  fTokenID := tkSymbol;
endproc

#34::  String
beginproc
  fTokenID := tkString;
  if (FLine[Run + 1] = #34) and (FLine[Run + 2] = #34) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
endproc

|><|
