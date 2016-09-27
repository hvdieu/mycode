{$H+}
Const   inp = '';
        out = '';
        maxk = 101;
Var     fi,fo   :       text;
        n,m,k,res   :       longint;
        mau       :       array [1..maxk] of string;
        la,s      : string;

procedure nhap;
var i,j   : longint;
    ch   : char;
    s   :       string;
        begin
                assign(fi, inp); reset(fi);
                readln(fi, n, m, k);
                for i := 1 to n do
                BEGIN
                        read(fi, ch);
                        la := la + ch;
                END;
                readln(fi);
                for i := 1 to k do
                        BEGIN
                                s := '';
                                for j := 1 to m do
                                        BEGIN
                                            read(fi,ch);
                                            s := s + ch;
                                        END;
                                mau[i] := s;
                                readln(fi);
                        END;
                close(fi);
        end;

procedure main;
var i,j,ham,t,g         :       longint;
        begin
                la := la + la;
                g := length(la);
                res := maxint;
                for i := 1 to k do
                        begin
                                s := mau[i];
                                for j := 1 to n do
                                        BEGIN
                                            ham := 0;
                                            for t := 1 to m do
                                               if s[t] <> la[j+t-1] then inc(ham);
                                            if ham < res then res := ham;

                                        END;
                        end;
        end;

procedure ghi;
        begin
                assign(fo,out); rewrite(fo);
                write(fo,res);
                close(fo);
        end;

BEGIN
        nhap;
        main;
        ghi;
END.