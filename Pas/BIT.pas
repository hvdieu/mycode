Const   maxn = 101;
Var     tree    :       array [0..maxn] of longint;
        n,i,m,j,k     :       longint;

Procedure update(i,val : longint);
        begin
             while i <= n do
               begin
                   inc(tree[i],val);
                   inc(i,i and (-i));
               end;
        end;

function truyvan(i : longint) : longint;
var s : longint;
        begin
             s := 0;
             while i > 0 do
               begin
                   inc(s,tree[i]);
                   dec(i,i and (-i));
               end;
             exit(s);
        end;

begin
      assign(input,'BIT.INP'); reset(input);
      assign(output,'BIT.OUT'); rewrite(output);
      readln(m); n := 100;
      while m > 0 do
        begin
            dec(m);
            readln(k,i,j);
            if k = 1 then update(i,j)
             else writeln(truyvan(j) - truyvan(i-1));
        end;
end.