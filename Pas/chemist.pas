{$H+}
Const   maxn = 50001;
Var     s       :       string;
        c       :       array ['a'..'z','a'..'{'] of boolean;
        f       :       array [0..maxn] of boolean;
        t       :       longint;

procedure khoitao;
begin
 c['h','{'] := true; c['h','e'] := true; c['l','i'] := true; c['b','e'] := true;
 c['b','{'] := true; c['c','{'] := true; c['n','{'] := true; c['o','{'] := true;
 c['f','{'] := true; c['n','e'] := true; c['n','a'] := true; c['m','g'] := true;
 c['a','l'] := true; c['s','i'] := true; c['p','{'] := true; c['s','{'] := true;
 c['c','l'] := true; c['a','r'] := true; c['k','{'] := true; c['c','a'] := true;
 c['s','c'] := true; c['t','i'] := true; c['v','{'] := true; c['c','r'] := true;
 c['m','n'] := true; c['f','e'] := true; c['c','o'] := true; c['n','i'] := true;
 c['c','u'] := true; c['z','n'] := true; c['g','a'] := true; c['g','e'] := true;
 c['a','s'] := true; c['s','e'] := true; c['b','r'] := true; c['k','r'] := true;
 c['r','b'] := true; c['s','r'] := true; c['y','{'] := true; c['z','r'] := true;
 c['n','b'] := true; c['m','o'] := true; c['t','c'] := true; c['r','u'] := true;
 c['r','h'] := true; c['p','d'] := true; c['a','g'] := true; c['c','d'] := true;
 c['i','n'] := true; c['s','n'] := true; c['s','b'] := true; c['t','e'] := true;
 c['i','{'] := true; c['x','e'] := true; c['c','s'] := true; c['b','a'] := true;
 c['h','f'] := true; c['t','a'] := true; c['w','{'] := true; c['r','e'] := true;
 c['o','s'] := true; c['i','r'] := true; c['p','t'] := true; c['a','u'] := true;
 c['h','g'] := true; c['t','l'] := true; c['p','b'] := true; c['b','i'] := true;
 c['p','o'] := true; c['a','t'] := true; c['r','n'] := true; c['f','r'] := true;
 c['r','a'] := true; c['r','f'] := true; c['d','b'] := true; c['s','g'] := true;
 c['b','h'] := true; c['h','s'] := true; c['m','t'] := true; c['d','s'] := true;
 c['r','g'] := true; c['c','n'] := true; c['f','l'] := true; c['l','v'] := true;
 c['l','a'] := true; c['c','e'] := true; c['p','r'] := true; c['n','d'] := true;
 c['p','m'] := true; c['s','m'] := true; c['e','u'] := true; c['g','d'] := true;
 c['t','b'] := true; c['d','y'] := true; c['h','o'] := true; c['e','r'] := true;
 c['t','m'] := true; c['y','b'] := true; c['l','u'] := true; c['a','c'] := true;
 c['t','h'] := true; c['p','a'] := true; c['u','{'] := true; c['n','p'] := true;
 c['p','u'] := true; c['a','m'] := true; c['c','m'] := true; c['b','k'] := true;
 c['c','f'] := true; c['e','s'] := true; c['f','m'] := true; c['m','d'] := true;
 c['n','o'] := true; c['l','r'] := true;
end;

procedure main;
var i  : longint;
        begin
            fillchar(f,sizeof(f),false);
            f[0] := true;
            for i := 1 to length(s) do
              begin
                  if f[i-1] and c[s[i],'{'] then f[i] := true;
                  if (i > 1) and f[i-2] and c[s[i-1],s[i]] then f[i] := true;
              end;
            if f[length(s)] then writeln('YES')
             else writeln('NO');
        end;

begin
      assign(input,'chemist.inp'); reset(input);
      assign(output,'chemist.out'); rewrite(output);
      readln(t);
      khoitao;
      while t > 0 do
        begin
            dec(t);
            readln(s);
            main;
        end;
end.