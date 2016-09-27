uses math;
Const   inp = 'VMECLIP.INP';
        out = 'VMECLIP.OUT';
Var     fi,fo : text;
        x1,x2,y1,y2,v1,v2       :       int64;
        goc1,goc2       :       integer;
        r1,r2,vg1,vg2,res   :       extended;
        t1,t2   :       boolean;
Procedure Swap( Var xx,yy : extended);
Var temp : extended;
BEGIN
    temp := xx; xx:= yy; yy:=temp;
END;

procedure dc( Var xx, yy : int64);
Var temp : int64;
BEGIN
     temp := xx; xx:= yy; yy:=temp;
END;

Function tinhgoc( x1,y1 : extended) : integer;
        BEGIN
              if x1 > 0 then
                BEGIN
                   if y1 > 0 then tinhgoc := 1
                     else tinhgoc := 2;
                END
                 else if x1 < 0 then
                        BEGIN
                            if y1 < 0 then tinhgoc := 3
                                else tinhgoc := 4;
                        END;
        END;

Procedure main;
Var     a1,a2,b1,b2,y3,o,hv   :   extended;
        BEGIN
             if (x1 <> 0) and (x2 <> 0) then
             BEGIN
             a1 := y1 / x1;
             a2 := y2 / x2;
             if (a1 = a2) then
                BEGIN
                    writeln(fo,0);
                    exit;
                END;
             END;
             t1 := false;
             t2 := false;
             r1 := sqrt( sqr(x1) + sqr(y1) );
             r2 := sqrt( sqr(x2) + sqr(y2) );
             vg1 := v1 / r1;
             vg2 := v2 / r2;
             if vg2 > vg1 then
                BEGIN
                    swap(vg1,vg2);
                    swap(a1,a2);
                    dc(x1,x2);
                    dc(y1,y2);
                    dc(v1,v2);
                END;
             if ( vg1 = vg2 ) then
                BEGIN
                        writeln(fo,-1);
                        exit;
                END;
             if (x1*x2 > 0) and (y1*y2 > 0) then
                BEGIN

                      y3 := x2 * a1;
                      if y3 > y2 then t1 := true
                        else t2 := true;
                      o := arccos( abs(a1*a2+1) / ( sqrt( sqr(a1) + 1) * sqrt( sqr(a2) + 1) ));
                      if (vg1 > vg2) and t1 then o := 2*pi - o;
                      if (vg1 < vg2) and t2 then o := 2*pi - o;
                      hv := abs(vg1 - vg2);
                      res := o / hv;
                      write(fo,res:0:7);
                      exit;

                END
                        else
                BEGIN
                    goc1 := tinhgoc(x1,y1);
                    goc2 := tinhgoc(x2,y2);
                    if (x1=0) or (x2=0) or (y1 = 0) or (y2 = 0 ) then
                        BEGIN
                            if x1 = 0 then
                              BEGIN
                                  a1 := 1;
                                  b1 := 0;
                                  if y1 > 0 then goc1 := 4
                                        else goc1 := 2;
                              END;
                            if x2 = 0 then
                              BEGIN
                                  a2 := 1;
                                  b2 :=0;
                                  if y2 > 0 then goc2 := 4
                                        else goc2 := 2;

                              END;
                            if y1 = 0 then
                                BEGIN
                                    a1 :=0;
                                    b1 :=1;
                                    if x1 > 0 then goc1 := 1
                                        else goc1 := 3;

                                END;
                            if y2 = 0 then
                                BEGIN
                                    a2 := 0;
                                    b2 := 1;
                                    if x1 > 0 then goc1 := 1
                                        else goc1 := 3;
                                END;
                        END
                          else BEGIN
                                    a1 := y1 / x1;
                                    a2 := y2 / x2;
                                    b1 := -1;
                                    b2 := -1;
                               END;
                    o := arccos( abs(a1*a2+b1*b2) / ( sqrt( sqr(a1) + sqr(b1)) * sqrt( sqr(a2) + sqr(b2)) ));
                    if (vg1 > vg2) then
                        BEGIN

                              if goc1 = 1 then
                                BEGIN
                                    if goc2 = 2 then o := 2*pi - o;
                                    if goc2 = 3 then
                                        BEGIN
                                           if abs(y2) > abs(x2) then o := 2*pi - o;
                                        END;
                                END;
                              if goc1 = 2 then
                                BEGIN
                                    if goc2 = 3 then o := 2*pi - o;
                                    if goc2 = 4 then
                                        BEGIN
                                            if abs(y2) > abs(x2) then o := 2*pi - o;
                                        END;
                                END;
                              if goc1 = 3 then
                                BEGIN
                                    if goc2 = 4 then o := 2*pi - o;
                                    if goc2 = 1 then
                                        BEGIN
                                            if abs(y2) > abs(x2) then o := 2*pi - o;
                                        END;
                                END;
                              if goc1 = 4 then
                                BEGIN
                                     if goc2 = 1 then o := 2*pi - o;
                                    if goc2 = 2 then
                                        BEGIN
                                            if abs(y2) > abs(x2) then o := 2*pi - o;
                                        END;
                                END;
                        END;
                    hv := abs(vg1 - vg2);
                    res := o / hv;
                    write(fo,res:0:7);
                    exit;

                END;

        END;

BEGIN
        Assign(fi, inp); reset(fi);
        Assign(fo, out); rewrite(fo);
        readln(fi, x1, y1, v1);
        readln(fi, x2, y2, v2);
        main;
        close(fi);
        close(fo);


END.
