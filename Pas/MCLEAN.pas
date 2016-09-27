Const   inp = 'MCLEAN.INP';
        out = 'MCLEAN.OUT';
        maxn = 21;
Type    point = record
           x,y : integer;
END;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of char;
        d       :       array [1..maxn,
        b       :       array [1..11] of point;
        free,cx    :       array[0..maxn,0..maxn] of boolean;
        m,n,dem,vx,vy     :       integer;
        qx,qy   :       array [1..410] of integer;

Procedure main;
Var i,j : integer;
        BEGIN
              For i := 1 to dem do
                For j := 1 to
        END;

Procedure input;
Var i,j : integer;
        BEGIN
              Assign(fi,inp); reset(fi);
              fillchar(free,sizeof(free),false);
              readln(fi,m,n);
              dem := 0;
              For i := 1 to m do
                BEGIN
                      For j :=1 to n do
                        BEGIN
                             read(fi,a[i,j]);
                             free[i,j] := true;
                             if a[i,j] = '*' then
                               BEGIN
                                     inc(dem);
                                     b[dem].x := i;
                                     b[dem].y := j;
                               END;
                             if a[i,j] = 'x' then free[i,j] := false;
                             if a[i,j] = 'o' then
                               BEGIN
                                    vx := i;
                                    vy := j;
                               END;
                        END;
                      readln(fi);
                END;

        END;
