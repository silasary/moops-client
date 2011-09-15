unit fileio;

interface

uses Classes, Windows, SysUtils;

{
18 Jan 2000 Pete Mee
 - Added Destroy to some components.
9 Jan 2000 Pete Mee
 - Added some other 'default' objects: TWinshoeWriteFile, TWinshoeReadFile,
   TWinshoeReadWriteFile, TWinshoeOverWriteFile.
8 Jan 2000 Pete Mee
 - TDebugLog renamed to TWinshoeDebugToFile (an append configuration).
6 Jan 2000 Pete Mee
 - Modified to remove compiler warnings. fioHandle, fioFilePos, fioBufferPos now defined
   as DWord.
29 Dec 1999 Pete Mee
 - Modified fioBufferSize and fioBufferRead defines to DWord to compile correctly under
   Delphi 5.
30 Oct 1999 Pete Mee
 - Added functions ReadByte, ReadWord, ReadDWord, WriteByte, WriteWord,
   WriteDWord, GetSize, GetRealSize.
 - Removed unused PBuff reference in WriteXBytesToBuffer.
 - Fixed bug in sequential writing to a non-append file (file pos not updated).
 - Fixed bug in ReadPChar - was calling ReadLn and not ReadEOL.
24 Oct 1999 Pete Mee
 - Altered fioFlags, Flags and SetFlags to fioAccessFlags, AccessFlags
   and SetAccessFlags respectively to avoid any confusion with File Attributes.
 - Added functions GetAttributes, SetAttributes (plus individuals).  Note: not tested.
 - Added property Attributes (plus individuals).  Note: not tested.
 - Removed default file name (was C:\WINSHOES.LOG).  File must now be specified.
 - Added TDebugLog.  Defaults are Append only access to an existing file (creating a new
   file if not in existence).
 - Altered SetAccessMode to check for unnecessary closing of file.
17 Oct 1999 Pete Mee
 - Added Append only access (during writes)
 - Added Close-after-access - close the real file after every access.  This
   flag comes into it's own when accessing commonly used changeable resources
   (databases for example).
3 Oct 1999 Pete Mee
 - Fixed a bug that got lost due to FAT corruption (hence nothing between
   now & 14th...).  The bug prevented access to any file because I'd removed
   the mapping of ACCESS modes to the GENERIC_ set.
14 Sep 1999 Pete Mee
 - Reworked ReadLn as ReadEOL
 - Added ReadLn, ReadPChar, WriteLn, WritePChar.  xLn functions are CR + LF terminated,
   xPChar functions are zero terminated.
 - Expanded functionality - allows setting current file position, creation
   style, flags on the fly
 - Added explicit CloseFile & FlushBuffer (these before were only implied
   when setting attributes) 
5 Sep 1999 Pete Mee
 - Expanded functionality - allows setting filename, bufferwrites, buffersize
   on the fly
 - Added ReadLn
2 Sep 1999 Pete Mee
 - Added Read Buffer implementation
 - Added Write Buffer implementation
 - Added option to buffer the writes (BufferWrites)
 - Added option to alter AccessMode on the fly
29 Aug 1999 Pete Mee
 - Started implementation
 - To do: File Locking, Attribute checking, Opening types
}

