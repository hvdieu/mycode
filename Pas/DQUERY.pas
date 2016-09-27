Const   maxn = 30001;
        maxq = 200001;

Var     a,tree,id,p       :       array [1..maxn] of longint;
        n,i,q     :    longint;
        u,v,pos,kq     :    array [1..maxq] of longint;
        head    :   array [1..1000000] of longint;

procedure update(i,val : longint);
        begin
            while i <= n do
              begin
                  inc(tree[i],val);
                  inc(i,i and (-i));
              end;
        end;

function get(i : longint) : longint;
var s : longint;
        begin
             s := 0;
             while i > 0 do
               begin
                  inc(s,tree[i]);
                  dec(i,i and (-i));
               end;
             exit(s);
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := p[l+random(h-l+1)];
            repeat
                while p[i] < k do inc(i);
                while p[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(p[i],p[j]);
                            swap(id[i],id[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure qsort(l,h : longint);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := u[l+random(h-l+1)];
            repeat
                while u[i] < key do inc(i);
                while u[j] > key do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(u[i],u[j]);
                            swap(v[i],v[j]);
                            swap(pos[i],pos[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            qsort(l,j); qsort(i,h);
        end;

procedure main;
var i,j : longint;
        begin
            for i := 1 to n do
              begin
                  p[i] := head[a[i]];
                  head[a[i]] := i;
              end;
            sort(1,n); qsort(1,q);
            i := 1; j := 1;
            while j <= q do
              begin
                  while (i <= n) and (p[i] < u[j]) do
                    begin
                        update(id[i],1);
                        inc(i);
                    end;
                  kq[pos[j]] := get(v[j]) - get(u[j]-1);
                  inc(j);
              end;
            for i := 1 to q do writeln(kq[i]);
        end;


begin
     assign(input,'DQUERY.INP'); reset(input);
     assign(output,'DQUERY.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do
      begin
        read(a[i]);
        id[i] := i;
      end;
     readln(q);
     for i := 1 to q do
      begin
        read(u[i],v[i]);
        pos[i] := i;
      end;
     main;
end.