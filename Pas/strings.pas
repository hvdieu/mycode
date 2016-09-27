{$H+}
Const   maxn = 300010;
        p = 1337377;
Var     s,st       :       string;
        m,n,i,dem     :       longint;
        d       : array [0..maxn,'a'..'z'] of longint;
        dd      : array [0..maxn] of longint;
        f       : array [1..maxn] of longint;

procedure push(st : string);
var i,t : longint;
    ch : char;
        begin
           t := 0;
           for i := 1 to length(st) do
             begin
                  ch := st[i];
                  if d[t,ch] = 0 then
                    begin
                        inc(dem);
                        d[t,ch] := dem;
                        t := dem;
                    end
                  else t := d[t,ch];
             end;
           inc(dd[t]);
        end;

procedure main;
var i,t,j : longint;
        begin
            n := length(s);
            f[n+1] := 1;
            for i := n downto 1 do
              begin
                   t := 0;
                   for j := i to n do
                     begin
                         t := d[t,s[j]];
                         if t = 0 then break;
                         f[i] := (f[i] + f[j+1]*dd[t]) mod p;
                     end;
              end;
            write(f[1]);
        end;


begin
      assign(input,''); reset(input);
      assign(output,''); rewrite(output);
      readln(s);
      readln(n);
      for i := 1 to n do
        begin
            readln(st);
            push(st);
        end;
      main;
end.
