var n,m,k,min,x1,x2,y1,y2:longint;
a,s:array[0..501,0..501] of longint;
procedure doc;
var i,j:longint;
begin
   readln(m,n,k); min:=maxlongint;
   for i:=1 to m do
    for j:=1 to n do read(a[i,j]);
end;
procedure xuly;
var i,j,i1,j1,t:longint;
begin
  for i:=1 to m do
    for j:=1 to n do
      s[i,j]:=s[i-1,j]+s[i,j-1]-s[i-1,j-1]+a[i,j];
  x1:=-1;x2:=-1;y1:=-1;y2:=-1;
  for i:=1 to m do
    for i1:=i to m do
          begin
             j:=1;
             j1:=1;
             repeat
               t:=s[i1,j1]-s[i1,j-1]-s[i-1,j1]+s[i-1,j-1];
               if t>=k then
                 begin
                   if (i1-i+1)*(j1-j+1)<min then
                     begin
                       min:=(i1-i+1)*(j1-j+1);
                       x1:=i;
                       x2:=i1;
                       y1:=j;
                       y2:=j1;
                     end;
                   inc(j);
                 end
               else inc(j1)
             until (j>j1) or (j1>n);
          end;
end;
procedure xuat;
begin
   // if (x1<>-1) and (x2<>-1) and (y1<>-1) and (y2<>-1) then
   Assign(fo,'out2.ou)');rewrite(fo);
   if min<>maxlongint then
     begin
       Writeln(min);
       Writeln(x1,#32,y1,#32,x2,#32,y2);
     end
   else Writeln(-1);
end;
begin
  assign(input,'14.in');reset(input);
  doc;
  xuly;
  xuat;
end.
