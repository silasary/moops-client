{Grammar for a Perl HighLighter}
{Copyright 1998 Michael Trier.  All right reserved}
{mailto:mtrier@pobox.com}
{No syntax check takes Place}
{ DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.}
{ You use it at your own risc. }

TDcjPerlSyn {first Identifier is considered to be the Class Name }
tk        {second Identifier is considered to be the Identifier Prefix }
Sensitive {case sensitive}
IdentStart '%', '@', '$', '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

KEYS  { all between KEYS and |><| is considered to be a keyword }
{styles=hexh dqdoubles dqdoubles heredocument dqbackslash sqbackslash perl}
sub
abs
accept
alarm
atan2
bind
binmode
bless
caller
chdir
chmod
chomp
chop
chown
chr
chroot
close
closedir
connect
cos
crypt
dbmclose
dbmopen
defined
delete
die
do
dump
each
else
elsif
eof
eval
exec
exists
exit
exp
endpwent
endgrent
endhostent
endnetent
endprotoent
endservent
fcntl
fileno
flock
for
foreach
fork
formline
format
getc
getlogin
getpeername
getpgrp
getppid
getpriority
getpwnam
getgrnam
gethostbyname
getnetbyname
getprotobyname
getpwuid
getgrgid
getservbyname
gethostbyaddr
getnetbyaddr
getprotobynumber
getservbyport
getpwent
getgrent
gethostent
getnetent
getprotoent
getservent
getsockname
getsockopt
glob
gmtime
goto
grep
hex
import
index
int
ioctl
if
join
keys
kill
last
lc
lcfirst
length
link
listen
local
localtime
log
lstat
m
map
mkdir
msgctl
msgget
msgsnd
msgrcv
my
next
no
oct
open
opendir
ord
pack
package
pipe
pop
pos
print
push
q
qq
qx
qw
quotemeta
rand
read
readdir
readlink
recv
redo
ref
rename
require
reset
return
reverse
rewinddir
rindex
rmdir
scalar
seek
seekdir
select
semctl
semget
semop
send
setpgrp
setpriority
setsockopt
shift
shmctl
shmget
shmread
shmwrite
shutdown
sin
sleep
socket
socketpair
sort
splice
split
sprintf
sqrt
srand
stat
study
substr
symlink
syscall
sysread
system
syswrite
setgrent
sethostent
setnetent
setprotoent
setpwent
setservent
tell
telldir
tie
time
times
tr
truncate
uc
ucfirst
umask
undef
unless
unlink
unpack
untie
unshift
use
utime
values
vec
wait
waitpid
wantarray
warn
while
write
{predefined variables}
$ACCUMULATOR
$ARG
$ARGV
$BASETIME
$CHILD_ERROR
$DEBUGGING
$EFFECTIVE_GROUP_ID
$EFFECTIVE_USER_ID
$EGID
$ENV
$ERRNO
$EUID
$EVAL_ERROR
$EXECUTABLE_NAME
$FORMAT_FORMFEED
$FORMAT_LINES_LEFT
$FORMAT_LINES_PER_PAGE
$FORMAT_LINE_BREAK_CHARACTERS
$FORMAT_NAME
$FORMAT_PAGE_NUMBER
$FORMAT_TOP_NAME
$GID
$INPLACE_EDIT
$INPUT_LINE_NUMBER
$INPUT_RECORD_SEPARATOR
$LAST_PAREN_MATCH
$LIST_SEPARATOR
$MATCH
$MULTILINE_MATCHING
$NR
$OFMT
$ORS
$OS_ERROR
$OUTPUT_AUTOFLUSH
$OUTPUT_FIELD_SEPARATOR
$PERLDB
$PERL_VERSION
$PID
$POSTMATCH
$PREMATCH
$PROCESS_ID
$PROGRAM_NAME
$REAL_GROUP_ID
$REAL_USER_ID
$RS
$SIG
$SUBSCRIPT_SEPARATOR
$SUBSEP
$SYSTEM_FD_MAX
$UID
$WARNING
%INC
@ARGV
@INC
{ Preprocessor and Pragma keywords }
constant
diagnostics
integer
less
locale
sigtrap
strict
subs
vars
{ Operators Symbols keywords }
and
cmp
eq
ge
gt
le
lt
ne
not
or
xor

