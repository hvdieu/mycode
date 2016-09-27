Const   inp = '';
        out = '';
        maxn = 10007;
Type    arr     =       array [1..maxn] of integer;
Var     fi,fo   :       text;
        n,n1,n2,i,nheap,k       :       integer;
        a,b,tt,heap,cs,x,y,z     :       arr;
        d               :       array [1..maxn] of boolean;
        ok              :       boolean;
        sa,sb,sc           :       longint;
Procedure Swap( Var xx,yy : integer);
Var temp : integer;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure dc(Var xx,yy : boolean);
Var temp : boolean;
        BEGIN
             temp := xx; xx := yy; yy := temp;
        END;

Procedure Downheap(i : integer);
Var cha,con : integer;
        BEGIN
              cha := i;
              repeat
                     con := cha*2;
                     if (con < nheap) and (heap[con] > heap[con+1]) then inc(con);
                     if (con > nheap) or (heap[cha] < heap[con]) then break;
                     swap(heap[cha],heap[con]);
                     dc(d[cha],d[con]);
                     swap(cs[cha],cs[con]);
                     cha := con;
              Until false;
        END;

Procedure Upheap(i : integer);
Var cha,con : integer;
        BEGIN
              con := i;
              repeat
                    cha := con div 2;
                    if (cha = 0) or (heap[cha] < heap[con]) then break;
                    swap(heap[cha],heap[con]);
                    dc(d[cha],d[con]);
                    swap(cs[cha],cs[con]);
                    con := cha;
              Until false;
        END;

BEGIN
      Assign(fi,inp); reset(fi);
      readln(fi,n);
      for i := 1 to n do read(fi,x[i]);
      readln(fi);
      for i := 1 to n do read(fi,y[i]);
      readln(fi);
      for i := 1 to n do read(fi,z[i]);
      close(fi);
      for i := 1 to n do
        BEGIN
             a[i] := x[i] + y[i];
             b[i] := y[i] + z[i];
        END;
      for i := 1 to n do
        BEGIN
            cs[i] := i;
            if a[i] < b[i] then
               BEGIN
                     heap[i] := a[i];
                     d[i] := true;
               END
                  else
                     BEGIN
                           heap[i] := b[i];
                           d[i] := false;
                     END;
        END;
      nheap := n;
      for i := n div 2 downto 1 do downheap(i);
      n2 := 0; n1 := 0;
      For i := 1 to n do
         BEGIN
               k := heap[1];
               ok := d[1];
               if ok then
                  BEGIN
                        inc(n2);
                        tt[n2] := cs[1];
                  END
                    else
                       BEGIN
                            tt[n-n1] := cs[1];
                            inc(n1);
                       END;
               heap[1] := heap[nheap];
               d[1] := d[nheap];
               cs[1] := cs[nheap];
               dec(nheap);
               downheap(1);
         END;
    sa := x[tt[1]];
    sb := sa + y[tt[1]];
    sc := sb + z[tt[1]];
    for i := 2 to n do
       BEGIN
            sa := sa + x[tt[i]];
            if sa >= sb then sb := sa + y[tt[i]]
              else sb := sb + y[tt[i]];
            if sb >= sc then sc := sb + z[tt[i]]
              else sc := sc + z[tt[i]];
       END;
    Assign(fo,out); rewrite(fo);
    writeln(fo,sc);
    for i := 1 to n do write(fo,tt[i],' ');
    close(fo);
END.
