Const   inp = 'QBBISHOP.INP';
        out = 'QBBISHOP.OUT';
        maxn = 201;
        h       :       array [1..4] of integer = (-1,-1,1,1);
        c       :       array [1..4] of integer = (-1,1,1,-1);
Var     fi,fo   :       text;
        free    :       array [0..maxn,0..maxn] of boolean;
        qx,qy   :       array [1..201*201] of integer;
        n       :       integer;
        left,right : longint;

Procedure input;
Var i,j,x,y : integer;
        BEGIN
                Assign(fi, inp); reset(fi);
                readln(fi,n,m,p,q,s,t);
                For i := 1 to n do
                  For j := 1 to n do free[i,j] := true;
                For i := 1 to m do
                  BEGIN
                        readln(fi,x,y);
                        free[x,y] := false;
                  END;
        END;

Procedure main;
Var i,j,px,py  :   integer;
        BEGIN
               left := 0;
               right := 1;
               qx[right] := s;
               qy[right] := t;
        END;