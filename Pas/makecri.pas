Const out = 'critical.inp';
Var i,j : longint;
    fo : text;
    n,m : longint;
BEGIN
     assign(fo,out); rewrite(fo);
     writeln(fo,20000,' ',200000);
     For i := 1 to 200000 do
       BEGIN
         j := random(15000);
         writeln(fo,j+1,' ',j+random(4000)+1);

       END;
     close(fo);

END.

