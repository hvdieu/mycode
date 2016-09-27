Const   inp = '';
        out = '';
Var     fi,fo : text;
        ca,cb,ma,mb,t,du     :       int64;
        res,y,temp     :       int64;
        i       :       longint;

Function min ( xx,yy : int64) : int64;
        BEGIN
                if xx > yy then min := yy
                        else min := xx;
        END;

Procedure Main;
        BEGIN
                if (ca = 0) or (ma = 0) then
                        BEGIN
                            res := min( cb,mb);
                            writeln(fo,res);
                            exit;
                        END;
                if (cb = 0) or (mb = 0) then
                        BEGIN
                            res := min (ca,ma);
                            writeln(fo,res);
                            exit;
                        END;
                if ca = cb then
                        BEGIN
                            res := ca + cb;
                            writeln(fo,res);
                            exit;
                        END;
                if ca > cb then
                        BEGIN
                            temp := ca;
                            ca := cb;
                            cb := temp;
                            temp := ma;
                            ma := mb;
                            mb := temp;
                        END;
                res := ca + ca + 1;
                du := cb - ca - 1;
                y := (ca + 1) * (mb - 1);
                res := res + min (du,y);
                writeln(fo,res);

        END;

BEGIN
        Assign(fi,inp); reset(fi);
        Assign(fo,out); rewrite(fo);
        readln(fi,t);
        for i := 1 to t do
                BEGIN
                        readln(fi,ca,cb,ma,mb);
                        main;
                END;
        close(fi);
        close(fo);
END.
