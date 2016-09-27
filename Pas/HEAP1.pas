Const   inp = 'HEAP1.INP';
        out = 'HEAP1.OUT';
        maxn = 20001;
Var     fi,fo   :       text;
        a     :       array [1..maxn] of int64;
        n,nheap,t,st       : longint;
        res     : int64;

Procedure Swap( Var xx,yy : int64);
Var temp : int64;
        BEGIN
              temp := xx; xx := yy; yy := temp;
        END;

Procedure Downheap(i : longint);
Var cha,con : longint;
        BEGIN
              cha := i;
              repeat
                     con := cha*2;
                     if (con < nheap) and (a[con] > a[con+1]) then inc(con);
                     if (con > nheap) or (a[cha] < a[con]) then break;
                     swap(a[cha],a[con]);
                     cha := con;
              Until false;
        END;
Procedure Upheap(i : longint);
Var cha,con : longint;
        BEGIN
              con := i;
              repeat
                    cha := con div 2;
                    if (cha = 0) or (a[cha] < a[con]) then break;
                    swap(a[cha],a[con]);
                    con := cha;
              Until false;
        END;

Procedure main;
Var i,j,num1,num2   :  longint;
        BEGIN
              nheap := n;
              res := 0;
              for i := n div 2 downto 1 do downheap(i);
              repeat
                   num1 := a[1];
                   a[1] := a[nheap];
                   dec(nheap);
                   downheap(1);
                   num2 := a[1];
                   a[1] := a[nheap];
                   dec(nheap);
                   downheap(1);
                   res := res + num1 + num2;
                   inc(nheap);
                   a[nheap] := num1 + num2;
                   upheap(nheap);
              Until nheap = 1;
             writeln(fo,res);
        END;

Procedure nhap;
Var i : longint;
        BEGIN
                assign(fi,inp); reset(fi);
                assign(fo,out); rewrite(fo);
                readln(fi,t);
                for st := 1 to t do
                   BEGIN
                          readln(fi,n);
                          for i := 1 to n do read(fi,a[i]);
                          readln(fi);
                          main;
                   END;
                close(fi); close(fo);
        END;

BEGIN
      nhap;
END.
