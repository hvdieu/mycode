{$MODE OBJFPC}
Const   inp = '';
        out = '';
        maxn = 201;
Var     fi,fo   :       text;
        a       :       array [-maxn..maxn,-maxn..maxn] of integer;
        dem     :       array [1..15] of qword;
        d       :       array [1..15] of boolean;
        xmax,ymax,xmin,ymin : longint;
        i,j     :       longint;
        n       :       longint;
        res     :       qword;

Procedure input;
Var i,j,x,y,k : longint;
        BEGIN
              Assign(fi,inp); reset(fi);
              readln(fi,n);
              xmax := -405; ymax := -405;
              xmin := 405;  ymin := 405;
              For i := 1 to n do
                 BEGIN
                      readln(fi,x,y,k);
                      a[x,y] := k;
                      if k = 3 then a[x,y] := 5;
                      if k = 4 then a[x,y] := 7;
                      if xmax < x then xmax := x;
                      if xmin > x then xmin := x;
                      if ymax < y then ymax := y;
                      if ymin > y then ymin := y;
                 END;
              close(fi);
        END;

Procedure main;
Var l,r,i : longint;
        BEGIN
              res := 0;
              fillchar(d,sizeof(d),false);
              d[3] := true; d[6] := true; d[8] := true;
              d[7] := true; d[9] := true; d[12] := true;
              For l := xmin to xmax-1 do
                 BEGIN
                       For r := l+1 to xmax do
                          BEGIN
                               fillchar(dem,sizeof(dem),0);
                               For i := ymax downto ymin do
                                 if (a[l,i] <> 0) and (a[r,i] <> 0) and (a[l,i] <> a[r,i]) then
                                   inc(dem[a[l,i] + a[r,i]]);
                               For i := 3 to 12 do
                                 if d[i] then res := res + dem[i]*dem[15-i];
                          END;
                 END;
              res := res div 2;
        END;

Procedure output;
        BEGIN
              Assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
      input;
      main;
      output;
END.