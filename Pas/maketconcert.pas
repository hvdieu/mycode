var n,m,i,u,v : longint;

begin
    randomize;
    assign(output,'tconcert.inp'); rewrite(output);
    n := 400000; m := 1000000;
    writeln(m,' ',n);
    for i := 1 to n do
     begin
       u := random(m)+1; v := u+random(m-u);
       writeln(u,' ',v,' ',random(m)+1);
     end;
end.