|><| { token names }
Comment
Identifier
Key
Null
Number
Operator
Pragma
Space
String
Symbol
Unknown
Variable
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

#34::  StringInterp
BeginProc
  fTokenID := tkString;
  if (FLine[Run + 1] = #34) and (FLine[Run + 2] = #34) then inc(Run, 2);
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
      #92:
        { backslash quote not the ending one }
        if FLine[Run + 1] = #34 then inc(Run);
    end;
    inc(Run);
  until FLine[Run] = #34;
  if FLine[Run] <> #0 then inc(Run);
EndProc

#39::  StringLiteral
BeginProc
  fTokenID := tkString;
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #39;
  if FLine[Run] <> #0 then inc(Run);
EndProc

'0'..'9', '.':: Number
BeginProc
  if FLine[Run] = '.' then
  begin
    case FLine[Run + 1] of
      '.':
        begin
          inc(Run, 2);
          if FLine[Run] = '.' then     {sed range}
            inc(Run);
      
          fTokenID := tkSymbol;        {range}
          break;
        end;
      '=':
        begin
          inc(Run, 2);
          fTokenID := tkSymbol;        {concatenation assign}
          break;
        end;
      'a'..'z', 'A'..'Z', '_':
        begin
          fTokenID := tkSymbol;        {concatenation}
          inc(Run);
          break;
        end;
    end;
  end;
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in
      ['0'..'9', '-', '_', '.', 'A'..'F', 'a'..'f', 'x', 'X'] do
  begin
    case FLine[Run] of
      '.':
        if FLine[Run + 1] = '.' then break;
      '-':                             {check for e notation}
        if not ((FLine[Run + 1] = 'e') or (FLine[Run + 1] = 'E')) then break;
    end;
    inc(Run);
  end;
EndProc

'%', '@', '$', 'A'..'Z', 'a'..'z', '_':: Ident
BeginProc
  Case FLine[Run] of
    '$':
      begin
        Case FLine[Run + 1] of
          '!'..'+', '-'..'@', '['..']', '_', '`', '|', '~':
            begin                      {predefined variables}
              inc(Run, 2);
              fTokenID := tkVariable;
              break;
            end;
          '^':
            begin
              Case FLine[Run + 2] of
                'A', 'D', 'F', 'I', 'L', 'P', 'T', 'W', 'X':
                  begin                {predefined variables}
                    inc(Run, 3);
                    fTokenID := tkVariable;
                    break;
                  end;
                #0, #10, #13:          {predefined variables}
                  begin
                    inc(Run, 2);
                    fTokenID := tkVariable;
                    break;
                  end;
              end;
            end;
        end;
      end;
    '%':
      begin
        Case FLine[Run + 1] of 
          '=':                         {mod assign}
            begin
              inc(Run, 2);
              fTokenID := tkSymbol;
              break;
            end;
          #0, #10, #13:                {mod}
            begin
              inc(Run);
              fTokenID := tkSymbol;
              break;
            end;
        end;
      end;
    'x':
      begin
        Case FLine[Run + 1] of 
          '=':                         {repetition assign}
            begin
              inc(Run, 2);
              fTokenID := tkSymbol;
              break;
            end;
          #0, #10, #13:                {repetition}
            begin
              inc(Run);
              fTokenID := tkSymbol;
              break;
            end;            
        end;
      end;    
  end;
  {regular identifier}
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
EndProc

'!':: NotSymbol
BeginProc
  case FLine[Run + 1] of
    '~':                               {logical negated bind like =~}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '=':                               {not equal}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {not}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

'#':: Comment
BeginProc
  fTokenID := tkComment;
  repeat
    case FLine[Run] of
      #0, #10, #13: break;
    end;
    inc(Run);
  until FLine[Run] = #0;
EndProc

'{':: BraceOpen
BeginProc
  inc(Run);
  fTokenId := tkSymbol;
EndProc

'}':: BraceClose
BeginProc
  inc(Run);
  fTokenId := tkSymbol;
EndProc

'~':: Tilde                            {bitwise negation}
BeginProc
  inc(Run);
  fTokenId := tkSymbol;
EndProc

'|':: OrSymbol
BeginProc
  case FLine[Run + 1] of
    '=':                               {bit or assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '|':
      begin
        if FLine[Run + 2] = '=' then   {logical or assign}
          inc(Run, 3)
        else                           {logical or}
          inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {bit or}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

'&':: AndSymbol
BeginProc
  case FLine[Run + 1] of
    '=':                               {bit and assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '&':                               
      begin
        if FLine[Run + 2] = '=' then   {logical and assign}
          inc(Run, 3)
        else                           {logical and}
          inc(Run, 2);
        fTokenID := tkSymbol;        
      end;
  else                                 {bit and}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

'(':: RoundOpen
BeginProc
  inc(Run);
  FTokenID := tkSymbol;
  inc(FRoundCount);
EndProc

')':: RoundClose
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
  dec(FRoundCount);
EndProc

'*':: Star
BeginProc
  case FLine[Run + 1] of
    '=':                               {multiply assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '*':                               
      begin
        if FLine[Run + 2] = '=' then   {exponentiation assign}
          inc(Run, 3)
        else                           {exponentiation}
          inc(Run, 2);
        fTokenID := tkSymbol;        
      end;
  else                                 {multiply}
    begin
      inc(Run);
      fTokenID := tkSymbol;
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
      end;
    '+':                               {increment}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {add}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

',':: Comma
BeginProc
  inc(Run);
  fTokenID := tkSymbol;                {comma}
EndProc

'-':: Minus
BeginProc
  case FLine[Run + 1] of
    '=':                               {subtract assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '-':                               {decrement}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '>':                               {arrow}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {subtract}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

'/':: Slash
BeginProc
  case FLine[Run + 1] of
    '=':                               {division assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {division}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

':':: Colon
BeginProc
  Case FLine[Run + 1] of
    ':':                               {double colon}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {colon}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

';':: SemiColon
BeginProc
  inc(Run);
  fTokenID := tkSymbol;                {semicolon}
EndProc

'<':: Lower
BeginProc
  case FLine[Run + 1] of
    '=':                               
      begin
        if FLine[Run + 2] = '>' then   {compare - less than, equal, greater}
          inc(Run, 3)
        else                           {less than or equal to}
          inc(Run, 2);
        fTokenID := tkSymbol;      
      end;
    '<':
      begin
        if FLine[Run + 2] = '=' then   {shift left assign}
          inc(Run, 3)
        else                           {shift left}
          inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {less than}
    begin
      inc(Run);
      fTokenID := tkSymbol;
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
      end;
    '>':                               {digraph}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
    '~':                               {bind scalar to pattern}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {assign}
    begin
      inc(Run);
      fTokenID := tkSymbol;
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
      end;
    '>':
      begin
        if FLine[Run + 2] = '=' then   {shift right assign}
          inc(Run, 3)
        else                           {shift right}
          inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {greater than}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

'?':: Question
BeginProc
  fTokenID := tkSymbol;                {conditional op}
  inc(Run);
EndProc

'\':: Backslash
BeginProc
  fTokenID := tkSymbol;                {reference}
  inc(Run);
EndProc

'[':: SquareOpen
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
  inc(FSquareCount);
EndProc

']':: SquareClose
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
  dec(FSquareCount);
EndProc

'^':: XOrSymbol
BeginProc
  Case FLine[Run + 1] of
    '=':                               {xor assign}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else                                 {xor}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc
|><|

