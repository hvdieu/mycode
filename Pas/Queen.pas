Const   inp = 'QUEEN.INP';
        out = 'QUEEN.OUT';
        maxn = 1100;

Var     a       :       array [0..maxn,0..maxn] of integer;
        dd     :       array [0..maxn,0..maxn] of longint;
        res    :       array [0..maxn,0..maxn] of longint;
        x,c,pi,pj,mau : array [0..maxn*maxn] of longint;
        m,n,dem     :       longint;

{***************************************************************************}
procedure nhap;
var i,j : longint;
    ch : char;
        begin
             assign(input,inp); reset(input);
             assign(output,out); rewrite(output);
             readln(m,n);
             for i := 0 to m+1 do
              for j := 0 to n+1 do a[i,j] := 1;
             for i := 1 to m do
               begin
                   for j := 1 to n do
                     begin
                         read(ch);
                         if ch = '.' then a[i,j] := 0
                          else a[i,j] := 1;
                     end;
                   readln;
               end;
        end;
{***************************************************************************}
procedure trai;
var i,j : longint;
        begin
            fillchar(dd,sizeof(dd),0);
            for i := 1 to m do
              begin
                  for j := 1 to n do
                   if a[i,j] = 0 then dd[i,j] := dd[i,j-1]
                    else dd[i,j] := j;
              end;
            for i := 1 to m do
               for j := 1 to n do
               inc(res[i,j],j-dd[i,j]);
        end;
{***************************************************************************}
procedure phai;
var i,j : longint;
        begin
            fillchar(dd,sizeof(dd),0);
            for i := 1 to m do dd[i,n+1] := n+1;
            for i := 1 to m do
              for j := n downto 1 do
               if a[i,j] = 0 then dd[i,j] := dd[i,j+1]
                else dd[i,j] := j;
            for i := 1 to m do
             for j := 1 to n do inc(res[i,j],dd[i,j]-j);
        end;
{***************************************************************************}
procedure tren;
var i,j : longint;
        begin
            fillchar(dd,sizeof(dd),0);
            for j := 1 to n do
             for i := 1 to m do
              if a[i,j] = 0 then dd[i,j] := dd[i-1,j]
               else dd[i,j] := i;
            for j := 1 to n do
             for i := 1 to m do inc(res[i,j],i-dd[i,j]);
        end;
{***************************************************************************}
procedure duoi;
var i,j : longint;
        begin
            fillchar(dd,sizeof(dd),0);
            for j := 1 to n do dd[m+1,j] := m+1;
            for j := 1 to n do
             for i := m downto 1 do
              if a[i,j] = 0 then dd[i,j] := dd[i+1,j]
               else dd[i,j] := i;
            for j := 1 to n do
             for i := 1 to m do inc(res[i,j],dd[i,j]-i);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
           temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := c[k]; k2 := x[k];
            repeat
               while (c[i]<k1) or ((c[i]=k1) and (x[i]<k2)) do inc(i);
               while (c[j]>k1) or ((c[j]=k1) and (x[j]>k2)) do dec(j);
               if i <= j then
               begin
               if i < j then
                 begin
                     swap(c[i],c[j]);
                     swap(x[i],x[j]);
                     swap(mau[i],mau[j]);
                     swap(pi[i],pi[j]);
                     swap(pj[i],pj[j]);
                 end;
               inc(i); dec(j);
            end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure ktcheo1;
var i,j : longint;
        begin
            dem := 0;
            for i := 0 to m+1 do
             for j := 0 to n+1 do
              begin
                  inc(dem);
                  c[dem] := i+j;
                  x[dem] := i;
                  pi[dem] := i; pj[dem] := j;
                  if a[i,j] = 0 then mau[dem] := 0 else mau[dem] := 1;
              end;
        end;
{***************************************************************************}
procedure ktcheo2;
var i,j : longint;
        begin
            dem := 0;
            for i := 0 to m+1 do
             for j := 0 to n+1 do
              begin
                  inc(dem);
                  c[dem] := i-j;
                  x[dem] := i;
                  pi[dem] := i; pj[dem] := j;
                  if a[i,j] = 0 then mau[dem] := 0 else mau[dem] := 1;
              end;
        end;
{***************************************************************************}
procedure cheo;
var i,j,vt : longint;
        begin
            sort(1,dem);
            c[0] := maxlongint;
            for i := 1 to dem do
              begin
                  if c[i] <> c[i-1] then vt := x[i]
                   else if (c[i] = c[i-1]) and (mau[i]=1) then vt := x[i]
                    else if (c[i] = c[i-1]) and (mau[i]=0) then inc(res[pi[i],pj[i]],x[i]-vt);
              end;
            c[dem+1] := maxlongint;
            for i := dem downto 1 do
              begin
                  if c[i] <> c[i+1] then vt := x[i]
                   else if (c[i]=c[i+1]) and (mau[i]=1) then vt := x[i]
                    else if (c[i]=c[i+1]) and (mau[i]=0) then inc(res[pi[i],pj[i]],vt-x[i]);
              end;
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
            trai;
            phai;
            tren;
            duoi;
            ktcheo1;
            cheo;
            ktcheo2;
            cheo;
        end;
{***************************************************************************}
procedure inkq;
var i,j : longint;
        begin
            for i := 1 to m do
             for j := 1 to n do
              if res[i,j] > 0 then dec(res[i,j],7);
            for i := 1 to m do
             begin
               for j := 1 to n do write(res[i,j],' ');
               writeln;
             end;
        end;
{***************************************************************************}
begin
     nhap;
     main;
     inkq;
end.
