Const   inp = 'hc.inp';
        out = 'hc.out';
        maxn = 200;
        maxC = 9999999;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     fi,fo   :       text;
        a,d,pos       :       array [1..maxn,1..maxn] of longint;
        free      :       array [0..maxn+1,0..maxn+1] of boolean;
        heapi,heapj     :       array [1..maxn*maxn] of longint;
        m,n,nheap,tmp,res     :       longint;


Procedure input;
Var i,j : integer;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,m,n);
              for i := 1 to m do
                for j := 1 to n do read(fi,a[i,j]);
              close(fi);
        END;

Procedure init;
Var i,j : integer;
        BEGIN
             fillchar(d,sizeof(d),0);
             for i := 1 to m do d[i,1] := a[i,1];
             For i := 1 to m do
               For j := 2 to n do
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
                      if j = n then
                        BEGIN
                          tmp := d[i,j];
                          break;
                        END;
                      free[i,j] := false;
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
Var i,j : longint;
        BEGIN
              res := maxlongint;
              init;
              For i := 1 to m do
                BEGIN
                     inc(nheap);
                     heapi[nheap] := i; heapj[nheap] := 1;
                     pos[i,1] := nheap;
                     Upheap(i,1);
                END;
              Dij;
              Assign(fo,out); rewrite(fo);
              write(fo,tmp);
              close(fo);
        END;

BEGIN
       input;
       main;
END.
