{Grammar for a Java HighLighter}
{Copyright 1998 Michael Trier.  All right reserved}
{mailto:mtrier@pobox.com}
{No syntax check takes Place}
{ DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.}
{ You use it at your own risk. }

TDcjJavaSyn {first Identifier is considered to be the Class Name }
tk        {second Identifier is considered to be the Identifier Prefix }
Sensitive {: Optional}
IdentStart '_', '$', 'a'..'z', 'A'..'Z':: '_', '$', '0'..'9', 'a'..'z', 'A'..'Z'::

KEYS  { all between KEYS and |><| is considered to be a keyword }
abstract
boolean
break
byte
case
catch
char
class
continue
default
do
double
else
extends
final
finally
float
for
if
implements
import
instanceof
int
interface
long
native
new
package
private
protected
public
return
short
static
super
switch
synchronized
this
throw
throws
transient
try
void
volatile
while
{ not in Java 1.0 }
{ byvalue }
{ cast }
const
{ future }
{ generic }
goto
{ inner }
{ operator }
{ outer }
{ rest }
{ var }
{ added in Java 1.2 }
strictfp
{ boolean literals }
false
true
{ null literal }
null

|><| { token names }
Comment
Document
Identifier
Invalid
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

#34::  String
BeginProc
  fTokenID := tkString;
  if (FLine[Run + 1] = #34) and (FLine[Run + 2] = #34) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
      #92:                             {backslash}
        {if we have an escaped quote it doesn't count}
        if FLine[Run + 1] = #34 then inc(Run);
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
EndProc

#39::  AsciiChar
BeginProc
  fTokenID := tkString;
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
      #92:                             {backslash}
        {if we have an escaped single quote it doesn't count}
        if FLine[Run + 1] = #39 then inc(Run);
    end;
    inc(Run);
  until FLine[Run] = #39;
  if FLine[Run] <> #0 then inc(Run);
EndProc

'.', '0'..'9':: Number
BeginProc
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in
      ['0'..'9', '.', '-', 'l', 'L', 'x', 'X', 'A..F', 'a..f'] do
  begin
    case FLine[Run] of
      '.':
        if FLine[Run + 1] = '.' then break;
    end;
    inc(Run);
  end;
EndProc

'A'..'Z', 'a'..'z', '_', '$':: Ident
BeginProc
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
EndProc

'!':: NotSymbol
BeginProc
  case FLine[Run + 1] of
    '=':                               {not equal}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkNotEqual;
      end;
  else                                 {logical complement}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkLogComplement;
    end;
  end;
EndProc

'#':: Pound
BeginProc
  inc(Run);
  fTokenID := tkInvalid;
EndProc

'{':: BraceOpen
BeginProc
  inc(Run);
  fTokenId := tkSymbol;
  fSymbolEx := xtkBraceOpen;
EndProc

'}':: BraceClose
BeginProc
  inc(Run);
  fTokenId := tkSymbol;
  fSymbolEx := xtkBraceClose;
EndProc

'~':: Tilde
BeginProc
  inc(Run);                            {bitwise complement}
  fTokenId := tkSymbol;
  fSymbolEx := xtkBitComplement;
EndProc

'|':: OrSymbol
BeginProc
  case FLine[Run + 1] of
    '=':                               {inclusive or assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkIncOrAssign;
      end;
    '|':                               {conditional or}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkCondOr;
      end;
  else                                 {inclusive or}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkIncOr;
    end;
  end;
EndProc

'%':: RemainderSymbol
BeginProc
  case FLine[Run + 1] of
    '=':                               {remainder assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkRemainderAssign;
      end;
  else                                 {remainder}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkRemainder;
    end;
  end;
EndProc

'&':: AndSymbol
BeginProc
  case FLine[Run + 1] of
    '=':                               {and assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkAndAssign;
      end;
    '&':                               {conditional and}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkCondAnd;
      end;
  else                                 {and}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkAnd;
    end;
  end;
EndProc

'(':: RoundOpen
BeginProc
  inc(Run);
  FTokenID := tkSymbol;
  fSymbolEx := xtkRoundOpen;
  inc(FRoundCount);
EndProc

')':: RoundClose
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
  fSymbolEx := xtkRoundClose;
  dec(FRoundCount);
EndProc

'*':: Multiply
BeginProc
  case FLine[Run + 1] of
    '=':                               {multiply assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkMultiplyAssign;
      end;
  else                                 {multiply}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkMultiply;
    end;
  end;
EndProc

'+':: Plus
BeginProc
  case FLine[Run + 1] of
    '=':                               {add assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkAddAssign;
      end;
    '+':                               {increment}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkIncrement;
      end;
  else                                 {add}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkAdd;
    end;
  end;
EndProc

',':: Comma
BeginProc
  inc(Run);
  fTokenID := tkInvalid;
EndProc

'-':: Minus
BeginProc
  case FLine[Run + 1] of
    '=':                               {subtract assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkSubtractAssign;
      end;
    '-':                               {decrement}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkDecrement;
      end;
  else                                 {subtract}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkSubtract;
    end;
  end;
EndProc

'.':: Point
BeginProc
  inc(Run);                            {point}
  fTokenID := tkSymbol;
  fSymbolEx := xtkPoint;
EndProc

'/':: Slash
BeginProc
  case FLine[Run + 1] of
    '/':                               {c++ style comments}
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
    '*':
      begin
        fRange := rsComment;
        inc(Run);
        if fLine[Run+1] = '*' then     {documentation comment}
        begin
          fTokenID := tkDocument;
          inc(Run);
        end
        else                           {c style comment}
          fTokenID := tkComment;

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
    '=':                               {division assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkDivideAssign;
      end;
  else                                 {division}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkDivide;
    end;
  end;
EndProc

':':: Colon
BeginProc
  inc(Run);                            {colon - conditional}
  fTokenID := tkSymbol;
  fSymbolEx := xtkColon;
EndProc

';':: SemiColon
BeginProc
  inc(Run);                            {semicolon}
  fTokenID := tkSymbol;
  fSymbolEx := xtkSemiColon;
EndProc

'<':: Lower
BeginProc
  case FLine[Run + 1] of
    '=':                               {less than or equal to}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkLessThanEqual;
      end;
    '<':
      begin
        if FLine[Run + 2] = '=' then   {shift left assign}
        begin
          inc(Run, 3)
          fSymbolEx := xtkShiftLeftAssign;
        end
        else                           {shift left}
        begin
          inc(Run, 2);
          fSymbolEx := xtkShiftLeft;
        end;
        fTokenID := tkSymbol;
      end;
  else                                 {less than}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkLessThan;
    end;
  end;
EndProc

'=':: Equal
BeginProc
  case FLine[Run + 1] of
    '=':                               {logical equal}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkLogEqual;
      end;
  else                                 {assign}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkAssign;
    end;
  end;
EndProc

'>':: Greater
BeginProc
  Case FLine[Run + 1] of
    '=':                               {greater than or equal to}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkGreaterThanEqual;
      end;
    '>':
      begin
        Case FLine[Run + 2] of
          '=':                         {shift right assign}
            inc(Run, 3)
            fSymbolEx := xtkShiftRightAssign;
          '>':
            if FLine[Run + 3] = '=' then
            begin
              inc(Run, 4)              {unsigned shift right assign}
              fSymbolEx := xtkUnsignShiftRightAssign;
            end
            else
            begin
              inc(Run, 3)              {unsigned shift right}
              fSymbolEx := xtkUnsignShiftRight;
            end;
        else                           {shift right}
        begin
          inc(Run, 2);
          fSymbolEx := xtkShiftRight;
        end;
        fTokenID := tkSymbol;
      end;
  else                                 {greater than}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkGreaterThan;
    end;
  end;
EndProc

'?':: Question
BeginProc
  fTokenID := tkSymbol;                {question mark - conditional}
  fSymbolEx := xtkQuestion;
  inc(Run);
EndProc

'@':: AtSymbol
BeginProc
  fTokenID := tkInvalid;
  inc(Run);
EndProc

'[':: SquareOpen
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
  fSymbolEx := xtkSquareOpen;
  inc(FSquareCount);
EndProc

']':: SquareClose
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
  fSymbolEx := xtkSquareClose;
  dec(FSquareCount);
EndProc

'^':: XOrSymbol
BeginProc
  Case FLine[Run + 1] of
    '=':                               {xor assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
        fSymbolEx := xtkXorAssign;
      end;
  else                                 {xor}
    begin
      inc(Run);
      fTokenID := tkSymbol;
      fSymbolEx := xtkXor;
    end;
  end;
EndProc
|><|

