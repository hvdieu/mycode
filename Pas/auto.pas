
Const   inp = 'auto.in';
        out = 'auto.out';
        maxn = 500001;

Var     m,n,k,count,t,i     :       longint;
        s       :       ansistring;
        d       :       array [0..maxn,'a'..'z'] of longint;
        g,f,id       :  array [0..maxn] of longint;
        ch : char;

{****************************************************************************}
procedure push(s : ansistring);
var i : longint;
  begin
      t := 0;
      for i := 1 to length(s) do
        begin
            if d[t,s[i]]=0 then
              begin
                  inc(count); d[t,s[i]] := count;
                  t := count;
              end
            else t := d[t,s[i]];
        end;
  end;
{****************************************************************************}
procedure dfs(u : longint);
var j : char;
  begin
      for j := 'a' to 'z' do
       if d[u,j] <> 0 then
         begin
             dfs(d[u,j]);
             f[u] := f[u] + f[d[u,j]];
         end;
  end;
{****************************************************************************}
procedure main;
var i,u: longint;
    j : char;
  begin
      t := 0;
      for i := 1 to length(s) do
        begin
            if d[t,s[i]]=0 then
              begin
                  writeln(-1);
                  exit;
              end;
            t := d[t,s[i]];
        end;
      if f[t]<k then
        begin
            writeln(-1);
            exit;
        end;
      while k<>0 do
        begin
            for j := 'a' to 'z' do
            begin
             dec(k,g[t]);
             if k=0 then
              begin
                writeln(id[t]);
                exit;
              end;
             if (d[t,j]<>0) then
              begin
                  u := d[t,j];
                  if f[u] >= k then t := u
                   else dec(k,f[u]);
              end;
            end;
        end;
  end;
{****************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(m,n);
     for i := 1 to m do
       begin
           readln(s);
           push(s);
           id[t] := i;
           inc(f[t]); inc(g[t]);
       end;
     dfs(0);
     for i := 1 to n do
       begin
           read(k,ch);
           readln(s);
           main;
       end;
end.
