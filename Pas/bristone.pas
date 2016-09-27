{$H+}
Const   maxn = 101;
Var     a       :       array [0..1,1..maxn] of char;
        f       :       array [0..maxn,0..maxn,0..1] of string;
        st,s       :       string;
        n,i,t,j,m     :       longint;
        res     :   string;

function add(a,b : string)  : string;
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

procedure main;
var i,j,t : longint;
        begin
              for i := 1 to n do
               for j := 1 to n do
                for t := 0 to 1 do
                 f[i,j,t] := '0';

              for i := 1 to n do
               begin
                 if a[0,i] = s[1] then f[1,i,0] := '1';
                 if a[1,i] = s[1] then f[1,i,1] := '1';
               end;

              for i := 2 to m do
                begin
                    for j := 2 to n do
                      begin
                          if a[0,j] = s[i] then
                            for t := 1 to j-1 do
                              if a[1,t] = s[i-1] then
                                f[i,j,0] := add(f[i,j,0], f[i-1,t,1]);

                          if a[1,j] = s[i] then
                            for t := 1 to j-1 do
                              if a[0,t] = s[i-1] then
                                f[i,j,1] := add(f[i,j,1], f[i-1,t,0]);
                      end;
                end;
              res := '0';
             for i := 1 to n do
               begin
                   res := add(res,f[m,i,0]);
                   res := add(res,f[m,i,1]);
               end;
             writeln(res);
        end;


begin
      assign(input,'BRISTONE.INP'); reset(input);
      assign(output,'BRISTONE.OUT'); rewrite(output);
      readln(s);
      m := length(s);
      readln(st);
      n := length(st);
      for i := 1 to n do a[0,i] := st[i];
      readln(st);
      for i := 1 to n do a[1,i] := st[i];
      main;
end.
