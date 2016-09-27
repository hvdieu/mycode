uses math;
Const   inp = 'gridp.inp';
        out = 'gridp.out';
        maxn = 19;
Var     fi,fo   :       text;
        a,b,f       :       array [1..maxn,1..maxn] of longint;
        m,n,r,c :       integer;
        r1,c1,r2,c2   :       array [0..maxn] of longint;
        s,s1       :       array [0..maxn,0..maxn] of longint;
        res     :       longint;

procedure input;
var i,j : longint;
        begin
            assign(fi,inp); reset(fi);
            assign(fo,out); rewrite(fo);
            readln(fi,m,n,r,c);
            for i := 1 to m do
              for j := 1 to n do read(fi,a[i,j]);
        end;

procedure sub1;
var i,j : longint;
        begin
             for i := 1 to n do
               for j := 1 to n do
                if a[i,j] > res then res := a[i,j];
             writeln(fo,res);
        end;

function tong(i,j,u,v : longint) : longint;
        begin
             tong := s[u,v] - s[i-1,v] - s[u,j-1] + s[i-1,j-1];
        end;

procedure tinh;
var i,j,temp : longint;
        begin
             temp := 0;
             for i := 1 to r+1 do
               for j := 1 to c+1 do
               begin
                f[i,j] := s1[i,c1[j]] - s1[i,c1[j-1]];
                if f[i,j] > temp then temp := f[i,j];
               end;
             if temp < res then
               begin
                 res := temp;
                 r2 := r1; c2 := c1;
               end;
        end;

procedure tryc( i : longint);
var j : longint;
        begin
            for j := c1[i-1]+1 to n-1-c+i do
              begin
                   c1[i] := j;
                   if i = c then tinh
                     else tryc(i+1);
              end;
        end;

procedure xuly;
var i,j,t,j1,temp,x : longint;
        begin
              For i := 1 to r+1 do
               for j := 1 to n do
                 b[i,j] := tong(r1[i-1]+1,j,r1[i],j);

              for i := 1 to r+1 do
                for j := 1 to n do
                  s1[i,j] := s1[i-1,j] + s1[i,j-1] - s1[i-1,j-1] + b[i,j];

              tryc(1);

        end;


procedure tryr(i : longint);
var j : longint;
        begin
             for j := r1[i-1]+1 to m-1-r+i do
               begin
                   r1[i] := j;
                   if i = r then xuly
                    else tryr(i+1);
               end;
        end;

procedure sub2;
var i,j : longint;
        begin
             r1[0] := 0; c1[0] := 0;
             r1[r+1] := m; c1[c+1] := n;
             res := maxlongint;
             for i := 1 to m do
               for j := 1 to n do
                s[i,j] := s[i-1,j] + s[i,j-1] - s[i-1,j-1] + a[i,j];
             tryr(1);
             writeln(fo,res);
             for i := 1 to r do write(fo,r2[i],' ');
             writeln(fo);
             for i := 1 to c do write(fo,c2[i],' ');

        end;

procedure main;
var i,j : longint;
        begin
             if (m = r + 1) and (n = c + 1) then sub1
              else sub2;
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.
