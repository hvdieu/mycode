{$COperators ON}
{$H+}
Uses math;
Const
	inp = '1.in';
	out = 'a.out';
	maxn = 1001;

Var
	a,b,s1,s2 : string;
	m,n,res,ll : Longint;
	f,g : array [0..maxn,0..maxn] of longint;
	dd : array [0..maxn,'a'..'{'] of boolean;
	st : array [1..maxn] of char;
    na,nb : array [1..maxn,'a'..'{'] of longint;
    pos : array ['a'..'{'] of longint;

procedure dfs(i : longint);
	var ch : char;
		k : longint;
begin
	if i = 0 then
	   begin
	   	  for k := 1 to ll do write(st[k]);
	   	  writeln;
	   	  inc(res);
	   	  exit;
	   end;
	for ch := 'a' to 'z' do
	 if dd[i][ch] then
	   begin
	   	 st[ll-i+1] := ch;
	   	 dfs(i-1);
	   end;
end;

procedure truyvet(l,i,j : longint);
    var k,u,v : longint;
        ch : char;
begin
    if l = 0 then
      begin
          for k := 1 to ll do write(st[k]);
          writeln;
          inc(res);
          exit;
      end;
    for ch := 'a' to 'z' do
      begin
          u := na[i][ch]; v := nb[j][ch];
          if (u>0) and (v>0) and (f[u][v]=l) then
           begin
               st[ll-l+1] := ch;
               truyvet(l-1,u,v);
           end;
      end;
end;

procedure main;
	var i,j : longint;
        ch : char;
begin
	m := length(s1); n := length(s2);
	a := ''; b := '';
	for i := m downto 1 do a := a + s1[i];
	for i := n downto 1 do b := b + s2[i];
    a := a+'{';
    b := b+'{';
    for i := 1 to m+1 do
      begin
          for ch := 'a' to 'z' do na[i][ch] := pos[ch];
          pos[a[i]] := i;
      end;
    fillchar(pos,sizeof(pos),0);
    for i := 1 to n+1 do
      begin
          for ch := 'a' to 'z' do nb[i][ch] := pos[ch];
          pos[b[i]] := i;
      end;
	for i := 0 to m do g[i][0] := 1;
	for i := 0 to n do g[0][i] := 1;
	for i := 1 to m+1 do
	  for j := 1 to n+1 do
	    if a[i] = b[j] then
	     begin
	     	f[i][j] := f[i-1][j-1]+1;
	     	g[i][j] := g[i-1][j-1];
	     	dd[f[i][j]][a[i]] := true;
	     end
	    else begin
	    	f[i][j] := max(f[i][j-1],f[i-1][j]);
	    	if f[i][j] = f[i-1][j] then g[i][j] += g[i-1][j];
	    	if f[i][j] = f[i][j-1] then g[i][j] += g[i][j-1];
	    	if f[i][j] = f[i-1][j-1] then g[i][j] -= g[i-1][j-1];
	    end;
    writeln(g[m+1][n+1]);
	ll := f[m][n];
	truyvet(ll,m+1,n+1);
  //  writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(s1); readln(s2);
	main;
end.
