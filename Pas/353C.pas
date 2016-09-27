uses math;
Const   maxn = 100001;

Var     n,i,j       :       longint;
        a,s     :       array [-1..maxn] of longint;
        f       :       array [0..maxn,0..1] of longint;
        b       : array [0..maxn] of char;

function tinh(i,ok : longint) : longint;
var j,res : longint;
        begin
             if f[i,ok] <> -1 then exit(f[i,ok]);
             if i = 0 then
              begin
                  if b[i] = '1' then f[i,ok] := a[i]
                   else f[i,ok] := 0;
                  exit(f[i,ok]);
              end;
             if ok = 1 then
               begin
                   if b[i] = '1' then f[i,ok] := max(tinh(i-1,1)+a[i],tinh(i-1,0))
                    else f[i,ok] := tinh(i-1,1);
               end
             else
               begin
                    f[i,ok] := s[i];
               end;
             exit(f[i,ok]);
        end;

begin
     // assign(input,'asd.inp'); reset(input);
     // assign(output,'asd.out'); rewrite(output);
      readln(n);
      for i := 0 to n-1 do
       begin
         read(a[i]);
         s[i] := s[i-1] + a[i];
       end;
      readln;
      for i := 0 to n-1 do read(b[i]);
      for i := 0 to n-1 do
      for j := 0 to 1 do f[i,j] := -1;
      write(tinh(n-1,1));
end.