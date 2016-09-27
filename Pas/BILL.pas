Const   inp = '';
        out = '';
        tien    :       array [1..3] of longint = (20000,2990000,497990000);
        dien    :       array [1..4] of integer = (700,500,300,200);
Var     fi,fo : text;
        x,y,res,t1,t2 : int64;
        d1,d2,n :       longint;
        cs      :       integer;

Function tinhtien(sum : int64) : int64;
Var t : int64;
        BEGIN
               t := 0;
               While sum > 0 do

                        BEGIN
                              if sum > 1000000 then
                                  BEGIN
                                        t := t + 700* (sum - 1000000);
                                        sum := 1000000;
                                  END;
                              if (sum > 10000) and (sum <= 1000000) then
                                  BEGIN
                                        t := t + 500* (sum - 10000);
                                        sum := 10000;
                                  END;
                              if (sum > 100) and (sum <= 10000) then
                                  BEGIN
                                        t := t + 300*(sum - 100);
                                        sum := 100;
                                  END;
                              if sum <= 100 then
                                  BEGIN
                                        t := t + sum * 200;
                                        sum := 0;
                                  END;
                        END;
               tinhtien := t;
        END;

Function tinhdien(sum : int64) : longint;
Var temp : longint;
        BEGIN
              if sum >= tien[3] then
                BEGIN
                      temp := 1000000;
                      sum := sum - tien[3];
                      n := sum;
                      temp := temp + sum div 700;
                      cs := 1;
                END
              else if (sum >= tien[2]) and (sum < tien[3]) then
                BEGIN
                       temp := 10000;
                       sum := sum - tien[2];
                       n := sum;
                       temp := temp + sum div 500;
                       cs := 2;
                END
              else if (sum >= tien[1]) and (sum < tien[2]) then
                BEGIN
                       temp := 100;
                       sum := sum - tien[1];
                       temp := temp + sum div 300;
                       n := sum;
                       cs := 3;
                END
              else if sum < tien[1] then
                BEGIN
                     temp := sum div 200;
                     n := sum;
                     cs := 4;
                END;
              tinhdien := temp;
        END;

Function find(d,c   :   int64) : int64;
Var mid,s : int64;
        BEGIN
              While d <= c do
                BEGIN
                      mid := (d+c) div 2;
                      d1:= mid;
                      t1 := tinhtien(d1);
                      t2 := t1 + y;
                      d2 := tinhdien(t2);
                      s := tinhtien(d1+d2);
                      if (s = x) and (n mod dien[cs] = 0) then
                         BEGIN
                               find := t1;
                               exit;
                         END
                           else if (s >= x) then c := mid -1
                             else d := mid + 1;


                END;
        END;


BEGIN
       assign(fi,inp); reset(fi);
       readln(fi,x,y);
       close(fi);
       res := find(1,10000000000);
       Assign(fo,out); rewrite(fo);
       write(fo,res);
       close(fo);

END.