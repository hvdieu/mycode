Const   inp = '';
        out = '';
        maxn = 1001;

Var     a       :       array [1..maxn,1..maxn] of integer;
        queue,trace   :       array [1..maxn] of longint;
        mx,my : array [1..maxn] of longint;
        m,n,left,right,res,num     :       longint;

{***************************************************************************}
procedure nhap;
var i,j,count : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(m,n,num);
            while not seekeof(input) do
              begin
                  readln(i,j);
                  a[i,j] := 1;
              end;
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to m do
              begin
                  for j := 1 to n do
                   if (a[i,j]=1) and (my[j]=0) then
                     begin
                         my[j] := i; mx[i] := j;
                         break;
                     end;
              end;
        end;
{***************************************************************************}
function timduongmo : longint;
var i,j : longint;
        begin
            right := 0; left := 0;
            for i := 1 to m do
             if mx[i]=0 then
               begin
                   inc(right); queue[right] := i;
               end;
            fillchar(trace,sizeof(trace),0);
            while left < right do
              begin
                  inc(left); i := queue[left];
                  for j := 1 to n do
                   if (a[i,j]=1) and (trace[j]=0) then
                     begin
                         trace[j] := i;
                         if my[j]=0 then exit(j);
                         inc(right); queue[right] := my[j];
                     end;
              end;
            exit(0);
        end;
{***************************************************************************}
procedure morong(f : longint);
var next,x : longint;
        begin
            repeat
                x := trace[f];
                next := mx[x];
                mx[x] := f;
                my[f] := x;
                f := next;
            until f = 0;
        end;
{***************************************************************************}
procedure main;
var f : longint;
        begin
            repeat
                 f := timduongmo;
                 if f = 0 then break;
                 morong(f);
            until false;
        end;
{***************************************************************************}
procedure inkq;
var i,j : longint;
        begin
            for i := 1 to m do
             if mx[i] <> 0 then inc(res);
            writeln(res);
        end;
{***************************************************************************}
begin
     nhap;
     khoitao;
     main;
     inkq;
end.
