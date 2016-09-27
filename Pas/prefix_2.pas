Const   maxn = 20001;
Var     n,t,count,i       :       longint;
        d       :       array [0..maxn*10,'a'..'z'] of longint;
        f,con       :       array [0..maxn*10] of longint;
        s       :       string;
        res     :       int64;

procedure push(s : string);
var i,t : longint;
        begin
            t := 0;
            for i := 1 to length(s) do
              if d[t,s[i]] = 0 then
                begin
                    inc(count); d[t,s[i]] := count;
                    t := count;
                end
              else t := d[t,s[i]];
            inc(f[t]);
        end;

procedure dfs(t : longint);
var ch : char;
    st,l : longint;
        begin
            res := res + (f[t]*(f[t]-1)) div 2;
            con[t] := f[t];
            for ch := 'a' to 'z' do
              if d[t,ch] <> 0 then
                begin
                    st := d[t,ch];
                    dfs(st);
                    con[t] := con[t] + con[st];
                    res := res + f[t]*con[st];
                end;
        end;

begin
      assign(input,'prefix.inp'); reset(input);
      assign(output,'prefix.out'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            readln(s);
            push(s);
        end;
      dfs(0);
      writeln(res);
end.