type
    TFIO = class(TComponent)
    protected
      fioHandle : DWord;
      fioAccessMode : Integer;
      fioRealAccessMode : Integer;
      fioShareAccess : Integer;
      fioCreationStyle : Integer;
      fioAccessFlags : Integer;

      //File details
      fioFileName : String;
      fioFilePos : DWORD;
      fioEOF : Boolean;
      fioNoBufferLeft : Boolean;

      //Buffer details
      fioBufferSize : DWord;
      fioBufferRead : DWord; //Number of bytes in buffer
      fioBufferPos : DWord;
      fioBuffer : String;

      //Whether to buffer up (cache) the writing
      fioBufferWrites : Boolean;
      //Whether the buffer is dirty
      fioBufferDirty : Boolean;
      //The count of bytes from the last buffer write
      fioBufferWrite : DWord;

      fioEOL : String;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      function RemoveFile : Boolean;
      procedure CloseFile;
      procedure FlushBuffer;

      //Property procedures
      function GetAttributes: DWORD;
      function GetAttribArchive : Boolean;
      function GetAttribCompressed : Boolean;
      function GetAttribHidden : Boolean;
      function GetAttribNormal : Boolean;
      function GetAttribReadOnly : Boolean;
      function GetAttribSystem : Boolean;
      function GetAttribTemporary : Boolean;
      // Gets the size of the file including any buffered writes held by this
      // object.
      function GetSize : DWORD;
      // Gets the size of the file as far as windows is concerned... without
      // a flush this may not necessarily indicate the disc size - just
      // cached (windows cache) size.
      function GetRealSize : DWORD;

      procedure SetAccessFlags(sFlags : Integer);
      procedure SetAccessMode(Mode : Integer);
      procedure SetAttributes(Attr : DWORD);
      procedure SetAttribArchive(Attr : Boolean);
      procedure SetAttribCompressed(Attr : Boolean);
      procedure SetAttribHidden(Attr : Boolean);
      procedure SetAttribNormal(Attr : Boolean);
      procedure SetAttribReadOnly(Attr : Boolean);
      procedure SetAttribSystem(Attr : Boolean);
      procedure SetAttribTemporary(Attr : Boolean);
      procedure SetBufferSize(BSize : DWord);
      procedure SetBufferWrites(AllowWritesBuffered : Boolean);
      procedure SetCreationStyle(Style : Integer);
      procedure SetFileName(FName : String);
      procedure SetFilePosition(Pos : DWord);

      //Direct Buffer functions
      function ReadXBytesFromBuffer(X : DWord; var BRead : DWord) : String;
      procedure WriteXBytesToBuffer(X : DWord; var Buffer;
        var BWrite : DWord);

      //Read Functions
      function ReadEOL : String;
      function ReadLn : String;
      function ReadPChar : PChar;
      function ReadByte : Byte;
      function ReadWord : Word;
      function ReadDword : Integer;

      //Write Functions
      function WriteLn(s : String) : DWord;
      function WritePChar(pc : PChar) : DWord;
      function WriteString(s : String) : DWord;
      function WriteByte(b : Byte) : DWord;
      function WriteWord(w : Word) : DWord;
      function WriteDWord(d : Integer) : DWord;

      property AccessFlags : Integer read fioAccessFlags write SetAccessFlags;
      property AccessMode : Integer read fioAccessMode write SetAccessMode;
      property Attributes : DWORD read GetAttributes write SetAttributes;
      property AttribArchive : Boolean read GetAttribArchive
        write SetAttribArchive;
      property AttribCompressed : Boolean read GetAttribCompressed
        write SetAttribCompressed;
      property AttribHidden : Boolean read GetAttribHidden
        write SetAttribHidden;
      property AttribNormal : Boolean read GetAttribNormal
        write SetAttribNormal;
      property AttribReadOnly : Boolean read GetAttribReadOnly
        write SetAttribReadOnly;
      property AttribSystem : Boolean read GetAttribSystem
        write SetAttribSystem;
      property AttribTemporary : Boolean read GetAttribTemporary
        write SetAttribTemporary;
      property BufferSize : DWord read fioBufferSize write SetBufferSize;
      property BufferWrites : Boolean read fioBufferWrites write SetBufferWrites;
      property CreationStyle : Integer read fioCreationStyle
                 write SetCreationStyle;
      property EOF : Boolean read fioNoBufferLeft;
      property FileName : String read fioFileName write SetFileName;
      property FileHandle : DWord read fioHandle;
      property FilePosition : DWORD read fioFilePos write SetFilePosition;
    private
      //The real heart of it...
      procedure OpenFile;
      procedure FillBuffer;
      procedure WriteBuffer;
    end;

    TWinshoeDebugToFile = class(TFIO)
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
    end;

    TWinshoeWriteFile = class(TFIO)
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
    end;

    TWinshoeOverWriteFile = class(TFIO)
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
    end;

    TWinshoeReadFile = class(TFIO)
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
    end;

    TWinshoeReadWriteFile = class(TFIO)
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
    end;

