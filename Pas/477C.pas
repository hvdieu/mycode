{$H+}
uses math;
Const
    inp = 'a.inp';
    out = 'a.out';
    maxn = 2001;
    oo = 10000;

Var
    s,p : string;
    m,n,i,j,cp,ii,jj : longint;
    next : array [0..maxn,'a'..'z'] of longint;
    pos : array ['a'..'z'] of longint;
    f,g : array [0..maxn,0..2000] of longint;
    c,last : array [0..maxn] of longint;
    ch : char;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(s); readln(p);
     n := length(s);
     m := length(p);
     for i := 1 to n do
       begin
         for ch := 'a' to 'z' do next[i][ch] := pos[ch];
         pos[s[i]] := i;
       end;
     for i := 1 to n do
      if s[i] <> p[m] then c[i] := oo
     else begin
         cp := 0;
         jj := i;
         for j := m-1 downto 1 do
           begin
               ii := jj;
               jj := next[jj][s[j]];
               if jj = 0 then
                 begin
                     cp := oo;
                     break;
                 end;
               cp := cp+ii-jj-1;
           end;
         c[i] := cp; last[i] := jj;
     end;
    for i := 0 to n do
     for j := 0 to n do
      begin
        f[i][j] := -oo;
        g[i][j] := -oo;
      end;
    f[0][0] := 0;
    g[0][0] := 0;
    for i := 1 to n do
      begin
         for j := 0 to i do
         begin
           if j > 0 then f[i][j] := f[i-1][j-1];
           f[i][j] := max(f[i][j],f[i-1][j]);
           if (last[i] > 0) and (j-c[i]>=0) then
           f[i][j] := max(f[i][j],g[last[i]-1][j-c[i]]+1);
           g[i][j] := max(g[i-1][j],f[i][j]);
         end
      end;
    for i := 0 to n do
    if g[n][i] > 0 then write(g[n][i],' ')
     else write(0,' ');
end.
