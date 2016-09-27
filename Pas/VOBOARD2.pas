{$H+}
Uses math;
Const   inp = '';
        out = '';
        maxn = 1000001;
        h       :       array [1..8] of integer = (-1,-1,0,1,1,1,0,-1);
        c       :       array [1..8] of integer = (0,1,1,1,0,-1,-1,-1);

Var     m,n,l,u,v,nheap   :       longint;
        s       :       string;
        a       :       array [0..1001,0..1001] of char;
        vt      :       array [1..8] of longint;
        next    :       array [0..maxn,1..8] of longint;
        heapi,heapj : array [1..maxn] of longint;
        pos,d     :       array [1..1001,1..1001] of longint;
        free    : array [1..1001,1..1001] of boolean;

{***************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(m,n);
            readln(u,v);
            for i := 1 to m do
             begin
                 for j := 1 to n do read(a[i,j]);
                 readln;
             end;
            readln(s); l := length(s);
        end;
{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure update(cha,con : longint);
        begin
            swap(heapi[cha],heapi[con]);
            swap(heapj[cha],heapj[con]);
            pos[heapi[cha],heapj[cha]] := cha;
            pos[heapi[con],heapj[con]] := con;
        end;
{***************************************************************************}
procedure upheap(i,j : longint);
var cha,con : longint;
        begin
            con := pos[i,j];
            if con=0 then
             begin
                 inc(nheap); heapi[nheap] := i; heapj[nheap] := j;
                 con := nheap; pos[i,j] := con;
             end;
            repeat
               cha := con div 2;
               if (cha=0) or (d[heapi[cha],heapj[cha]]<=d[heapi[con],heapj[con]]) then break;
               update(cha,con);
               con := cha;
            until false;
        end;
{***************************************************************************}
procedure pop;
var cha,con : longint;
        begin
            u := heapi[1]; v := heapj[1];
            heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap]; dec(nheap);
            pos[heapi[1],heapj[1]] := 1; cha := 1;
            repeat
               con := cha*2;
               if (con<nheap) and (d[heapi[con],heapj[con]]>d[heapi[con+1],heapj[con+1]]) then inc(con);
               if (con>nheap) or (d[heapi[cha],heapj[cha]]<=d[heapi[con],heapj[con]]) then break;
               update(cha,con);
               cha := con;
            until false;
        end;
{***************************************************************************}
procedure khoitao;
var i,j,dir : longint;
        begin
             for i := 1 to 8 do vt[i] := l+1;
             for i := l downto 1 do
               begin
                   for j := 1 to 8 do next[i][j] := vt[j];
                   val(s[i],dir); vt[dir] := i;
               end;
             for i := 0 to m+1 do
              begin
                  a[i,0] := '#'; a[i,n+1] := '#';
              end;
             for i := 0 to n+1 do
              begin
                  a[0,i] := '#'; a[m+1,i] := '#';
              end;
             for j := 1 to 8 do next[0][j] := vt[j];
             for i := 1 to m do
              for j := 1 to n do d[i,j] := l+1;
             d[u,v] := 0; upheap(u,v);
             fillchar(free,sizeof(free),true);
        end;
{***************************************************************************}
procedure main;
var i,j,k,x : longint;
        begin
            repeat
                 if nheap=0 then break;
                 pop;
                 free[u,v] := false; x := d[u,v];
                 for k := 1 to 8 do
                   begin
                       i := u+h[k]; j := v+c[k];
                       if (a[i,j]<>'#') and (free[i,j]) and (d[i,j]>next[x][k]) then
                         begin
                             d[i,j] := next[x][k];
                             upheap(i,j);
                         end;
                   end;
            until false;
            for i := 1 to m do
            begin
              for j := 1 to n do
               if d[i,j] < l+1 then write(1) else write(0);
               writeln;
            end;
        end;
{***************************************************************************}
begin
    nhap;
    khoitao;
    main;
end.

