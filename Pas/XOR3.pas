Const   inp = 'XOR3.INP';
        out = 'XOR3.OUT';
Var     fi,fo : text;
        a1,b1,a2,b2,a3,b3,min,max,c,x      :       longint;
        ba1,bb1,bx : integer;
        ok1,ok2 : boolean;

procedure input;
        BEGIN
             assign(fi,inp); reset(fi);
             readln(fi,a1,b1);
             readln(fi,a2,b2);
             readln(fi,a3,b3);
             close(fi);
        END;

Function bat(x ,i : longint) : longint;
        BEGIN
             bat := x or (1 shl i);
        END;

Function tat(x,i : longint) : longint;
        BEGIN
             tat := x and (not(1 shl i));
        END;

Function lay(x,i : longint) : longint;
        BEGIN
            lay := (x shr i) and 1;
        ENd;

procedure update(x,j : longint);
        BEGIN
             if bx < bb1 then ok2 := true;
             if bx > ba1 then ok1 := true;
        END;

procedure timmax;
Var i : longint;
    bit,bit1,cmin,cmax,j : integer;
        BEGIN
              max := -maxlongint;

              For i := a2 to b2 do
                  BEGIN
                        c := i xor a3;
                        x := 0;
                        ok1 := false; ok2 := false;
                        For j := 31 downto 0 do
                           BEGIN
                                bit := (c shr j) and 1;
                                ba1 := lay(a1,j);
                                bb1 := lay(b1,j);
                                if ok1 then cmin := 0
                                  else cmin := ba1;
                                if ok2 then cmax := 1
                                  else cmax := bb1;
                                if cmin = cmax then
                                   BEGIN
                                        if cmin = 1 then x := bat(x,j)
                                          else x := tat(x,j);

                                   END
                                     else
                                   BEGIN
                                         if bit = 1 then
                                            BEGIN
                                                 x := tat(x,j);
                                            END
                                              else
                                            BEGIN
                                                  x := bat(x,j);
                                            END;
                                   END;
                                bx := lay(x,j);
                                update(x,j);
                           END;
                        if max < x xor c then max := x xor c;
                  END;
        END;

Procedure timmin;
Var i : longint;
    bit,cmin,cmax,j : integer;
        BEGIN
              min := maxlongint;
              For i := a2 to b2 do
                  BEGIN
                        c := i xor a3;
                        x := 0;
                        ok1 := false;
                        ok2 := false;
                        For j := 31 downto 0 do
                          BEGIN
                                bit := (c shr j) and 1;
                                ba1 := lay(a1,j);
                                bb1 := lay(b1,j);
                                if ok1 then cmin := 0
                                  else cmin := ba1;
                                if ok2 then cmax := 1
                                  else cmax := bb1;
                                if cmin = cmax then
                                  BEGIN
                                        if cmin = 1 then x := bat(x,j)
                                          else x := tat(x,j);
                                  END
                                else
                                  BEGIN
                                        if bit = 1 then
                                          BEGIN
                                              x := bat(x,j);
                                          END
                                           else
                                          BEGIN
                                               x := tat(x,j);
                                          END;
                                  END;
                          END;
                        bx := lay(x,j);
                        update(x,j);
                        if min > x xor c then min := x xor c;
                  END;
        END;

procedure output;
        BEGIN
             assign(fo,out); rewrite(fo);
             writeln(fo,min);
             writeln(fo,max);
             close(fo);
        END;

BEGIN
     input;
     timmax;
     timmin;
     output;
END.
