uses math;
Const   maxm = 10001;
        maxn = 16;
        maxw = 999999999;

Var     m,n,i,j,res :       longint;
        a       :       array [1..maxm,1..maxn] of integer;
        c       :       array [1..maxn,1..maxn] of longint;
        f       :       array [1..maxn,0..65600] of longint;

{**************************************************************************}
procedure nhap;
var i,j,num : integer;
    ch : char;
        begin
             assign(input,'NHPAINT.INP'); reset(input);
             assign(output,'NHPAINT.OUT'); rewrite(output);
             readln(m,n);
             for i := 1 to m do
             begin
              for j := 1 to n do
              begin
                read(ch);
                val(ch,num);
                a[i,j] := num;
              end;
              readln;
             end;
        end;
{**************************************************************************}
function lay(x,i : longint) : longint;
        begin
            lay := (x shr i) and 1;
        end;
{*************************************************************************}
function bat(x,i : longint) : longint;
        begin
            bat := x or (1 shl i);
        end;
{*************************************************************************}
function tinh(i,j : longint) : longint;
var k,dem,count : longint;
        begin
            dem := 0;
            for k := 1 to m do
              begin
                  if a[k,j] = 1 then inc(count);
                  if a[k,i] <> a[k,j] then inc(dem);
              end;
            if abs(i-j) > 1 then exit(dem)
             else exit(min(dem,count));
        end;
{**************************************************************************}
procedure main;
var i,j,tt,x,dem : longint;
        begin
            for i := 1 to n do
             for j := 1 to n do
             if i <> j then c[i,j] := tinh(i,j);

            for i := 1 to n do
             for j := 0 to (1 shl n)-1 do f[i,j] := maxw;

            for j := 1 to n do
             begin
              dem := 0;
              for i := 1 to m do if a[i,j] = 1 then inc(dem);
              f[j, 1 shl (j-1)] := dem;
             end;
            for tt := 1 to 1 shl n - 1 do
              begin
                  for i := 1 to n do
                   if f[i,tt] < maxw then
                     begin
                         for j := 1 to n do
                          if (i <> j) and (lay(tt,j-1) = 0) then
                           begin
                               x := bat(tt,j-1);
                               f[j,x] := min(f[j,x],f[i,tt] + c[i,j]);
                           end;
                     end;
              end;
            res := maxw;
            for i := 1 to n do res := min(f[i,1 shl n-1],res);
            writeln(Res);
        end;
{*************************************************************************}
procedure make;
var i,j : longint;
        begin
             m := 10; n := 15;
             randomize;
             assign(output,'NHPAINT.INP'); rewrite(output);
             writeln(m,' ',n);
             for i := 1 to m do
             begin
              for j := 1 to n do write(random(2));
              writeln;
             end;
        end;
{*************************************************************************}
begin
   // make;
    nhap;
    main;
end.