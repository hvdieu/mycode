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
  res, reshs : string;
  n, k : longint;
  a : array [1..2000, 1..2000] of longint;
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
  i, j : longint;
begin
  SetCurrentDirectoryW(PWideChar(dirT));
  AssignFile(f, inputFile); Reset(f);
      Readln(f, k, n);
      for i := 1 to n do 
		for j := 1 to n do read(f, a[i][j]);
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
  i, j, x1, y1, x2, y2 : longint;
  sum : int64;
begin
  AllTasks;
  SetCurrentDirectoryW(PWideChar(DirC));
  if not FileExists(OutputFile) then
    GenErr('Kh'#$C3#$B4'ng th'#$E1#$BA#$A5'y file %s', [OutputFile]);
  AssignFile(f, OutputFile); Reset(f);
  try
    Readln(f, reshs);
	close(f);
	AssignFile(f, OutputFile); Reset(f);
    if (res = 'NIE') and (reshs <> 'NIE') then
      GenErr('KET QUA SAI', []);
	if (res <> 'NIE') and (reshs = 'NIE') then
	  GenErr('KET QUA SAI', []);
    sum := 0;
	readln(f, y1, x1, y2, x2);
    for i := x1 to x2 do
		for j := y1 to y2 do sum := sum + a[i][j];
    if (sum >= k) and (sum <= 2*k) then 
		begin
			WriteLn('KET QUA DUNG');
			WriteLn('0.35');
		end;
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
