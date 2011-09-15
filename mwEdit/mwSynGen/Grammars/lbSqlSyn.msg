{Grammar for a SQL HighLighter}
{Copyright 1998 Luiz C. Vaz de Brito.  All right reserved}
{No syntax check takes Place}
{ DISCLAIMER:  This is provided as is, expressly without a warranty of any kind.}
{              This covers the following SQL implementations:}
{                   IBM DB2 Version 5}
{                   Informix Online Server 7.22}
{                   Interbase 5.0}
{                   Microsoft Access 97}
{                   Microsoft SQL Server 6.5}
{                   Oracle 8.0.0.0}
{                   Sybase SQL Server 11.1.}

{ You use it at your own risc. }

TlbSqlSyn {first Identifier is considered to be the Class Name }
tk        {second Identifier is considered to be the Identifier Prefix }
{Sensitive : Optional}
IdentStart '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

KEYS  { all between KEYS and |><| is considered to be a keyword }
{Alphabetical Order}

ABS
ACOS
ACTION
ACTIVE
ADD
ADMIN
AFTER
ALL
ALTER
AND
ANY
AS
ASC
ASCENDING
ASCII
ASIN
AT
ATAN
ATAN2
AUTO
AUTODDL
AVG
BASE_NAME
BASED
BASENAME
BEFORE
BEGIN
BETWEEN
BFILE
BINARY
BIT
BIT_LENGTH
BLOB
BLOBEDIT
BUFFER
BUFFERPOOL
BY
BYTE
CACHE
CALL
CASCADE
CASE
CAST
CEILING
CHAR
CHAR_LENGTH
CHARACTER
CHARACTER_LENGTH
CHECK
CHECK_POINT_LEN
CHECK_POINT_LENGTH
CHR
CLOB
CLOB
CLOSE
CLUSTER
COALESCE
COLLATE
COLLATION
COLLCHAR
COLUMN
COMMENT
COMMIT
COMMITTED
COMPILETIME
COMPUTED
CONCAT
CONDITIONAL
CONNECT
CONNECTIONS
CONSTRAINT
CONTAINING
CONTINUE
CONTROLFILE
CONVERT
COS
COSH
COT
COUNT
COUNTER
CPU_BUSY
CREATE
CSTRING
CURRENCY
CURRENT
CURRENT DATE
CURRENT_TIME
CURRENT_TIMESTAMP
CURRENT_USER
CURSOR
CURSOR_ROWS
DATABASE
DATE
DATEFIRST
DATETIME
DAY
DAYNAME
DAYOFWEEK
DAYOFYEAR
DAYS
DB_KEY
DBANSIWARN
DBAPICODE
DBBLOBBUF
DBCLOB
DBDATE
DBDELIMITER
DBEDIT
DBLANG
DBMONEY
DBNLS
DBPATH
DBSPACETEMP
DBTIME
DBTS
DBUPSPACE
DEBUG
DEC
DECIMAL
DECLARE
DEFAULT
DEGREE
DEGREES
DELETE
DELIMIDENT
DESC
DESCENDING
DESCRIBE
DESCRIPTOR
DIFFERENCE
DIGITS
DISCONNECT
DISPLAY
DISTINCT
DO
DOMAIN
DOUBLE
DROP
ECHO
EDIT
ELSE
END
ENTRY_POINT
ERROR
ESCAPE
EVENT
EVENT_MON_STATE
EXCEPTION
EXECUTE
EXISTS
EXIT
EXP
EXPLAIN
EXTERN
EXTERNAL
EXTRACT
FET_BUF_SIZE
FETCH
FETCH_STATUS
FILE
FILTER
FLOAT
FLOOR
FOR
FOREIGN
FOUND
FREE_IT
FROM
FULL
FUNCTION
GDSCODE
GEN_ID
GENERATE_UNIQUE
GENERATOR
GLOBAL
GOTO
GRANT
GRAPHIC
GROUP
GROUP_COMMIT_
GROUP_COMMIT_WAIT
GUID
HAVING
HELP
HEX
HEXTORAW
HOUR
IDENTITY
IDLE
IF
IMAGE
IMMEDIATE
IN
INACTIVE
INDEX
INDICATOR
INFORMIXCONRETRY
INFORMIXCONTIME
INFORMIXDIR
INFORMIXSERVER
INFORMIXSERVER
INFORMIXSTACKSIZE
INIT
INNER
INPUT
INPUT_TYPE
INSERT
INT
INTEGER
INTEGER
INTERVAL
INTO
IO_BUSY
IS
ISOLATION
ISOPEN
ISQL
JOIN
JULIAN_DAY
KEY
LANG
LANGID
LANGUAGE
LC_COLLATE
LC_CTYPE
LC_MESSAGES
LC_MONETARY
LC_NUMERIC
LC_TIME
LC_TYPE
LCASE
LEFT
LENGTH
LEV
LEVEL
LIKE
LOCATE
LOG
LOG_BUF_SIZE
LOG_BUFFER_SIZE
LOG10
LOGFILE
LONG
LONG_VARCHAR
LONG_VARGRAPHIC
LONGBINARY
LOWER
LTRIM
MANUAL
MAX
MAX_CONNECTIONS
MAX_PRECISION
MAX_SEGMENT
MAXIMUM
MAXIMUM_SEGMENT
MEMO
MERGE
MESSAGE
MICROSECOND
MICROSOFTVERSION
MIDNIGHT_SECONDS
MIN
MINIMUM
MINUTE
MLSLABEL
MOD
MODE
MODULE_NAME
MONEY
MONTH
MONTHNAME
NAMES
NATIONAL
NATURAL
NCHAR
NCLOB
NESTLEVEL
NO
NOAUTO
NODE
NODEFDAC
NODEGROUP
NODENUMBER
NOT
NULL
NULLIF
NUM_LOG_BUFFERS
NUM_LOG_BUFS
NUMBER
NUMERIC
NVARCHAR
OCTET_LENGTH
OF
ON
ONCONFIG
ONLY
OPEN
OPTIMIZATION
OPTION
OR
ORDER
OUTER
OUTPUT
OUTPUT_TYPE
OVERFLOW
PACK_RECEIVED
PACK_SENT
PACKET_ERRORS
PAGE
PAGE_SIZE
PAGELENGTH
PAGES
PARAMETER
PARTITION
PASSWORD
PATH
PI
PLAN
POSITION
POSSTR
POST_EVENT
POWER
PRECISION
PREPARE
PRIMARY
PRIVILEGES
PROCEDURE
PROCID
PROTECTED
PUBLIC
QUARTER
QUERY
QUIT
RADIANS
RAISE_ERROR
RAND
RAW
RAW_PARTITIONS
READ
REAL
RECORD_VERSION
REFERENCES
RELEASE
REMSERVER
REPEAT
REPLACE
RESERV
RESERVING
RESTRICT
RETAIN
RETURN
RETURNING_VALUES
RETURNS
REVOKE
RIGHT
ROLE
ROLLBACK
ROUND
ROWCOUNT
ROWTYPE
RTRIM
RUNTIME
SCHEMA
SECOND
SECTION
SEGMENT
SELECT
SERIAL
SERVER
SERVERNAME
SESSION_USER
SET
SHADOW
SHARED
SHELL
SHORT
SHORTDATETIME
SHOW
SIGN
SIN
SINGLE
SINGULAR
SINH
SIZE
SMALLDATETIME
SMALLINT
SMALLMONEY
SNAPSHOT
SOME
SORT
SOUNDEX
SPACE
SPID
SQL
SQLCODE
SQLERROR
SQLWARNING
SQRT
STABILITY
STARTING
STARTS
STATEMENT
STATIC
STATISTICS
SUB_TYPE
SUBSTR
SUBSTRING
SUM
SUSPEND
SYSTEM_USER
TABLE
TABLE_NAME
TABLE_SCHEMA
TABLESPACE
TAN
TANH
TERMINATOR
TEXT
TEXTSIZE
THEN
TIME
TIMESTAMP
TIMESTAMP_ISO
TIMESTAMPDIFF
TIMETICKS
TIMEZONE
TINYINT
TO
TO_BINARY_INTEGER
TO_CHAR
TO_DATE
TO_MULTI_BYTE
TO_NUMBER
TO_SINGLE_BYTE
TOTAL_ERRORS
TOTAL_READ
TOTAL_WRITE
TRANCOUNT
TRANSACTION
TRANSLATE
TRANSLATION
TRIGGER
TRIM
TRUNCATE
TYPE
UCASE
UNCOMMITTED
UNION
UNIQUE
UPDATE
UPPER
USER
USING
VALUE
VALUES
VARBINARY
VARBIT
VARCHAR
VARCHAR2
VARGRAPHIC
VARIABLE
VARYING
VERSION
VIEW
WAIT
WAIT_TIME
WEEK
WHEN
WHENEVER
WHERE
WHILE
WITH
WORK
WRITE
YEAR
|><|

