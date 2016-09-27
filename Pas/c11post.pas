Const   inp = '';
        out = '';
        maxn = 101;
        h       :       array [1..8] of integer = (-1,-1,0,1,1,1,0,-1);
        c       :       array [1..8] of integer = (0,1,1,1,0,-1,-1,-1);

Var     m,n,top,res,min,max,dem     :       longint;
        a       :       array [1..maxn,1..maxn] of longint;
        x,y,b     :       array [0..maxn*maxn] of longint;
        free    :       array [0..maxn,0..maxn] of boolean;

{****************************************************************************}
procedure nhap;
var i,j : longint;
    ch : char;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(m,n);
            for i := 1 to m do
             begin
                 for j := 1 to n do
                  begin
                      read(ch);
                      if ch <> '.' then
                       begin
                          if ch = 'K' then
                           begin
                            inc(top); x[top] := i; y[top] := j;
                           end
                            else begin x[0] := i; y[0] := j; end;
                       end;
                  end;
                 readln;
             end;
            for i := 1 to m do
             for j := 1 to n do
              begin
                read(a[i,j]);
              end;
        end;
{***************************************************************************}
procedure dfs(i,j : longint);
var k,u,v : longint;
        begin
            free[i,j] := false;
            for k := 1 to 8 do
             begin
                 u := i+h[k]; v := j+c[k];
                 if free[u,v] and (a[u,v]>=min) and (a[u,v]<=max) then dfs(u,v);
             end;
        end;
{***************************************************************************}
function check : boolean;
var i,j,ii : longint;
        begin
            for i := 1 to m do for j := 1 to n do free[i,j] := true;
            if (a[x[0],y[0]] >= min) and (a[x[0],y[0]] <= max) then dfs(x[0],y[0]);
            for i := 0 to top do
             if free[x[i],y[i]] then exit(false);
            exit(true);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure sort(l,h : longint);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := b[l+random(h-l+1)];
            repeat
               while b[i] < key do inc(i);
               while b[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(b[i],b[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
procedure main;
var i,j,l,r,mid : longint;
        begin
            for i := 1 to m do
             for j := 1 to n do
              begin
                 inc(dem); b[dem] := a[i,j];
              end;
            sort(1,dem); res := maxlongint;
            i := 1; j := 1;
            while (i <= dem) and (j <= dem) and (i <= j) do
              begin
                  min := b[i]; max := b[j];
                  while (j <= dem) and (check=false) do
                    begin
                        inc(j); max := b[j];
                    end;
                  if (j <= dem) then
                    begin
                        if res > b[j]-b[i] then res := b[j]-b[i];
                    end
                  else break;
                  inc(i);
              end;
            writeln(Res);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.
