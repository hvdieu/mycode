Const   inp = 'BEADS.INP';
        out = 'BEADS.OUT';
        maxn = 100010;

Var     n,m,res       :       longint;
        a,f,l,startof       :       array [0..maxn] of longint;

{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
             assign(input,inp); reset(input);
             assign(output,out); rewrite(output);
             readln(n);
             for i := 1 to n do read(a[i]);
        end;
{**************************************************************************}
function find1(i : longint) : longint;
var d,c,mid,j : longint;
        begin
            d := 1; c := m+1;
            repeat
                mid := (d+c) div 2;
                j := startof[mid];
                if a[j] > a[i] then d := mid
                 else c := mid;
            until d+1=c;
            exit(startof[d]);
        end;
{**************************************************************************}
procedure khoitaotang;
        begin
            fillchar(f,sizeof(f),0);
            fillchar(startof,sizeof(startof),0);
            a[n+1] := maxlongint;
            a[0] := -maxlongint;
            startof[1] := n+1;
            f[n+1] := 1;
            m := 1;
        end;
{**************************************************************************}
procedure timtang;
var i,j,k : longint;
        begin
            khoitaotang;
            for i := n downto 0 do
              begin
                  j := find1(i);
                  k := f[j]+1;
                  if k > m then
                    begin
                        m := k;
                        startof[k] := i;
                    end
                  else if a[i] > a[startof[k]] then startof[k] := i;
                  f[i] := k;
              end;
        end;
{**************************************************************************}
procedure khoitaogiam;
var i,j : longint;
        begin
            fillchar(l,sizeof(l),0);
            fillchar(startof,sizeof(startof),0);
            a[n+1] := -maxlongint;
            a[0] := maxlongint;
            l[n+1] := 1;
            startof[1] := n+1;
            m := 1;
        end;
{**************************************************************************}
function find2(i : longint) : longint;
var d,c,mid,j : longint;
        begin
             d := 1; c := m+1;
             repeat
                 mid := (d+c) div 2;
                 j := startof[mid];
                 if a[j] < a[i] then d := mid
                  else c := mid;
             until d+1=c;
             exit(startof[d]);
        end;
{**************************************************************************}
procedure timgiam;
var i,j,k : longint;
        begin
            khoitaogiam;
            for i := n downto 0 do
              begin
                  j := find2(i);
                  k := l[j]+1;
                  if k > m then
                    begin
                        m := k;
                        startof[k] := i;
                    end
                  else if a[i] < a[startof[k]] then startof[k] := i;
                  l[i] := k;
              end;
        end;
{**************************************************************************}
procedure main;
var i,j : longint;
        begin
            timtang;
            timgiam;
            for i := 1 to n do
             if f[i]+l[i]-3 > res then res := f[i]+l[i]-3;
             writeln(res);
        end;
{**************************************************************************}
begin
     nhap;
     main;
end.

