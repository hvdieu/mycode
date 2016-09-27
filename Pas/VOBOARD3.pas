Const   inp = '';
        out = '';
        maxn = 1001;

Var     m,n,dem     :       longint;
        a       :       array [1..maxn,1..maxn] of longint;
        t       :       array [1..maxn] of longint;
        rx,ry   :       array [1..maxn*maxn] of longint;

{***************************************************************************}
procedure nhap;
var i,j : longint;
    ch : char;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(m,n);
            for i := 1 to m do
             begin
               for j := 1 to n do
                 begin
                     read(ch);
                     val(ch,a[i,j]);
                 end;
               readln;
             end;
        end;
{***************************************************************************}
procedure update(i,val : longint);
        begin
            while i <= n do
             begin
                 inc(t[i],val);
                 inc(i,i and (-i));
             end;
        end;
{***************************************************************************}
function get(i : longint) : longint;
var s : longint;
        begin
            s := 0;
            while i > 0 do
             begin
                 inc(s,t[i]);
                 dec(i,i and (-i));
             end;
            exit(s);
        end;
{***************************************************************************}
procedure main;
var i,j,x : longint;
        begin
            for i := m downto 1 do
             for j := n downto 1 do
              begin
                 x := get(n-j+1);
                 if (x mod 2 + a[i,j] = 1) then
                  begin
                      inc(dem);
                      rx[dem] := i; ry[dem] := j;
                      update(n-j+1,1);
                  end;
              end;
             writeln(dem);
             for i := 1 to dem do writeln(1,' ',1,' ',rx[i],' ',ry[i]);
        end;
{***************************************************************************}
begin
     nhap;
     main;
end.