const
     //While these at first appear to be just copies of the system vars, the
     //values improve future compatibility if the fio versions are used.  You
     //never know - an alteration here may help out in functionality... as the
     //access mode constants show

     //Note on constants given: some of the constants are NT only (security
     //stuff for example.  I (PM) envision a separate NT-specific encapsulation
     //that is an inheritence from this.  Access Masks, etc. could then be
     //included in the new object.

     //////////////////////////
     // fioAccessMode constants
     //////////////////////////

     // Don't open the file at all... effective close file.
     fioNO_ACCESS = 256;
     // Allows access to file attributes only - no read / write functions
     fioNO_FILE_ACCESS = 1;
     // Read access
     fioREAD_ACCESS = 2;
     // Write access
     fioWRITE_ACCESS = 4;
     // Read / write access
     fioREAD_WRITE_ACCESS = fioREAD_ACCESS or fioWRITE_ACCESS;
     // Append access.  Use fioAPPEND_ACCESS instead of fioAPPEND_FLAG.
     // fioAPPEND_FLAG is used internally for checking the APPEND bit.
     fioAPPEND_FLAG = 8;
     fioAPPEND_ACCESS = fioAPPEND_FLAG or fioWRITE_ACCESS;
     // fioCLOSE_AFTER_ACCESS enables all other attributes to remain the same
     // but the program does not hold open a file handle.  Often desirable
     // when accessing files shared among the masses and are often changed
     // by other users (which means your buffers within this object could be
     // out of date very quickly).  Also good for writing to a file that is
     // being modified by others programs.  Note: this does differ from the
     // fioFLAG_NO_BUFFERING for fioAccessFlags in that Windows buffers remains
     // used and exclusive access by other programs is possible between reads
     // and writes.
     //
     // Note: this flag can not be used on it's own but must be used
     // with a Read, Write or Append flag as well.
     fioCLOSE_AFTER_ACCESS = 32;
     // fioFLUSH_AFTER_WRITE causes the WriteBuffer procedure to request of
     // windows to ensure that the written data gets to the disc A.S.A.P.
     // Use of this flag still allows Windows a 'lazy flush'.  For true
     // disc-write operation, use the fioFLAG_WRITE_THROUGH for the
     // fioAccessFlags instead.
     //
     // Note: this flag can not be used on it's own but must be used
     // with a Write or Append flag as well.
     fioFLUSH_AFTER_WRITE = 64;


     ///////////////////////////
     // fioShareAccess constants
     ///////////////////////////
     fioNO_SHARE = 0;
     fioREAD_SHARE = FILE_SHARE_READ;
     fioWRITE_SHARE = FILE_SHARE_WRITE;

     /////////////////////////////
     // fioCreationStyle constants
     /////////////////////////////
     fioCREATE_ALWAYS = CREATE_ALWAYS;
     fioCREATE_NEW = CREATE_NEW;
     fioOPEN_ALWAYS = OPEN_ALWAYS;
     fioOPEN_EXISTING = OPEN_EXISTING;
     fioTRUNCATE_EXISTING = TRUNCATE_EXISTING;

     //////////////////////////
     // Disclaimer for comments
     //////////////////////////
     //fioAccessFlags constants (large portions of the comments in the constants
     //section are taken ad-verbatim direct from the Borland Delphi 3-installed
     //help files. Apologies in for copyright infringements.
     //Remember - they can be removed).

     // Attributes on the file - these may be used for creation
     //////////////////////////////////////////////////////////
     fioATTRIBUTE_NORMAL = FILE_ATTRIBUTE_NORMAL;
     // Combinations of these flags can be used (ATTRIBUTE_xxx, FLAG_xxx,
     // and SECURITY_xxx values)
     fioATTRIBUTE_ARCHIVE = FILE_ATTRIBUTE_ARCHIVE;
     fioATTRIBUTE_COMPRESSED = FILE_ATTRIBUTE_COMPRESSED;
     fioATTRIBUTE_HIDDEN = FILE_ATTRIBUTE_HIDDEN;
     fioATTRIBUTE_READONLY = FILE_ATTRIBUTE_READONLY;
     fioATTRIBUTE_SYSTEM = FILE_ATTRIBUTE_SYSTEM;
     fioATTRIBUTE_TEMPORARY = FILE_ATTRIBUTE_TEMPORARY;

     // Attributes on the 'file' - these may only be tested for
     //////////////////////////////////////////////////////////
     fioATTRIBUTE_DIRECTORY = FILE_ATTRIBUTE_DIRECTORY;
     fioATTRIBUTE_OFFLINE = FILE_ATTRIBUTE_OFFLINE;  //Backed up to tape, etc.

     // Known variables, but unknown values:
     // fioATTRIBUTE_ATOMIC_WRITE = FILE_ATTRIBUTE_ATOMIC_WRITE;
     // fioATTRIBUTE_XACTION_WRITE = FILE_ATTRIBUTE_XACTION_WRITE;


     // Additional flags for fioAccessFlags
     //////////////////////////////////////
     
     // Instructs the operating system to write through any intermediate cache
     // and go directly to the file. The operating system can still cache write
     // operations, but cannot lazily flush them.
     fioFLAG_WRITE_THROUGH = FILE_FLAG_WRITE_THROUGH;

     // Instructs the operating system to initialize the file, so ReadFile,
     // WriteFile, ConnectNamedPipe, and TransactNamedPipe operations that take
     // a significant amount of time to process return ERROR_IO_PENDING. When
     // the operation is finished, an event is set to the signaled state.
     //
     // When you specify FILE_FLAG_OVERLAPPED, the ReadFile and WriteFile
     // functions must specify an OVERLAPPED structure. That is, when
     // FILE_FLAG_OVERLAPPED is specified, an application must perform
     // overlapped reading and writing.
     //
     // When FILE_FLAG_OVERLAPPED is specified, the operating system does not
     // maintain the file pointer. The file position must be passed as part of
     // the lpOverlapped parameter (pointing to an OVERLAPPED structure) to
     // the ReadFile and WriteFile functions.
     //
     // This flag also enables more than one operation to be performed
     // simultaneously with the handle (a simultaneous read and write
     // operation, for example).
     fioFLAG_OVERLAPPED = FILE_FLAG_OVERLAPPED;

     // Instructs the operating system to open the file with no intermediate
     // buffering or caching. This can provide performance gains in some
     // situations. An application must meet certain requirements when working
     // with files opened with FILE_FLAG_NO_BUFFERING:·	File access must begin
     // at offsets within the file that are integer multiples of the volume's
     // sector size. ·	File access must be for numbers of bytes that are
     // integer multiples of the volume's sector size. For example, if the
     // sector size is 512 bytes, an application can request reads and writes
     // of 512, 1024, or 2048 bytes, but not of 335, 981, or 7171 bytes.
     //
     // Buffer addresses for read and write operations must be aligned on
     // addresses in memory that are integer multiples of the volume's sector
     // size. An application can determine a volume's sector size by calling
     // the GetDiskFreeSpace function.
     fioFLAG_NO_BUFFERING = FILE_FLAG_NO_BUFFERING;

     // Indicates that the file is accessed randomly. Windows uses this flag
     // to optimize file caching.
     fioFLAG_RANDOM_ACCESS = FILE_FLAG_RANDOM_ACCESS;

     // Indicates that the file is to be accessed sequentially from beginning
     // to end. Windows uses this flag to optimize file caching. If an
     // application moves the file pointer for random access, optimum caching
     // may not occur; however, correct operation is still guaranteed.
     //
     // Specifying this flag can increase performance for applications that
     // read large files using sequential access. Performance gains can be
     // even more noticeable for applications that read large files mostly
     // sequentially, but occasionally skip over small ranges of bytes.
     fioFLAG_SEQUENTIAL_SCAN = FILE_FLAG_SEQUENTIAL_SCAN;

     // Indicates that the operating system is to delete the file immediately
     // after all of its handles have been closed.  If you use this flag when
     // you call CreateFile, then open the file again, and then close the
     // handle for which you specified FILE_FLAG_DELETE_ON_CLOSE, the file
     // will not be deleted until after you have closed the second and any
     // other handle to the file.
     fioFLAG_DELETE_ON_CLOSE = FILE_FLAG_DELETE_ON_CLOSE;

     // Indicates that the file is to be accessed according to POSIX rules.
     // This includes allowing multiple files with names, differing only in
     // case, for file systems that support such naming. Use care when using
     // this option because files created with this flag may not be accessible
     // by applications written for MS-DOS, Windows 3.x, or Windows NT.
     fioFLAG_POSIX_SEMANTICS = FILE_FLAG_POSIX_SEMANTICS;

