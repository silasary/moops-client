TmwMOOSyntax {first Identifier is considered to be the Class Name }
mo        {second Identifier is considered to be the Identifier Prefix }
IdentStart '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

KEYS  { all between KEYS and |><| is considered to be a keyword }
if
elseif
else
endif
for
in
endfor
while
endwhile
return
fork
endfork
|><| { token names }
String
Number
Object
$-ref
Variable
Keyword
Symbol
Comment
Null
Space
Unknown
|><|

CHARS

#0:: Null
BeginProc
  fTokenID := tkNull;
EndProc

#1..#32:: Space
BeginProc
  fTokenID := tkSpace;
  repeat
    inc(Run);
  until not (fLine[Run] in [#1..#32]);
EndProc

'?','|','&','!','%','*','/','(',')','{','}','[',']',';',',':: Symbol
BeginProc
  fTokenID := tkSymbol;
  repeat
    inc(Run);
  until not (fLine[Run] in ['?','|','&','!','%','*','/','(',')','{','}','[',']',';',',']);
EndProc

'A'..'Z', 'a'..'z', '_':: Ident
BeginProc
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
EndProc

'"':: String
BeginProc
  fTokenID := tkString;
  Inc(Run);
  repeat
    if fLine[Run] = '"' then
    begin
      Inc(Run);
      if fLine[Run] <> '"' then break;
    end;
    Inc(Run);
  until fLine[Run] in [#0, #10, #13];
EndProc
|><|

