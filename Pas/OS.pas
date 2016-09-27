uses math;
Const   maxn = 100001;
Var     n,i,j,m,res,k,gt     :       longint;
        a,b     :       array [1..maxn] of longint;
        x      :       array [1..2*maxn] of longint;
        t,f       :       array [1..8*maxn] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
             if l >= h then exit;
             i := l; j := h; k := x[l+random(h-l+1)];
             repeat
                while x[i] < k do inc(i);
                while x[j] > k do dec(j);
                if i <= j then
                  begin
                       if i < j then swap(x[i],x[j]);
                       inc(i); dec(j);
                  end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

function find(key : longint) : longint;
var d,c,mid,ans : longint;
        begin
             d := 1; c := m;
             while d <= c do
               begin
                   mid := (d+c) div 2;
                   if x[mid] = key then
                     begin
                         ans := mid;
                         c := mid-1;
                     end
                   else if x[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;

procedure down(i,con1,con2 : longint);
        begin
              inc(f[con1],f[i]);
              inc(f[con2],f[i]);
              inc(t[con1],f[i]);
              inc(t[con2],f[i]);
              f[i] := 0;
        end;

procedure update(i,lo,hi,u,v,x : longint);
var mid,con1,con2 : longint;
        begin
             if (lo=u) and (hi=v) then
               begin
                   inc(f[i],x);
                   inc(t[i],x);
                   exit;
               end;
             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1+1;
             down(i,con1,con2);
             if u <= mid then update(con1,lo,mid,u,min(mid,v),x);
             if v > mid then update(con2,mid+1,hi,max(mid+1,u),v,x);
             t[i] := t[con1] + t[con2];
        end;

function get(i,lo,hi,u,v : longint) : longint;
var mid,ans,con1,con2,x,y : longint;
        begin
             if (lo = u) and (hi = v) then exit(t[i]);

             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1 + 1;
             down(i,con1,con2);
             x := 0; y := 0;
             if u <= mid then x := get(con1,lo,mid,u,min(mid,v));
             if v > mid then  y := get(con2,mid+1,hi,max(mid+1,u),v);
             exit(x+y);
        end;

procedure khoitao;
var i,j : longint;
        begin
            sort(1,m);
            for i := 1 to n do
              begin
                  a[i] := find(a[i]);
                  b[i] := find(b[i]);
              end;
        end;

procedure main;
var i,sum : longint;
        begin
              for i := n downto 1 do
                begin
                    sum := get(1,1,m,a[i],b[i]);
                    if sum = 0 then inc(res);
                    update(1,1,m,a[i],b[i],1);
                end;
              writeln(res);
        end;


begin
      assign(input,'OS.INP'); reset(input);
      assign(output,'OS.OUT'); rewrite(output);
      readln(k,n);
      for i := 1 to n do
        begin
            read(a[i],b[i]);
            inc(j); x[j] := a[i];
            inc(j); x[j] := b[i];
        end;
      m := j;
      khoitao;
      main;
end.