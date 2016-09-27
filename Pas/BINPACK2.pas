Const   inp = 'BINPACK2.INP';
        out = 'BINPACK2.OUT';
        maxn = 101;
        max = 1048580;
Type    arr     =       array [1..max] of int64;
        arr1    =       array [1..max] of longint;
Var     fi,fo   :       text;
        t,n,k,m,d1,d2,bit   :       longint;
        res     :       array [1..maxn] of integer;
        x       :       array [0..21] of integer;
        w,w1,w2       :       array [1..maxn] of longint;
        p,q     :       arr;
        cp,cq   :       arr1;
        sum,s     :       int64;

Procedure swap(Var xx,yy : int64);
Var temp : int64;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure dc(Var xx,yy : longint);
Var temp : longint;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure sort(l,h : longint; Var k : arr;Var cs : arr1);
Var i,j : longint;
    key : int64;
        BEGIN
              if l >= h then exit;
              i := l; j := h; key := k[ (l+h) div 2];
              Repeat
                 While k[i] < key do inc(i);
                 While k[j] > key do dec(j);
                 if i <= j then
                   BEGIN
                         if i < j then
                           BEGIN
                              swap(k[i],k[j]);
                              dc(cs[i],cs[j]);
                           END;
                         inc(i);
                         dec(j);
                   END;
              Until i > j;
              sort(l,j,k,cs);
              sort(i,h,k,cs);
        END;

Procedure ql1(i,k : integer);
Var j : integer;
        BEGIN
              For j := x[i-1] + 1 to n - k + i do
                 BEGIN
                       x[i] := j;
                       bit := bit or (1 shl (j-1));
                       s := s + w1[j];
                       if i = k then
                          BEGIN
                               inc(d1);
                               p[d1] := s;
                               cp[d1] := bit;
                          END
                            else ql1(i+1,k);
                       s := s - w1[j];
                       bit := bit and (not (1 shl (j-1)));
                 END;
        END;

procedure ql2(i,k : integer);
Var j : integer;
        BEGIN
              For j := x[i-1] + 1 to m - k + i do
                 BEGIN
                       x[i] := j;
                       bit := bit or (1 shl (j-1));
                       s := s + w2[j];
                       if i = k then
                         BEGIN
                               inc(d2);
                               q[d2] := s;
                               cq[d2] := bit;
                         END
                           else ql2(i+1,k);
                       s := s - w2[j];
                       bit := bit and(not (1 shl (j-1)));
                 END;
        END;

Procedure sub2;
Var i,j,k,u,v,b1,b2: longint;
    s   : int64;
        BEGIN
              m := n;
              n := n div 2;
              m := m - n;
              d1 := 0;
              sum := 0;
              For i := 1 to n do
                BEGIN
                  read(fi,w1[i]);
                  sum := sum + w1[i];
                END;
              For i := 1 to m do
                BEGIN
                  read(fi,w2[i]);
                  sum := sum + w2[i];
                END;
              readln(fi);

              bit := 0; d1 := 0; s := 0;
              For i := 1 to n do ql1(1,i);

              bit := 0; s := 0; d2 := 0;
              For i := 1 to m do ql2(1,i);

              sort(1,d1,p,cp);
              sort(1,d2,q,cq);
              sum := sum div 2;
              j := d2+1;
              For i := 1 to d1 do
                BEGIN
                      While (p[i] >= sum - q[j-1]) and (j > 1) do dec(j);
                      if p[i] + q[j] = sum then
                        BEGIN
                             b1 := cp[i];
                             b2 := cq[j];
                             break;
                        END;
                END;
              For i := 1 to n+m do res[i] := 2;
              For i := 0 to n-1 do
                 BEGIN
                     if (b1 shr i) and 1 = 1 then res[i+1] := 1;
                 END;
              For i := 0 to m-1 do
                 BEGIN
                     if (b2 shr i) and 1 = 1 then res[n+i+1] := 1;
                 END;
              For i := 1 to m+n do write(fo,res[i]);
              writeln(fo);
        END;

Procedure Sub3;
Var i,j,dem,t,vt : longint;
    sum,s : int64;
    ok : boolean;
        BEGIN
              sum := 0;
              For i := 1 to n do
                BEGIN
                  read(fi,w[i]);
                  sum := sum + w[i];
                END;
              readln(fi);
              sum := sum div 2;
              s := 0;
              dem := 0;
              t := k;
              ok := false;
              For i := 1 to n do res[i] := 2;
              For i := 1 to n do
                BEGIN
                     s := s + w[i];
                     if s < sum then
                       BEGIN
                         res[i] := 1;
                       END
                       else if s > sum then
                         BEGIN
                              s := s - w[i];
                              res[i] := 0;
                              vt := i;
                              dec(k);
                              break;
                         END;
                END;
              For i := i+1 to n do
                 BEGIN
                      res[i] := 0;
                      dec(k);
                      if k = 0 then break;
                 END;
              While k > 0 do
                For i := 1 to n do
                  if res[i] = 1 then
                     BEGIN
                          res[i] := 0;
                          dec(k);
                          if k = 0 then break;
                     END;
              For i := 1 to n do if res[i] = 2 then ok := true;
              if ok = false then
                BEGIN
                      For i := 1 to n do
                        if res[i] = 1 then
                          BEGIN
                               res[i] :=2;
                               break;
                          END;
                END;
              For i := 1 to n do write(fo,res[i]);

        END;

Procedure input;
Var st,i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,t);
              For st := 1 to t do
                BEGIN
                      readln(fi,n,k);
                      if k = 0 then sub2
                        else sub3;
                END;
              close(fi); close(fo);
        END;

BEGIN
      input;
END.
