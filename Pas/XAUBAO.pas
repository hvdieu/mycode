uses crt;
Var
    a,b,s,t,c,d : string;
    temp,m,n,i,j : longint;

begin
    clrscr;
    write('Nhap xau a : '); readln(a);
    write('Nhap xau b : '); readln(b);
    s := a+b;
    m := length(a); n := length(b);
    temp := m+n;
    for i := 1 to m do
      begin
          d := copy(a,1,m-i);
          c := copy(a,m-i+1,i);
          if (pos(c,b)=1) and (n+m-i<temp) then
            begin
                temp := n+(m-i);
                s := d+b;
            end;
      end;
    t := a; a := b; b := t;
    m := length(a); n := length(b);
    for i := 1 to m do
      begin
          d := copy(a,1,m-i);
          c := copy(a,m-i+1,i);
          if (pos(c,b)=1) and (n+m-i<temp) then
            begin
                temp := n+(m-i);
                s := d+b;
            end;
      end;
    write('Xau bao ngan nhat la : ',s);
    readln;
end.