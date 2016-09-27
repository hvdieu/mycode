Const   inp = 'IT.INP';
        out = 'IT.OUT';
        maxn = 100001;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        t       :       array [1..4*maxn] of longint;
        n       :       longint;

Procedure input;
Var i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n);
              For i := 1 to n do read(fi,a[i]);
        END;

Procedure init(i,lo,hi : longint);
Var mid : longint;
        BEGIN
             if lo = hi then
               begin
                   t[i] := a[lo];
                   exit;
               end;
             mid := (lo+hi) div 2;
             init(i*2,lo,mid);
             init(i*2+1,mid+1,hi);
             t[i] := t[2*i] + t[2*i+1];
        END;

Procedure Update(i,lo,hi,u,x : longint);
Var mid : longint;
        BEGIN
             if (lo > u) or (hi < u) then exit;
             if lo = hi then
                begin
                     t[i] := x;
                     exit;
                end;
             mid := (lo + hi) div 2;
             update(i*2,lo,mid,u,x);
             update(i*2+1,mid+1,hi,u,x);
             t[i] := t[i*2] + t[i*2+1];
        END;

Function Qr(i,lo,hi,u,v : longint) : longint;
Var mid : longint;
        BEGIN
             if (lo >= u) and (hi <= v) then exit(t[i]);
             if (lo > v) or (hi < u) then exit(0);
             mid := (lo+hi) div 2;
             qr := qr(i*2,lo,mid,u,v) + qr(i*2+1,mid+1,hi,u,v);
        END;

Procedure main;
Var i,j,u,v,k,q : longint;
        BEGIN
             init(1,1,n);
             readln(fi,q);
             For i := 1 to q do
               begin
                    readln(fi,k,u,v);
                    if k = 1 then update(1,1,n,u,v)
                      else writeln(fo,qr(1,1,n,u,v));
               end;
             close(fi); close(fo);
        END;

BEGIN
      input;
      main;
END.
