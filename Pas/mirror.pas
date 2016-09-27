Uses math;
Const   inp = 'mirror.in';
        out = 'mirror.out';
        maxn = 1001;

Var     m,n,res     :       longint;
        a       :       array [0..maxn,0..maxn] of char;
        f       :       array [0..maxn,0..maxn,1..4] of longint;
        check   :       array [0..maxn,0..maxn,1..4] of boolean;

{***************************************************************************}
procedure nhap;
var i,j : longint;
    ch : char;
  begin
      assign(input,inp); reset(input);
      assign(output,out); rewrite(output);
      readln(m,n);
      for i := 1 to m do
        begin
            for j := 1 to n do read(a[i,j]);
            readln;
        end;
  end;
{***************************************************************************}
function tinh(i,j,tt : longint) : longint;
  begin
      if (i=0) or (j=0) or (i>m) or (j>n) then exit(0);
      if check[i,j,tt] then exit(f[i,j,tt]);
      if a[i,j]='\' then
        begin
            if tt=1 then f[i,j,tt] := 1+tinh(i,j+1,4);
            if tt=2 then f[i,j,tt] := 1+tinh(i-1,j,3);
            if tt=3 then f[i,j,tt] := 1+tinh(i,j-1,2);
            if tt=4 then f[i,j,tt] := 1+tinh(i+1,j,1);
        end else
        begin
            if tt=1 then f[i,j,tt] := 1+tinh(i,j-1,2);
            if tt=2 then f[i,j,tt] := 1+tinh(i+1,j,1);
            if tt=3 then f[i,j,tt] := 1+tinh(i,j+1,4);
            if tt=4 then f[i,j,tt] := 1+tinh(i-1,j,3);
        end;
      check[i,j,tt] := true;
      exit(f[i,j,tt]);
  end;
{***************************************************************************}
procedure main;
var i,j : longint;
  begin
      res := -1;
      for i := 1 to m do
        begin
            res := max(res,tinh(i,1,4));
            res := max(res,tinh(i,n,2));
        end;
      for j := 1 to n do
        begin
            res := max(res,tinh(1,j,1));
            res := max(res,tinh(m,j,3));
        end;
      writeln(res);
  end;
{***************************************************************************}
begin
     nhap;
     main;
end.