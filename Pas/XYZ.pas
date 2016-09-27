Const   inp = 'XYZ.INP';
        out = 'XYZ.OUT';
        maxn = 501;
        maxC = 9999999;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     fi,fo   :       text;
        a,d,pos       :       array [1..maxn,1..maxn] of longint;
        free    :     array [0..maxn,0..maxn] of boolean;
        cx            :       array [1..5,1..5] of boolean;
        f       :     array [1..5,1..5] of longint;
        x,y     :     array [1..5] of longint;
        heapi,heapj       :     array [1..maxn*maxn] of longint;
        m,n,u,v,res,tmp,nheap       :       longint;

Procedure input;
Var i,j : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,m,n);
              for i := 2 to 4 do read(fi,x[i],y[i]);
              For i := 1 to m do
                For j := 1 to n do read(fi,a[i,j]);
              close(fi);
        END;

Procedure init;
Var i,j : longint;
        BEGIN
             fillchar(d,sizeof(d),0);
             For i := 1 to m do
               For j := 1 to n do
                 d[i,j] := maxC;
             nheap := 0;
             For i := 1 to m do
               For j := 1 to n do free[i,j] := true;
             fillchar(heapi,sizeof(heapi),0);
             fillchar(heapj,sizeof(heapj),0);
             fillchar(pos,sizeof(pos),0);
        END;

Procedure swap(Var xx,yy : longint);
Var temp : longint;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure upheap(i,j : longint);
Var cha,con : longint;
        BEGIN
            con := pos[i,j];
            if pos[i,j] = 0 then
            BEGIN
                inc(nheap); heapi[nheap] := i;
                heapj[nheap] := j;
                pos[i,j] := nheap;
                con := nheap;
            END;
            Repeat
               BEGIN
                     cha := con div 2;
                     if (cha = 0) or
                      (d[heapi[cha],heapj[cha]] < d[heapi[con],heapj[con]]) then break;
                     swap(heapi[cha],heapi[con]);
                     swap(heapj[cha],heapj[con]);
                     pos[heapi[cha],heapj[cha]] := cha;
                     pos[heapi[con],heapj[con]] := con;
                     con := cha;
               END;
            Until false;
        END;

Procedure Downheap(i,j : longint);
Var cha,con : longint;
        BEGIN
             cha := pos[i,j];
             Repeat
               BEGIN
                    con := cha*2;
                    if (con < nheap) and (d[heapi[con],heapj[con]] > d[heapi[con+1],heapj[con+1]]) then inc(con);
                    if (con > nheap) or
                     (d[heapi[cha],heapj[cha]] < d[heapi[con],heapj[con]]) then break;
                    swap(heapi[cha],heapi[con]);
                    swap(heapj[cha],heapj[con]);
                    pos[heapi[cha],heapj[cha]] := cha;
                    pos[heapi[con],heapj[con]] := con;
                    cha := con;
               END;
             until false;
        END;

Procedure Dij;
Var i,j,k : longint;
        BEGIN
             Repeat
                BEGIN
                      i := heapi[1];
                      j := heapj[1];
                      heapi[1] := heapi[nheap];
                      heapj[1] := heapj[nheap];
                      pos[heapi[1],heapj[1]] := 1;
                      Downheap(heapi[1],heapj[1]);
                      dec(nheap);
                      free[i,j] := false;
                      if (i=u) and (j=v) then
                        BEGIN
                          tmp := d[i,j];
                          break;
                        END;

                      For k := 1 to 4 do
                        if free[i+h[k],j+c[k]] then
                          BEGIN
                               if d[i+h[k],j+c[k]] > d[i,j] + a[i+h[k],j+c[k]] then
                                 BEGIN
                                   d[i+h[k],j+c[k]] := d[i,j] + a[i+h[k],j+c[k]];
                                   upheap(i+h[k],j+c[k]);
                                 END;
                          END;
                END;
             Until false;
        END;


Procedure main;
Var i,j,t,sum : longint;
        BEGIN
             x[1] := 1; y[1] := 1; x[5] := m; y[5] := n;
             res := maxlongint;
             fillchar(cx,sizeof(cx),true);
             For i := 1 to 5 do
              For j := i+1 to 5 do
               if (i <> j) and cx[i,j] then
                BEGIN
                     init;
                     d[x[i],y[i]] := a[x[i],y[i]];
                     inc(nheap);
                     heapi[nheap] := x[i]; heapj[nheap] := y[i];
                     pos[x[i],y[i]] := nheap;
                     u := x[j];
                     v := y[j];
                     Dij;
                     For t := i+1 to 5 do
                       if free[x[t],y[t]] = false then
                          BEGIN
                               f[i,t] := d[x[t],y[t]];
                               f[t,i] := f[i,t];
                               cx[i,t] := false;
                               cx[t,i] := false;
                          END;
                END;
             For i := 2 to 4 do
               For j := 2 to 4 do
                 if i <> j then
                   BEGIN
                        sum := f[1,i] + f[i,j] + f[j,5] - a[x[i],y[i]] - a[x[j],y[j]];
                        if sum < res then res := sum;
                   END;
             Assign(fo,out); rewrite(fo);
             write(fo,res);
             close(fo);
        END;

BEGIN
      input;
      main;
END.
