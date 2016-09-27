Uses crt;
Var     a,b,x,y,z,r       :       double;

begin
     clrscr;
     write('Nhap diem x,y : '); readln(x,y);
     write('Nhap tam a,b : '); readln(a,b);
     write('Nhap ban kinh r : '); readln(r);
     if sqr(x-a) + sqr(y-b) <= sqr(r) then z := abs(x) + abs(y)
      else z := x + y;
     write(z:0:2);
     readln;
end.