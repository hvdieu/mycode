Const	inp = 'DISNEY1.INP';
		out = 'DISNEY1.OUT';
		maxn = 201;
Var		fi,fo	:	text;
		n		:	integer;
		a		:	array [1..maxn,1..maxn] of longint;

Procedure input;
Var i,j : longint;
		BEGIN
		     assign(fi,inp); reset(fi);
			 readln(fi,n);
			 For i := 1 to n do
			   For j := 1 to n do read(fi,a[i,j]);
			 close(fi);
		END;

BEGIN

END.