Var     tu,mau,res,temp  :       int64;
begin
   //  assign(input,'asd.inp'); reset(input);
   //  assign(output,'asd.out'); rewrite(output);
     readln(tu,mau);
     res := 0;
     repeat
         if tu = 1 then
           begin
               inc(res,mau);
               break;
           end;
         res := res + tu div mau;
         tu := tu mod mau;
         temp := tu; tu := mau; mau := temp;
     until false;
     writeln(res);
end.
