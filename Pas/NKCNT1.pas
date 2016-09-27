{$H+} {$INLINE ON}
Uses math;
Const
	inp = '';
	out = '';
	maxn = 5001;
	oo = 5002;

Type
	arr2 = array [0..1,0..maxn] of integer;
	arr3 = array [0..maxn] of integer;

Var
	m,n : longint;
	s : arr2;
    res : qword;
    f,g : arr3;

procedure nhap(); inline;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
end;

procedure main(); inline;
	var i,j,cs,t : longint;
     a : string;
begin
    t := 1;
    for i := 1 to m do
      begin
          readln(a);
          for j := 1 to n do
           if a[j]='0' then
            begin
                f[j] := f[j-1]+1;
                g[j] := g[j]+1;
                s[t,j] := min(s[1-t,j-1]+1,min(f[j],g[j]));
                res := res + s[t,j];
            end
           else begin f[j] := 0; g[j] := 0; s[t,j] := 0; end;
           t := 1-t;
      end;
    writeln(res);
end;

begin
	nhap;
    main;
end.
