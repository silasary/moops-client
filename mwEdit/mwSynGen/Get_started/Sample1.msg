{ DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.}
{ You use it at your own risc. }

TmwSampleSyn {first Identifier is considered to be the Class Name }
tk        {second Identifier is considered to be the Identifier Prefix }
{Sensitive : Optional}
IdentStart '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

KEYS  { all between KEYS and |><| is considered to be a keyword }
mwEdit
|><| { token names }
Comment
Identifier
Key
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

'A'..'Z', 'a'..'z', '_':: Ident
BeginProc
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
EndProc

'/':: Slash
BeginProc
  Inc(Run);
  if fLine[Run] = '/' then
  begin
    fTokenID := tkComment;
    repeat
      Inc(Run);
    until fLine[Run] in [#0, #10, #13];
  end else
    fTokenID := tkUnknown;
EndProc
|><|

