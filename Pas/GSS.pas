uses math;
Const   inp = 'GSS.INP';
        out = 'GSS.OUT';
        maxn = 15001;
Var     fi,fo   :       text;
        n,q       :       longint;
        t,s       :       array [1..4*maxn] of int64;

        a       :       array [1..maxn] of longint;

Procedure input;
Var i : longint;
        begin
             assign(fi,inp); reset(fi);
             read(fi,n);
             for i := 1 to n do read(fi,a[i]);
        end;

procedure initt(i,lo,hi : longint);
var mid : longint;
        begin
             if lo=hi then
               begin
                   t[i] := a[lo];
                   exit;
               end;
             mid := (lo+hi) shr 1;
             initt(i*2,lo,mid); initt(i*2+1,mid+1,hi);
             t[i] := t[i*2] + t[i*2+1];
        end;

Procedure inits(i,lo,hi : longint);
var mid : longint;
        begin
             if lo=hi then
               begin
                    s[i] := a[lo];
                    exit;
               end;
             mid := (lo+hi) shr 1;
             inits(i*2,lo,mid); inits(i*2+1,mid+1,hi);
             s[i] := max(t[i*2],t[i*2+1]);
        end;

Function qr(i,lo,hi,u,v : longint) : longint;
var mid,x,y : longint;
        begin
               if (lo > v) or ( hi < u) then exit(-maxlongint);
               if (u<=lo) and (v >= hi) then exit(s[i]);
               mid := (lo+hi) shr 1;
               x := qr(i*2,lo,mid,u,v);
               y := qr(i*2+1,mid+1,hi,u,v);
               if x > y then exit(x)
                 else exit(y);
        end;

procedure main;
var i,j,u,v : longint;
        begin
              initt(1,1,n);
              inits(1,1,n);
              read(fi,q);
              assign(fo,out); rewrite(fo);
              for i := 1 to q do
                begin
                     read(fi,u,v);
                     writeln(fo,qr(1,1,n,u,v));
                end;
              close(fi); close(fo);
        end;

begin
     input;
     main;
end.