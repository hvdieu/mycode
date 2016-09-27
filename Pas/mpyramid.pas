Const   inp = '';
        out = '';
        maxn = 1001;
Type    truy = record
        x,y     :       longint;
        end;
Var     fi,fo   :       text;
        s,mincd,scd       :       array [0..maxn,0..maxn] of longint;
        hang,cot   :       array [1..maxn,1..maxn] of longint;
        st,p    :       array [1..maxn] of longint;
        num       :       array [1..maxn,1..maxn] of longint;
        m,n,a,b,c,d,top,bot,u1,u2,v1,v2,res     :       longint;

procedure input;
var i,j : longint;
        begin
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n,m,b,a,d,c);
              for i := 1 to m do
                for j := 1 to n do read(fi,num[i,j]);
        end;

function gets(u,v,i,j : longint) : longint;
        begin
             gets := s[i,j] - s[u-1,j] - s[i,v-1] + s[u-1,v-1];
        end;

procedure init;
var i,j,u,v : longint;
        begin
              for i := 1 to m do
                for j := 1 to n do
                 s[i,j] := s[i,j-1] + s[i-1,j] - s[i-1,j-1] + num[i,j];
        end;

procedure main;
var i,j,k,temp,x,u,v : longint;
        begin
             k := b - d - 1;
             for i := c to m do // tim mincd theo hang
                begin
                    top := 0; bot := 1;
                    for j := d to d+k-2 do
                     begin
                          x := gets(i-c+1,j-d+1,i,j);
                          while (top >= bot) and (x < st[top]) do dec(top);
                          inc(top);
                          st[top] := x;
                          p[top] := j;
                     end;
                    for j := d to n - k + 1 do
                     begin
                          x := gets(i-c+1,j+k-c,i,j+k-1);
                          while (top >= bot) and (x < st[top]) do dec(top);
                          inc(top);
                          st[top] := x; p[top] := j+k-1;
                          mincd[i,j+k-1] := st[bot];
                          cot[i,j+k-1] := p[bot];
                          while (top >= bot) and (p[bot] <= j) do inc(bot);
                     end;
                end;
           k := a - c - 1;
           for j := d to n do
                begin
                    top := 0; bot := 1;
                    for i := c to c+k-2 do
                     begin
                          while (top >= bot) and (mincd[i,j] < st[top]) do dec(top);
                          inc(top);
                          st[top] := mincd[i,j];
                          p[top] := i;
                     end;
                    for i := c to m - k + 1 do
                     begin
                          while (top >= bot) and (mincd[i+k-1,j] < st[top]) do dec(top);
                          inc(top);
                          st[top] := mincd[i+k-1,j]; p[top] := i+k-1;
                          scd[i+k-1,j] := st[bot];
                          hang[i+k-1,j] := p[bot];
                          while (top >= bot) and (p[bot] <= i) do inc(bot);
                     end;
                end;

           for i := a to m do
             for j := b to n do
              begin
                   temp :=  gets(i-a+1,j-b+1,i,j) - scd[i-1,j-1];
                   if temp > res then
                     begin
                          res := temp;
                          u1 := i - a + 1; v1 := j - b + 1;
                          u2 := hang[i-1,j-1]; v2 := cot[u2,j-1];
                          u2 := u2 - c + 1; v2 := v2 - d + 1;
                     end;
              end;
        //  writeln(fo,res);
          writeln(fo,v1,' ',u1);
          writeln(fo,v2,' ',u2);
          {for i := 1 to m do
           begin
                for j := 1 to n do write(fo,scd[i,j],' ');
                writeln(fo);
           end;}
          close(fi); close(fo);
        end;

begin
      input;
      init;
      main;
end.