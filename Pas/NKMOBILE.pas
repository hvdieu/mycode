Const   inp = '';
        out = '';
        maxn = 1025;

Var     n,u,v,i,j,kind,x,res       :       longint;
        t       :       array [1..maxn,1..maxn] of longint;

{************************************************************************}
procedure update(i,j,val : longint);
var j1 : longint;
        begin
            while i <= n do
              begin
                  j1 := j;
                  while j1 <= n do
                    begin
                        inc(t[i,j1],val);
                        inc(j1,j1 and (-j1));
                    end;
                  inc(i,i and (-i));
              end;
        end;
{************************************************************************}
function get(i,j : longint) : longint;
var s,j1 : longint;
        begin
            s := 0;
            while i > 0 do
              begin
                  j1 := j;
                  while j1 > 0 do
                    begin
                        inc(s,t[i,j1]);
                        dec(j1,j1 and (-j1));
                    end;
                  dec(i,i and (-i));
              end;
            exit(s);
        end;
{************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     while not eof do
      begin
          read(kind);
          if kind = 0 then read(n)
           else if kind = 1 then
            begin
               read(u,v,x);
               update(u+1,v+1,x);
            end
           else if kind = 2 then
             begin
                 read(i,j,u,v);
                 res := get(u+1,v+1)-get(i,v+1)-get(u+1,j)+get(i,j);
                 writeln(res);
             end
           else break;
      end;
end.