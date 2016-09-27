uses math;
Const   inp = '';
        out = '';
        maxn = 50001;
Var     fi,fo   :       text;
        t,f     :       array [1..4*maxn] of longint;
        n,m,k,x,u,v,i   :       longint;

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
                    inc(f[i],x);
                    inc(t[i],x);
                    exit;
              end;

            mid := (lo+hi) shr 1;
            con1 := i*2; con2 := con1 + 1;
            down(i,con1,con2);
            if u <= mid then update(con1,lo,mid,u,min(mid,v),x);
            if v > mid then update(con2,mid+1,hi,max(mid+1,u),v,x);
            t[i] := max(t[con1], t[con2]);
        end;

function get(i,lo,hi,u,v : longint) : longint;
var mid,ans,con1,con2 : longint;
        begin
             if (lo = u) and (hi = v) then exit(t[i]);

             mid := (lo+hi) shr 1;
             con1 := i*2; con2 := con1 + 1;
             down(i,con1,con2);
             ans := -maxlongint;
             if u <= mid then ans := max(ans, get(con1,lo,mid,u,min(mid,v)));
             if v > mid then ans := max(ans, get(con2,mid+1,hi,max(mid+1,u),v));
             exit(ans);
        end;

begin
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,n,m);
      for i := 1 to m do
        begin
             read(fi,k,u,v);
             if k = 0 then
               begin
                 read(fi,x);
                 update(1,1,n,u,v,x);
               end
               else writeln(fo,get(1,1,n,u,v));
        end;
      close(fi); close(fo);
end.
