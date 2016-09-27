uses math;
Const   inp = '';
        out = '';
        maxn = 50001;
var     fi,fo   :       text;
        a       :       array [0..maxn] of longint;
        t        :      array [1..4*maxn] of longint;
        n,m,q,k    :      longint;

procedure input;
var i,u,v : longint;
        begin
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n,m);
              for i := 1 to m do
                begin
                     readln(fi,u,v,k);
                     inc(a[u],k); dec(a[v+1],k);
                end;
              for i := 1 to n do
                a[i] := a[i-1] + a[i];
        end;

procedure init(i,lo,hi : longint);
var mid : longint;
        begin
              if lo = hi then
                begin
                    t[i] := a[lo]; exit;
                end;
              mid := (lo+hi) shr 1;
              init(i*2,lo,mid); init(i*2+1,mid+1,hi);
              t[i] := max(t[i*2], t[i*2+1]);
        end;

function qr(i,lo,hi,u,v : longint) : longint;
var mid,x,y : longint;
        begin
              if (v < lo) or (u > hi) then exit(-maxlongint);
              if (u <= lo) and (v >= hi) then exit(t[i]);
              mid := (lo+hi) shr 1;
              x := qr(i*2,lo,mid,u,v); y := qr(i*2+1,mid+1,hi,u,v);
              exit(max(x, y));
        end;

procedure main;
var i,u,v : longint;
        begin
                init(1,1,n);
                readln(fi,q);
                for i := 1 to q do
                  begin
                      readln(fi,u,v);
                      writeln(fo,qr(1,1,n,u,v));
                  end;
                close(fi); close(fo);
        end;

begin
     input;
     main;
end.