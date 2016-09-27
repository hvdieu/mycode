Const   inp = '';
        out = '';
        maxn = 1048580;
type    arr     =       array [1..maxn] of longint;
        arr1    =       array [1..maxn] of longint;
Var     fi,fo   :       text;
        wa,va,wb,vb     :       array [1..21] of longint;
        wx,wy,vx,vy,maxvy     :       array [1..maxn] of longint;
        m,n,max,dx,dy         :       longint;
        res     :       longint;
{*      *       *       *       *}
Procedure Input;
Var i,j         :       longint;
BEGIN
        Assign(fi,inp); reset(fi);
        readln(fi, n, max);
        m := n;
        n := n div 2;
        m := m - n;
        For i := 1 to n do readln(fi, wa[i], va[i]);
        For i := 1 to m do readln(fi, wb[i], vb[i]);
        close(fi);
END;
{*      *       *       *       *}
Procedure Swap( Var xx,yy : longint);
var temp : longint;
BEGIN
       temp := xx;
       xx := yy;
       yy := temp;
END;
{*      *       *       *       *}
Procedure Quicksort( L,H : longint);
Var i,j     :       longint;
    key     :       longint;
BEGIN
        if l >= h then exit;
        i := l;
        j := h;
        key := wy [ (l+h) div 2];
        Repeat
                While wy[i] < key do inc(i);
                While wy[j] > key do dec(j);
                if i <= j then
                        BEGIN
                            if i < j then
                                BEGIN
                                        Swap(wy[i],wy[j]);
                                        Swap(vy[i],vy[j]);
                                END;
                            inc(i);
                            dec(j);
                        END;
        Until i > j;
        Quicksort(L,j);
        Quicksort(i,h);
END;
{*      *       *       *       *}
Function Find(d,c : longint;key   :  longint) : longint;
Var mid : longint;
BEGIN
    While d < c do
        BEGIN
            mid := (d+c+1) div 2;
             if wy[mid] <= key then d := mid
              else c := mid -1;
        END;
    find := d;
END;
{*      *       *       *       *}
Procedure main;
Var     i,j     :       longint;
        sw,sv   :       longint;
BEGIN
        dx := 0;
        dy := 0;
        For i := 1 to 1 shl n - 1 do
                BEGIN
                        sw := 0;
                        sv := 0;
                        For j := 0 to n - 1 do
                                BEGIN
                                    if (i shr j) and 1 = 1 then
                                        BEGIN
                                            sw := sw + wa[ j+1 ];
                                            sv := sv + va[ j+1 ];
                                            if sw > max then break;
                                        END;
                                END;
                        if sw <= max then
                                BEGIN
                                    inc(dx);
                                    wx[dx] := sw;
                                    vx[dx] := sv;
                                END;

                END;
        For i :=1 to 1 shl m - 1 do
                BEGIN
                        sw := 0;
                        sv := 0;
                        For j := 0 to m - 1 do
                                BEGIN
                                    if (i shr j) and 1 = 1 then
                                        BEGIN
                                                sw := sw + wb [ j+1 ];
                                                sv := sv + vb [ j+1 ];
                                                if sw > max then break;
                                        END;
                                END;
                        if sw <= max then
                                BEGIN
                                    inc(dy);
                                    wy[dy] := sw;
                                    vy[dy] := sv;
                                END;
                END;
        Quicksort(1,dy);
        maxvy[1] := vy[1];
        For i:=2 to dy do
              BEGIN
                        if vy[i] > maxvy[i-1] then maxvy[i] := vy[i]
                                else maxvy[i] := maxvy[i-1];
              END;
        res:=0;
        For i:=1 to dx do
                BEGIN
                    j := find(1,dy,max - wx[i]);
                    if vx[i] + maxvy[j] > res then
                        res := vx[i] + maxvy[j];
                END;
        Assign(fo,out);rewrite(fo);
        write(fo,res);
        close(fo);

END;
{*      *       *       *       *}
BEGIN
     input;
     main;
END.