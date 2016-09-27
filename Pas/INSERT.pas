uses math;
Const   inp = 'INSERT.INP';
        out = 'INSERT.OUT';
        maxn = 100001;
        maxaa = 1000001;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        t,f       :       array [1..4*maxaa] of longint;
        n,res,mina,maxa       :       longint;

procedure input;
var i : longint;
        begin
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n);
              mina := maxlongint;
              for i := 1 to n do
               begin
                 readln(fi,a[i]);
                 mina := min(mina,a[i]);
                 maxa := max(maxa,a[i]);
               end;
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
             if (lo = u) and (hi = v) then
              begin
                   inc(f[i]); inc(t[i]);
                   exit;
              end;

             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1 + 1;
             down(i,con1,con2);
             if u <= mid then update(con1,lo,mid,u,min(mid,v),x);
             if v > mid then update(con2,mid+1,hi,max(mid+1,u),v,x);
             t[i] := t[con1] + t[con2];
        end;

procedure get(i,lo,hi,u : longint);
var mid,con1,con2 : longint;
        begin
             if (lo=u) and (hi=u) then
              begin
                  res := t[i];
                  exit;
              end;
             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1+1;
             down(i,con1,con2);
             if u <= mid then get(con1,lo,mid,u);
             if u > mid then get(con2,mid+1,hi,u);
        end;

procedure main;
var i,x : longint;
        begin
            a[n+1] := a[1];
            inc(n);
            for i := 1 to n-1 do
             if a[i] + 1 < a[i+1] then update(1,mina,maxa,a[i]+1,a[i+1]-1,1);
            while not eof(fi) do
             begin
                 readln(fi,x);
                 if (x > maxa) or (x < mina) then res := 0
                 else get(1,mina,maxa,x);
                 writeln(fo,res);
             end;
            close(fi); close(fo);
        end;

begin
     input;
     main;
end.


