uses math;
Const   inp = '';
        out = '';
        maxn = 2510;
        maxa = 1000001;

Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        pos     :       array [-maxa..maxa] of longint;
        f       :       array [1..maxn,0..maxn] of longint;
        n,ntest,res :       longint;

procedure main;
var i,j,x,k : longint;
        begin
             fillchar(pos,sizeof(pos),0);
             fillchar(f,sizeof(f),0);
             res := 0;
             for i := 1 to n do f[i,0] := 1;
             for i := 1 to n do
             begin
              for j := i+1 to n do
               begin
                   x := a[j] - a[i];
                   if (abs(x) > maxa) then k := 0 else k := pos[x];
                    f[j,i] := f[i,k] + 1;
                   if f[j,i] > res then res := f[j,i];
               end;
              pos[a[i]] := i;
             end;
              writeln(fo,res);
        end;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,ntest);
             while ntest > 0 do
              begin
                  dec(ntest);
                  readln(fi,n);
                  for i := 1 to n do read(fi,a[i]);
                  main;
              end;
             close(fi); close(fo);
        end;

begin
     input;
end.