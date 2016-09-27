Const	out = 'message1.inp';
var i,j	:	longint;
	fo : text;

begin
     assign(fo,out); rewrite(fo);
     writeln(fo,1);
     writeln(fo,100,' ',100);
     for i := 1 to 100 do
      begin
       for j := 1 to 100 do
            if j <= 50 then write(fo,'a')
             else write(fo,'b');
       writeln(fo);
      end;
     for i := 1 to 100 do
       begin
           for j :=  1 to 100 do
            if j <= 50 then write(fo,'b')
             else write(fo,'a');
           writeln(fo);
       end;		
     close(fo);

end.
