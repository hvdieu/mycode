{$MODE OBJFPC}
Const   inp = '';
        out = '';
        maxn = 20010;
Var     fi,fo     :     text;
        l,w     : array [0..maxn+1] of longint;
        f,startof       : array [0..maxn+1] of longint;
        n,t,m,k       : longint;
Procedure Swap(Var xx,yy : longint);
Var temp : longint;
        BEGIN
             temp := xx; xx := yy; yy := temp;
        END;

Function Find(i : longint) : longint;
Var dau,cuoi,giua,j : longint;
BEGIN
    dau:=1;cuoi:=m+1;
    repeat
        giua:=(dau+cuoi) div 2;
        j:=startof[giua];
        if (w[i] >= w[j]) then dau:=giua
             else cuoi:=giua;
      until dau+1=cuoi;
      find:=startof[dau];
END;


Procedure Quicksort(d,c : longint);
Var i,j,lkey,wkey : longint;
        BEGIN
              if d >= c then exit;
              i := d; j := c; lkey := l[(d+c) div 2];
              wkey := w[ (d+c) div 2];
              Repeat
                   While (l[i] < lkey) or ((l[i] = lkey) and (w[i] > wkey)) do inc(i);
                   While (l[j] > lkey) or ((l[j] = lkey) and (w[j] < wkey)) do dec(j);
                   if i <= j then
                      BEGIN
                            if i < j then
                               BEGIN
                                    swap(l[i],l[j]);
                                    swap(w[i],w[j]);
                               END;
                            inc(i);
                            dec(j);
                      END;
              Until i > j;
              Quicksort(d,j); quicksort(i,c);
        END;


Procedure Solve;
Var i,j : longint;
BEGIN
     For i:=n downto 0 do
       BEGIN
           j:=find(i);
           k:=f[j]+1;
           if k>m then
             BEGIN
                 m:=k;
                 startof[k]:=i;
             END
               else if w[i] < w[startof[k]] then
                     startof[k]:=i;
               f[i]:=k;

       END;
END;

Procedure input;
Var i,st : longint;
        BEGIN
              Assign(fi,inp); reset(fi);
              Assign(fo,out); rewrite(fo);
              readln(fi,t);
              For st := 1 to t do
                 BEGIN
                        readln(fi,n);
                        For i := 1 to n do read(fi,l[i],w[i]);
                        readln(fi);
                        w[0] := maxlongint;
                        w[n+1] := -maxlongint;
                        fillchar(f,sizeof(f),0);
                        fillchar(startof,sizeof(startof),0);
                        f[n+1] := 1; startof[1] := n+1;
                        Quicksort(1,n);
                        m := 1;
                        solve;
                        writeln(fo,m-2);
                 END;
              close(fi);
              close(fo);
        END;
BEGIN
    input;
END.