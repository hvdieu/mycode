Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        a,b,d,heap,pos   :       array [1..maxn] of longint;
        c       :       array [1..maxn] of double;
        t,n,nheap     :       longint;
        res,k     :       double;

Procedure swap(Var xx,yy : longint);
Var temp : longint;
        BEGIN
             temp := xx; xx := yy; yy := temp;
        END;

Procedure Downheap(i : longint);
Var cha,con : longint;
        BEGIN
              cha := i;
              repeat
                     con := cha*2;
                     if (con < nheap) and (heap[con] < heap[con+1]) then inc(con);
                     if (con > nheap) or (heap[cha] > heap[con]) then break;
                     swap(heap[cha],heap[con]);
                     swap(pos[cha],pos[con]);
                     cha := con;
              Until false;
        END;

Procedure Upheap(i : longint);
Var cha,con : longint;
        BEGIN
              con := i;
              repeat
                    cha := con div 2;
                    if (cha = 0) or (heap[cha] > heap[con]) then break;
                    swap(heap[cha],heap[con]);
                    swap(pos[cha],pos[con]);
                    con := cha;
              Until false;
        END;

Procedure sort(l,h : longint);
Var i,j,key : longint;
        BEGIN
            if l>=h then exit;
            i := l; j := h;
            key := d[(l+h) div 2];
            Repeat
               While d[i] < key do inc(i);
               While d[j] > key do dec(j);
               if i <= j then
                 BEGIN
                       if i < j then
                          BEGIN
                                swap(d[i],d[j]);
                                swap(a[i],a[j]);
                                swap(b[i],b[j]);
                          END;
                       inc(i); dec(j);
                 END;
            Until i > j;
            sort(l,j); sort(i,h);
        END;

Procedure main;
Var i,vt,s : longint;
        BEGIN
              sort(1,n);
              k := 0;
              For i := 1 to n do c[i] := b[i] / a[i];
              nheap := 0;
              res := 0;
              For i := 1 to n do
                BEGIN
                      inc(nheap);
                      heap[nheap] := a[i];
                      pos[nheap] := i;
                      upheap(nheap);
                      k := k + b[i];
                      if k > d[i] then
                         BEGIN
                              vt := pos[1];
                              While k - c[vt]*a[vt] >= d[i] do
                                BEGIN
                                     heap[1] := heap[nheap];
                                     pos[1] := pos[nheap];
                                     dec(nheap);
                                     downheap(1);
                                     res := res + c[vt];
                                     k := k - c[vt]*a[vt];
                                     c[vt] := 0;
                                     vt := pos[1];
                                END;
                              if (k - c[vt]*a[vt] < d[i]) and (k > d[i]) then
                                 BEGIN
                                      res := res + (k-d[i]) / a[vt];
                                      c[vt] := c[vt] - (k-d[i]) / a[vt];
                                      k := d[i];
                                 END;
                         END;
                END;
              writeln(fo,res:0:2);

        END;

Procedure input;
Var st,i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,t);
              For st := 1 to t do
                 BEGIN
                       readln(fi,n);
                       For i := 1 to n do readln(fi,a[i],b[i],d[i]);
                       main;
                 END;
              close(fi);close(fo);
        END;

BEGIN
     input;
END.
