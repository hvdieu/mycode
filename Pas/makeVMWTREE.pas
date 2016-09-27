Uses math;
Const
	out = 'VMWTREE.INP';

Var
	n,q,i,u,v,k : longint;
    p : array [1..100000] of longint;

procedure swap(var x,y : longint);
	var temp : longint;
begin
    temp := x; x := y; y := temp;
end;

begin
    randomize;
    assign(output,out); rewrite(output);
	n := 2000;
    q := 2000;
    for i := 1 to n do p[i] := i;
    for i := 1 to n do swap(p[i],p[random(n)+1]);
    writeln(n,' ',q);
    k := q div 2;
    for i := 1 to n do write(random(1000000000)+1,' ');
    writeln;
    for i := 2 to n do
     writeln(p[i],' ',p[random(i-1)+1]);
    for i := 1 to q do
      writeln(random(3)+1,' ',random(n)+1,' ',random(n)+1);
   // for i := 1 to q-k do
    //  writeln(random(2)+1,' ',random(n)+1,' ',random(n)+1);
end.
