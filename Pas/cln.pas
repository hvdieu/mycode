{$H+}
Const   maxn = 5001;
Var     a,b     :       string;
        m,n,i,j     :       longint;
        l       :       array [0..maxn,0..maxn] of longint;
        s       :       array [0..maxn,0..maxn] of string;

procedure main;
var i,j : longint;
        begin
            m := length(a); n := length(b);
            for i := 0 to m do
               for j := 0 to n do s[i,j] := '';
            for i := 1 to m do
             for j := 1 to n do
             if a[i] = b[j] then
                begin
                   l[i,j] := l[i-1,j-1]+1;
                   s[i,j] := s[i-1,j-1] +  a[i];
                end
             else
               begin
                    if l[i,j-1] > l[i-1,j] then
                      begin
                          l[i,j] := l[i,j-1];
                          s[i,j] := s[i,j-1];
                      end
                    else if l[i,j-1] < l[i-1,j] then
                      begin
                          l[i,j] := l[i-1,j];
                          s[i,j] := s[i-1,j];
                      end
                    else
                      begin
                          l[i,j] := l[i-1,j];
                          if s[i-1,j] > s[i,j-1] then s[i,j] := s[i-1,j]
                           else s[i,j] := s[i,j-1];
                      end;
               end;

        end;

begin
      assign(input,'cln.inp'); reset(input);
      assign(output,'cln.out'); rewrite(output);
      readln(a); readln(b);
      main;
      write(s[m,n]);
end.

