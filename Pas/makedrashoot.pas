Const	out = 'drashoot.inp';
	
var	n,m,i,dem,kind,u,v,count : longint;
	a : array [0..1] of char;

begin
    randomize;
    assign(output,out); rewrite(output);
    a[0] := 'S'; a[1] := 'Q';
    n := 10; m := 10;
    writeln(n);
    for i := 1 to n do writeln(random(100000));
    writeln(m); dem := n;
    for i := 1 to m do
      begin
          kind := random(2);
      	  write(a[kind],' ');
          if kind=0 then
            begin
                u := random(dem)+1;
                dec(dem); writeln(u);
                inc(count);
            end
          else
            begin
                u := random(count);
                v := u+random(count-u);
                writeln(u,' ',v);
            end;
      end;
end.
