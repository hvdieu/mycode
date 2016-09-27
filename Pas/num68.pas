Const   maxn = 19;
Var     s       :       string;
        n       :       longint;
        f       :       array [0..maxn,0..1] of int64;

function tinh(i,nho : longint) : int64;
var k,j,x,l1 : longint;
    dem : int64;
        begin
            if i = 0 then
              begin
                  if (nho = 0) then exit(1)
                   else exit(0);
              end;
            if f[i,nho] <> -1 then exit(f[i,nho]);
            dem := 0;
            val(s[i],x);
            for j := 0 to 9 do
             for k := 0 to 9 do
              if ((j+k+nho) mod 10 = x) and ((j<>6) and (k<>6)
               and (j<>8) and (k<>8)) then
                 dem := dem + tinh(i-1,(j+k+nho) div 10);

             f[i,nho] := dem;
             exit(dem);
        end;

procedure main;
var i,j,k : longint;
    res : int64;
        begin
            for i := 0 to n do
             for j := 0 to 1 do
              f[i,j] := -1;
            val(s,res);
            res := res - tinh(n,0);
            res := res div 2;
            writeln(res);
        end;

begin
    assign(input,'NUM68.INP'); reset(input);
    assign(output,'NUM68.OUT'); rewrite(output);
    while not eof(input) do
      begin
          readln(s);
          n := length(s);
          main;
      end;
end.
