var a:array[0..201,0..201] of char;
    b:array[0..200] of integer;
    m,n,i,j,d: integer;
BEGIN
   // assign(input,'mcityhal.inp'); reset(input);
   // assign(output,'mcityhal.out'); rewrite(output);
    readln(m,n);
    for i:=1 to m do
        begin
            for j:=1 to n do read(a[i,j]);
            readln;
        end;
    for j:=1 to n do b[j]:=0;
    for j:=1 to n do
        begin
             d:=0;
             for i:=1 to m+1 do
                 if a[i,j]='0' then d:=d+1
                    else
                        begin
                             b[d]:=b[d]+1;
                             d:=0;
                        end;
        end;
    for i:=1 to m do if b[i]<>0 then writeln(i,' ',b[i]);
END.