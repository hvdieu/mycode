Const   out = 'bietthu.inp';
Var         fo      :       text;
        n       :       longint;
        i       :       longint;

begin
     assign(fo,out); rewrite(fo);
     write('n= '); read(n);
     writeln(fo,n);
     for i := 1 to n do writeln(fo,1+random(29999),' ',1+random(29999));
     close(fo);
end.
