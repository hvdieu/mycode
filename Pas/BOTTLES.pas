uses math;
Const   inp = 'bottles.inp';
        out = 'bottles.out';
        maxn = 100001;
        maxc = 999999999;
Var     fi,fo   :       text;
        a,f,pre       :       array [1..maxn] of longint;
        kq      :     array [1..maxn] of boolean;
        t,trace       :       array [1..4*maxn] of longint;
        n,k,vt,sum,res,dem     :       longint;

Procedure input;
Var i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,n,k);
              for i := 1 to n do
                begin
                    read(fi,a[i]);
                    sum := sum + a[i];
                end;
              close(fi);
        END;

Procedure init(i,lo,hi : longint);
Var mid : longint;
        BEGIN
             if lo = hi then
                begin
                    t[i] := a[lo];
                    trace[i] := lo;
                    exit;
                end;
             mid := (lo+hi) div 2;
             init(i*2,lo,mid); init(i*2+1,mid+1,hi);
             if t[2*i] > t[2*i+1] then
               begin
                    t[i] := t[2*i+1];
                    trace[i] := trace[2*i+1];
               end
             else begin
                    t[i] := t[2*i];
                    trace[i] := trace[2*i];
               end;
        END;

Procedure Update(i,lo,hi,u,x : longint);
Var mid : longint;
        BEGIN
              if (hi > u) or (lo < u) then exit;
              if lo = hi then
                 begin
                      t[i] := x;
                      exit;
                 end;
              mid := (lo+hi) div 2;
              update(i*2,lo,mid,u,x); update(i*2+1,mid+1,hi,u,x);
               if t[2*i] > t[2*i+1] then
               begin
                    t[i] := t[2*i+1];
                    trace[i] := trace[2*i+1];
               end
             else begin
                    t[i] := t[2*i];
                    trace[i] := trace[2*i];
               end;
        END;

Function Qr(i,lo,hi,u,v : longint) : longint;
Var mid,temp,x,y : longint;
        BEGIN
             if (v < lo) or (hi < u) then exit(maxC);
             if (u <=lo) and (v>=hi) then exit(t[i]);
             mid := (lo+hi) div 2;
             x := qr(i*2,lo,mid,u,v); y := qr(i*2+1,mid+1,hi,u,v);
             if x < y then
                begin
                    vt := trace[i*2];
                    exit(x);
                end
             else begin
                    vt := trace[i*2+1];
                    exit(y);
                end;

        END;

Procedure main;
Var i,j,ti : longint;
        BEGIN
             for i := 1 to k do
               begin
                 f[i] := a[i];
                 pre[i] := i;
               end;
             for i := k+1 to n do f[i] := maxC;
             init(1,1,n);
             For i := k+1 to n do
                begin
                    ti := qr(1,1,n,i-k,i-1);
                    f[i] := ti + a[i];
                    pre[i] := vt;
                    update(1,1,n,i,f[i]);
                end;
            res := maxlongint;
            For i := n-k+1 to n do
               if res > f[i] then
                 begin
                   res := f[i];
                   vt := i;
                 end;
            res := sum - res;
        END;

Procedure output;
Var i : longint;
        BEGIN
              assign(fo,out); rewrite(fo);
              i := vt;
              repeat
                 begin
                     inc(dem);
                     kq[i] := true;
                     i := pre[i];
                 end;
              until pre[i] = i;
              kq[i] := true; inc(dem);
              writeln(fo,dem,' ',res);
              for i := 1 to n do
               if not kq[i] then write(fo,i,' ');
              close(fo);
        END;

BEGIN
      input;
      main;
      output;
END.
