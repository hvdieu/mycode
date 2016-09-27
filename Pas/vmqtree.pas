Uses math;
Const 	inp = '';
        out = '';
	maxn = 50001;

Type	arr = array [1..maxn,0..16] of longint;

Var		n,q,ntest,dem1,dem2,i,j,vmax,u,v : longint;
		head,cha,d,g1,g2,g,num,thoat,g3 : array [1..maxn] of longint;
		ke,next : array [-maxn..maxn] of longint;
		f,f1,f2 : arr;

procedure init;
	var i,j : longint;
		begin
			vmax := round(ln(n)/ln(2));
			fillchar(f,sizeof(f),0);
			fillchar(cha,sizeof(cha),0);
			cha[1] := 1; f[1,0] := 1;
			fillchar(d,sizeof(d),0);
			fillchar(g1,sizeof(g1),0);
			fillchar(g2,sizeof(g2),0);
                        fillchar(g3,sizeof(g3),0);
			fillchar(g,sizeof(g),0);
                        for i := 1 to n do
                         for j := 1 to vmax do
                           begin
                               f1[u,j] := -999999999;
                               f2[u,j] := f1[u,j];
                           end;
			dem1 := 0; dem2 := 0;
		end;

procedure dfs(u : longint);
	var j,v,x : longint;
		begin
			inc(dem1); num[u] := dem1;
			for j := 1 to vmax do f[u,j] := f[f[u,j-1],j-1];
			j := head[u];
			while j <> 0 do
			  begin
			  	v := ke[j];
			  	if cha[v]=0 then
			  		begin
			  	  		cha[v] := u;
			  	  		f[v,0] := u;
			  	  		d[v] := d[u]+1;
			  	  		dfs(v);
			  	  		x := g1[v]+1;
			  	  		if x > g1[u] then
			  	  			begin
			  	  				g3[u] := g2[u]; g2[u] := g1[u]; g1[u] := x;
			  	  			end
			  	  		else if (x>g2[u]) and (x<=g1[u]) then
                                                 begin
                                                     g3[u] := g2[u]; g2[u] := x;
                                                 end
                                                else if (x>g3[u]) and (x<=g2[u]) then g3[u] := x;
			  	  	end;
			  	j := next[j];
			  end;

			j := head[u];
			while j <> 0 do
				begin
					v := ke[j];
					if cha[v]=u then
						begin
							if g1[v]+1=g1[u] then g[v] := g2[u] else g[v] := g1[u];
						end;
					j := next[j];
				end;
                        inc(dem2); thoat[u] := dem2;
		end;

function check(u,v : longint) : boolean;
	begin
		if (num[u] <= num[v]) and (thoat[u] >= thoat[v]) then exit(true) else exit(false);
	end;

function lca(u,v : longint) : longint;
var j : longint;
	begin
		if check(u,v) then exit(u);
		if check(v,u) then exit(v);
		for j := vmax downto 0 do
			if check(f[u,j],v) = false then u := f[u,j];
		exit(cha[u]);
	end;

procedure swap(var xx,yy : longint);
var temp : longint;
	begin
		temp := xx; xx := yy; yy := temp;
	end;

function pa(u,t : longint) : longint;
var j : longint;
	begin
		if t=0 then exit(u);
		for j := vmax downto 0 do
			if t-1 shl j >=0 then
				begin
					u := f[u,j];
					dec(t,1 shl j);
				end;
		exit(u);
	end;

function get(tt,u,t : longint) : longint;
var res,j : longint;
	begin
                if t < 0 then exit(-99999999);
                res := -99999999;
                if tt=1 then begin
		for j := vmax downto 0 do
			if t-1 shl j >=0 then
				begin
					res := max(res, f1[u,j]);
					u := f[u,j];
					dec(t,1 shl j);
				end;
                end
                else begin
                for j := vmax downto 0 do
			if t-1 shl j >=0 then
				begin
					res := max(res, f2[u,j]);
					u := f[u,j];
					dec(t,1 shl j);
				end;
                end;
                if tt=1 then res := max(res,-d[cha[u]]+g[u])
                 else res := max(res,d[cha[u]]+g[u]);
                exit(res);
	end;

function qr(u,v : longint) : longint;
var i,j,p,res,p1,kc,mid,x,l,r : longint;
	begin
		p := lca(u,v);
		if (d[u]-d[p] > d[v]-d[p]) then swap(u,v);
		res := g1[v];
		if u=p then
			begin
				res := max(res, g[pa(v,d[v]-d[u]-1)]);
			end
		else res := max(res, g1[u]);
		if p <> 1 then
			begin
				res := max(res,d[p]+min(d[u]-d[p],d[v]-d[p])+get(1,p,d[p]-1));
			end;
		kc := d[u]+d[v]-2*d[p];
                res := max(res, kc div 2);
		mid := pa(v, kc div 2);
                if u<>p then
                begin
		if mid <> p then res := max(res, d[v]+get(1,v,d[v]-d[mid]-1))
                 else res := max(res, d[v]+get(1,v,d[v]-d[mid]-2));
		res := max(res, d[u]+get(1,u,d[u]-d[p]-2));
                l := g1[pa(u,d[u]-d[p]-1)]+1;
                r := g1[pa(v,d[v]-d[p]-1)]+1;
                if max(l,r)<>g1[p] then x := g1[p]
                 else if min(l,r)<>g2[p] then x := g2[p]
                  else x := g3[p];
                res := max(res,min(d[v]-d[p],d[u]-d[p])+x);
		if (mid <> p) and (cha[mid]<>p) then
			begin
				res := max(res, d[u]-2*d[p]+get(2,mid,d[mid]-d[p]-2))
			end;
                end else
                begin
                   res := max(res, d[v]+get(1,v,d[v]-d[mid]-1));
                   res := max(res, -d[u]+get(2,mid,d[mid]-d[u]-1));
                end;
		exit(res);
	end;

procedure loang(u : longint);
var j,v : longint;
  begin
      j := head[u];
      f1[u,0] := -d[cha[u]]+g[u];
      f2[u,0] := d[cha[u]]+g[u];
      for j := 1 to vmax do
        begin
	  f1[u,j] := max(f1[u,j-1], f1[f[u,j-1],j-1]);
	  f2[u,j] := max(f2[u,j-1], f2[f[u,j-1],j-1]);
	end;
      j := head[u];
      while j <> 0 do
        begin
            v := ke[j];
            if cha[v]=u then loang(v);
            j := next[j];
        end;
  end;

procedure main;
	var i,j,u,v : longint;
		begin
			init;
			dfs(1);
                        loang(1);
			readln(q);
			for i := 1 to q do
				begin
					readln(u,v);
					writeln(qr(u,v));
				end;
		end;

procedure nhap;
begin
   fillchar(head,sizeof(head),0);
                readln(n);
	  	for i := 1 to n-1 do
	  		begin
	  			readln(u,v);
	  			ke[i] := v; next[i] := head[u]; head[u] := i;
	  			ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  		end;
end;


begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
                nhap;
	  	main;
	  end;
end.