{ token names }
{Alphabetical Order}

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
{Alphabetical Order}

'&':: Ampersand
BeginProc
  inc(Run);
  fTokenId := tkSymbol;
EndProc

'}':: BraceClose
BeginProc
  inc(Run);
  fTokenId := tkSymbol;
EndProc

'{':: BraceOpen
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

#13:: CR
BeginProc
  fTokenID := tkSpace;
  Case FLine[Run + 1] of
    #10: inc(Run, 2);
  else inc(Run);
  end;
EndProc

':':: Colon
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

',':: Comma
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

'=':: Equal
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

'^':: Exponentiation
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

'>':: Greater
BeginProc
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
EndProc

'A'..'Z', 'a'..'z', '_':: Ident
BeginProc
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do inc(Run);
EndProc

#10:: LF
BeginProc
  fTokenID := tkSpace;
  inc(Run);
EndProc

'<':: Lower
BeginProc
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
EndProc

'-':: Minus
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

#0:: Null
BeginProc
  fTokenID := tkNull;
  fEol := True;
EndProc

'0'..'9':: Number
BeginProc
  inc(Run);
  fTokenID := tkNumber;
  while FLine[Run] in ['0'..'9', '.', 'e', 'E'] do
    inc(Run);
EndProc

'%':: Percent
BeginProc
  fTokenID := tkSymbol;
  fEol := True;
