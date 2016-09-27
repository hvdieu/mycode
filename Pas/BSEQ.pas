Const   maxn = 5001;
Var     n,i,m       :       longint;
        f       :       array [0..maxn,0..maxn,0..1] of longint;
        a,b     :       array [1..maxn] of longint;

function max(x,y,z : longint) : longint;
var temp : longint;
        begin
             if x > y then temp := x
			  else temp := y;
			 if z > temp then exit(z)
			  else exit(temp);
        end;

procedure main;
var i,j  : longint;
        begin
             for i := 1 to m do
              for j := 1 to n do
               begin
                   if a[i] > b[j] then
                     begin
                      f[i,j,1] := max(f[i-1,j-1,0]+1,f[i,j-1,1],f[i-1,j,1]);
                      f[i,j,0] := max(f[i-1,j-1,0],f[i,j-1,0],f[i-1,j,0]);
                     end
                    else if a[i] < b[j] then
                     begin
                      f[i,j,0] := max(f[i-1,j-1,1]+1,f[i,j-1,0],f[i-1,j,0]);
                      f[i,j,1] := max(f[i-1,j-1,1],f[i,j-1,1],f[i-1,j,1]);
                     end
                     else if a[i] = b[j] then
                      begin
                          f[i,j,1] := max(f[i-1,j-1,0]+1,f[i-1,j,1],f[i,j-1,1]);
                          f[i,j,0] := max(f[i-1,j-1,1]+1,f[i-1,j,0],f[i,j-1,0]);
                      end;
               end;
              writeln(max(f[m,n,0],f[m,n,1],-maxlongint));
        end;

begin
     assign(input,'BSEQ.INP'); reset(input);
     assign(output,'BSEQ.OUT'); rewrite(output);
     readln(m,n);
     for i := 1 to m do read(a[i]);
     for i := 1 to n do read(b[i]);
     main;
end.