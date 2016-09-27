Uses math;
Const
	inp = 'DIVSEQQ.INP';
	out = 'DIVSEQQ.OUT';
	maxn = 100001;

Var	
	n,q,m : longint;
	cha,g,a : array [0..maxn] of longint;
	s : array [0..maxn] of int64;
    f : array [0..maxn,0..19] of longint;

procedure nhap();
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,q,m);
	for i := 1 to n do read(a[i]);
end;

function find(l,r : longint; key : int64) : longint;
	var mid,res : longint;
begin
	while l <= r do
		begin
			mid := (l+r) shr 1;
			if s[mid] >= key then
				begin
					res := mid;
					r := mid-1
				end
			else l := mid+1;
		end;
	find := res;
end;

procedure init();
	var i,j,vmax : longint;
begin
	for i := 1 to n do
		begin
			s[i] := s[i-1]+a[i];
			j := find(0,i-1,s[i]-m);
			g[i] := g[j]+1;
			cha[i] := j;
			f[i,0] := j;
			vmax := round(ln(g[i])/ln(2));
			for j := 1 to vmax do f[i,j] := f[f[i,j-1],j-1];
		end;
end;

procedure main();
	var i,j,u,v,e,vmax : longint;
begin
	while q > 0 do
		begin
            dec(q);
			readln(u,v);
			if v >= g[u] then writeln(1)
			 else begin
			 	e := u;
			 	vmax := round(ln(g[u])/ln(2));
			 	for j := vmax downto 0 do
			 		if v-1 shl j >= 0 then
			 			begin
			 				e := f[e,j];
			 				v := v-1 shl j;
			 			end;
			 	writeln(e+1);
			 end;
		end;
end;

begin
	nhap;
	init;
	main;
end.