EndProc

'|':: Pipe
BeginProc
  Case FLine[Run + 1] of
    '|':                   {concatenation}
      begin
        inc(Run, 2);
        fTokenID := tkSymbol;
      end;
  else
    begin
      inc(Run);
      fTokenID := tkIdentifier;
    end;
  end;
EndProc

'+':: Plus
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

'.':: Point
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

'?':: Question
BeginProc
  fTokenID := tkSymbol;
  inc(Run);
EndProc

')':: RoundClose
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

'(':: RoundOpen
BeginProc
  inc(Run);
  FTokenID := tkSymbol;
EndProc

';':: SemiColon
BeginProc
  inc(Run);
  fTokenID := tkSymbol;
EndProc

'/':: Slash
BeginProc
  case FLine[Run + 1] of
    '*':                               {begin comment}
      begin
        fTokenID := tkComment;
        fRange   := rsRem;
        inc(Run);
        while fLine[Run] <> #0 do
          case fLine[Run] of
            '*':
              if fLine[Run + 1] = '/' then
              begin
                inc(Run, 2);
                fRange   := rsANil;
                break;
              end else inc(Run);
            #10: break;
            #13: break;
          else inc(Run);
          end;
      end;
  else                                 {division}
    begin
      inc(Run);
      fTokenID := tkSymbol;
    end;
  end;
EndProc

#1..#9, #11, #12, #14..#32:: Space
BeginProc
  inc(Run);
  fTokenID := tkSpace;
  while FLine[Run] in [#1..#9, #11, #12, #14..#32] do inc(Run);
EndProc

'*':: Star
BeginProc
  case FLine[Run + 1] of
    '/':                     {end comment}
      begin
        fTokenID := tkComment;
        fRange   := rsANil;
        inc(Run, 2);
      end;
    else
      begin
        inc(Run);            {multi}
        fTokenID := tkSymbol;
      end;
  end;
EndProc

#39::  String
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

|><|
