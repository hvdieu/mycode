Const   in1 = 'horses.out';
        in2 = 'horses.oup';
        out = 'Compare.out';
Var     f1,f2,fo : text;
        i       :       longint;
        x,y : longint;

begin
     assign(f1,in1); reset(f1);
     assign(f2,in2); reset(f2);
     assign(fo,out); rewrite(fo);
     while not eof(f1) do
      begin
         inc(i);
         readln(f1,x); readln(f2,y);
         if x <> y then
           writeln(fo,i,' ',x,' ',y);
      end;
     close(fo);
end.

