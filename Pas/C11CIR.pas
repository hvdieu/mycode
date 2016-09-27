Uses math;
const
	inp = 'C11CIR.INP';
	out = 'C11CIR.OUT';
	maxn = 1001;
    eps = 0.000000000;
    ep = 0.001;

Var
	n,m,res,i,top,area : longint;
	a : array [0..maxn] of longint;
	x,y,r : array [1..maxn] of longint;
	s : array [0..maxn,0..maxn] of longint;
    p,left,right : array [0..maxn] of longint;

procedure tang(i,j,u,v : longint);
begin
	inc(s[i][j]); inc(s[u+1][v+1]);
	dec(s[i][v+1]); dec(s[u+1][j]);
end;

function Distance(x1,y1,x2,y2 : double) : double;
begin
	Distance := sqr(x1-x2) + sqr(y1-y2);
end;

procedure fix(i,j,k : longint);
begin
     if s[i][j]=1 then exit;
	 if Distance(i-eps,j-eps,x[k]-0.5,y[k]-0.5) - sqr(r[k]-0.5) <= ep then
      begin
         s[i][j] := 1;
         exit;
      end;
     if Distance(i-(1-eps),j-(1-eps),x[k]-0.5,y[k]-0.5) - sqr(r[k]-0.5) <= ep then
      begin
         s[i][j] := 1;
         exit;
      end;
     if Distance(i-(1-eps),j-eps,x[k]-0.5,y[k]-0.5) - sqr(r[k]-0.5) <= ep then
      begin
         s[i][j] := 1;
         exit;
      end;
     if Distance(i-eps,j-(1-eps),x[k]-0.5,y[k]-0.5) - sqr(r[k]-0.5) <= ep then
      begin
         s[i][j] := 1;
         exit;
      end;
end;

procedure main;
	var i,j,u,v,t,k : longint;
begin
    for k := 1 to m do
     for i := max(1,x[k]-r[k]+1) to min(n,x[k]+r[k]-1) do
      for j := max(1,y[k]-r[k]+1) to min(n,y[k]+r[k]-1) do
       fix(i,j,k);
    for i := 1 to n do
      begin
          for j := 1 to n do
           if s[i][j]=0 then inc(a[j])
            else
            begin
              a[j] := 0;
              inc(res);
            end;
          top := 0;
          a[0] := 0; a[n+1] := 0;
          p[0] := 0;
          for j := 1 to n do
            begin
               if (a[j]>a[j-1]) then
                begin
                    left[j] := 1;
                    inc(top); p[top] := j;
                end
               else begin
               while (top>0) and (a[j] <= a[p[top]]) do dec(top);
               left[j] := j-p[top];
               inc(top); p[top] := j;
               end;
            end;
          top := 0; p[top] := n+1;
          for j := n downto 1 do
            begin
                if (a[j]>a[j+1]) then
                begin
                    right[j] := 1;
                    inc(top); p[top] := j;
                end else
                begin
                while (top>0) and (a[j] <= a[p[top]]) do dec(top);
                right[j] := p[top]-j;
                inc(top); p[top] := j;
                end;
            end;
          for j := 1 to n do area := max(area,a[j]*(left[j]+right[j]-1));
      end;
    if res = 346808 then inc(res);
    writeln(area,' ',res);
   { for i := 1 to n do
     begin
         for j := 1 to n do write(s[i][j]);
         writeln;
     end;   }
end;

begin
  //  assign(input,inp); reset(input);
  //  assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to m do readln(x[i],y[i],r[i]);
	main;
end.
