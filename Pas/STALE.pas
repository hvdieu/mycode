Const	inp = 'STABLE.INP';
		out = 'STABLE.OUT';
		maxn = 10001;
		maxm = 50001;
Var		fi,fo	:	text;
		n,m,s,res	:	longint;
		head	:	array [1..maxn+1] of longint;
		adj,x,y		:	array [1..maxm+1] of longint;
		q,kc,pree :	array [1..maxn] of longint;
		free,d	:	array [1..maxn] of boolean;
		

Procedure input;
Var i : longint;
		BEGIN
			assign(fi,inp); reset(fi);
			readln(fi,n,m,s);
			For i := 1 to m do
				BEGIN
					 readln(fi,x[i],y[i]);
					 inc(head[x[i]]);
				END;
			close(fi);
			For i := 2 to n do head[i] := head[i-1] + head[i];
			For i := 1 to m do
				BEGIN
					adj[head[x[i]]] := y[i];
					dec(head[x[i]]);
				END;
			head[n+1] := m;
		END;
		
Procedure BFS;
Var left,right,u,v,i : longint;
		BEGIN
			left := 0; right := 1;
			q[right] := s;
			fillchar(free,sizeof(free),true);
			fillchar(d,sizeof(d),true);
			free[s] := false;
			While left < right do
				BEGIN
					inc(left);
					u := q[left];
					For i := head[u] + 1 to head[u+1] do
						BEGIN
							v := adj[i];
							if free[v] then
								BEGIN
									kc[v] := kc[u] + 1;
									free[v] := false;
									inc(right);
									q[right] := v;
								END
							else
								BEGIN
									if (kc[v] = kc[u] + 1) and d[v] and
 									(v<>s)then
										BEGIN
											inc(res);
											d[v] := false;
										END;
								END;
						END;
				END;
		END;

Procedure output;
		BEGIN
			assign(fo,out); rewrite(fo);
			write(fo,res);
			close(fo);
		END;
		
BEGIN
	input;
	BFS;
	output;
END.
	
