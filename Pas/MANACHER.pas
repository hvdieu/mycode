Const    inp = 'manacher.inp';
         out = 'manacher.out';
         maxn = 50001;
Var      fi,fo    :    text;
         m      :   array [0..2*maxn+1] of longint;
         cur,r,p1,p2,n : longint;
         s      :       string;

Procedure manacher;
        BEGIN
               m[0] := 0;
               m[1] := 1;
               r := 2; cur := 1;
               For p2 := 2 to 2*n do
                   BEGIN
                          p1 := cur ;
                   END;
        END;

BEGIN
      Assign(fi,inp); reset(fi);
      readln(fi,n);
      readln(fi,s);
      close(fi);
END.