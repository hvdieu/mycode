uses crt;
var s : string;
    i,dem : integer;

begin
    clrscr;
    write('Nhap xau : '); readln(s);
    for i := 1 to length(s) do
     if s[i]<>' ' then write(s[i]);
    readln;
end.