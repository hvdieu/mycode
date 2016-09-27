Const    inp = '';
         out = '';
         maxn = 10001;
         kq     :       array [1..3] of integer = (1,1,0);
Var      fi,fo  :       text;
         s,n,n1,sum,st    :       int64;
         k,i,ck,j,res,a,b      :       longint;

         f      :       array [0..3] of longint;
         dem    :       array [0..maxn] of int64;

{*       *      *       *       *}
Procedure Swap(Var a,b : longint);
Var temp : longint;
BEGIN
        temp := a;
        a := b;
        b := temp;
END;
{*      *       *       *       *}
Procedure Output;
BEGIN
    sum := 0;
    For i:= 0 to k do
        BEGIN
            s := s - dem[i];
            if s <= 0 then
                BEGIN
                 res :=i;
                 break;
                END;
        END;
    write(fo,res );
    close(fo);
    halt;
END;
{*      *       *       *       *}
BEGIN
    assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,n,k,s);
    close(fi);
    f[1]:=1;
    f[2]:=2;
    inc(dem[1]);
    inc(dem[2]);
    i:=2;
    a := f[1];
    b := f[2];
    if n = 1 then
        BEGIN
            write(fo,1);
            close(fo);
            halt;

        END
          else if n = 2 then
                BEGIN
                    if s = 2 then
                    write(fo,2);
                    if s = 1 then write(fo,1);

                    close(fo);
                    halt;
                END
                  else if (n > 2) and (k = 1) then
                        BEGIN
                            if s > 3 then
                       BEGIN
                           if s < n - 2 then write(fo,0);
                           if s = n - 1 then write(fo,1);
                           if s = n then write(fo,2);
                       END;
                    close(fo);
                    halt;
                        END;
    if k = 2 then
        BEGIN

            if n = 3 then inc(dem[1]);
            if n = 4 then inc(dem[1],2);
            if n = 5 then
                BEGIN
                    inc(dem[1],2);
                    inc(dem[0]);
                END;
            if n > 5 then
                BEGIN
                    inc(dem[1],2);
                    inc(dem[0]);
                    n1 := (n - 2) mod 3;
                    n := (n - 2) div 3;

                    if n <> 0 then
                    for i:= 0 to 1 do
                      dem[i] := dem[i] * n;
                    For i:=1 to n1 do
                        BEGIN
                            inc(dem [ kq[i] ]);
                        END;
                END;
            output;
        END;
    While i < n do
        BEGIN
            inc(i);
            a := ( a + b) mod k;
            inc(dem[a]);
            swap(a,b);
           if (a=1) and (b = 2) then
                BEGIN
                    dec( dem[a]);
                    dec( dem[b]);
                    break;
                END;
        END;
    if i < n then
    BEGIN
        ck:=i-2;
        n1 := n mod ck;
        st := n div ck;
        For i := 0 to k - 1 do
                dem[i] := dem[i] * st;
        if n1 = 1 then inc(dem[a]);
        if n1 = 2 then
                BEGIN
                    inc(dem[a]);
                    inc(dem[b]);
                END;
        if n > 2 then
                BEGIN
                        For i:= 3 to n1 do
                                BEGIN
                                    a := ( a + b) mod k;
                                    inc( dem[a]);
                                    swap(a,b);
                                END;
                END;
    END;
    output;
END.
