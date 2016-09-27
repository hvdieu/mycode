Const   inp = '';
        out = '';
        maxn = 15001;
Var     fi,fo : text;
        a,kq      :       array [0..maxn] of longint;
        nheap,x,max,res      :       longint;
        ch      :       char;

Procedure Swap( Var xx,yy : longint);
Var temp : longint;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure Upheap( i : longint);
Var cha,con   :  longint;
        BEGIN
                con := i;
                repeat
                        cha := con div 2;
                        if (cha = 0) or (a[cha] > a[con]) then break;
                        swap(a[cha],a[con]);
                        con := cha;
                Until false;
        END;

Procedure Push( x : longint);
        BEGIN
              inc(nheap);
              a[nheap] := x;
              Upheap(nheap);
        END;

Procedure Downheap(i : longint;x : longint);
Var cha,con,k : longint;
        BEGIN
              cha := i;
              k := x;
              repeat
                   con := cha*2;
                   if (con < nheap) and (a[con] < a[con+1]) then inc(con);
                   if (con > nheap) or (a[cha] > a[con]) then break;
                   swap(a[cha],a[con]);
                   cha := con;
              Until false;
        END;

Procedure Pop;
Var max : longint;
        BEGIN
              max := a[1];
              While (a[1] = max) and (nheap >0) do
              BEGIN
                a[1] := a[nheap];
                dec(nheap);
                Downheap(1,a[1]);
              END;
        END;

Procedure nhap;
Var   i,j,last : longint;
        BEGIN
                Assign(fi,inp); reset(fi);
                nheap := 0;
                While not eof(fi) do
                        BEGIN
                             read(fi,ch);
                             if ch = '+' then
                                BEGIN
                                   readln(fi,x);
                                   if nheap < 15000 then Push(x);
                                END
                             else
                                BEGIN
                                  if nheap > 0 then Pop;
                                  readln(fi);
                                END;
                        END;
                close(fi);
                Assign(fo,out); rewrite(fo);
                res := 0;
                kq[0] := -1;
                last := -1;
                While nheap > 0 do
                   BEGIN
                        if a[1] <> kq[res] then
                           BEGIN
                                inc(res);
                                kq[res] := a[1];
                           END;
                        a[1] := a[nheap];
                        dec(nheap);
                        downheap(1,a[1]);
                   END;
                writeln(fo,res);
                For i := 1 to res do write(fo,kq[i],' ');
                   close(fo);
        END;
BEGIN
      nhap;
END.
