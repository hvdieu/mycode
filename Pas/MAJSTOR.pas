Var
r,n,i,j,t : integer;
r1,r2,kq,temp : longint;
s : string;
d : array ['A'..'Z',1..50] of integer;
k : array [1..3] of char;
gt : array ['A'..'Z'] of byte;
ch : char;

Function l(c1,c2 : char):byte;
BEGIN
if abs(gt[c1]-gt[c2])<=1 then
BEGIN
if gt[c1]<gt[c2] then l:=0
else if gt[c1]=gt[c2] then l:=1
else l:=2;
END
else
BEGIN
if gt[c1]>gt[c2] then l := 0
else l:=2;
END;
END;

BEGIN
readln(r);readln(s);readln(n);
for i:=1 to n do
BEGIN
For j:=1 to r do
BEGIN
read(ch);
inc(d[ch,j]);
END;
readln;
END;
gt['S']:=1;gt['R']:=2;gt['P']:=3;
k[1] :='S';k[2] :='R';k[3]:='P';
for i := 1 to r do
BEGIN
kq := 0;
for j := 1 to 3 do
r1 := r1 + l(s[i],k[j]) * d[k[j],i]
END;
writeln(r1);
for i := 1 to r do
BEGIN
temp := 0;
For j := 1 to 3 do
BEGIN
kq := 0;
for t := 1 to 3 do
kq := kq + l(k[j],k[t]) * d[k[t],i];
if kq > temp then temp := kq;
END;
r2 := r2 + temp;
END;
writeln(r2);
END.