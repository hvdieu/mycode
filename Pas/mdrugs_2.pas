{$H+}
Uses math;
Const   maxn = 201;
        maxw = 999999999;
Var     d       :       array [1..maxn] of string;
        f       :       array [0..500,0..500] of longint;
        next    :       array [0..10001,'A'..'Z'] of longint;
        pos     :       array ['A'..'Z'] of longint;
        s       :       string;
        i,n,res,m     :       longint;

procedure main;
var i,j,k : longint;
    ch : char;
        begin
            res := 0;
            fillchar(pos,sizeof(pos),0);
            for ch:='A' to 'Z' do
                begin
                        next[length(s)+1,ch]:=length(s)+1;
                        pos[ch]:=length(s)+1;
                end;

            for i := length(s) downto 1 do
              begin
                  for ch := 'A' to 'Z' do next[i,ch] := pos[ch];
                  pos[s[i]] := i;
              end;

            For ch := 'A' to 'Z' do next[0,ch] := pos[ch];

            for k := 1 to n do
              begin
                  fillchar(f,sizeof(f),0);
                  m := length(d[k]);
                  for i := 0 to m do
                   for j := 0 to m do
                        if j=0 then f[i,j]:=0 else f[i,j] := length(s)+1;

                  for i := 1 to m do
                   for j := 1 to m do
                    f[i,j] := min(next[f[i-1,j-1],d[k][i]], f[i-1,j]);

                  for j := m downto 1 do
                   if f[m,j] <> length(s)+1 then
                        begin
                                res := max(res,j);
                                break;
                        end;
              end;
        end;

begin
     assign(input,'MDRUGS.INP'); reset(input);
     assign(output,'MDRUGS.OUT'); rewrite(output);
     while not seekeof(input) do
     begin
        readln(n);
        readln(s);
        for i := 1 to n do readln(d[i]);
        main;
        writeln(res);
     end;
end.
