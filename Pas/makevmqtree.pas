Const	out = 'VMQTREE.INP';
var	n,q,ntest,i,j,u,v : longint;

begin
    randomize;
    assign(output,out); rewrite(output);
    ntest := 5;
    writeln(ntest);
    while ntest > 0 do
    begin
    dec(ntest);
    n := 50000;
    writeln(n);
    for i := 2 to n do
      begin
          writeln(i,' ',random(i-1)+1);
      end;
    q := 50000;
    writeln(q);
    for i := 1 to q do writeln(random(n)+1,' ',random(n)+1);
    end;
end.
