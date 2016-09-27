{$H+}
Var     i,n,t,x : longint;
        left,right : int64;
        s       :       string;

begin
    readln(s);
    n := length(s);
    for i := 1 to n do if s[i]='^' then
     begin
         t := i;
         break;
     end;
    for i := 1 to t-1 do
     if s[i] <> '=' then
       begin
           val(s[i],x);
           left := left+x*(t-i);
       end;
    for i := t+1 to n do
     if s[i] <> '=' then
       begin
           val(s[i],x);
           right := right+x*(i-t);
       end;
    if left = right then write('balance')
     else if left > right then write('left')
      else write('right');
    readln;
end.