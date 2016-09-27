Const   inp = '';
        out = '';
        maxn = 100001;
        oo = 1000000007;

Var     n,i,m,res     :       longint;
        a,f,g,id,startof,dau,cuoi,b,c,pos,t      :       array [0..maxn] of longint;

{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n);
            for i := 1 to n do read(a[i]);
        end;
{***************************************************************************}
function find(i : longint) : longint;
var j,ans,d,c,mid : longint;
        begin
            d := 0; c := m; ans := 0;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  j := startof[mid];
                  if a[i] > a[j] then
                    begin
                        ans := mid;
                        d := mid+1;
                    end
                  else c := mid-1;
              end;
            find := startof[ans];
        end;
{***************************************************************************}
procedure khoitao;
var i,j,k : longint;
        begin
            f[0] := 0; a[0] := -maxlongint; startof[0] := 0;
            m := 0;
            for i := 1 to n do
              begin
                  id[i] := i;
                  j := find(i);
                  k := f[j]+1;
                  if k > m then
                    begin
                        m := k;
                        startof[k] := i;
                    end
                  else if a[startof[k]] > a[i] then startof[k] := i;
                  f[i] := k;
              end;
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
            i := l; j := h; k := l+random(h-l+1); k1 := b[k]; k2 := c[k];
            repeat
               while (b[i]<k1) or ((b[i]=k1) and (c[i]<k2)) do inc(i);
               while (b[j]>k1) or ((b[j]=k1) and (c[j]>k2)) do dec(j);
               if i <= j then
                begin
                    if i < j then
                     begin
                         swap(b[i],b[j]); swap(c[i],c[j]);
                         swap(id[i],id[j]);
                     end;
                    inc(i); dec(j);
                end;
            until i > j;
            sort(l,j); sort(i,h);
        end;
{***************************************************************************}
function find2(l,r,key : longint) : longint;
var mid,ans : longint;
        begin
            while l <= r do
              begin
                  mid := (l+r) shr 1;
                  if c[mid] < key then
                   begin
                       ans := mid; l := mid+1;
                   end
                  else r := mid-1;
              end;
            exit(ans);
        end;
{***************************************************************************}
procedure init;
var i,j : longint;
        begin
            for i := 1 to n do
             begin
                 b[i] := f[i]; c[i] := a[i]; id[i] := i;
             end;
            sort(1,n);
            for i := 1 to n do pos[id[i]] := i;
            i := 0;
            while i <= n do
             begin
                 inc(i);
                 dau[b[i]] := i;
                 while (i<n) and (b[i]=b[i+1]) do inc(i);
                 cuoi[b[i]] := i;
             end;
        end;
{***************************************************************************}
procedure update(i,val : longint);
        begin
            while i <= n do
              begin
                  t[i] := t[i]+val;
                  if t[i] >= oo then t[i] := t[i]-oo;
                  inc(i,i and (-i));
              end;
        end;
{***************************************************************************}
function get(i : longint) : longint;
var s : longint;
        begin
            s := 0;
            while i > 0 do
              begin
                 s := s + t[i];
                 if s >= oo then s := s - oo;
                 dec(i,i and (-i));
              end;
            exit(s);
        end;
{***************************************************************************}
function sum(u,v : longint) : longint;
        begin
            sum := ((get(v)-get(u-1)) + oo) mod oo;
        end;
{***************************************************************************}
procedure main;
var i,j,u,v : longint;
        begin
            for i := 1 to n do
             begin
               if f[i] = 1 then g[i] := 1
                 else
                   begin
                         u := dau[f[i]-1];
                         v := find2(dau[f[i]-1],cuoi[f[i]-1],a[i]);
                         g[i] := sum(u,v);
                   end;
                  update(pos[i],g[i]);
                  if f[i]=b[n] then
                    begin
                        res := res + g[i];
                        if res >= oo then dec(res,oo);
                    end;
             end;
             writeln(res);
        end;
{***************************************************************************}
begin
    nhap;
    khoitao;
    init;
    main;
end.
