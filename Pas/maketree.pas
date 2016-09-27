Const	out = 'input.txt';
Var	fo : text;
        n,i,x, m,t,u,v : longint;

begin
      randomize;
      assign(output,out); rewrite(output);
      n := 1000; m := 1000;
      writeln(n,' ', m);
      for i := 2 to n-1 do writeln(i,' ', random(i-1)+1);
      for i := 1 to m do
        begin
            u := random(n)+1;
            v := random(n)+1;
            if u > v then begin
                  t := u; u := v; v := t;
            end;
            writeln(u,' ',v);
        end;
end.
