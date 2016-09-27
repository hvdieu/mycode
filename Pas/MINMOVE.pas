Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        s,ss       :       ansistring;
        stack   :       array [1..maxn] of longint;
        xau      :       array [1..maxn] of ansistring;
        n,res,dem,d       :       longint;
        ch      :       char;
        ok      :       boolean;

Procedure Main;
Var st : char;
    i,j,k,vt,l   :   longint;
    min :   ansistring;

        BEGIN
                ss := s;
                n := 0;
                For st := 'a' to 'z' do
                        BEGIN
                                if pos(st,ss) = 0 then continue
                                else
                                        BEGIN
                                                ch := st;
                                                break;
                                        END;
                        END;
                While pos (ch,ss) <> 0 do
                        BEGIN
                                inc(n);
                                k := pos (ch,ss);
                                stack[n] := k;
                                ss[k] := '1';
                                xau[n] := ch;

                        END;
                dem := 0;
                if n = 1 then
                        BEGIN
                                res := stack[1] - 1;
                                write(fo,res);
                                exit;
                        END
                                else
                                BEGIN
                                     l := length(s);
                                     s:=s+s;
                                     For i :=1 to n do
                                     xau[i] := copy(s,stack[i],l-1);
                                     min := xau[1];
                                     vt := stack[1];
                                     For i:=2 to n do
                                        if xau[i] < min then
                                               BEGIN
                                                   vt := stack[i];
                                                   min := xau[i];
                                               END;
                                     write(fo,vt - 1);
                                     exit;

                                END;


        END;

BEGIN
        Assign(fi,inp); reset(fi);
        Assign(fo,out); rewrite(fo);
        read(fi,s);
        close(fi);
        main;
        close(fo);
END.
