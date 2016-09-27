Const   inp = '';
        out = '';
Var     fi,fo : text;
        s,t     :       string;
        d      :       array ['a'..'z'] of integer;

Procedure main;
Var i,j,n,d1,d2,mid,temp,kq : integer;
        c1,c2,res   :       char;
        BEGIN
                if s = t then write(fo, s)
                        else
                           BEGIN
                               n := length(s);
                               for i := 1 to n do
                                  BEGIN
                                     if s[i] = t[i] then write(fo,s[i])
                                        else BEGIN
                                                 c1 := s[i]; c2 := t[i];
                                                 if d[c1] > d[c2] then
                                                        BEGIN
                                                            res := c2;
                                                            temp := d[c1] - d[c2];
                                                            kq := d[c2] - 1 + 27 - d[c1];
                                                            if kq <= temp then res := 'a';
                                                        END
                                                 else if d[c1] < d[c2] then
                                                        BEGIN
                                                            res := c1;
                                                            temp := d[c2] - d[c1];
                                                            kq := d[c1] - 1 + 27 - d[c2];
                                                            if kq <= temp then res := 'a';
                                                        END;
                                                 write(fo,res);
                                             END;

                                  END;
                           END;
        END;

Procedure nhap;
Var cse   :   string;
    ch  :  char;
    i   :  integer;
        BEGIN
                Assign(fi, inp); reset(fi);
                Assign(fo, out); rewrite(fo);
                i := 0;
                for ch := 'a' to 'z' do
                        BEGIN
                            inc(i);
                            d[ch] := i;
                        END;
                Repeat
                        readln(fi, cse);
                        if cse = '[CASE]' then
                                BEGIN
                                    readln(fi, s);
                                    readln(fi, t);
                                    readln(fi);
                                    main;
                                    writeln(fo);
                                END
                                        else break;
                until false;
                close(fi);
                close(fo);

        END;

BEGIN
    nhap;
END.