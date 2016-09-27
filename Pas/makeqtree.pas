uses math;
Const
	out = 'QTREE.INP';
    maxn = 10001;

Var
	n,i,ntest,t,m : longint;
    s : array [1..3] of string;
    a : array[0..1] of longint;

begin
	s[1] := 'QUERY '; s[2] := 'CHANGE '; s[3] := 'NEGATE ';
    a[0] := 2; a[1] := -1;
    randomize;
    assign(output,out); rewrite(output);
    ntest := 20;
    writeln(ntest);
    while ntest > 0 do
      begin
      		writeln;
          dec(ntest);
          n := 10000; m := 10000;
          writeln(n);
          for i := 2 to n do
           begin
              writeln(i,' ',random(i-1)+1,' ',a[random(2)]*random(10));
           end;
          for i := 1 to m do
            begin
                t := random(3)+1;
                write(s[t]);
                if (t=1) or (t=3) then writeln(random(n)+1,' ',random(n)+1)
                 else writeln(random(n-1)+1,' ',a[random(2)]*random(10));
            end;
          writeln('DONE');
      end;
end.
