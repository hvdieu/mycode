Const   inp = '';
        out = '';
        a       :       array [0..9] of integer = (0,1,2,3,4,5,6,7,8,9);
        b       :       array [0..9] of integer = (0,0,2,3,4,5,6,7,8,9);
Var     fi,fo : text;
        n,k,t,s,m,i       :       longint;


BEGIN
        Assign(fi,inp); reset(fi);
        Assign(fo,out);rewrite(fo);
        readln(fi,k);
        For t := 1 to k do
                BEGIN
                        readln(fi,n);
                        if n < 10 then
                                BEGIN
                                        For i := 1 to n do write(fo,i);
                                        for i := n-1 downto 1 do write(fo,i);
                                        writeln(fo);
                                END
                                else
                                BEGIN
                                        m := n div 9;
                                        s := n mod 9;
                                        write(fo,'12346579');
                                        if s <> 0 then
                                        BEGIN
                                        for i := 1 to m -1 do write(fo,'012345679');
                                        if s = 1 then write(fo,'00')
                                        else
                                        BEGIN
                                        for i := 0 to s do write(fo,a[i]);
                                        for i := s - 1 downto 1 do write(fo,b[i]);
                                        END;
                                        for i := 1 to m - 1do write(fo,'987654320');
                                        writeln(fo,'987654321');
                                        END
                                                else
                                                        BEGIN
                                                            for i := 1 to m-2 do write(fo,'012345679');
                                                            write(fo,'012345678');
                                                            for i := 1 to m-1 do write(fo,'987654320');
                                                            writeln(fo,'987654321');
                                                        END;
                                END;
                END;
        close(fi);
        close(fo);
END.