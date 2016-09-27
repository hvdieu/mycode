{$H+}
Uses math;
Const   maxn = 1001;
        p = 26;
        p1 = 1000000007;
Var     s       :       string;
        f       :       array [0..maxn] of longint;
        g  :       array [1..maxn,1..maxn] of boolean;
        t,st,n  :       longint;

procedure khoitao;
var i,j,d,c : longint;
        begin
             n := length(s);
             fillchar(g,sizeof(g),false);
             for i := 1 to n do
               begin
                   g[i,i] := true;
                   d := i; c := i;
                   while (d <> 1) and (c <> n) do
                     begin
                         if s[d-1] = s[c+1] then
                           begin
                               dec(d); inc(c);
                               g[d,c] := true;
                           end
                         else break;
                     end;
               end;
             for i := 1 to n-1 do
               if s[i] = s[i+1] then
                begin
                    g[i,i+1] := true;
                    d := i; c := i+1;
                    while (d <> 1) and (c <> n) do
                     begin
                          if s[d-1] = s[c+1] then
                            begin
                                dec(d); inc(c);
                                g[d,c] := true;
                            end
                          else break;
                     end;
                end;
        end;

procedure main;
var i,j,x,y : longint;
        begin
             f[0] := 0;
             for i := 1 to n do f[i] := 9999999;
             for j := 1 to n do
              for i := j downto 1 do
                if g[i,j] then f[j] := min(f[j],f[i-1]+1);
             writeln(f[n])
        end;

begin
      assign(input,'1044.inp'); reset(input);
      assign(output,'1044.out'); rewrite(output);
      readln(t);
      for st := 1 to t do
        begin
            write('Case ',st,': ');
            readln(s);
            khoitao;
            main;
        end;
end.