Const   maxn = 1000001;

Var     n       :       longint;
        a,b     :       string;
        pos     :       array ['A'..'Z',1..maxn] of longint;
        dem     :       array ['A'..'Z'] of longint;
        t       :       array [1..maxn] of longint;
        res     :       int64;

{***************************************************************************}
procedure nhap;
        begin
            assign(input,'LETTERS.INP'); reset(input);
            assign(output,'LETTERS.OUT'); rewrite(output);
            readln(n);
            readln(a);
            readln(b);
        end;
{***************************************************************************}
procedure khoitao;
var i : longint;
    ch : char;
        begin
             for i := 1 to n do
               begin
                    ch := a[i];
                    inc(dem[ch]);
                    pos[ch,dem[ch]] := i;
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
var i,j,vt,add : longint;
    ch : char;
        begin
             fillchar(dem,sizeof(dem),0);
             for i := 1 to n do
               begin
                   ch := b[i];
                   inc(dem[ch]);
                   add := get(n-pos[ch,dem[ch]]+1);
                   vt := pos[ch,dem[ch]] + add;
                   inc(res,vt-i);
                   update(n-pos[ch,dem[ch]]+1,1);
               end;
             writeln(res);
        end;
{**************************************************************************}
begin
      nhap;
      khoitao;
      main;
end.