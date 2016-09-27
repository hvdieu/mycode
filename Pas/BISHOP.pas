Uses math;
Const   maxn = 101;
Var     n,k     :       longint;
        f,g     :       array [0..maxn,0..maxn] of string;
        res     :       string;

function cong(a,b : string) : string;
var sum,carry,i,x,y : longint;
    c   :       string;
        begin
             carry := 0;  c := '';
             while length(a) < length(b) do a := '0' + a;
             while length(a) > length(b) do b := '0'+ b;
             for i := length(a) downto 1 do
              begin
                  x := ord(a[i])-ord('0');
                  y := ord(b[i])-ord('0');
                  sum := x+y+carry;
                  carry := sum div 10;
                  c := chr(sum mod 10 +48)+c;
              end;
             if carry > 0 then c := '1'+c;
             exit(c);
        end;

function nhan1(a : string; b : longint) : string;
var i,carry,s : longint;
    c,tmp : string;
        begin
             c := '';
             carry := 0;
             for i := length(a) downto 1 do
               begin
                   s := (ord(a[i])-48)*b + carry;
                   carry := s div 10;
                   c := chr(s mod 10 + 48) + c;
               end;
             if carry > 0 then str(carry,tmp) else tmp := '';
             nhan1 := tmp+c;
        end;

function nhan(a,b : string) : string;
var sum,tmp : string;
    m,i,j : longint;
        begin
             m := -1; sum := '';
             for i := length(a) downto 1 do
               begin
                   m := m+1;
                   tmp := nhan1(b,ord(a[i])-48);
                   for j := 1 to m do tmp := tmp + '0';
                   sum := cong(tmp,sum);
               end;
             while (length(sum) > 1) and (sum[1]='0') do delete(sum,1,1);
             exit(sum);
        end;

procedure chan;
var i,j : longint;
        begin
             for i := 0 to n do
              for j := 0 to k do
                begin
                    f[i,j] := '0';
                    g[i,j] := '0';
                end;
             for i := 0 to n do
              f[i,0] := '1';
             for i := 1 to n div 2 do
              for j := 1 to min(k,i*2-1) do
               begin
                   f[i,j] := cong(f[i,j], f[i-1,j]);
                   f[i,j] := cong(f[i,j], nhan1(f[i-1,j-1],2*(i*2-1)-2*(j-1) ));
                   if j >= 2 then
                     f[i,j] := cong(f[i,j], nhan1(f[i-1,j-2],(i*2-1-(j-1))*(i*2-1-(j-2)) ) );
               end;
             res := '0';
             for i := 0 to k do
              res := cong(res,nhan(f[n div 2,i],f[n div 2,k-i]));
        end;

procedure le;
var i,j,t : longint;
        begin
             for i := 0 to n do
               for j := 0 to k do
                begin
                    f[i,j] := '0';
                    g[i,j] := '0';
                end;
             for i := 0 to n do
               begin
                 f[i,0] := '1';
                 g[i,0] := '1';
               end;
             for i := 1 to n div 2 do
              for j := 1 to min(k,i*2-1) do
               begin
                   f[i,j] := cong(f[i,j], f[i-1,j]);
                   f[i,j] := cong(f[i,j], nhan1(f[i-1,j-1],2*(i*2-1)-2*(j-1) ));
                   if j >= 2 then
                    f[i,j] := cong(f[i,j], nhan1(f[i-1,j-2],(i*2-1-(j-1))*(i*2-1-(j-2)) ) );
               end;
             i := n div 2 + 1;
             for j := 1 to n do
               begin
                   f[i,j] := cong(f[i,j], f[i-1,j]);
                   f[i,j] := cong(f[i,j], nhan1(f[i-1,j-1], n-(j-1)));
               end;
             res := '0';
             for i := 1 to n div 2 do
               for j := 1 to min(k,i*2) do
                 begin
                     g[i,j] := cong(g[i,j], g[i-1,j]);
                     g[i,j] := cong(g[i,j], nhan1(g[i-1,j-1], 4*i-2*(j-1)));
                     if j >= 2 then
                      g[i,j] := cong(g[i,j], nhan1(g[i-1,j-2], (2*i-(j-2))*(2*i-(j-1))));
                 end;
            for i := 0 to k do
               res := cong(res, nhan(f[n div 2+1,i], g[n div 2,k-i]));

        end;

begin
     assign(input,'BISHOP.INP'); reset(input);
     assign(output,'BISHOP.OUT'); rewrite(output);
     readln(n,k);
     if n mod 2 = 0 then chan
      else le;
     writeln(res);
end.