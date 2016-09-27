Const   maxn = 1000001;

Type    arr = array [0..maxn] of longint;

Var     n,i,m,k       :       longint;
        x,y,startof,l     :       array [0..maxn] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k1,k2,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := x[k]; k2 := y[k];
            repeat
               while (x[i] < k1) or ((x[i] = k1) and (y[i] < k2)) do  inc(i);
               while (x[j] > k1) or ((x[j] = k1) and (y[j] > k2)) do dec(j);
               if i <= j then
                 begin
                     if i < j then
                       begin
                           swap(x[i],x[j]);
                           swap(y[i],y[j]);
                       end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

function find(i : longint) : longint;
var d,c,mid,j : longint;
        begin
            d := 1; c := m+1;
            repeat
              mid := (d+c) div 2;
              j := startof[mid];
              if y[j] < y[i] then d := mid
               else c := mid;
            until d+1=c;
            find := startof[d];
        end;

procedure main;
var i,j : longint;
        begin
             sort(1,n);
             y[n+1] := -maxlongint; y[0] := maxlongint;
             l[n+1] := 1;
             m := 1; startof[1] := n+1;
             for i := n downto 0 do
               begin
                   j := find(i);
                   k := l[j]+1;
                   if k > m then
                     begin
                         m := k;
                         startof[k] := i;
                     end
                   else if y[startof[k]] > y[i] then startof[k] := i;
               l[i] := k;
               end;
             write(l[0]-2);
        end;

begin
      assign(input,'robotcam.inp'); reset(input);
      assign(output,'robotcam.out'); rewrite(output);
      readln(n);
      for i := 1 to n do readln(x[i],y[i]);
      main;
end.