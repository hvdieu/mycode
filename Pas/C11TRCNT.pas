Const   inp = '';
        out = '';
        maxn = 201;
Type    point = record
        x,y : int64;
END;
Var     fi,fo   :       text;
        p     :       array [1..maxn] of point;
        dem   :       array [1..maxn] of longint;
        i,j,n,min,vt,res     :       longint;

Function th(p1,p2,p3 : point) : boolean;
Var vt1,vt2 : point;
BEGIN
        vt1.x := p2.x - p1.x;
        vt1.y := p2.y - p1.y;
        vt2.x := p3.x - p2.x;
        vt2.y := p3.y - p2.y;
        if vt1.x * vt2.y = vt2.x * vt1.y then exit(true)
            else exit(false);
END;

Procedure main;
Var i,j,k : integer;
        BEGIN
              fillchar(dem,sizeof(dem),0);
              res := 0;
              For i := 1 to n - 2 do
                For j := i+1 to n-1 do
                  For k := j+1 to n do
                     BEGIN
                          if th(p[i],p[j],p[k]) = false then
                            BEGIN
                                 inc(res);
                                 inc(dem[i]);
                                 inc(dem[j]);
                                 inc(dem[k]);
                            END;
                     END;
              min := maxlongint;
              For i := 1 to n do
                if dem[i] < min then
                  BEGIN
                        vt := i;
                        min := dem[i];
                  END;


        END;

BEGIN
      Assign(fi,inp); reset(fi);
      readln(fi,n);
      For i := 1 to n do readln(fi,p[i].x,p[i].y);
      close(fi);
      main;
      Assign(fo,out); rewrite(fo);
      write(fo,res,' ',vt);
      close(fo);

END.