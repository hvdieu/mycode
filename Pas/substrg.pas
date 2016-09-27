{$H+}
Const   maxn = 100001;
Var     s       :       string;
        n,k,res,kq     :       longint;
        d       :       array [0..255] of longint;

function check : boolean;
var i : longint;
        begin
             for i := 0 to 255 do
              if d[i] > k then exit(false);
             exit(true);
        end;

procedure main;
var i,j : longint;
        begin
              res := 1; i := 1; j := 1; kq := 1;
              inc(d[ord(s[1])]);
              while (i <= n) and (j <= n) do
                begin
                    if check then
                      begin
                            if j-i+1 > res then
                              begin
                                  res := j-i+1;
                                  kq := i;
                              end;
                            inc(j); inc(d[ord(s[j])]);
                      end
                    else begin
                              dec(d[ord(s[i])]);
                              inc(i);
                         end;
                end;
              writeln(res,' ',kq);
        end;

begin
      assign(input,'SUBSTRG.INP'); reset(input);
      assign(output,'SUBSTRG.OUT'); rewrite(output);
      readln(n,k);
      readln(s);
      s := s + '1';
      main;
end.
