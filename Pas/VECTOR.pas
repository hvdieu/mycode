Const   inp = '';
        out = '';
        maxn = 31;
Var     fi,fo   :       text;
        ax,ay,bx,by     :       array [1..maxn] of integer;
        f       :        array [-3001..3001,-3001..3001] of longint;
        i,j,n,m,u,v,res   :       longint;
{*      *       *       *       *}
Procedure nhap;
Var i,j         :       longint;
BEGIN
        Assign(fi,inp); reset(fi);
        Assign(fo,out); rewrite(fo);
        readln(fi,n);
        m := n;
        n := n div 2;
        m := m - n;
        For i := 1 to n do
                BEGIN
                        readln(fi, ax[i], ay[i]);
                END;
        For i := 1 to m do readln(fi, bx[i], by[i]);
        readln(fi, u, v);
        close(fi);
        if (abs (u) > 3000) or (abs(v) > 3000) then
          BEGIN
            write(fo,0);
            close(fo);
            halt;
          END;

END;
{*      *       *       *       *}
Procedure init;
Var    i,j,sa,sb : longint;
BEGIN
        For i:=1 to 1 shl n - 1  do
                BEGIN
                        sa := 0;
                        sb := 0;
                        For j:= 0 to n - 1 do
                                BEGIN
                                    if (i shr j) and 1 = 1 then
                                        BEGIN
                                                sa := sa + ax[ j+1 ];
                                                sb := sb + ay[ j+1 ];
                                        END;
                                END;
                        inc(f[sa, sb]);
                END;
        for i:=1 to 1 shl m - 1 do
                BEGIN
                        sa := 0;
                        sb := 0;
                        For j := 0 to m - 1 do
                                BEGIN
                                    if (i shr j) and 1 = 1 then
                                        BEGIN
                                                sa := sa + bx[ j+1 ];
                                                sb := sb + by[ j+1 ];
                                        END;
                                END;
                        res := res + f[ u - sa, v - sb ];
                        if (u = sa) and (v = sb) then inc(res);
                END;
        res := res + f[u,v];
        if (u = 0) and (v = 0) then inc(res);
        write(fo,res);
        close(fo);
END;
{*      *       *       *       *}
BEGIN
    nhap;
    init;
END.