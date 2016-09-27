Uses crt;
Var     m,n,i,res : longint;
begin
     clrscr;
     write('Nhap m,n : '); readln(m,n);
     for i := m to n do
      if i mod 2 = 0 then inc(res);
     writeln('So so chan trong doan m -> n la : ',res);
     readln;
end.