{$MODE OBJFPC}
{$R-,Q-,S-,I-}
{$OPTIMIZATION LEVEL2}
program IntervalCover;
uses Windows, SysUtils, Math;
const
  InputFile  = 'DIVIDE.INP';
  OutputFile = 'DIVIDE.OUT';
var
  dirT, dirC: WideString;
  res, reshs, sum, n : longint;
  a, b : array [0..5000] of longint;
  ok  : boolean;
procedure GenErr(const s: string; const param: array of const);
begin
  raise Exception.CreateFmt(s, param);
end;

procedure ReadDirs;
var
  s: AnsiString;
begin
  ReadLn(s); dirT := Utf8Decode(s);
  ReadLn(s); dirC := Utf8Decode(s);
end;

procedure ReadInput;
var
  f: TextFile;
  i : longint;
begin
  SetCurrentDirectoryW(PWideChar(dirT));
  AssignFile(f, inputFile); Reset(f);
      Readln(f, n);
      for i := 1 to n do read(f, a[i]);
      for i := 1 to n do read(f, b[i]);
  CloseFile(f);
end;

procedure ReadOutput;
    var f : textfile;
begin
  SetCurrentDirectoryW(PWideChar(dirT));
  AssignFile(f, outputFile); Reset(f);
    readln(f, res);
  CloseFile(f);
end;

procedure AllTasks;
begin
  ReadInput;
  ReadOutput;
end;

procedure DoCheck;
var
  f: TextFile;
  u, v : longint;
begin
  AllTasks;
  SetCurrentDirectoryW(PWideChar(DirC));
  if not FileExists(OutputFile) then
    GenErr('Kh'#$C3#$B4'ng th'#$E1#$BA#$A5'y file %s', [OutputFile]);
  AssignFile(f, OutputFile); Reset(f);
  try
    Read(f, reshs);
    if (res <> reshs) then
      GenErr('KET QUA SAI', []);
    sum := 0;
    while not seekeof(f) do
      begin
         u := 0; v := 0;
         read(f, u, v);
         if (a[u] > a[v]) then inc(sum, b[v])
         else inc(sum, b[u]);
      end;
    if (sum <> res) then GenErr('TRUY VET SAI', []);
    WriteLn('KET QUA DUNG');
    WriteLn('0.35');
  finally
    CloseFile(f);
  end;
end;

begin

  ReadDirs;
  Write(#$EF#$BB#$BF); //Utf-8 BOM
  try
    ok := true;
    DoCheck;
  except
    on E: Exception do
      begin
        WriteLn(E.Message);
        writeln('0.0');
      end;
  end;
end.
