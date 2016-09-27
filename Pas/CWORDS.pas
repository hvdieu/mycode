Const   maxn = 100001;
Var     a,b       :       array ['A'..'Z','A'..'Z'] of longint;
        n,i     :       longint;
        s       :       string;
        res     :       qword;

{**************************************************************************}
procedure main;
var i,j : longint;
    c1,c2,c3,c4 : char;
    tg : int64;
        begin
             for c1 := 'A' to 'Z' do
              for c2 := 'A' to 'Z' do
               for c3 := 'A' to 'Z' do
                for c4 := 'A'to 'Z' do
                  begin
                      tg := a[c1,c2]; inc(b[c1,c2]);
                      tg := tg*(a[c3,c4]-b[c3,c4]);
                      inc(b[c3,c4]);
                      tg := tg*(a[c1,c3]-b[c1,c3]); inc(b[c1,c3]);
                      tg := tg*(a[c2,c4]-b[c2,c4]); inc(b[c2,c4]);
                      res := res + tg;
                      b[c1,c2] := 0; b[c2,c4] := 0; b[c3,c4] := 0; b[c1,c3] :=0;
                  end;
             writeln(res);
        end;
{**************************************************************************}
begin
      assign(input,'CWORDS.INP'); reset(input);
      assign(output,'CWORDS.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            readln(s);
            inc(a[s[1],s[length(s)]]);
        end;
      main;
end.