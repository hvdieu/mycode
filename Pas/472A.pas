Const
    inp = 'asd.inp';
    out = 'asd.out';

Var n,i,j : longint;
    p  : array [2..1000000] of boolean;

begin
    readln(n);
    if n mod 2=0 then writeln(n-4,' ',4)
     else begin
         fillchar(p,sizeof(p),true);
         for i := 2 to 1000 do
         if p[i] then
           begin
               j := i*i;
               while j<=1000000 do
                 begin
                     p[j] := false;
                     j := j+i;
                 end;
           end;
         for i := n-2 downto 2 do
          if (p[i]=false) and (p[n-i]=false) then
           begin
             writeln(i,' ',n-i);
             readln;
             halt;
           end;
     end;
    readln;
end.