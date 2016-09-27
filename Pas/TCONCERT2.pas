uses math ;
const
     p = 1000000000 ;
type
    big = array[0..4] of longint;
var   n,m:longint;
      res:big;
      s,h:array[0..1000100] of int64 ;
      a,b,c:array[0..400100] of longint;
function Add(a,b:big) : big ;
var i,tmp :longint;
      c:big ;
      begin
            c[0] := max(a[0],b[0]) ;
            tmp := 0 ;
            for i := 1 to c[0] do
               begin
                     if i <= a[0] then tmp := tmp + a[i];
                     if i <= b[0] then tmp := tmp + b[i];
                     c[i] := tmp mod p ;
                     tmp := tmp div p ;
               end;
            if tmp > 0 then
             begin
                  inc(c[0]) ;
                  c[c[0]] := tmp ;
             end;
            exit(c) ;
      end;
function Mul(a:int64 ; b:longint) :big ;
var i :longint;
      tmp :int64;
      c:big;
begin
      c[0] := 0 ;
      while a > 0 do
       begin
              inc(c[0]) ;
              c[c[0]] := a mod p ;
              a := a div p ;
       end;
       tmp := 0 ;
     for i := 1 to c[0] do
         begin
                tmp := tmp + int64(c[i]) * b ;
                c[i] := tmp mod p;
                tmp := tmp div p ;
         end;
     if tmp > 0 then
       begin
            inc(c[0]);
            c[c[0]] := tmp;
       end;
     exit(c) ;
end;
procedure iNn(c:big) ;
var i:longint;
      s:string ;
      tmp : int64 ;
 begin
    tmp := 0 ;
      for i := c[0] downto 1 do
           begin
                 tmp := tmp * p + c[i] ;
                 c[i] := tmp div 2 ;
                 tmp := tmp mod 2 ;
           end;
      while (c[0] > 0) and (c[c[0]] = 0) do dec(c[0] );
      write(c[c[0]]) ;
      for i := c[0] - 1 downto 1 do
           begin
                 str(c[i],s) ;
                 while length(s ) < 9 do s:= '0' + s;
                 write(s) ;
           end;
 end;
procedure process;
var
  i,j,k:longint;
  sum: int64 ;
begin
     read(n,m) ;
     for i := 1 to m do
      begin
           read(a[i],b[i],c[i]) ;
           inc(h[a[i]],c[i]) ;
           dec(h[b[i]+1],c[i]) ;
      end;
     res[0] := 0 ;
     for i := 1 to n do
       begin
         h[i] := h[i-1] + h[i] ;
         s[i] := s[i-1] + h[i];
       end;
       for i := 1 to m do
       begin
             sum := s[b[i]] - s[a[i]-1] - int64(b[i]- a[i] + 1) * c[i] ;
             res := add(res,Mul(sum,c[i])) ;
       end;
       inn(res) ;
end ;
begin
     assign(input,'TCONCERT.INP') ; reset(input) ;
     assign(output,'TCONCERT.OU1');rewrite(output) ;
     process ;
end.


