Uses math;
Const   inp = '';
        out = '';
        maxn = 1001;
        oo = 1000000000;

Type    arr = array [0..30] of longint;

Var     m,n,i: longint;
        a : array [1..maxn] of longint;
        f,g : array [0..maxn,0..1] of arr;
        res : arr;

procedure add(var a,b : arr);
var i,l,nho : longint;
  begin
      l := max(a[0],b[0]);
      nho := 0;
      for i := 1 to l do
        begin
           if i <= a[0] then inc(nho,a[i]);
           if i <= b[0] then inc(nho,b[i]);
           a[i] := nho mod oo;
           nho := nho div oo;
        end;
      a[0] := l;
      if nho<>0 then
        begin
            inc(a[0]); a[a[0]] := nho;
        end;
  end;

procedure ghi(a : arr);
var i : longint;
    s : string;
  begin
      write(a[a[0]]);
      for i := a[0]-1 downto 1 do
        begin
            str(a[i],s);
            while length(s) < 9 do s := '0'+s;
            write(s);
        end;
  end;

procedure main;
var i,j,x,y : longint;
  begin
      x := 0;
      g[0,0][1] := 0; g[0,0][0]:=1;
      for i := a[1] to n do
      begin
        f[i,0][1] := 1;
        f[i,0][0] := 1;
        g[i,0][0] := 1; g[i,0][1] := 0;
        add(g[i,0],g[i-1,0]);
        add(g[i,0],f[i,0]);
      end;
      for i := 2 to m do
        begin
            y := 1-x;
            g[0,y][0] := 1; g[0,y][1] := 0;
            for j := 1 to n do
              begin
                  f[j,y][0] := 1; f[j,y][1] := 0;
                  g[j,y] := f[j,y];
                  if j-a[i]>0 then add(f[j,y],g[j-a[i]-1,x]);
                  add(g[j,y],g[j-1,y]);
                  add(g[j,y],f[j,y]);
              end;
            x := 1-x;
        end;
      res[0]:=1; res[1] := 0;
      for j := 1 to n do add(res,f[j,x]);
      ghi(res);
  end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n,m);
    for i := 1 to m do read(a[i]);
    main;
end.