implementation

uses GlobalWinshoe; //Only to import CR & LF defs... no point duplicating them

constructor TFIO.Create;
begin
     inherited;
     fioHandle := INVALID_HANDLE_VALUE;
     //No special attribute checking yet
     fioAccessFlags := FILE_ATTRIBUTE_NORMAL;
     fioAccessMode := fioNO_ACCESS;
     //Use compatible sharing - locking not yet impl.
     fioShareAccess := fioREAD_SHARE or fioWRITE_SHARE;
     //For now, open regardless of current existence
     fioCreationStyle := fioOPEN_EXISTING;
     fioFileName := '';
     fioFilePos := 0;
     fioBufferSize := 4096;
     fioBufferRead := 0;
     fioBufferPos := 1;
     SetLength(fioBuffer, fioBufferSize);
     fioBufferWrites := False;
     fioBufferDirty := False;
     fioBufferWrite := 0;
     fioEOL := CR + LF;
end;

destructor TFIO.Destroy;
begin
     CloseFile;
     inherited Destroy;
end;

procedure TFIO.SetAccessMode;
var
   Change : Integer;
   CloseNeeded : Boolean;
begin
     If Mode <> fioAccessMode then begin

        //Check if the alteration does requires a close and re-open
        Change := (Mode xor fioAccessMode) and Mode;
        CloseNeeded := True;

        // At time of construction, the check is only needed for the
        // fioFLUSH_AFTER_WRITE and fioAPPEND_FLAG options... but the
        // structure is good for an
        // easy alteration later. ;-) 
        while Change <> 0 do begin
          // Check for consts that do not require a close first
          if Change and fioFLUSH_AFTER_WRITE = fioFLUSH_AFTER_WRITE then begin
             FlushBuffer;
             Change := Change xor fioFLUSH_AFTER_WRITE;
             CloseNeeded := False;

          end else if Change and fioAPPEND_FLAG = fioAPPEND_FLAG
          then begin
             Change := Change xor fioAPPEND_FLAG;
             CloseNeeded := False;

          // Check for consts that do require a close

          // If a const requires a special action then it should be tested
          // for before the default (as the fioFLUSH_AFTER_WRITE requires
          // use of the FlushBuffer).
          end else begin
              CloseNeeded := True;
              Change := 0;
          end;
        end;

        if not CloseNeeded then Exit;
         
        //Ensure that the current handle does not get lost
        CloseFile;

        if Mode and fioNO_ACCESS = fioNO_ACCESS then begin
          fioRealAccessMode := 0;
        end else if Mode and (fioREAD_ACCESS or fioWRITE_ACCESS) =
        (fioREAD_ACCESS or fioWRITE_ACCESS) then begin
          fioRealAccessMode := Integer(GENERIC_READ or GENERIC_WRITE);
        end else if Mode and fioREAD_ACCESS = fioREAD_ACCESS then begin
          fioRealAccessMode := Integer(GENERIC_READ);
        end else if Mode and fioWRITE_ACCESS = fioWRITE_ACCESS then begin
          fioRealAccessMode := GENERIC_WRITE;
        end else if Mode and fioAPPEND_FLAG = fioAPPEND_FLAG then begin
          // Capture for someone using only the fioAPPEND_FLAG on it's own
          fioRealAccessMode := GENERIC_WRITE;
        end else if Mode and fioNO_FILE_ACCESS = fioNO_FILE_ACCESS then begin
          fioRealAccessMode := 0; 
        end;

        fioAccessMode := Mode;

        if (fioAccessMode <> fioNO_ACCESS)
        and (fioAccessMode and fioCLOSE_AFTER_ACCESS <> fioCLOSE_AFTER_ACCESS)
        then begin
           OpenFile;
        end else begin
            // File should be closed if open
            If fioHandle <> INVALID_HANDLE_VALUE then begin
               //Close the current handle
               CloseHandle(fioHandle);
               fioHandle := INVALID_HANDLE_VALUE;
            end;
        end;
     end;
