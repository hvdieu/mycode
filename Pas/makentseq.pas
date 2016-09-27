Const out = 'ntseq.inp';
var n,i : longint;

begin
    randomize;
    assign(output,out); rewrite(output);
    n := 100000;
    writeln(n);
  //  for i := 1 to n do write(random(1000000000)+1,' ');
    for i := 1 to n div 2 do write(1,' ');
    for i := n div 2 +1 to n do write(1,' ');
end.
