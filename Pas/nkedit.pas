uses crt;
var s,p,st:string;
    i,n,k,l,d,j:integer;
    dung:boolean;
begin
     assign(input,'input.txt'); reset(input);
     assign(output, 'output.txt'); rewrite(output);
     clrscr;
     readln(k);
     readln(s);
     readln(p);
     d:=0;
     repeat
     dung:=false;
     n := length(s);
     for l:=n downto k do
         for i:=1 to n-l+1 do if (i+l-1 <= length(s)) then
             begin
                  st:=copy(s,i,l);
                  j := pos(st, p);
                  if j<>0 then
                     begin
                          delete(s,i,l);
                          delete(p,j,l);
                          d:=d+1;
                          dung:=true;
                          break;
                     end;
             end;
     until dung = false;
     writeln(d);
     writeln(s);
     writeln(p);
     readln;
END.