end;

procedure TFIO.FillBuffer;
begin
     if fioAccessMode and fioCLOSE_AFTER_ACCESS = fioCLOSE_AFTER_ACCESS
     then begin
       OpenFile;
       if fioHandle = INVALID_HANDLE_VALUE then begin
          // Should raise an exception instead
          Exit;
       end;
     end;

     SetFilePointer(fioHandle, fioFilePos, Nil, FILE_BEGIN);
     ReadFile(fioHandle, fioBuffer[1], fioBufferSize, fioBufferRead, Nil);

     fioFilePos := fioFilePos + fioBufferRead;
     fioBufferPos := 1;
     fioBufferWrite := 0;
     fioBufferDirty := False;

     //Check if buffer is full or the EOF has been reached
     if fioBufferSize <> fioBufferRead then begin
        fioEOF := True;
        if fioBufferRead = 0 then begin
           fioNoBufferLeft := True;
        end;
     end else begin
         fioEOF := False;
         fioNoBufferLeft := False;
     end;

     if fioAccessMode and fioCLOSE_AFTER_ACCESS = fioCLOSE_AFTER_ACCESS
     then begin
       CloseFile;
     end;
end;

function TFIO.ReadXBytesFromBuffer;
var
   BytesDone : DWord;
begin
     If X <= 0 then begin
        BRead := 0;
        result := '';
        // Valid return value - no exception needed
        Exit;
     end;

     FlushBuffer;

     If fioBufferPos > fioBufferRead then begin
        FillBuffer;
        If fioBufferRead = 0 then begin
           BRead := 0;
           fioNoBufferLeft := True;
           result := '';
           // Valid return value - no exception needed
           Exit;
        end;
     end;

     If X < fioBufferRead + 1 - fioBufferPos then begin
        result := Copy(fioBuffer, fioBufferPos, X);
        fioBufferPos := fioBufferPos + X;
        BRead := X;
     end else begin
         result := Copy(fioBuffer, fioBufferPos, fioBufferRead + 1);

         If fioEOF then begin
            BRead := fioBufferRead + 1 - fioBufferPos;
            fioBufferPos := fioBufferRead + 1;
         end else begin
             BytesDone := fioBufferRead + 1 - fioBufferPos;
             FillBuffer;
             result := result + ReadXBytesFromBuffer(X - BytesDone, BRead);
             BRead := BRead + BytesDone;
         end;
     end;
end;

