uses math;
Const
    inp = 'bd.out';
    in1 = 'bd.inp';
    out = 'checkbd.out';
    maxn = 10;

var
    n,i,j,m,u,v : longint;
    a : array [1..3,1..10] of longint;
    fi : text;

procedure swap(var xx,yy : longint);
    var temp : longint;
begin
    temp := xx; xx := yy; yy := temp;
end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     assign(fi,in1); reset(fi);
     readln(fi,n);
     for i := 1 to 3 do
      for j := 1 to n do read(fi,a[i][j]);
     readln(m);
     while m > 0 do
       begin
           dec(m);
           readln(u,v,i,j);
           swap(a[u][v],a[i][j]);
       end;
     for i := 1 to 3 do
      begin
          for j := 1 to n do write(a[i][j],' ');
          writeln;
      end;
end.