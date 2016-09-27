{$INLINE ON}
uses math ;
const
   amax = 1000000 ;
var
   res,test,n,m:longint;
   a:array[0..2510] of longint;
   dd:array[-amax..amax] of longint;
   f:array[0..2510,0..2510] of longint;
procedure process;
var i,j,k,v:longint;
begin
   read(test);
   while test > 0 do
    begin
      dec(test);   res := 0 ;
      read(n) ;
      for i := 1 to n do read(a[i]) ;
      for i := 1 to n do f[i][0] := 1;
      for i := 1 to n do begin
         for j := i + 1 to n do
          begin
            k := a[j] - a[i];
            if abs(k) > amax then v := 0 else v := dd[k] ;
            f[j][i] := f[i][v] + 1;
            res := max(res,f[j][i]) ;
          end ;
        dd[a[i]] := i ;
      end;
      for i := 1 to n do dd[a[i]] := 0 ;
      writeln(res) ;
    end;
end;
begin
       // assign(input,'spoj.inp') ;reset(input);
       // assign(output,'') ; rewrite(output) ;
        process;
end .

