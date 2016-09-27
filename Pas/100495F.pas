uses math;
const
	inp = 'F.INP';
	out = 'F.OUT';
	maxn = 11;
	h : array [1..4] of integer = (-1,0,1,0);
	c : array [1..4] of integer = (0,1,0,-1);

Var
	m,n,k,i,j,ntest,dem,u,v : longint;
	a : array [1..maxn,1..maxn] of char;
	b : array [0..maxn,0..maxn] of boolean;
	found : boolean;
    s1 : string;

procedure duyet(i,j,l : longint);
	var u,v,k : longint;
begin
	if found then exit;
	if l=0 then
	  begin
	  	found := true; exit;
	  end;
	for k := 1 to 4 do
	  begin
	  	u := i+h[k]; v := j+c[k];
	  	if u > m then u := 1;
	  	if u < 1 then u := m;
	  	if v > n then v := 1;
	  	if v < 1 then v := n;
	  	if b[u,v] then
	  	  begin
	  	  	b[u][v] := false;
	  	  	if a[u][v]='o' then duyet(u,v,l)
	  	  	 else duyet(u,v,l-1);
	  	  	b[u][v] := true;
	  	  end;
	  end;
end;

begin
   //assign(input,inp); reset(input);
   //assign(output,out); rewrite(output);
	readln(ntest);
    s1 := 'Oh no, snake';
    s1 := s1+chr(39);
    s1 := s1+'s too fat!';
	while (ntest>0) do
	  begin
	  	dec(ntest);
	  	inc(dem); write('Case #',dem,': ');
	  	readln(m,n,k);
	  	fillchar(b,sizeof(b),true);
	  	for i := 1 to m do
	  	  begin
	  	  	for j := 1 to n do
	  	  	  begin
	  	  	  	read(a[i][j]);
	  	  	  	if a[i][j]='#' then b[i][j] := false;
	  	  	  	if a[i][j]='x' then
	  	  	  	  begin
	  	  	  	  	u := i; v := j;
	  	  	  	  	b[i][j] := false;
	  	  	  	  end;
	  	  	  end;
            readln;
	  	  end;
	  	found := false;
	  	duyet(u,v,k-1);
	  	if found then writeln('Fits perfectly!')
	  	 else writeln(s1);
	  end;
end.
