uses math;
Const   inp = '';
        out = '';
Var     fi,fo : text;
        x1,x2,v1,v2,y1,y2       :       int64;
        vg1,vg2,r1,r2,o1,o2,o,hv,res :       extended;
        g1,g2,t   :       integer;

Procedure Swap(Var xx,yy : extended);
Var temp : extended;
        BEGIN
            temp := xx; xx:= yy; yy := temp;
        END;
Function tinhgoc(o1 : extended;g1 : integer) : extended;
BEGIN
    if (o1 < 0) and (g1=2) then tinhgoc := abs(o1);
    if (o1 > 0) and (g1=2) then tinhgoc := pi - o1;
    if (o1 < 0) and (g1=1) then tinhgoc := pi + o1;
    if (o1 >= 0) and (g1 =1) then tinhgoc := o1;
END;

Procedure main;
        BEGIN
             r1 := sqrt( sqr(x1) + sqr(y1) );
             r2 := sqrt( sqr(x2) + sqr(y2) );
             if y1 = 0 then o1 := pi/2
               else o1 := arctan(x1 / y1);
             if y2 = 0 then o2 := pi/2
               else o2 := arctan(x2 / y2);
             if x1 = 0 then
               if y1 > 0 then o1 := 0
                 else o1 := pi;
             if x2 = 0 then
               if y2 > 0 then o2 := 0
                 else o2 := pi;
             if x1 >= 0 then g1 := 1
              else g1 := 2;
             if x2 >= 0 then g2 := 1
              else g2 := 2;
             o1 := tinhgoc(o1,g1);
             o2 := tinhgoc(o2,g2);
             if (o1 = o2) and (g1 = g2) then
                BEGIN
                    writeln(fo,0);
                    exit;
                END;
             vg1 := v1 / r1;
             vg2 := v2 / r2;
             if vg1 = vg2 then
                BEGIN
                    writeln(fo,-1);
                    exit;
                END;
             if vg1 < vg2 then
               BEGIN
                    swap(vg1,vg2);
                    swap(o1,o2);
                    t := g1; g1 := g2; g2 := t;
               END;
             if (g1 = 1) and (g2 = 1) then
                BEGIN
                     if o1 > o2 then o := o1 - o2
                      else o := 2*pi - o2 + o1;
                END;
             if (g1 = 1) and (g2 = 2) then
                o := o1 + o2;
             if (g1 = 2) and (g2 = 1) then
                o := 2*pi - o1 - o2;
             if (g1 = 2) and (g2 = 2) then
               if o1 < o2 then o := o2 - o1
                 else o := 2*pi - o1 + o2;
             hv := vg1 - vg2;
             res := o / hv;
             writeln(fo,res:0:6);
        END;

BEGIN
        Assign(fi,inp); reset(fi);
        Assign(fo,out); rewrite(fo);
        readln(fi,x1,y1,v1);
        readln(fi,x2,y2,v2);
        close(fi);
        main;
        close(fo);
END.
