uses math;
Const   inp = '';
        out = '';
        maxn = 50001;
Type    node = record
        x,y : longint;
        end;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        t       :       array [1..4*maxn] of node;
        n,q,r1,r2       :       longint;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,q);
             for i := 1 to n do readln(fi,a[i]);
        end;

procedure init(i,lo,hi : longint);
var mid : longint;
        begin
              if lo = hi then
                begin
                     t[i].x := a[lo];
                     t[i].y := a[lo];
                     exit;
                end;
              mid := (lo+hi) div 2;
              init(i*2,lo,mid); init(i*2+1,mid+1,hi);
              t[i].x := max(t[i*2].x, t[i*2+1].x);
              t[i].y := min(t[i*2].y, t[i*2+1].y);
        end;

function qrx(i,lo,hi,u,v : longint) : longint;
var mid,x,y : longint;
        begin
             if (lo > v) or (hi < u) then exit(-maxlongint);
             if (u <= lo) and (v >= hi) then exit(t[i].x);
             mid := (lo+hi) div 2;
             x := qrx(i*2,lo,mid,u,v); y := qrx(i*2+1,mid+1,hi,u,v);
             exit(max(x,y));
        end;

function qry(i,lo,hi,u,v : longint) : longint;
var mid,x,y : longint;
        begin
             if (lo > v) or (hi < u) then exit(maxlongint);
             if (u <= lo) and (v >= hi) then exit(t[i].y);
             mid := (lo+hi) shr 1;
             x := qry(i*2,lo,mid,u,v); y := qry(i*2+1,mid+1,hi,u,v);
             exit(min(x,y));
        end;

procedure main;
var i,u,v : longint;
        begin
             init(1,1,n);
             for i := 1 to q do
               begin
                    readln(fi,u,v);
                    writeln(fo,qrx(1,1,n,u,v) - qry(1,1,n,u,v));
               end;
             close(fi); close(fo);
        end;

begin
      input;
      main;
end.