procedure TFIO.WriteBuffer;
begin
     //Don't do any checks on the status of the buffer as this should only
     //be called by this object's own procedures which should know better.
     // - Should...

     if fioAccessMode and fioCLOSE_AFTER_ACCESS = fioCLOSE_AFTER_ACCESS
     then begin
       OpenFile;
       if fioHandle = INVALID_HANDLE_VALUE then begin
          // Should raise an exception instead
          Exit;
       end;
     end;

     if fioAccessMode and fioAPPEND_FLAG = fioAPPEND_FLAG then begin
        SetFilePointer(fioHandle, 0, Nil, FILE_END);
     end else begin
         SetFilePointer(fioHandle, fioFilePos, Nil, FILE_BEGIN);
     end;
     WriteFile(fioHandle, fioBuffer[1], fioBufferRead, fioBufferWrite, Nil);
     fioBufferRead := 0;
     fioBufferPos := 1;
     fioBufferDirty := False;

     if (fioAccessMode and fioFLUSH_AFTER_WRITE = fioFLUSH_AFTER_WRITE)
     and (fioRealAccessMode and GENERIC_WRITE = GENERIC_WRITE)
     then begin
          if not FlushFileBuffers(fioHandle) then begin
             // Should check for fioCLOSE_AFTER_ACCESS and then raise an error
             GetLastError;
          end;
     end;
     
     if fioAccessMode and fioCLOSE_AFTER_ACCESS = fioCLOSE_AFTER_ACCESS
     then begin
       CloseFile;
     end;
end;

procedure TFIO.WriteXBytesToBuffer;
var
   BytesDone : DWord;
   PBuff : Pointer;
begin
     If X = 0 then begin
        BWrite := 0;
        // Valid return value - no exception needed
        Exit;
     end;

     if X < fioBufferSize - fioBufferPos then begin
        CopyMemory(@fioBuffer[fioBufferPos], @Buffer, X);
        fioBufferRead := fioBufferRead + X;
        fioBufferPos := fioBufferPos + X;
        BWrite := X;
        fioBufferDirty := True;
     end else begin
         //Fill the buffer and then write it
         CopyMemory(@fioBuffer[fioBufferPos], @Buffer,
           fioBufferSize - fioBufferPos);
         BytesDone := fioBufferSize - fioBufferPos;
         fioBufferRead := fioBufferSize;
         WriteBuffer;

         //Write the rest
         Inc(DWord(Buffer), BytesDone);
         WriteXBytesToBuffer(X - BytesDone, PBuff, BWrite);
         BWrite := BWrite + BytesDone;
     end;

     if not fioBufferWrites then begin
        WriteBuffer;
        fioFilePos := fioFilePos + BWrite;
     end;
end;

procedure TFIO.SetBufferWrites;
begin
     If AllowWritesBuffered <> fioBufferWrites then begin
        FlushBuffer;
        fioBufferWrites := AllowWritesBuffered;
     end;
end;

procedure TFIO.SetFileName;
begin
     //Purposefully don't check for setting to the same file to allow for
     //an effective flush of the file with subsequent re-open, resetting all
     //variables as well.
     CloseFile;

     fioFileName := FName;
     fioEOF := false;
     fioNoBufferLeft := false;
     fioFilePos := 0;
     fioBufferRead := 0;
     fioBufferPos := 1;
     
     if (fioAccessMode <> fioNO_ACCESS)
     and (fioAccessMode and fioCLOSE_AFTER_ACCESS <> fioCLOSE_AFTER_ACCESS)
     then begin
        OpenFile;
     end;
end;

procedure TFIO.OpenFile;
begin
     //Attempt to open the fFileName for fioAccessMode access
     fioHandle := CreateFile(PChar(fioFileName),
               fioRealAccessMode,
               fioShareAccess,
               Nil,
               fioCreationStyle,
               fioAccessFlags,
               0);
     If fioHandle <> INVALID_HANDLE_VALUE then begin
         fioFilePos := 0;
         FillBuffer;
     end;
end;

procedure TFIO.SetBufferSize;
begin
     If fioBufferSize <> BSize then begin
        FlushBuffer;

        try
           SetLength(fioBuffer, BSize);
           fioBufferSize := BSize;
           //Set the vars to force a new read / write
           fioBufferRead := 0;
           fioBufferPos := 1;
        except
        end;
     end;
end;

function TFIO.ReadEOL;
var
   i, j : DWord;
   EOLFound : Boolean;
begin
     EOLFound := False;

     result := '';
     repeat
           i := Pos(fioEOL, Copy(fioBuffer, fioBufferPos, fioBufferRead));
           if i <> 0 then begin
              EOLFound := True;
              //Remove the reference to the first char of the fioEOL
              Dec(i);
           end else begin
               //Capture all the current buffer
               i := fioBufferRead + 1 - fioBufferPos;
               if fioEOF then begin
                  EOLFound := True;
               end;
           end;
           result := result + ReadXBytesFromBuffer(i + DWORD(length(fioEOL)), j);
     until EOLFound;
end;

function TFIO.ReadLn;
var
   s, ret : String;
   i : Integer;
