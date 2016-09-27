uses crt;
const
        Nmax    =       500000;
var
       a            :       array[1..500000] of longint;
       n,i,j,tg,min :       longint;
BEGIN
       read(n);
       for i:=1 to n do
        read(a[i]);


       for i:=1 to n-1 do
         for j:=i+1 to n do
          if a[i]>a[j] then
           begin
             tg:=a[i];
             a[i]:=a[j];
             a[j]:=tg;
           end;
   {   min:=a[1];
      for i:=2 to n do if a[i]<min then min:=a[i];  }

      j:=1;
      for i:=1 to n do
      while j=a[i] do
        inc(j);
      write(j);
 readln;

END.