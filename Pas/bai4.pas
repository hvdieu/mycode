uses crt;
var s : string;
    i,dem : integer;

begin
    clrscr;
    write('Nhap xau : '); readln(s);
    for i := 1 to length(s)-1 do
     if (s[i]=' ') and (s[i+1]<>' ') then inc(dem);
    writeln(dem+1);
    readln;
end.