begin
     s := fioEOL;
     fioEOL := CR + LF;
     ret := ReadEOL;
     i := Pos(CR, ret); //This should be length(ret) - 2, but could be the EOF
     if i <> 0 then begin
        result := Copy(ret, 1, i - 1);
     end;
     fioEOL := s;
end;

function TFIO.ReadByte;
var
   BRead : DWord;
   s : String;
begin
     s := ReadXBytesFromBuffer(1, BRead);
     if BRead <> 0 then begin
        result := Ord(s[1]);
     end else begin
         // Should raise an exception?
         result := $FF;
     end;
end;

function TFIO.ReadWord;
begin
     result := ReadByte;
     result := result + (ReadByte * 256);
end;

function TFIO.ReadDWord;
begin
     result := ReadWord;
     result := result + (ReadWord * (256 * 256));
end;

function TFIO.WriteLn;
begin
     s := s + CR + LF;
     WriteXBytesToBuffer(length(s), s[1], result);
end;

function TFIO.ReadPChar;
var
   s, ret : String;
begin
     s := fioEOL;
     fioEOL := #0;
     ret := ReadEOL + #0;
     try
        GetMem(result, Length(ret));
        CopyMemory(result, @ret[1], Length(ret));
     except
           result := Nil;
     end;     
     fioEOL := s;
end;

function TFIO.WritePChar;
var
   ln : Integer;
   s : String;
begin
     ln := StrLen(pc);
     SetLength(s, ln);
     CopyMemory(@s[1], pc, ln);
     WriteXBytesToBuffer(ln, s[1], result);
end;

function TFIO.WriteString;
begin
     WriteXBytesToBuffer(length(s), s[1], result);
end;

function TFIO.WriteByte;
begin
     WriteXBytesToBuffer(1, b, result);
end;

function TFIO.WriteWord;
begin
     WriteXBytesToBuffer(2, w, result);
end;

function TFIO.WriteDWord;
begin
     WriteXBytesToBuffer(4, d, result);
end;

procedure TFIO.SetFilePosition;
begin
     if (fioFilePos + fioBufferRead > Pos) and (fioFilePos < Pos) then begin
        // The file position is within the boundaries of the current buffer
        // so set the buffer.
        fioBufferPos := Pos - fioFilePos;
     end else begin
         //Just set the vars to force a new read / write on next function
         fioFilePos := Pos;
         fioBufferRead := 0;
         fioBufferPos := 1;
     end;
end;

procedure TFIO.SetCreationStyle;
begin
     if Style = fioCreationStyle then begin
        Exit;
     end;
     
     if fioHandle = INVALID_HANDLE_VALUE then begin
        fioCreationStyle := Style;
     end else begin
         CloseFile;
         
         fioCreationStyle := Style;
         
         if (fioAccessMode <> fioNO_ACCESS)
         and (fioAccessMode and fioCLOSE_AFTER_ACCESS <> fioCLOSE_AFTER_ACCESS)
         then begin
            OpenFile;
         end;
     end;
end;

procedure TFIO.SetAccessFlags;
begin
     if fioAccessFlags = sFlags then begin
        Exit;
     end;

     if fioHandle = INVALID_HANDLE_VALUE then begin
        fioAccessFlags := sFlags;
     end else begin
         CloseFile;
         
         fioAccessFlags := sFlags;

         if (fioAccessMode <> fioNO_ACCESS)
         and (fioAccessMode and fioCLOSE_AFTER_ACCESS <> fioCLOSE_AFTER_ACCESS)
         then begin
            OpenFile;
         end;
     end;
end;

procedure TFIO.CloseFile;
begin
     if fioHandle <> INVALID_HANDLE_VALUE then begin
        FlushBuffer;
        CloseHandle(fioHandle);
     end;
end;

procedure TFIO.FlushBuffer;
begin
     if fioBufferWrites then begin
        if fioBufferDirty then begin
           WriteBuffer;
           fioBufferDirty := False;
        end;
     end;
end;

function TFIO.RemoveFile;
begin
     CloseFile;
     result := DeleteFile(fioFileName);
end;

function TFIO.GetAttributes;
begin
     result := GetFileAttributes(PChar(fioFileName));
end;

procedure TFIO.SetAttributes;
begin
     SetFileAttributes(PChar(fioFileName), Attr);
end;

function TFIO.GetAttribArchive;
begin
     result := GetAttributes and FILE_ATTRIBUTE_ARCHIVE =
       FILE_ATTRIBUTE_ARCHIVE;
end;

function TFIO.GetAttribCompressed;
begin
     result := GetAttributes and FILE_ATTRIBUTE_COMPRESSED =
       FILE_ATTRIBUTE_COMPRESSED;
end;

function TFIO.GetAttribHidden;
begin
     result := GetAttributes and FILE_ATTRIBUTE_HIDDEN = FILE_ATTRIBUTE_HIDDEN;
