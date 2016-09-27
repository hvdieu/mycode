{$H+}
Uses math;
Const
	inp = 'MSTRING.INP';
	out = 'MSTRING.OUT';
	maxn = 1001;

Var
	a,b : string;
	m,n,i,j,kq : longint;
	next : array [0..maxn,'a'..'z'] of longint;
	vt : array ['a'..'z'] of longint;
	f : array [0..maxn,0..maxn] of longint;
	check : array [0..maxn,0..maxn] of boolean;

function dfs(i,j : longint) : longint;
	var k,res : longint;
begin
	if j > n then exit(0);
    if i > m then exit(m+1);
	if check[i][j] then exit(f[i][j]);
	res := 1+dfs(i+1,next[j][a[i]]);
    res := min(res,dfs(i+1,j));
	check[i][j] := true;
	f[i][j] := res;
	exit(res);
end;

procedure main;
	var i,j : longint;
		ch : char;
begin
	for ch := 'a' to 'z' do vt[ch] := n+1;
	for i := n downto 0 do
	  begin
	  	for ch := 'a' to 'z' do next[i][ch] := vt[ch];
        if i <> 0 then vt[b[i]] := i;
	  end;
	kq := m+1;
    for i := 1 to m do kq := min(kq,dfs(i,0));
	writeln(kq);
end;

begin
   // assign(input,inp); reset(input);
   // assign(output,out); rewrite(output);
	readln(a); readln(b);
	m := length(a); n := length(b);
	main;
   // solve;
end.