end;

function TFIO.GetAttribNormal;
begin
     result := GetAttributes = FILE_ATTRIBUTE_NORMAL;
end;

function TFIO.GetAttribReadOnly;
begin
     result := GetAttributes and FILE_ATTRIBUTE_READONLY =
       FILE_ATTRIBUTE_READONLY;
end;

function TFIO.GetAttribSystem;
begin
     result := GetAttributes and FILE_ATTRIBUTE_SYSTEM = FILE_ATTRIBUTE_SYSTEM;
end;

function TFIO.GetAttribTemporary;
begin
     result := GetAttributes and FILE_ATTRIBUTE_TEMPORARY =
       FILE_ATTRIBUTE_TEMPORARY;
end;

procedure TFIO.SetAttribArchive;
begin
     SetAttributes(GetAttributes and FILE_ATTRIBUTE_ARCHIVE); 
end;

procedure TFIO.SetAttribCompressed;
begin
     SetAttributes(GetAttributes and FILE_ATTRIBUTE_COMPRESSED);
end;

procedure TFIO.SetAttribHidden;
begin
     SetAttributes(GetAttributes and FILE_ATTRIBUTE_HIDDEN);
end;

procedure TFIO.SetAttribNormal;
begin
     SetAttributes(FILE_ATTRIBUTE_NORMAL);
end;

procedure TFIO.SetAttribReadOnly;
begin
     SetAttributes(GetAttributes and FILE_ATTRIBUTE_READONLY);
end;

procedure TFIO.SetAttribSystem;
begin
     SetAttributes(GetAttributes and FILE_ATTRIBUTE_SYSTEM);
end;

procedure TFIO.SetAttribTemporary;
begin
     SetAttributes(GetAttributes and FILE_ATTRIBUTE_TEMPORARY);
end;

function TFIO.GetRealSize;
var
   bh : TByHandleFileInformation;
begin
     if fioAccessMode and fioCLOSE_AFTER_ACCESS = fioCLOSE_AFTER_ACCESS then begin
        OpenFile;
     end;
     if GetFileInformationByHandle(fioHandle, bh) then begin
        result := bh.nFileSizeLow;                
     end else begin
         // Should raise exception...
         //Clear windows error:
         GetLastError;
         result := $FFFFFFFF;
     end;
     if fioAccessMode and fioCLOSE_AFTER_ACCESS = fioCLOSE_AFTER_ACCESS then begin
        CloseFile;
     end;
end;

function TFIO.GetSize : DWORD;
begin
     result := GetRealSize;
     if (result <> DWORD(-1)) and (fioBufferWrites) then begin
        if fioBufferDirty then begin
           result := result + fioBufferRead;
        end;
     end;
end;

//////////////////////////////////////////

constructor TWinshoeDebugToFile.Create;
begin
     inherited Create(AOwner);
     // As this would principally be used for debugging it is desireable to
     // ensure Windows understands it shouldn't cache the writes for long (see
     // notes for the fioFLUSH_AFTER_WRITE flag above).
     // Also: if file exists then append to it, otherwise create it

     SetAccessMode(fioAPPEND_ACCESS or fioFLUSH_AFTER_WRITE);
     SetCreationStyle(fioOPEN_ALWAYS);
end;

destructor TWinshoeDebugToFile.Destroy;
begin
     inherited Destroy;
end;

//////////////////////////////////////////

constructor TWinshoeWriteFile.Create;
begin
     inherited Create(AOwner);
     SetAccessMode(fioWRITE_ACCESS);
     SetCreationStyle(fioCREATE_NEW);
end;

destructor TWinshoeWriteFile.Destroy;
begin
     inherited Destroy;
end;

//////////////////////////////////////////

constructor TWinshoeOverWriteFile.Create;
begin
     inherited Create(AOwner);
     SetAccessMode(fioWRITE_ACCESS);
     SetCreationStyle(fioOPEN_ALWAYS);
end;

destructor TWinshoeOverWriteFile.Destroy;
begin
     inherited Destroy;
end;

//////////////////////////////////////////

constructor TWinshoeReadFile.Create;
begin
     inherited Create(AOwner);
     SetAccessMode(fioREAD_ACCESS);
     SetCreationStyle(fioOPEN_EXISTING);
end;

destructor TWinshoeReadFile.Destroy;
begin
     inherited Destroy;
end;

//////////////////////////////////////////

constructor TWinshoeReadWriteFile.Create;
begin
     inherited Create(AOwner);
     SetAccessMode(fioREAD_ACCESS or fioWRITE_ACCESS);
     SetCreationStyle(fioOPEN_ALWAYS);
end;

destructor TWinshoeReadWriteFile.Destroy;
begin
     inherited Destroy;
end;

end.
